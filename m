Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7268 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaGAHRQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jul 2014 03:17:16 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rjw@sisk.pl>,
	<nagananda.chumbalkar@hp.com>, <thierry.reding@gmail.com>,
	<swarren@nvidia.com>, <kthota@nvidia.com>,
	<linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v1] PCI: enable ASPM configuration in PCIE POWERSAVE mode
Date: Tue, 1 Jul 2014 12:46:18 +0530
Message-ID: <1404198978-26593-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit 1a680b7c moved pcie_aspm_powersave_config_link() out of
pci_raw_set_power_state() to pci_set_power_state() which would enable
ASPM. But, with commit db288c9c, which re-introduced the following check
./drivers/pci/pci.c: pci_set_power_state()
+   /* Check if we're already there */
+   if (dev->current_state == state)
+       return 0;
in pci_set_power_state(), call to pcie_aspm_powersave_config_link() is never
made leaving ASPM broken.
Fix it by not returning from when the above condition is true, rather, jump to
ASPM configuration code and exit from there eventually.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1c8592b..ded24c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -804,7 +804,7 @@ EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
  */
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int error;
+	int error = 0;
 
 	/* bound the state we're entering */
 	if (state > PCI_D3cold)
@@ -821,7 +821,7 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	/* Check if we're already there */
 	if (dev->current_state == state)
-		return 0;
+		goto config_aspm;
 
 	__pci_start_power_transition(dev, state);
 
@@ -839,6 +839,8 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	if (!__pci_complete_power_transition(dev, state))
 		error = 0;
+
+config_aspm:
 	/*
 	 * When aspm_policy is "powersave" this call ensures
 	 * that ASPM is configured.
-- 
1.8.1.5

