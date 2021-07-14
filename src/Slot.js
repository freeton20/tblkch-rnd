const contract = require("./Random");
$('#playButton').click(async function () {
    $('#numbers ul').playSpin({
        manualStop: true,
        onFinish: onFinishCallback
    });

    $('#playButton').attr('disabled', true);

    const startTime = performance.now();

    let r = await contract.random();

    $('#numbers ul').stopSpin({ stopEndNums: [r.endNums.value0, r.endNums.value1, r.endNums.value2] });

    function onFinishCallback() {
        $('#playButton').attr('disabled', false);
        $('#fees').html(`Fees: ${r.fees / 1e9} TON`);
        $('#timer').html(`Spent time: ${Math.round(performance.now() - startTime)} milliseconds`);
        $('#balance').html(`Balance: ${r.balance}`);
        $('#betValue').html(`Bet value: ${r.betValue}`);
    }
});

