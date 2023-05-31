package main

import (
    "fmt"
    "os"
    "path/filepath"
)

func main() {
    sourceDir := "../../assets/images/uniswap/assets"

    files, err := os.ReadDir(sourceDir)
    if err != nil {
        fmt.Println(err)
        return
    }

    for _, file := range files {
        if !file.IsDir() && filepath.Ext(file.Name()) == ".png" {
            oldPath := filepath.Join(sourceDir, file.Name())
            newPath := filepath.Join(filepath.Dir(sourceDir), file.Name())

            err = os.Rename(oldPath, newPath)
            if err != nil {
                fmt.Println(err)
                return
            }
        }
    }

    fmt.Println("PNG files moved successfully.")
}