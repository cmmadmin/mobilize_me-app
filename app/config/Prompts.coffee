@MM.module "Config", (Config, App, Backbone, Marionette, $, _) ->

  Config.Prompts =
    assess:
      title: "Assess"
      content:  """
                Assess the Student
                """
    contact_list:
      title: "Contact List"
      content: """
               The Contact List displays a list of the contacts.
               """
    contact_home:
      title: "Contact Home"
      content: """
               This is the main home page for your contact. Here you have access to all the mentoring tools. Step through each of the tools in order to begin mentoring your student.

               1. Start with Snapshot to get an idea of what areas of development you should work on with the student
               2. Use the Develop tool to create a Plan to address certain areas of development
               """
    edit_new_mentee:
      title: "Edit/New Mentee"
      content: "Edit a contact or add a new contact"
    edit_new_user:
      title: "Edit/New User"
      content: "Edit a user or register a new user"
    snapshot: 
      title: "Snapshot"
      content: "Use this tool to get an idea of where your student is in their faithwalk"
    develop:
      title: "Develop"
      content: "Use this tool to decide which areas you could develop your student"
    journal:
      title: "Journal"
      content: "Take notes about your meetings and thoughts"
    login:
      title: "Login"
      content: "Login with your username and password"

    snapshot_growing_christian:
      title: "Growing Christian Profile"
      content: """
               - Knows they are saved by grace through faith in Jesus Christ alone (Ephesians 2:8-9)

               - Exhibits a growing relationship with God through the Word and prayer (Colossians 2:6‐7)

               - Displays observable Christ‐like attitudes and actions (John 14:21)

               - Is accountable to a fellowship of committed believers (Hebrews 10:24-25)

               - Participates regularly in witnessing to others or at least expresses a willingness to learn (Matthew 4:19)

               - Is Faithful, Available, Initiative‐taking, Teachable and Humble (F.A.I.T.H.)
               """
    snapshot_world_christian:
      title: "World Christian Profile"
      content: """
               - Understands the Bible as the story of God actively redeeming people from every tribe, tongue, people, and language

               - Understands unreached peoples and the remaining task for world evangelization, as well as unsent peoples and the potential of frontier mobilization

               - Practices World Christian Habits: Praying, Sending, Welcoming

               - Makes time and lifestyle choices based upon their World Christian values
               """
    snapshot_mobilizer:
      title: "Mobilizer Profile"
      content: """
               - Provides World Christian Influence for others

               - Can clearly explain the Biblical Basis of Missions, Status of the World, and Frontier Mobilization

               - Displays a commitment to ongoing development as a World Christian

               - Can connect people with opportunities and resources

               - Is developing a strategy to mobilize a particular affinity group

               - Has established at least one other person as a World Christian

               - Has the character of a servant leader
               """

    snapshot_multiplying_mobilizer:
      title: "Multiplying Mobilizer Profile"
      content: """
               - Has equipped at least one World Christian as a mobilizer

               - Can clearly explain the process of mobilization

               - Advocates for Mission Mobilization

               - Has a specific strategy for multiplying Mobilizers among a particular affinity group
               
               - Has played a part in sending at least one long term goer
               """

