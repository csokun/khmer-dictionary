export default {
    mounted() {
        this.handleEvent("play", ({ text }) => {
            const audio =  new Audio(`http://localhost:3000/${text}`)
            audio.play();
        });
    }
}