const contract = require("./Random");
$('#playButton').click(async function () {
    $('#numbers ul').playSpin({
        manualStop: true
    });
 
    $('#playButton').attr('disabled',true);
    const startTime = performance.now();    

    contract.random().then(r => {
        $('#playButton').attr('disabled',false);
        $('#numbers ul').stopSpin({ stopEndNums: [r.endNums.value0, r.endNums.value1, r.endNums.value2] });
        $('#fees').html(`Fees: ${r.fees/1e9} TON`);
        $('#timer').html(`Spent time: ${Math.round(performance.now() - startTime)} milliseconds`);
    }
    )
});
