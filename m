Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B2C10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A25218A2
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfCVQSL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfCVQSL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 12:18:11 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MOiPx-1hM1Sy32Yp-00QCNR; Fri, 22 Mar 2019 17:17:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 4/8] PCI: endpoint: Use EPC's device in dma_alloc_coherent()/dma_free_coherent()
Date:   Fri, 22 Mar 2019 17:17:19 +0100
Message-Id: <20190322161727.1153278-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o2CLoPPlNd8UOmBaKmOyATpVwB8HHtVtSKM+jhSfSQtfC+aMt0q
 Qy8eWkE1aQFAplhErWK22aC11lYeUAfBhRJn1G7KaUwzS3+PfKvotAAzb2q/2Vitzgva2Sm
 b/CLGslToUt3vsGJzvb5EtZB2z2rwSNwXouP3yRu7Ap2t1HNwcb8Xt7nTAfm/9l5zu4WN18
 a3MZl5DvVAQpq5cbMtfyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MQsZCJCy4cU=:oI3MyfMmFwB3s/9sNcqbtp
 PDb1eAr102e0g9COK2Xh5YELeGSqD4+p3tyBjSXv1MZlCzLi6iDWv7ir/iuJVbi3uxmfq3vWX
 mUl24vGjKYbfq3ZDMAamq5OkzGnrNr0zyDV81ci5EOe1gelWA8KTiJpmb2AzFvjf69QSV6Pwy
 5xQtmYWA1eN2xvf56ex2SBBjPGvFTCaListYnKqt3A7Vd311U/B0h/eY5diZMCEpNIx2zFfq+
 VIaB7eNiJDH3HH4g0KD1BgVgu9fmcyzHBaUIgJ57P1rsgbMGa3HEF9aGpmXD54EoWG3OPD/pO
 paws2HxHC3U0sNR84cv3+aFKqtJuBwIP7ON007WQ4G+BN4Y2BQaqgmvQONsRyIvUOp+vBYV7U
 jgpeGnpIfr3H22/US9E4cj9yJ8xf8SlQnsPRjSmh1Q1ZO/VTuUQv0W9M9MFqEZX5P0Kq0Vts9
 TeiX/zO+tRqTVoVEcG8/fugZGUkQ+2MSSl7sL/rqtQjZcwqta4SgTmKdYSyo2hs4MObWqsedz
 H7lNJH6KjdlCWDeyVRoo1BIYlFCMsdhohCojQSbe9VEhcDYL2fsYVCWBYFEyc9ZPi/BTGeFLM
 Z04XS+CPv7JE377BdIPFmDhD164XnzuVZR7S5asOjzNqxC5GEwlVQoIupaYpsBYC89u8S0UZ2
 x4+XxzaE9RQmvNv3frmnRd77CH2jL1pqkoUuHFWz3sZ5kFCYqmdjQY3nA+LZBTphI8xopbH84
 o+9wMdO4tdMAtu6+C3UEHUdWSal6KmTveyZfzA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

After commit 723288836628 ("of: restrict DMA configuration"),
of_dma_configure() doesn't configure the coherent_dma_mask/dma_mask
of endpoint function device (since it doesn't have a DT node associated
with and hence no dma-ranges property), resulting in
dma_alloc_coherent() (used in pci_epf_alloc_space()) to fail.

Fix it by making dma_alloc_coherent() use EPC's device for allocating
memory address.

Link: http://lkml.kernel.org/r/64d63468-d28f-8fcd-a6f3-cf2a6401c8cb@ti.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[lorenzo.pieralisi@arm.com: tweaked commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Tested-by: Niklas Cassel <niklas.cassel@axis.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
(cherry picked from commit b330104fa76df3eae6e199a23791fed5d35f06b4)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/endpoint/pci-epc-core.c | 10 ----------
 drivers/pci/endpoint/pci-epf-core.c |  4 ++--
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 42c2a1156325..cd7d4788b94d 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -371,7 +370,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
 	unsigned long flags;
-	struct device *dev = epc->dev.parent;
 
 	if (epf->epc)
 		return -EBUSY;
@@ -383,12 +381,6 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 		return -EINVAL;
 
 	epf->epc = epc;
-	if (dev->of_node) {
-		of_dma_configure(&epf->dev, dev->of_node);
-	} else {
-		dma_set_coherent_mask(&epf->dev, epc->dev.coherent_dma_mask);
-		epf->dev.dma_mask = epc->dev.dma_mask;
-	}
 
 	spin_lock_irqsave(&epc->lock, flags);
 	list_add_tail(&epf->list, &epc->pci_epf);
@@ -503,9 +495,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	INIT_LIST_HEAD(&epc->pci_epf);
 
 	device_initialize(&epc->dev);
-	dma_set_coherent_mask(&epc->dev, dev->coherent_dma_mask);
 	epc->dev.class = pci_epc_class;
-	epc->dev.dma_mask = dev->dma_mask;
 	epc->dev.parent = dev;
 	epc->ops = ops;
 
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index ae1611a62808..95ccc4b8a0a2 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -99,7 +99,7 @@ EXPORT_SYMBOL_GPL(pci_epf_bind);
  */
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar)
 {
-	struct device *dev = &epf->dev;
+	struct device *dev = epf->epc->dev.parent;
 
 	if (!addr)
 		return;
@@ -122,7 +122,7 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
 void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
 {
 	void *space;
-	struct device *dev = &epf->dev;
+	struct device *dev = epf->epc->dev.parent;
 	dma_addr_t phys_addr;
 
 	if (size < 128)
-- 
2.20.0

