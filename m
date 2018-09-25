Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784BDECE562
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 16:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C16A21508
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 16:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C16A21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeIYWbO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:31:14 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42814 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbeIYWbN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 18:31:13 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g4q6p-0002fH-OJ; Tue, 25 Sep 2018 10:22:58 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g4q6c-00019H-G3; Tue, 25 Sep 2018 10:22:34 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 25 Sep 2018 10:22:21 -0600
Message-Id: <20180925162231.4354-4-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925162231.4354-1-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org, sbates@raithlin.com, hch@lst.de, sagi@grimberg.me, bhelgaas@google.com, jgg@mellanox.com, maxg@mellanox.com, keith.busch@intel.com, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, axboe@kernel.dk, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v7 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to adjust the bus offset
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DMA address used when mapping PCI P2P memory must be the PCI bus
address. Thus, introduce pci_p2pmem_map_sg() to map the correct
addresses when using P2P memory.

Memory mapped in this way does not need to be unmapped and thus if we
provided pci_p2pmem_unmap_sg() it would be empty. This breaks the
expected balance between map/unmap but was left out as an empty
function doesn't really provide any benefit. In the future, if
this call becomes necessary it can be added without much difficulty.

For this, we assume that an SGL passed to these functions contain all
P2P memory or no P2P memory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/p2pdma.c       | 43 ++++++++++++++++++++++++++++++++++++++
 include/linux/memremap.h   |  1 +
 include/linux/pci-p2pdma.h |  7 +++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index d61389945da2..bbbf86165428 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -190,6 +190,8 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->res.flags = pci_resource_flags(pdev, bar);
 	pgmap->ref = &pdev->p2pdma->devmap_ref;
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
+		pci_resource_start(pdev, bar);
 
 	addr = devm_memremap_pages(&pdev->dev, pgmap);
 	if (IS_ERR(addr)) {
@@ -816,3 +818,44 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 	pdev->p2pdma->p2pmem_published = publish;
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
+
+/**
+ * pci_p2pdma_map_sg - map a PCI peer-to-peer scatterlist for DMA
+ * @dev: device doing the DMA request
+ * @sg: scatter list to map
+ * @nents: elements in the scatterlist
+ * @dir: DMA direction
+ *
+ * Scatterlists mapped with this function should not be unmapped in any way.
+ *
+ * Returns the number of SG entries mapped or 0 on error.
+ */
+int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		      enum dma_data_direction dir)
+{
+	struct dev_pagemap *pgmap;
+	struct scatterlist *s;
+	phys_addr_t paddr;
+	int i;
+
+	/*
+	 * p2pdma mappings are not compatible with devices that use
+	 * dma_virt_ops. If the upper layers do the right thing
+	 * this should never happen because it will be prevented
+	 * by the check in pci_p2pdma_add_client()
+	 */
+	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
+			 dev->dma_ops == &dma_virt_ops))
+		return 0;
+
+	for_each_sg(sg, s, nents, i) {
+		pgmap = sg_page(s)->pgmap;
+		paddr = sg_phys(s);
+
+		s->dma_address = paddr - pgmap->pci_p2pdma_bus_offset;
+		sg_dma_len(s) = s->length;
+	}
+
+	return nents;
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 9553370ebdad..0ac69ddf5fc4 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -125,6 +125,7 @@ struct dev_pagemap {
 	struct device *dev;
 	void *data;
 	enum memory_type type;
+	u64 pci_p2pdma_bus_offset;
 };
 
 #ifdef CONFIG_ZONE_DEVICE
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 127e95f50491..f039c48990a5 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -35,6 +35,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
 					 unsigned int *nents, u32 length);
 void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
+int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		      enum dma_data_direction dir);
 #else /* CONFIG_PCI_P2PDMA */
 static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
 		size_t size, u64 offset)
@@ -97,5 +99,10 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
+static inline int pci_p2pdma_map_sg(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_P2PDMA */
 #endif /* _LINUX_PCI_P2P_H */
-- 
2.19.0

