
$('.trigger_vote').on("click", (item) => {
  const proposal_id = item.target.attributes.getNamedItem('proposal_id').value
  const user_id = item.target.attributes.getNamedItem('user_id').value
  $('#' + proposal_id + "_" + user_id + "_submit")[0].click()
})