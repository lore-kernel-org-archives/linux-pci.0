Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:47548 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbaBUBme (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 20:42:34 -0500
Message-ID: <5306AF07.6000601@gmail.com>
Date: Thu, 20 Feb 2014 17:42:31 -0800
From: Rajat Jain <rajatxjain@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
CC: Rajat Jain <rajatjain@juniper.net>,
	Guenter Roeck <groeck@juniper.net>
Subject: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In case of a spurious "cmd completed", pcie_write_cmd() does not
clear it, but yet expects more "cmd completed" events to be generated.
This does not happen because the previous (spurious) event has not
been acknowledged. Fix that.

Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Guenter Roeck <groeck@juniper.net>
---
 drivers/pci/hotplug/pciehp_hpc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index d7d058f..1463412 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -159,6 +159,8 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (slot_status & PCI_EXP_SLTSTA_CC) {
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+					   PCI_EXP_SLTSTA_CC);
 		if (!ctrl->no_cmd_complete) {
 			/*
 			 * After 1 sec and CMD_COMPLETED still not set, just
-- 
1.7.9.5

