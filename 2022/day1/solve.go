package main

import (
    "fmt"
    "os"
    "strings"
    "strconv"
)

func get_max(contents string) int {
    var sum int = 0
    var mx int = 0
    for _, content := range strings.Split(contents, "\n") {
        if mx < sum {
            mx = sum
        }
        if content != "" {
            nr, _ := strconv.Atoi(content)
            sum += nr
        } else {
            sum = 0
        }
    }

    return mx
}

func get_min(a *int, b *int, c *int) *int {
    if *a <= *b {
        return map[bool]*int{true: a, false: c} [*a <= *c]
    } else if *b <= *a {
        return map[bool]*int{true: b, false: c} [*b <= *c]
    } else {
        return c
    }
}

func get_top_3(contents string) (int, int, int) {
    var sum, a, b, c int = 0, 0, 0, 0

    for _, content := range strings.Split(contents, "\n") {
        if *get_min(&a, &b, &c) < sum {
            *get_min(&a, &b, &c) = sum
        }
        if content != "" {
            nr, _ := strconv.Atoi(content)
            sum += nr
        } else {
            sum = 0
        }
    }

    return a, b, c
}

func main() {
    data, _ := os.ReadFile(os.Args[1])

    fmt.Printf("part 1: %d\n", get_max(string(data)))

    a, b, c := get_top_3(string(data))
    fmt.Printf("part 2: %d\n", a + b + c)
}
