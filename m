Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49755 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbbLHOuL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Dec 2015 09:50:11 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 21DBC20515
	for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2015 14:50:10 +0000 (UTC)
Received: from localhost (173-27-161-33.client.mchsi.com [173.27.161.33])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1F3CD204EB
	for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2015 14:50:09 +0000 (UTC)
Subject: [PATCH] PCI: Simplify config space size computation
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 08 Dec 2015 08:50:07 -0600
Message-ID: <20151208145007.32114.75564.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Restructure the logic so we return the config space size as soon as we know
it.  This reduces indentation, removes negations, and removes gotos.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index edb1984..0d86c82 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1107,14 +1107,11 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 	int pos = PCI_CFG_SPACE_SIZE;
 
 	if (pci_read_config_dword(dev, pos, &status) != PCIBIOS_SUCCESSFUL)
-		goto fail;
+		return PCI_CFG_SPACE_SIZE;
 	if (status == 0xffffffff || pci_ext_cfg_is_aliased(dev))
-		goto fail;
+		return PCI_CFG_SPACE_SIZE;
 
 	return PCI_CFG_SPACE_EXP_SIZE;
-
- fail:
-	return PCI_CFG_SPACE_SIZE;
 }
 
 int pci_cfg_space_size(struct pci_dev *dev)
@@ -1127,19 +1124,17 @@ int pci_cfg_space_size(struct pci_dev *dev)
 	if (class == PCI_CLASS_BRIDGE_HOST)
 		return pci_cfg_space_size_ext(dev);
 
-	if (!pci_is_pcie(dev)) {
-		pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-		if (!pos)
-			goto fail;
+	if (pci_is_pcie(dev))
+		return pci_cfg_space_size_ext(dev);
 
-		pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
-		if (!(status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)))
-			goto fail;
-	}
+	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (!pos)
+		return PCI_CFG_SPACE_SIZE;
 
-	return pci_cfg_space_size_ext(dev);
+	pci_read_config_dword(dev, pos + PCI_X_STATUS, &status);
+	if (status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ))
+		return pci_cfg_space_size_ext(dev);
 
- fail:
 	return PCI_CFG_SPACE_SIZE;
 }
 

