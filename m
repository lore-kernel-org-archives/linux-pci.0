Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:25743 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdHRO7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2017 10:59:08 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 14/18] misc: pci_endpoint_test: Add support to provide aligned buffer addresses
Date: Fri, 18 Aug 2017 20:28:06 +0530
Message-ID: <20170818145810.17649-15-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some platforms like TI's K2G have a restriction that the host side
buffer address should be aligned to either 1MB/2MB/4MB or 8MB
(Ref: 11.14.4.9.1 Outbound Address Translation in K2G TRM SPRUHY8F
January 2016 – Revised May 2017) addresses depending on how it is
configured in the endpoint. Add support to provide such aligned address
here so that pci_endpoint_test driver can be used to test K2G EP.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 91 +++++++++++++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 5fc0f6c6a9e5..5f6bd23ab657 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -91,10 +91,12 @@ struct pci_endpoint_test {
 	struct mutex	mutex;
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
+	size_t alignment;
 };
 
 struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
+	size_t alignment;
 };
 
 static int bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
@@ -210,16 +212,32 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t dst_phys_addr;
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
+	void *orig_src_addr;
+	dma_addr_t orig_src_phys_addr;
+	void *orig_dst_addr;
+	dma_addr_t orig_dst_phys_addr;
+	size_t offset;
+	size_t alignment = test->alignment;
 	u32 src_crc32;
 	u32 dst_crc32;
 
-	src_addr = dma_alloc_coherent(dev, size, &src_phys_addr, GFP_KERNEL);
-	if (!src_addr) {
+	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
+					   &orig_src_phys_addr, GFP_KERNEL);
+	if (!orig_src_addr) {
 		dev_err(dev, "failed to allocate source buffer\n");
 		ret = false;
 		goto err;
 	}
 
+	if (alignment && !IS_ALIGNED(orig_src_phys_addr, alignment)) {
+		src_phys_addr = PTR_ALIGN(orig_src_phys_addr, alignment);
+		offset = src_phys_addr - orig_src_phys_addr;
+		src_addr = orig_src_addr + offset;
+	} else {
+		src_phys_addr = orig_src_phys_addr;
+		src_addr = orig_src_addr;
+	}
+
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
 				 lower_32_bits(src_phys_addr));
 
@@ -229,11 +247,21 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	get_random_bytes(src_addr, size);
 	src_crc32 = crc32_le(~0, src_addr, size);
 
-	dst_addr = dma_alloc_coherent(dev, size, &dst_phys_addr, GFP_KERNEL);
-	if (!dst_addr) {
+	orig_dst_addr = dma_alloc_coherent(dev, size + alignment,
+					   &orig_dst_phys_addr, GFP_KERNEL);
+	if (!orig_dst_addr) {
 		dev_err(dev, "failed to allocate destination address\n");
 		ret = false;
-		goto err_src_addr;
+		goto err_orig_src_addr;
+	}
+
+	if (alignment && !IS_ALIGNED(orig_dst_phys_addr, alignment)) {
+		dst_phys_addr = PTR_ALIGN(orig_dst_phys_addr, alignment);
+		offset = dst_phys_addr - orig_dst_phys_addr;
+		dst_addr = orig_dst_addr + offset;
+	} else {
+		dst_phys_addr = orig_dst_phys_addr;
+		dst_addr = orig_dst_addr;
 	}
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
@@ -253,10 +281,12 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	if (dst_crc32 == src_crc32)
 		ret = true;
 
-	dma_free_coherent(dev, size, dst_addr, dst_phys_addr);
+	dma_free_coherent(dev, size + alignment, orig_dst_addr,
+			  orig_dst_phys_addr);
 
-err_src_addr:
-	dma_free_coherent(dev, size, src_addr, src_phys_addr);
+err_orig_src_addr:
+	dma_free_coherent(dev, size + alignment, orig_src_addr,
+			  orig_src_phys_addr);
 
 err:
 	return ret;
@@ -270,15 +300,29 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t phys_addr;
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
+	void *orig_addr;
+	dma_addr_t orig_phys_addr;
+	size_t offset;
+	size_t alignment = test->alignment;
 	u32 crc32;
 
-	addr = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
-	if (!addr) {
+	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
+				       GFP_KERNEL);
+	if (!orig_addr) {
 		dev_err(dev, "failed to allocate address\n");
 		ret = false;
 		goto err;
 	}
 
+	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
+		phys_addr =  PTR_ALIGN(orig_phys_addr, alignment);
+		offset = phys_addr - orig_phys_addr;
+		addr = orig_addr + offset;
+	} else {
+		phys_addr = orig_phys_addr;
+		addr = orig_addr;
+	}
+
 	get_random_bytes(addr, size);
 
 	crc32 = crc32_le(~0, addr, size);
@@ -301,7 +345,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	if (reg & STATUS_READ_SUCCESS)
 		ret = true;
 
-	dma_free_coherent(dev, size, addr, phys_addr);
+	dma_free_coherent(dev, size + alignment, orig_addr, orig_phys_addr);
 
 err:
 	return ret;
@@ -314,15 +358,29 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t phys_addr;
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
+	void *orig_addr;
+	dma_addr_t orig_phys_addr;
+	size_t offset;
+	size_t alignment = test->alignment;
 	u32 crc32;
 
-	addr = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
-	if (!addr) {
+	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
+				       GFP_KERNEL);
+	if (!orig_addr) {
 		dev_err(dev, "failed to allocate destination address\n");
 		ret = false;
 		goto err;
 	}
 
+	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
+		phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
+		offset = phys_addr - orig_phys_addr;
+		addr = orig_addr + offset;
+	} else {
+		phys_addr = orig_phys_addr;
+		addr = orig_addr;
+	}
+
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
 				 lower_32_bits(phys_addr));
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
@@ -339,7 +397,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
 		ret = true;
 
-	dma_free_coherent(dev, size, addr, phys_addr);
+	dma_free_coherent(dev, size + alignment, orig_addr, orig_phys_addr);
 err:
 	return ret;
 }
@@ -410,11 +468,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	test->test_reg_bar = 0;
+	test->alignment = 0;
 	test->pdev = pdev;
 
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
-	if (data)
+	if (data) {
 		test_reg_bar = data->test_reg_bar;
+		test->alignment = data->alignment;
+	}
 
 	init_completion(&test->irq_raised);
 	mutex_init(&test->mutex);
-- 
2.11.0
