function logp(string){
    console.log('[ oops hud ] ' + string);
}

let gender;
let maxHealth;

window.addEventListener('DOMContentLoaded', () => {
    logp('NUI:DOMContentLoaded');

    window.addEventListener('message', function(event) {
		switch(event.data.action) {
			case 'data_emitted':
				updateUI(event.data);
				break;
			case 'gender_emit':
				emitGender(event.data)
				break;
		}
	})

	function emitGender(data){
		logp('NUI:gender_emitted ' + data.gender);
		gender = data.gender;
		
		if(gender == 'male'){
			maxHealth = 200;
		} else {
			maxHealth = 175;
		}
	}

    function updateUI(data){
		var health = document.getElementById('health');
		var thirsty = document.getElementById('thirsty');
		var armor = document.getElementById('armor');
		var dead = document.getElementById('dead');

		var healthWidth = (data.health / maxHealth) * 100;
		var armorWidth = (data.armor / 100) * 100;

		health.style.width = healthWidth + '%';
		armor.style.width = armorWidth + '%';

		if(data.isDeath == true){
			dead.style.opacity = '1';
		} else {
			dead.style.opacity = '0';
		}
    }
})