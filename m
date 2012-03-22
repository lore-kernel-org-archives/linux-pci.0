Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40490 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab2CVEHn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Mar 2012 00:07:43 -0400
Received: by pbcun15 with SMTP id un15so1273842pbc.19
        for <linux-pci@vger.kernel.org>; Wed, 21 Mar 2012 21:07:43 -0700 (PDT)
Message-ID: <4F6AA586.70403@kernel.org>
Date: Thu, 22 Mar 2012 12:07:34 +0800
From: Shaohua Li <shli@kernel.org>
MIME-Version: 1.0
To: mjg@redhat.com, jbarnes@virtuousgeek.org
CC: linux-pci@vger.kernel.org
Subject: [patch]pci: fix a panic in pcie_aspm_init_link_state
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


My desktop always painc in pcie_aspm_init_link_state. Looks commit
4949be16822e92 causes it. The FADT declaims the system doesn't support ASPM.
Below patch fixes the painc for me. I'm quite strange we still touch aspm
registers even aspm_disabled.

Signed-off-by: Shaohua Li <shli@kernel.org>

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 24f049e..2e8eb86 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -500,9 +500,6 @@ static int pcie_aspm_sanity_check(struct pci_dev *pdev)
  	int pos;
  	u32 reg32;

-	if (aspm_disabled)
-		return 0;
-
  	/*
  	 * Some functions in a slot might not all be PCIe functions,
  	 * very strange. Disable ASPM for the whole slot
@@ -566,7 +563,11 @@ static struct pcie_link_state 
*alloc_pcie_link_state(struct pci_dev *pdev)
  void pcie_aspm_init_link_state(struct pci_dev *pdev)
  {
  	struct pcie_link_state *link;
-	int blacklist = !!pcie_aspm_sanity_check(pdev);
+	int blacklist;
+
+	if (aspm_disabled)
+		return;
+	blacklist = !!pcie_aspm_sanity_check(pdev);

  	if (!pci_is_pcie(pdev) || pdev->link_state)
  		return;
