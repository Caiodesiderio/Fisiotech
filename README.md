# 🤖 Mão Robótica para Fisioterapia | Protótipo Multifuncional Impresso em 3D

Este projeto apresenta uma **mão robótica impressa em 3D**, desenvolvida como uma ferramenta de apoio à **fisioterapia**, com foco especial em **reabilitação interativa para crianças**. Projetada e modelada no Autodesk Inventor, o protótipo integra soluções de hardware e software para permitir múltiplos modos de operação e engajamento do paciente.

## 🧠 Principais Funcionalidades

A mão robótica possui **4 modos de funcionamento**, combinando eletrônica, visão computacional, desenvolvimento mobile e controle embarcado:

### 1. 🔘 Modo Manual (Botões)
Cada um dos cinco dedos pode ser aberto ou fechado individualmente através de botões físicos — ideal para testes diretos e demonstrações.

### 2. 🧍‍♂️ Modo Visão Computacional
Um sistema baseado em webcam detecta os gestos da mão humana em tempo real e os replica na mão robótica, utilizando algoritmos de visão computacional.

### 3. 📱 Modo Aplicativo (Flutter + Firebase)
Uma solução completa que simula o funcionamento de um aplicativo de clínica:
- **Pacientes** e **profissionais** se conectam via ID único.
- O profissional pode agendar sessões e configurar os parâmetros do tratamento (ângulos dos servos, repetições, duração).
- No dia agendado, o paciente ativa a sessão e imita os movimentos da mão robótica — promovendo uma **terapia interativa e gamificada**, especialmente voltada para crianças.

### 4. 🦾 Modo Exoesqueleto (com Potenciômetros)
Uma luva exoesqueleto equipada com potenciômetros captura os movimentos reais dos dedos e os replica na mão robótica — proporcionando um controle intuitivo e com baixa latência.

---

## 🛠️ Tecnologias Utilizadas

- **Projeto Mecânico**: Autodesk Inventor | Impressão 3D (PLA)
- **Sistema Embarcado**: Arduino / ESP32 | Servomotores | Potenciômetros | Botões
- **Visão Computacional**: OpenCV + Python
- **Aplicativo Mobile**: Flutter | Firebase (Firestore, Autenticação)
- **Comunicação em Tempo Real**: Firebase / Serial / Wi-Fi
- **Linguagens**: Dart, Python, C++

---

## 🎯 Aplicações e Impacto

Este protótipo é voltado para:
- **Terapia de reabilitação**
- **Tecnologia assistiva**
- **Educação em STEM**
- **Pesquisa em robótica e interação homem-máquina**

---

## 📸 Mídia e Demonstração

> _Adicione aqui imagens ou GIFs de cada modo para melhor visualização._  
> _Opcional: Insira o link de um vídeo demonstrativo (ex: YouTube)._

---

## 🚧 Melhorias Futuras

- Integrar sensores de força
- Melhorar a precisão da detecção de gestos
- Adicionar registro de dados e histórico de sessões no aplicativo
- Realizar testes práticos com profissionais da saúde

---

## 👨‍💻 Desenvolvedor

**Caio Daniel**  
Graduando em Engenharia de Controle e Automação — UEA (Manaus, Brasil)  
Pesquisador em robótica, sistemas embarcados e tecnologia para saúde  
📧 cd.chaves2005@gmail.com | 🌐 www.linkedin.com/in/caiodesiderioch

---

## 📄 Licença

Licença MIT.  
Sinta-se à vontade para explorar, contribuir ou adaptar para fins acadêmicos e de pesquisa.
