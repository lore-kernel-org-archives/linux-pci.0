Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51241 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbaHFJFB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Aug 2014 05:05:01 -0400
From: "Chen, Gong" <gong.chen@linux.intel.com>
To: bhelgaas@google.com, rdunlap@infradead.org, bp@alien8.de,
	tony.luck@intel.com
Cc: linux-pci@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [RFC PATCH 5/5] PCI, aer: Update initial value of UC error mask
Date: Wed,  6 Aug 2014 04:32:44 -0400
Message-Id: <1407313964-20794-5-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1407313964-20794-1-git-send-email-gong.chen@linux.intel.com>
References: <1407313964-20794-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In PCI-e SPEC r3.0, BIT 0 of Uncorrectable Error Status Register
is redefined and it has an explicit requirement that when writing
this field, a value of 1b is the only choice. So change previous
initial maks from 0 to 1.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
NOTE: After scratching all use cases, this is the most obvious use
case to violate the SPEC. Most of use cases just read first and
then overwrite for clear purpose. Even so, such fix is obvious to
not compatiable with previous SPEC definition. Do we need a dirty
hack?

 arch/mips/pci/pci-octeon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 59cccd9..f1bfdc2 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -134,7 +134,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 				       dconfig);
 		/* Enable reporting of all uncorrectable errors */
 		/* Uncorrectable Error Mask - turned on bits disable errors */
-		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, 0);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, 1);
 		/*
 		 * Leave severity at HW default. This only controls if
 		 * errors are reported as uncorrectable or
-- 
2.0.0.rc2

