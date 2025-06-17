window.addEventListener("message", function(event) {
    const data = event.data.data;

    if (event.data.action === "openUI") {
        document.getElementById("players").innerText = `👥 عدد اللاعبين: ${data.total}`;
        document.getElementById("police").innerText = `👮 الشرطة: ${data.police}`;
        document.getElementById("ambulance").innerText = `🚑 الإسعاف: ${data.ambulance}`;
        document.getElementById("civilians").innerText = `🧑‍🤝‍🧑 المدنيين: ${data.civilians}`;
        document.getElementById("discord").href = data.discord;
    }
});

function join() {
    fetch(`https://${GetParentResourceName()}/joinServer`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    });
}
