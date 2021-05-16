describe('Home Page', () => {
    it('Opens successfully', () => {
        const env = Cypress.env('ENV');
        const homePageUrl = Cypress.env('url')[`${env}`];
        cy.visit(homePageUrl);
    })
});
