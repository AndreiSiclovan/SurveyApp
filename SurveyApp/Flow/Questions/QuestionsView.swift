//
//  QuestionsView.swift
//  SurveyApp
//
//  Created by Andrei Siclovan on 01.11.2023.
//

import SwiftUI

struct QuestionsView: View {
    
    @ObservedObject var viewModel: QuestionsViewModel
    
    
    var body: some View {
        VStack(spacing: 48) {
            
            Text("Questions submitted: \(viewModel.totalSubmitedAnswers)")
            
            Text(viewModel.getQuestion())
                .font(.title2)
            
            
            textFieldView
            
            submitButton
            
            Spacer()
            
        }
        .padding(24)
        .navigationBarTitle("Question \(viewModel.page + 1)/\(viewModel.totalQuestions)")
        .navigationBarItems(trailing:
            navigationButtons
        )
        .onAppear {
            viewModel.getQuestions()
        }
        .bannerOverlay(bannerView: BannerView(data: .init(type: viewModel.bannerType), show: $viewModel.showBanner), show: $viewModel.showBanner)
    }
    
    private var navigationButtons: some View {
        HStack {
            Button("previous") {
                viewModel.page -= 1
            }
            .disabled(viewModel.page == 0)
            .accessibilityIdentifier("previousButton")
        
            Button("next") {
                viewModel.page += 1
            }
            .disabled(viewModel.page == viewModel.totalQuestions - 1)
            .accessibilityIdentifier("nextButton")
        }
    }
    
    private var textFieldView: some View {
        VStack {
            TextField("Type your answer here", text: $viewModel.answer)
                .autocorrectionDisabled()
                .padding()
                .accessibilityIdentifier("answerTextField")
        }
        .background(Color.gray.opacity(0.2))
    }
    
    private var submitButton: some View {
        Button(action: {
            viewModel.submitAnswer(answer: viewModel.answer)
        }) {
            Text(viewModel.hasAnswer() ? "Already submited" : "Submit answer")
                .padding()
        }
        .disabled(viewModel.answer.isEmpty || viewModel.hasAnswer())
        .background(Color.gray.opacity(0.2))
        .accessibilityIdentifier("submitButton")
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView(viewModel: .init())
    }
}
