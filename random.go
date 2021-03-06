package gorp

import (
	"crypto/rand"
	"encoding/hex"
)

func secureRandom(n int) (string, error) {
	bytes := make([]byte, n)
	if _, err := rand.Read(bytes); err != nil {
		return "", err
	}
	return hex.EncodeToString(bytes), nil
}
