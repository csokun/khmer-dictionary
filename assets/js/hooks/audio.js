export default {
    mounted() {
        this.handleEvent("play", (payload) => {
            console.log("play", payload)
        });
    }
}