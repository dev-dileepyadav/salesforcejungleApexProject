import { ShowToastEvent } from "lightning/platformShowToastEvent";

const toast = (scope, config) => {
  const toastEvent = new ShowToastEvent({
    ...config
  });

  scope.dispatchEvent(toastEvent);
};

const toasts = {
  info: (scope, message, config) => {
    config = {
      ...config,
      message,
      variant: 'info'
    };
    toast(scope, config);
  },
  success: (scope, message, config) => {
    config = {
      ...config,
      message,
      variant: 'success'
    };
    toast(scope, config);
  },
  warning: (scope, message, config) => {
    config = {
      ...config,
      message,
      variant: 'warning'
    };
    toast(scope, config);
  },
  error: (scope, message, config) => {
    config = {
      ...config,
      message,
      variant: 'error'
    };
    toast(scope, config);
  }
};

const reduceErrors = (errors) => {
  if (!Array.isArray(errors)) {
    errors = [errors];
  }

  return errors.filter((error) => !!error) /* Remove null/undefined items*/
    .map((error) => { /* Extract an error message*/
      if (Array.isArray(error.body)) {  /* UI API read errors */
        return error.body.map((e) => e.message);
      } else if (error.body && error.body.output && error.body.output.errors && Array.isArray(error.body.output.errors) && error.body.output.errors.length > 0 && error.body.output.errors[0].message && typeof error.body.output.errors[0].message === 'string') { /* UI API DML, Apex and network errors */
        return error.body.output.errors[0].message;
      } else if (error.body && typeof error.body.message === 'string') { /* UI API DML, Apex and network errors */
        return error.body.message;
      } else if (typeof error.message === 'string') { /* JS errors */
        return error.message;
      }
      /* Unknown error shape so try HTTP status text*/
      return error.statusText;
    })
    /* Flatten*/
    .reduce((prev, curr) => prev.concat(curr), [])
    /* Remove empty strings*/
    .filter((message) => !!message);
}

const handleError = (scope, apexCallError) => {
  const errors = reduceErrors(apexCallError);
  toasts.error(scope, errors.join(', '), {
    title: 'Error!'
  });
};

const isValid = (scope) => {
  return [
    ...scope.template.querySelectorAll('.validate')
  ].filter((input) => {
    return input;
  }).reduce((validSoFar, input) => {
    input.reportValidity();
    return validSoFar && input.checkValidity();
  }, true);
}

const minDigits = (value, minDigits) => {
  return ('0' + value).slice(-1 * (minDigits || 2));
}



export {
  toasts,
  reduceErrors,
  handleError,
  isValid,
}