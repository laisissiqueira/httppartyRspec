describe 'Send' do
    context 'message' do
        it 'CT01: Mensagem enviada com sucesso ' do
            @body ={
                mensagem: 'oi tudo bem',
                num_destinatario: '12345678901'   
            }.to_json

            @message= Message.post('/lambdastresstest', body: @body)
            puts @message

            expect(@message.parsed_response['body']).to eq("\"Mensagem enviada com sucesso\"")

        end

        it 'CT2: Validar campo “Mensagem” obrigatório' do
            @body ={
                mensagem: nil,
                num_destinatario: '12345678901'   
            }.to_json

            @message= Message.post('/lambdastresstest', body: @body)
            puts @message

            expect(@message.parsed_response['body']).to eq("\"Campo mensagem é obrigatório\"")

        end

        it 'CT03: Validar campo “Número do destinatário” obrigatório' do
            @body ={
                mensagem: 'Oi',
                num_destinatario: nil   
            }.to_json

            @message= Message.post('/lambdastresstest', body: @body)
            puts @message

            expect(@message.parsed_response['body']).to eq("\"Campo número do destinatário é obrigatório\"")

        end

        it 'CT04: Validar campos “Mensagem” e “Número do destinatário” obrigatórios' do
            @body ={
                mensagem: nil,
                num_destinatario: nil   
            }.to_json

            @message= Message.post('/lambdastresstest', body: @body)
            puts @message

            expect(@message.parsed_response['body']).to eq("\"Campos mensagem e número do destinatário são obrigatórios\"")

        end

        it 'CT5: Validar limite de caracteres para o campo mensagem' do
            @body ={
                mensagem: 'MensagemdetesteMensagemdetesteMensagemdetesteMensagemdetesteMensagemdetesteMensagemdetesteMensagemdet',
                num_destinatario: '12345678901'   
            }.to_json

            @message= Message.post('/lambdastresstest', body: @body)
            puts @message

            expect(@message.parsed_response['body']).to eq("\"Limite de caracteres excedido para o campo mensagem\"")

        end

        it 'CT06: Validar limite de recebimento de mensagem' do
            @body ={
                mensagem: 'oi',
                num_destinatario: '12345678901'   
            }.to_json

            @message= Message.post('/lambdastresstest', body: @body)
            puts @message

            expect(@message.parsed_response['body']).to eq("\"Limite de mensagem execido para o destinatário informado\"")

        end

        it 'CT7: Validar número do destinatário inválido (menor 11)' do
            @body ={
                mensagem: 'Oi',
                num_destinatario: '1234567890'   
            }.to_json

            @message= Message.post('/lambdastresstest', body: @body)
            puts @message

            expect(@message.parsed_response['body']).to eq("\"Numero inválido\"")

        end

        it 'CT8: Validar número do destinatário inválido (maior que 11)' do
            @body ={
                mensagem: 'Oi',
                num_destinatario: '123456789012'   
            }.to_json

            @message= Message.post('/lambdastresstest', body: @body)
            puts @message

            expect(@message.parsed_response['body']).to eq("\"Numero inválido\"")

        end


    end
end