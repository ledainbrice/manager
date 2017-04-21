# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Voucher.Repo.insert!(%Voucher.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Manager.Repo
alias Manager.User
alias Manager.Group
alias Manager.Member
alias Manager.Element

Repo.delete_all(Element)
Repo.delete_all(Member)
Repo.delete_all(Group)
Repo.delete_all(User)

user1_id = "00000000-0000-0000-0000-000000000000"
user2_id = "11111111-1111-1111-1111-111111111111"

group1_id = "00000000-0000-0000-0000-000000000000"
group2_id = "11111111-1111-1111-1111-111111111111"
group3_id = "22222222-2222-2222-2222-222222222222"

element1_id = "00000000-0000-0000-0000-000000000000"
element2_id = "11111111-1111-1111-1111-111111111111"


Repo.insert!(%User{id: user1_id, name: "root", email: "root@yopmail.com"})
Repo.insert!(%User{id: user2_id, name: "user", email: "user@yopmail.com"})

Repo.insert!(%Group{id: group1_id, name: "Group 1"})
Repo.insert!(%Group{id: group2_id, name: "Group 2"})
Repo.insert!(%Group{id: group3_id, name: "Group 3"})

Repo.insert!(%Member{group_id: group1_id, user_id: user1_id})
Repo.insert!(%Member{group_id: group1_id, user_id: user2_id,role: "guest"})
Repo.insert!(%Member{group_id: group2_id, user_id: user1_id})
Repo.insert!(%Member{group_id: group3_id, user_id: user2_id})

Repo.insert!(%Element{id: element1_id, name: "Element 1", body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", group_id: group1_id})

Repo.insert!(%Element{id: element2_id,
	name: "Element 1",
	body: "Quare hoc quidem praeceptum, cuiuscumque est, ad tollendam amicitiam valet; illud potius praecipiendum fuit, ut eam diligentiam adhiberemus in amicitiis comparandis, ut ne quando amare inciperemus eum, quem aliquando odisse possemus. Quin etiam si minus felices in diligendo fuissemus, ferendum id Scipio potius quam inimicitiarum tempus cogitandum putabat.",
 	group_id: group1_id,
 	element_id: element1_id})
