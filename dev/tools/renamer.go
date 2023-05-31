package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

func main() {
	folderPath := "../../def/images/quickswap"

	files, err := ioutil.ReadDir(folderPath)
	if err != nil {
		fmt.Println(err)
		return
	}

	for _, file := range files {
		if !file.IsDir() {
			if strings.HasSuffix(strings.ToLower(file.Name()), ".png") {
				oldName := folderPath + "/" + file.Name()
				newName := folderPath + "/" + strings.ToLower(file.Name())

				err := os.Rename(oldName, newName)
				if err != nil {
					fmt.Println(err)
				}
			} else {
				err := os.Remove(folderPath + "/" + file.Name())
				if err != nil {
					fmt.Println(err)
				}
			}
		}
	}

	fmt.Println("File names changed to lowercase and non .png files deleted.")
}
