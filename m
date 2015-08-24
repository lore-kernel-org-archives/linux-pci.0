Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: mingo@kernel.org
Cc: bp@suse.de, bhelgaas@google.com, tomi.valkeinen@ti.com,
	airlied@linux.ie, linux-fbdev@vger.kernel.org, luto@amacapital.net,
	vinod.koul@intel.com, dan.j.williams@intel.com, toshi.kani@hp.com,
	benh@kernel.crashing.org, mst@redhat.com,
	akpm@linux-foundation.org, daniel.vetter@ffwll.ch,
	konrad.wilk@oracle.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>, dmaengine@vger.kernel.org
Subject: [PATCH v4 09/11] drivers/dma/iop-adma: Use dma_alloc_writecombine() kernel-style
Date: Mon, 24 Aug 2015 12:13:31 -0700
Message-Id: <1440443613-13696-10-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
References: <1440443613-13696-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

dma_alloc_writecombine()'s call and return value check is tangled in all
in one call. Untangle both calls according to kernel coding style.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1435258191-543-2-git-send-email-mcgrof@do-not-panic.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/dma/iop-adma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 998826854fdd..e4f43125e0fb 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -1300,10 +1300,11 @@ static int iop_adma_probe(struct platform_device *pdev)
 	 * note: writecombine gives slightly better performance, but
 	 * requires that we explicitly flush the writes
 	 */
-	if ((adev->dma_desc_pool_virt = dma_alloc_writecombine(&pdev->dev,
-					plat_data->pool_size,
-					&adev->dma_desc_pool,
-					GFP_KERNEL)) == NULL) {
+	adev->dma_desc_pool_virt = dma_alloc_writecombine(&pdev->dev,
+							  plat_data->pool_size,
+							  &adev->dma_desc_pool,
+							  GFP_KERNEL);
+	if (!adev->dma_desc_pool_virt) {
 		ret = -ENOMEM;
 		goto err_free_adev;
 	}
-- 
2.4.3

