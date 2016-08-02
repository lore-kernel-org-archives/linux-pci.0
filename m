Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
To: bhelgaas@google.com, paulus@samba.org, mpe@ellerman.id.au,
	sbranden@broadcom.com, m.chehab@samsung.com, pawel@osciak.com,
	m.szyprowski@samsung.com, kyungmin.park@samsung.com,
	k.kozlowski@samsung.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0826/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:50:10 +0800
Message-Id: <20160802115010.5044-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8b4dbd..3f583ad 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4897,7 +4897,7 @@ static ssize_t pci_resource_alignment_store(struct bus_type *bus,
 	return pci_set_resource_alignment_param(buf, count);
 }
 
-BUS_ATTR(resource_alignment, 0644, pci_resource_alignment_show,
+BUS_ATTR(resource_alignment, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, pci_resource_alignment_show,
 					pci_resource_alignment_store);
 
 static int __init pci_resource_alignment_sysfs_init(void)
-- 
2.9.2
