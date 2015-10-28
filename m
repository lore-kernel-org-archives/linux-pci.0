Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <hanjun.guo@linaro.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V5 5/9] device property: ACPI: Make use of the new DMA Attribute APIs
Date: Wed, 28 Oct 2015 15:50:50 -0700
Message-ID: <1446072654-5608-6-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we have the new DMA attribute APIs, we can replace the older
acpi_check_dma() and device_dma_is_coherent().

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: David S. Miller <davem@davemloft.net>
---
 drivers/acpi/acpi_platform.c              |  7 ++++++-
 drivers/acpi/glue.c                       |  8 +++++---
 drivers/crypto/ccp/ccp-platform.c         | 15 +++++++++++----
 drivers/net/ethernet/amd/xgbe/xgbe-main.c |  8 +++++++-
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 06a67d5..296b7a1 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -103,7 +103,12 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
 	pdevinfo.res = resources;
 	pdevinfo.num_res = count;
 	pdevinfo.fwnode = acpi_fwnode_handle(adev);
-	pdevinfo.dma_mask = acpi_check_dma(adev, NULL) ? DMA_BIT_MASK(32) : 0;
+
+	if (acpi_dma_supported(adev))
+		pdevinfo.dma_mask = DMA_BIT_MASK(32);
+	else
+		pdevinfo.dma_mask = 0;
+
 	pdev = platform_device_register_full(&pdevinfo);
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 1470ae4..5ea5dc2 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -168,7 +168,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	struct list_head *physnode_list;
 	unsigned int node_id;
 	int retval = -EINVAL;
-	bool coherent;
+	enum dev_dma_attr attr;
 
 	if (has_acpi_companion(dev)) {
 		if (acpi_dev) {
@@ -225,8 +225,10 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	if (!has_acpi_companion(dev))
 		ACPI_COMPANION_SET(dev, acpi_dev);
 
-	if (acpi_check_dma(acpi_dev, &coherent))
-		arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
+	attr = acpi_get_dma_attr(acpi_dev);
+	if (attr != DEV_DMA_NOT_SUPPORTED)
+		arch_setup_dma_ops(dev, 0, 0, NULL,
+				   attr == DEV_DMA_COHERENT);
 
 	acpi_physnode_link_name(physical_node_name, node_id);
 	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
diff --git a/drivers/crypto/ccp/ccp-platform.c b/drivers/crypto/ccp/ccp-platform.c
index bb241c3..844118c 100644
--- a/drivers/crypto/ccp/ccp-platform.c
+++ b/drivers/crypto/ccp/ccp-platform.c
@@ -96,6 +96,7 @@ static int ccp_platform_probe(struct platform_device *pdev)
 	struct ccp_platform *ccp_platform;
 	struct device *dev = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(dev);
+	enum dev_dma_attr attr;
 	struct resource *ior;
 	int ret;
 
@@ -122,18 +123,24 @@ static int ccp_platform_probe(struct platform_device *pdev)
 	}
 	ccp->io_regs = ccp->io_map;
 
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
-	if (ret) {
-		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
+	attr = device_get_dma_attr(dev);
+	if (attr == DEV_DMA_NOT_SUPPORTED) {
+		dev_err(dev, "DMA is not supported");
 		goto e_err;
 	}
 
-	ccp_platform->coherent = device_dma_is_coherent(ccp->dev);
+	ccp_platform->coherent = (attr == DEV_DMA_COHERENT);
 	if (ccp_platform->coherent)
 		ccp->axcache = CACHE_WB_NO_ALLOC;
 	else
 		ccp->axcache = CACHE_NONE;
 
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
+	if (ret) {
+		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
+		goto e_err;
+	}
+
 	dev_set_drvdata(dev, ccp);
 
 	ret = ccp_init(ccp);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index e83bd76..c607b3f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -342,6 +342,7 @@ static int xgbe_probe(struct platform_device *pdev)
 	struct resource *res;
 	const char *phy_mode;
 	unsigned int i, phy_memnum, phy_irqnum;
+	enum dev_dma_attr attr;
 	int ret;
 
 	DBGPR("--> xgbe_probe\n");
@@ -609,7 +610,12 @@ static int xgbe_probe(struct platform_device *pdev)
 		goto err_io;
 
 	/* Set the DMA coherency values */
-	pdata->coherent = device_dma_is_coherent(pdata->dev);
+	attr = device_get_dma_attr(dev);
+	if (attr == DEV_DMA_NOT_SUPPORTED) {
+		dev_err(dev, "DMA is not supported");
+		goto err_io;
+	}
+	pdata->coherent = (attr == DEV_DMA_COHERENT);
 	if (pdata->coherent) {
 		pdata->axdomain = XGBE_DMA_OS_AXDOMAIN;
 		pdata->arcache = XGBE_DMA_OS_ARCACHE;
-- 
2.1.0

