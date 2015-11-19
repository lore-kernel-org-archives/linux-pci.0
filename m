Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35220 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbbKSQFp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 Nov 2015 11:05:45 -0500
From: Andy Lutomirski <luto@kernel.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] pcie_aspm: Make link_state_store consistent with link_state_show
Date: Thu, 19 Nov 2015 08:05:35 -0800
Message-Id: <6ff64f0313c4e6400ef536017078e58ec3487c71.1447949082.git.luto@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If CONFIG_PCIEASPM_DEBUG is set, then pci devices have a link_state
attribute.  Reading that attribute shows the state as a bit mask: 1
means L0S upstream, 2 means L0S downstream, and 4 means L1.

Oddly, writing to link_state is inconsistent and gets translated,
leading to mysterious results in which the value you store isn't
comparable the value you load back out.

Fix it by making link_state_store match link_state_show.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/pci/pcie/aspm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 317e3558a35e..e543dac8e3f2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -834,22 +834,16 @@ static ssize_t link_state_store(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link, *root = pdev->link_state->root;
-	u32 val, state = 0;
+	u32 state;
 
-	if (kstrtouint(buf, 10, &val))
+	if (kstrtouint(buf, 10, &state))
 		return -EINVAL;
 
 	if (aspm_disabled)
 		return -EPERM;
-	if (n < 1 || val > 3)
+	if ((state & ~ASPM_STATE_ALL) != 0)
 		return -EINVAL;
 
-	/* Convert requested state to ASPM state */
-	if (val & PCIE_LINK_STATE_L0S)
-		state |= ASPM_STATE_L0S;
-	if (val & PCIE_LINK_STATE_L1)
-		state |= ASPM_STATE_L1;
-
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	list_for_each_entry(link, &link_list, sibling) {
-- 
2.5.0

