Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35670 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbbAOFhN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jan 2015 00:37:13 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wilmer van der Gaast <kernel@wilmer.gaast.net>,
	Zhang Rui <rui.zhang@intel.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	stable@vger.kernel.org.#.v3.10+
Subject: [PATCH] PCI: keep enable status consistent for device without driver
Date: Wed, 14 Jan 2015 21:36:48 -0800
Message-Id: <1421300208-7087-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Wilmer reported continuous suspend/resume does not work after
commit 928bea964827 ("PCI: Delay enabling bridges until they're needed").

For pci bridge without driver, FW enable it already.
In pci_pm_resume/pci_pm_reenable_device after first resume
will not reenable the device, aka the status is not the same
as that before first suspend.

Try to update enable status according to register value before
calling pci_reenable_device, so we will not miss those pm
operation calling for next suspend/resume.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=86421
Fixes: 928bea964827 ("PCI: Delay enabling bridges until they're needed")
Reported-by: Wilmer van der Gaast <kernel@wilmer.gaast.net>
Bisected-by: Wilmer van der Gaast <kernel@wilmer.gaast.net>
Tested-by: Wilmer van der Gaast <kernel@wilmer.gaast.net>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
CC: stable@vger.kernel.org  # v3.10+

---
 drivers/pci/pci-driver.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -519,8 +519,17 @@ static void pci_pm_set_unknown_state(str
  */
 static int pci_pm_reenable_device(struct pci_dev *pci_dev)
 {
+	u16 cmd;
 	int retval;
 
+	/* update enable_cnt according to cmd register */
+	pci_read_config_word(pci_dev, PCI_COMMAND, &cmd);
+	if (!pci_dev->is_busmaster && (cmd & PCI_COMMAND_MASTER))
+		pci_dev->is_busmaster = true;
+	if (!pci_is_enabled(pci_dev) &&
+	    (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)))
+		atomic_inc(&pci_dev->enable_cnt);
+
 	/* if the device was enabled before suspend, reenable */
 	retval = pci_reenable_device(pci_dev);
 	/*
