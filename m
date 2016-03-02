Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44293 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbcCBWbH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Mar 2016 17:31:07 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] VMD: Set bus resource start to 0
Date: Wed,  2 Mar 2016 15:31:04 -0700
Message-Id: <1456957864-1603-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1456957864-1603-1-git-send-email-keith.busch@intel.com>
References: <1456957864-1603-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The bus always starts at 0. Due to alignment and down-casting, this
happened to work before, but looked alarmingly incorrect in kernel logs.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/pci/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 68faa5e..f60ecaa 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -527,7 +527,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 	res = &vmd->dev->resource[VMD_CFGBAR];
 	vmd->resources[0] = (struct resource) {
 		.name  = "VMD CFGBAR",
-		.start = res->start,
+		.start = 0,
 		.end   = (resource_size(res) >> 20) - 1,
 		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
 	};
-- 
2.7.2

