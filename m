Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
To: konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
	david.vrabel@citrix.com, jgross@suse.com, bhelgaas@google.com,
	m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com,
	kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, chuansheng.liu@intel.com,
	baolex.ni@intel.com
Subject: [PATCH 0828/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:50:20 +0800
Message-Id: <20160802115020.5178-1-baolex.ni@intel.com>
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
 drivers/pci/xen-pcifront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 5f70fee..4008d5f 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -77,7 +77,7 @@ static DEFINE_SPINLOCK(pcifront_dev_lock);
 static struct pcifront_device *pcifront_dev;
 
 static int verbose_request;
-module_param(verbose_request, int, 0644);
+module_param(verbose_request, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static int errno_to_pcibios_err(int errno)
 {
-- 
2.9.2
