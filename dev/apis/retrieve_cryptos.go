package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type CoinGeckoToken struct {
	Id        string            `json:"id"`
	Name      string            `json:"name"`
	Symbol    string            `json:"symbol"`
	Platforms map[string]string `json:"platforms"`
}

type CoinCapToken struct {
	Id     string `json:"id"`
	Name   string `json:"name"`
	Symbol string `json:"symbol"`
}

func main() {
	resp, err := http.Get("https://api.coingecko.com/api/v3/coins/list?include_platform=true")
	if err != nil {
		fmt.Println("Error making request to CoinGecko API:", err)
		return
	}
	defer resp.Body.Close()

	var tokens []CoinGeckoToken
	err = json.NewDecoder(resp.Body).Decode(&tokens)
	if err != nil {
		fmt.Println("Error decoding CoinGecko API response:", err)
		return
	}

	resp, err = http.Get("https://api.coincap.io/v2/assets")
	if err != nil {
		fmt.Println("Error making request to CoinCap API:", err)
		return
	}
	defer resp.Body.Close()

	var data struct {
		Data []struct {
			CoinCapToken
			PlatformData []struct {
				Network string `json:"name"`
				Address string `json:"address"`
			} `json:"platforms"`
		} `json:"data"`
	}
	err = json.NewDecoder(resp.Body).Decode(&data)
	if err != nil {
		fmt.Println("Error decoding CoinCap API response:", err)
		return
	}

	var combinedData []map[string]interface{}
	for _, token := range tokens {
		for _, capToken := range data.Data {
			if token.Id == capToken.Id {
				newMap := make(map[string]interface{})
				newMap["id"] = capToken.Id
				newMap["name"] = capToken.Name
				newMap["symbol"] = capToken.Symbol
				newMap["platforms"] = token.Platforms
				combinedData = append(combinedData, newMap)
				break
			}
		}
	}

	jsonData, err := json.Marshal(combinedData)
	if err != nil {
		fmt.Println("Error converting combinedData to JSON:", err)
		return
	}

	fmt.Println(string(jsonData))
}
