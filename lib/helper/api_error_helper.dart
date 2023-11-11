class ApiErrorHelper {
  ApiErrorHelper();
   String getErrorByStatusCode(int satusCode) {
    switch (satusCode) {
      case 204:
        return "Não há conteúdo";
      case 400:
        return "Requisição inválida ou malformada";
      case 401:
        return "Você não tem permissão para acessar este recurso";
      case 403:
        return "Você não tem permissão para acessar este recurso";

      case 404:
        return "O recurso solicitado não foi encontrado";
      case 599:
        return "Verifique sua conexão e tente novamente.";
      default:
      return "Erro interno no servidor";
    }
  }
}
