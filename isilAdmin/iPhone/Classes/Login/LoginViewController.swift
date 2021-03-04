//
//  LoginViewController.swift
//  isilAdmin
//
//  Created by kerwin Joel on 2/23/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user.text = "antonyhuallullo@gmail.com"
        self.password.text = "12345678"
    }
    
    @IBAction func login(_ sender: UIButton) {
        let user = self.user.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var msj: String = ""
        
        if user == "" || password == "" {
   
            let alert = UIAlertController(title: "Error", message: "Ingrese un correo electrónico y una contraseña.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            
            self.present(alert, animated: true, completion: nil)
        
        } else {
            self.dataUser.signIn(withEmail: user, password: password) { [weak self] authResult, error in
                
                if error == nil {
                    self?.performSegue(withIdentifier: "AdminUser", sender: self)
                } else {
                    var msj: String = ""
                    let authError = error! as NSError
                    
                    print("authError.code", authError.code)
               
                    if let errorCode = AuthErrorCode(rawValue: error!._code) {
                        msj = self?.getMessageError(errorCode: errorCode) ?? ""
                    }
                    
                    let alertController = UIAlertController(title: "Error", message: msj, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func getMessageError(errorCode: AuthErrorCode) -> String {
        var msj: String = ""
        switch errorCode {
                
        case .accountExistsWithDifferentCredential:
            msj = "0- Indica que se requiere vincular la cuenta"
        case .adminRestrictedOperation:
            msj = "1- Indica que la operación está restringida por el administrador"
        case .appNotAuthorized:
            msj = "2- Indica que la aplicación no está autorizada para usar Firebase Authentication con la clave de API proporcionada"
        case .appNotVerified:
            msj = "3- Indica que Firebase no pudo verificar la aplicación durante la autenticación del número de teléfono"
        case .appVerificationUserInteractionFailure:
            msj = "4- Indica una falla general durante el flujo de verificación de la aplicación"
        case .captchaCheckFailed:
            msj = "5- Indica que el token reCAPTCHA no es válido"
        case .credentialAlreadyInUse:
            msj = "6- Indica un intento de vincular con una credencial que ya se vinculó con una cuenta de Firebase diferente"
        case .customTokenMismatch:
            msj = "7- Indica que la cuenta de servicio y la clave API pertenecen a proyectos diferentes"
        case .dynamicLinkNotActivated:
            msj = "8- Indica que un enlace dinámico de Firebase no está activado"
        case .emailAlreadyInUse:
            msj = "9- Indica que el correo electrónico utilizado para intentar registrarse ya está en uso"
        case .emailChangeNeedsVerification:
            msj = "10- Indica que se requiere un correo electrónico verificado para cambiar"
        case .expiredActionCode:
            msj = "11- Indica que el código OOB ha caducado"
        case .gameKitNotLinked:
            msj = "12- indica que el marco de GameKit no está vinculado antes de intentar iniciar sesión en Game Center"
        case .internalError:
            msj = "13- Indica que ocurrió un error interno"
        case .invalidActionCode:
            msj = "15- Indica que el código OOB no es válido"
        case .invalidAPIKey:
            msj = "15- Indica que se proporcionó una clave API no válida en la solicitud"
        case .invalidAppCredential:
            msj = "16- indica que se utilizó un token de dispositivo APNS no válido en la solicitud verifyClient"
        case .invalidClientID:
            msj = "17- Indica que el ID de cliente utilizado para invocar un flujo web no es válido"
        case .invalidContinueURI:
            msj = "18- indica que el dominio especificado en el URI de continuación no es válido"
        case .invalidCredential:
            msj = "19- Indica que el token IDP o requestUri no es válido"
        case .invalidCustomToken:
            msj = "20- Indica un error de validación con el token personalizado"
        case .invalidDynamicLinkDomain:
            msj = "21- indica que el dominio de enlace dinámico de Firebase utilizado no está configurado o no está autorizado para el proyecto actual"
        case .invalidEmail:
            msj = "22- Indica que el correo electrónico no es válido"
        case .invalidMessagePayload:
            msj = "23- indica que hay parámetros no válidos en la carga útil durante un intento de 'enviar correo electrónico para restablecer la contraseña'"
        case .invalidMultiFactorSession:
            msj = "24- Indica que la sesión multifactor no es válida"
        case .invalidPhoneNumber:
            msj = "25- Indica que se proporcionó un número de teléfono no válido en una llamada para verificarPhoneNumber finalización "
        case .invalidProviderID:
            msj = "26- Representa el código de error para cuando el ID de proveedor dado para una operación web no es válido"
        case .invalidRecipientEmail:
            msj = "27- Indica que el correo electrónico del destinatario no es válido"
        case .invalidSender:
            msj = "28- Indica que el correo electrónico del remitente no es válido durante un intento de enviar correo electrónico de restablecimiento de contraseña"
        case .invalidUserToken:
            msj = "29- indica que la credencial de autenticación guardada del usuario no es válida, el usuario debe iniciar sesión de nuevo"
        case .invalidVerificationCode:
            msj = "30- indica que se utilizó un código de verificación no válido en la solicitud verifyPhoneNumber"
        case .invalidVerificationID:
            msj = "31- indica que se utilizó un ID de verificación no válido en la solicitud verifyPhoneNumber"
        case .keychainError:
            msj = "32- Indica que ocurrió un error al intentar acceder al llavero"
        case .localPlayerNotAuthenticated:
            msj = "33- indica que el jugador local no estaba autenticado antes de intentar iniciar sesión en Game Center"
        case .maximumSecondFactorCountExceeded:
            msj = "34- Indica que se ha superado el recuento máximo de segundo factor"
        case .malformedJWT:
            msj = "35- Se genera cuando un JWT no puede analizar correctamente Puede ir acompañado de un error subyacente que describe qué paso del proceso de análisis JWT falló"
        case .missingAndroidPackageName:
            msj = "36- indica que falta el nombre del paquete de Android cuando el indicador androidInstallApp se establece en verdadero"
        case .missingAppCredential:
            msj = "37- indica que falta el token del dispositivo APNS en la solicitud verifyClient"
        case .missingAppToken:
            msj = "38- Indica que no se pudo obtener el token del dispositivo APNs Es posible que la aplicación no haya configurado correctamente la notificación remota o que no reenvíe el token del dispositivo APNs a FIRAuth si el delegado de la aplicación está deshabilitado"
        case .missingContinueURI:
            msj = "39- indica que no se proporcionó un URI de continuación en una solicitud al backend que lo requiere"
        case .missingClientIdentifier:
            msj = "40- Indica un error cuando falta el identificador del cliente"
        case .missingEmail:
            msj = "41- Indica que se esperaba una dirección de correo electrónico pero no se proporcionó una"
        case .missingIosBundleID:
            msj = "42- indica que falta el ID del paquete de iOS cuando se proporciona un ID de la App Store de iOS"
        case .missingMultiFactorSession:
            msj = "43- Indica que falta la sesión multifactor"
        case .missingOrInvalidNonce:
            msj = "44- Indica que el nonce falta o es inválido"
        case .missingPhoneNumber:
            msj = "45- Indica que no se proporcionó un número de teléfono en una llamada para verificarPhoneNumber completado"
        case .missingVerificationCode:
            msj = "46- Indica que la credencial de autenticación del teléfono se creó con un código de verificación vacío"
        case .missingVerificationID:
            msj = "47- indica que la credencial de autenticación del teléfono se creó con un ID de verificación vacío"
        case .missingMultiFactorInfo:
            msj = "48- Indica que falta la información de múltiples factores"
        case .multiFactorInfoNotFound:
            msj = "49- Indica que no se encuentra la información de múltiples factores"
        case .networkError:
            msj = "50- Indica que ocurrió un error de red (como un tiempo de espera, una conexión interrumpida o un host inaccesible) Estos tipos de errores a menudo se pueden recuperar con un reintento El campo NSUnderlyingError en el diccionario NSErroruserInfo contendrá el error encontrado "
        case.noSuchProvider:
            msj = "51- Indica un intento de desvincular un proveedor que no está vinculado"
        case .notificationNotForwarded:
            msj = "52- indica que la aplicación no puede reenviar la notificación remota a FIRAuth"
        case .nullUser:
            msj = "53- Indica que se esperaba un usuario no nulo como argumento para la operación, pero se proporcionó un usuario nulo"
        case .operationNotAllowed:
            msj = "54- Indica que el administrador inhabilitó el inicio de sesión con el proveedor de identidad especificado"
        case .providerAlreadyLinked:
            msj = "55- Indica un intento de vincular un proveedor al que la cuenta ya está vinculada"
        case .quotaExceeded:
            msj = "56- Indica que se ha excedido la cuota de mensajes SMS para un proyecto determinado"
        case .rejectedCredential:
            msj = "57- Indica que la credencial es rechazada porque está mal formada o no coincide"
        case .requiresRecentLogin:
            msj = "58- Indica que el usuario ha intentado cambiar el correo electrónico o la contraseña más de 5 minutos después de iniciar sesión"
        case .secondFactorAlreadyEnrolled:
            msj = "59- Indica que el segundo factor ya está registrado"
        case .secondFactorRequired:
            msj = "60- indica que el segundo factor es necesario para iniciar sesión"
        case .sessionExpired:
            msj = "61- Indica que el código SMS ha caducado"
        case .tooManyRequests:
            msj = "62- indica que se realizaron demasiadas solicitudes a un método de servidor"
        case .unauthorizedDomain:
            msj = "63- indica que el dominio especificado en la URL de continuación no está incluido en la lista blanca de la consola de Firebase"
        case .unsupportedFirstFactor:
            msj = "64- indica que el primer factor no es compatible"
        case .unverifiedEmail:
            msj = "65- Indica que el correo electrónico es necesario para la verificación"
        case .userDisabled:
            msj = "66- Indica que la cuenta del usuario está deshabilitada en el servidor"
        case .userMismatch:
            msj = "67- Indica que se intentó volver a autenticarse con un usuario que no es el usuario actual"
        case .userNotFound:
            msj = "68- Indica que no se encontró la cuenta de usuario"
        case .userTokenExpired:
            msj = "69- Indica que el token guardado ha expirado, por ejemplo, el usuario puede haber cambiado la contraseña de la cuenta en otro dispositivo. El usuario debe iniciar sesión nuevamente en el dispositivo que realizó esta solicitud"
        case .weakPassword:
            msj = "70- indica un intento de establecer una contraseña que se considera demasiado débil"
        case .webContextAlreadyPresented:
            msj = "71- Indica que se intentó presentar un nuevo contexto web mientras ya se estaba presentando uno"
        case .webContextCancelled:
            msj = "72- Indica que la presentación de la URL fue cancelada prematuramente por el usuario"
        case .webInternalError:
            msj = "73- Indica que ocurrió un error interno dentro de SFSafariViewController o WKWebView"
        case .webNetworkRequestFailed:
            msj = "74- Indica que una solicitud de red dentro de SFSafariViewController o WKWebView falló"
        case .wrongPassword:
            msj = "75- indica que el usuario intentó iniciar sesión con una contraseña incorrecta"
        case .webSignInUserInteractionFailure:
            msj = "76- indica un error general durante un flujo de inicio de sesión web"
        default:
            msj = "77- Se produjo un error desconocido"
        }
        
        return msj
    }
    

}
