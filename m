Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:33420 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbcEMLRM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:17:12 -0400
Message-Id: <98a243badc295903ec4cf7de5e2985b468c45907.1463134231.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 07/13] PCI: pciehp: Ignore interrupts during D3cold
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If a hotplug port is suspended to D3cold, its slot status register
cannot be read.  If that hotplug port happens to share its IRQ with
other devices, then whenever an interrupt occurs for one of these
devices, a "no response from device" message is logged with level
KERN_INFO.  Apart from this annoyance, CPU time is needlessly spent
trying to read the slot status register even though we know in advance
that it will fail.

On MacBook Pros introduced 2011 and 2012, the IRQ of a Thunderbolt
hotplug port is unfortunately shared with a wireless card, an audio card
and an SDXC controller.  When the Thunderbolt controller is powered
down, the machine carries out at least one unneeded slot status register
read for each wireless packet received and prints a corresponding error
message to the system log.

The hotplug port's current_state will be D3cold when it's powered down,
so ignore interrupts that occur during that power state.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 5c24e93..08e84d6 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -546,6 +546,10 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 	u8 present;
 	bool link;
 
+	/* Interrupts cannot originate from a controller that's asleep */
+	if (pdev->current_state == PCI_D3cold)
+		return IRQ_NONE;
+
 	/*
 	 * In order to guarantee that all interrupt events are
 	 * serviced, we need to re-inspect Slot Status register after
-- 
2.8.1

