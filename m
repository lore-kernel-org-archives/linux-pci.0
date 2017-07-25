Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:24025 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbdGYKTC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2017 06:19:02 -0400
Subject: Re: dma_alloc_coherent fail for arm64 in pci ep framework
To: Eric Yang <yu.yang_3@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <VI1PR04MB3071DA0C9EC142F0B2E17B578CB80@VI1PR04MB3071.eurprd04.prod.outlook.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0525e3da-fd81-5289-7065-dc684c793d35@ti.com>
Date: Tue, 25 Jul 2017 15:48:56 +0530
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB3071DA0C9EC142F0B2E17B578CB80@VI1PR04MB3071.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 25 July 2017 03:41 PM, Eric Yang wrote:
> Hi, all
> 
>  
> 
> I test the ep framework in qoriq ls2088a recently in 4.12, and find
> pci_epf_alloc_space() always fail, after debug
> 
> I found that when a EPF device is created by pci_epf_create(), if not invoke
> the arch_setup_dma_ops() manually
> 
> the dev->dma_ops will be NULL, so when dma_alloc occures, it will use the
> default dummy_dma_ops of arm64,
> 
> and will cause the failure.
> 
>  
> 
> For I haven’t test the ep driver entirely, I’m not sure whether this is a bug
> or not.

I think that's a bug. I faced a issue while using pci_epf_alloc_space and I
used a fix like below. Can you try if that helps?

Thanks
Kishon

8<---------------------------------
>From 358257b8a5513d86dd44d376805da9b5b05e819e Mon Sep 17 00:00:00 2001
From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Wed, 5 Jul 2017 19:50:41 +0530
Subject: [PATCH] PCI: endpoint: pci-epc-core: use of_dma_configure() to set
 initial dma mask

Use of_dma_configure() to set the initial dma mask of epf device. This
helps to get rid of "Coherent DMA mask 0x0 (pfn 0x0-0x1) covers a smaller
range of system memory than the DMA zone pfn" warning in certain platforms
like TI's K2G resulting in coherent dma mask not being set.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c
b/drivers/pci/endpoint/pci-epc-core.c
index 44ad93ff0f98..78ea9de4987c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/of_device.h>

 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
@@ -368,6 +369,7 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
 	unsigned long flags;
+	struct device *dev = epc->dev.parent;

 	if (IS_ERR(epc))
 		return -EINVAL;
@@ -375,8 +377,12 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 	if (epf->func_no > epc->max_functions - 1)
 		return -EINVAL;

-	dma_set_coherent_mask(&epf->dev, epc->dev.coherent_dma_mask);
-	epf->dev.dma_mask = epc->dev.dma_mask;
+	if (dev->of_node) {
+		of_dma_configure(&epf->dev, dev->of_node);
+	} else {
+		dma_set_coherent_mask(&epf->dev, epc->dev.coherent_dma_mask);
+		epf->dev.dma_mask = epc->dev.dma_mask;
+	}

 	spin_lock_irqsave(&epc->lock, flags);
 	list_add_tail(&epf->list, &epc->pci_epf);
@@ -493,6 +499,7 @@ __pci_epc_create(struct device *dev, const struct
pci_epc_ops *ops,
 	dma_set_coherent_mask(&epc->dev, dev->coherent_dma_mask);
 	epc->dev.class = pci_epc_class;
 	epc->dev.dma_mask = dev->dma_mask;
+	epc->dev.parent = dev;
 	epc->ops = ops;

 	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
-- 
2.11.0

> 
>  
> 
> BR
> 
> Eirc
> 
