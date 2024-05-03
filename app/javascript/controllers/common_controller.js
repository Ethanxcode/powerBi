import { Controller } from '@hotwired/stimulus'

export default class CommonController extends Controller {
  connect() {
    console.log(this.element)
    const fileInput = this.element.querySelector('#file-input')
    if (fileInput) {
      fileInput.addEventListener('change', (e) => {
        const fileName = e.target.files[0].name
        this.element.querySelector('span').textContent = fileName
      })
    }
  }

  goToLocation(event) {
    const url = new URL(window.location);
    url.searchParams.set('per_page', event.target.value);
    window.location.href = url;
  }


}
