Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:45528 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbaFNVV1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jun 2014 17:21:27 -0400
Received: by mail-ig0-f172.google.com with SMTP id l13so1645317iga.5
        for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2014 14:21:27 -0700 (PDT)
Subject: [PATCH RFC 2/4] PCI: pciehp: Wait for hotplug command completion
 lazily
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>, linux-pci@vger.kernel.org
Date: Sat, 14 Jun 2014 15:21:26 -0600
Message-ID: <20140614212126.15202.66060.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we issued a hotplug command and waited for it to complete.  But
there's no need to wait until we're ready to issue the *next* command.  The
next command will probably be much later, so the first one may have already
completed and we may not have to actually wait at all.

Because of hardware errata, some controllers generate command completion
events for some commands but not others.  In the case of Intel CF118 (see
spec update reference), the controller indicates command completion only
for Slot Control writes that change the value of the following bits:

  Power Controller Control
  Power Indicator Control
  Attention Indicator Control
  Electromechanical Interlock Control

Changes to other bits, e.g., the interrupt enable bits, do not cause the
Command Completed bit to be set.  Controllers from AMD and Nvidia are
reported to have similar errata.

These errata cause timeouts when pcie_enable_notification() enables
interrupts.  Previously that timeout occurred at boot-time.  With this
change, the timeout occurs later, when we change the state of the slot
power, indicators, or interlock.  This speeds up boot but causes a timeout
at the first hotplug event on the slot.  Subsequent events don't timeout
because only the first (boot-time) hotplug command updates Slot Control
without touching the power/indicator/interlock controls.

Link: http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 0e76e9d9d134..f44fdb5b0b08 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -165,6 +165,9 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 
 	mutex_lock(&ctrl->ctrl_lock);
 
+	/* Wait for any previous command that might still be in progress */
+	pcie_wait_cmd(ctrl);
+
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (slot_status & PCI_EXP_SLTSTA_CC) {
 		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
@@ -197,10 +200,6 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
 	ctrl->slot_ctrl = slot_ctrl;
 
-	/*
-	 * Wait for command completion.
-	 */
-	pcie_wait_cmd(ctrl);
 	mutex_unlock(&ctrl->ctrl_lock);
 }
 

