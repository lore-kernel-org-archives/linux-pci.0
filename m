Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36208 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:48 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 06/29] PCI: Add a call to pci_assign_irq in do_pci_enable_device
Date: Fri, 23 Oct 2015 06:03:39 +0100
Message-Id: <1445576642-29624-7-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_assign_irq function allows assignment of an irq to devices
during device enable time rather than only at boot. Therefore call it
in the do_pci_enable_device function during the enable device
code path so this assignment can be performed.

This patch will do nothing on arches which do not set the irq mapping
function pointers and is therefore currently a noop, however as support
for these function pointers is added to arch specific code this will
cause irq asignment to migrate to device enable time allowing the new
codepaths to be used.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6a9a111..6907312 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1226,6 +1226,8 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 	if (err < 0 && err != -EIO)
 		return err;
 
+	pci_assign_irq(dev);
+
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
 		pcie_aspm_powersave_config_link(bridge);
-- 
2.6.2

