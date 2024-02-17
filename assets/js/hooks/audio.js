export default {
    mounted() {
        this.handleEvent("play", ({ url }) => {
            const audio =  new Audio(url)
            audio.play();
        });
    }
}