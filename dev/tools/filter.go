package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

type Token struct {
	ChainId  int    `json:"chainId"`
	Address  string `json:"address"`
	Name     string `json:"name"`
	Symbol   string `json:"symbol"`
	Decimals int    `json:"decimals"`
	LogoURI  string `json:"logoURI"`
}

type TokenList struct {
	Name    string  `json:"name"`
	LogoURI string  `json:"logoURI"`
	Tokens  []Token `json:"tokens"`
}

func downloadJSONFile(url string) ([]byte, error) {
	response, err := http.Get(url)
	if err != nil {
		return nil, fmt.Errorf("Failed to download JSON file: %s", err)
	}
	defer response.Body.Close()

	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		return nil, fmt.Errorf("Failed to read JSON response: %s", err)
	}

	return body, nil
}

func filterTokensByChainID(inputURL string, chainID int) error {
	inputJSON, err := downloadJSONFile(inputURL)
	if err != nil {
		return fmt.Errorf("Failed to download input JSON file: %s", err)
	}

	var tokenList TokenList
	if err := json.Unmarshal(inputJSON, &tokenList); err != nil {
		return fmt.Errorf("Failed to parse input JSON: %s", err)
	}

	var filteredTokens []Token
	for _, token := range tokenList.Tokens {
		if token.ChainId == chainID {
			filteredTokens = append(filteredTokens, token)
		}
	}

	filteredTokenList := TokenList{
		Name:    tokenList.Name,
		LogoURI: tokenList.LogoURI,
		Tokens:  filteredTokens,
	}

	filteredJSON, err := json.MarshalIndent(filteredTokenList, "", "    ")
	if err != nil {
		return fmt.Errorf("Failed to convert TokenList to JSON: %s", err)
	}

	outputFilename := fmt.Sprintf("filtered/%s_filtered.json", tokenList.Name)
	if err := os.WriteFile(outputFilename, filteredJSON, 0644); err != nil {
		return fmt.Errorf("Failed to write filtered JSON to file: %s", err)
	}

	return nil
}

func main() {
	urls := map[string]int{
		"https://tokens.uniswap.org": 1,
		"https://raw.githubusercontent.com/pancakeswap/pancake-swap-interface/master/src/constants/token/pancakeswap.json": 56,
		"https://unpkg.com/quickswap-default-token-list@1.0.67/build/quickswap-default.tokenlist.json":                     137,
	}

	for url, chainID := range urls {
		if err := filterTokensByChainID(url, chainID); err != nil {
			fmt.Printf("Failed to filter tokens from %s: %s\n", url, err)
		} else {
			fmt.Printf("Filtered tokens from %s successfully\n", url)
		}
	}
}
