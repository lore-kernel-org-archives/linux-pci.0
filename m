Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36838 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbcCBWbH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Mar 2016 17:31:07 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] VMD: Document code for maintainability
Date: Wed,  2 Mar 2016 15:31:03 -0700
Message-Id: <1456957864-1603-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This comments the less obvious portion of the code for setting up
memory windows, and the platform dependency for initializing the h/w
with appropriate resources.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/pci/vmd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index d57e480..68faa5e 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -532,6 +532,23 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
 
+	/*
+	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
+	 * put 32-bit resources in the window.
+	 *
+	 * There's no hardware reason why a 64-bit window *couldn't*
+	 * contain a 32-bit resource, but pbus_size_mem() computes the
+	 * bridge window size assuming a 64-bit window will contain no
+	 * 32-bit resources.  __pci_assign_resource() enforces that
+	 * artificial restriction to make sure everything will fit.
+	 *
+	 * The only way we could use a 64-bit non-prefechable MEMBAR is
+	 * if its address is <4GB so that we can convert it to a 32-bit
+	 * resource. To be visible to the host OS, all VMD endpoints must
+	 * be initially configured by platform BIOS, which includes setting
+	 * up these resources. We can assume the device is configured
+	 * according to the platform needs.
+	 */
 	res = &vmd->dev->resource[VMD_MEMBAR1];
 	upper_bits = upper_32_bits(res->end);
 	flags = res->flags & ~IORESOURCE_SIZEALIGN;
-- 
2.7.2

