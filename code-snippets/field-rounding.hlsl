// Consider using the r value in your initial distance function so your field compensates for the "inflation" this will manifest.
float opRound(float field, float r) {
    return field - r;
}