//
//  LoginUseCaseTests.swift
//  ChatForTest
//
//  Created by Daniel Alberto Rodriguez Cielo on 05/06/25.
//
import XCTest
@testable import ChatForTest

final class LoginUseCaseTests: XCTestCase {
    
    let mockRepo = MockAuthRepository()
    var useCase: LoginUseCase!
    
    override func setUpWithError() throws {
        useCase = LoginUseCase(repository: mockRepo)
    }
    
    func testLoginSuccess() {
        mockRepo.shouldLoginSucceed = true

        let expectation = self.expectation(description: "Login success")

        useCase.execute(email: "test@example.com", password: "123456") { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.email, "test@example.com")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected login to succeed")
            }
        }

        waitForExpectations(timeout: 1)
    }

    func testLoginFailure() {
        mockRepo.shouldLoginSucceed = false

        let expectation = self.expectation(description: "Login failure")

        useCase.execute(email: "test@example.com", password: "wrongpass") { result in
            switch result {
            case .success:
                XCTFail("Expected login to fail")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1)
    }
}
