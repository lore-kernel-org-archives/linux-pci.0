Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36190 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbbJWFFo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:44 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 02/29] PCI: Add a prototype for pci_find_host_bridge to pci.h
Date: Fri, 23 Oct 2015 06:03:35 +0100
Message-Id: <1445576642-29624-3-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function pci_find_host_bridge is currently only used within
drivers/pci/host-bridge.c however the deferred IRQ assignment
requires its use in multiple files, therefore add a prototype
use within the pci drivers.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 24ba9dc..dfdf606 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -80,6 +80,7 @@ void pci_config_pm_runtime_put(struct pci_dev *dev);
 void pci_pm_init(struct pci_dev *dev);
 void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
+struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
-- 
2.6.2

