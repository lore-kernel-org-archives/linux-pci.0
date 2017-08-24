Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31008 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdHXKh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2017 06:37:58 -0400
Date: Thu, 24 Aug 2017 13:37:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kishon@ti.com
Cc: linux-pci@vger.kernel.org
Subject: [bug report] PCI: endpoint: Add EP core layer to enable EP
 controller and EP functions
Message-ID: <20170824103742.ik3tcfa2fcgcdza4@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Kishon Vijay Abraham I,

The patch 5e8cb4033807: "PCI: endpoint: Add EP core layer to enable
EP controller and EP functions" from Apr 10, 2017, leads to the
following static checker warning:

	drivers/pci/endpoint/pci-epc-core.c:379 pci_epc_add_epf()
	warn: 'epc' isn't an ERR_PTR

drivers/pci/endpoint/pci-epc-core.c
   370   */
   371  int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
   372  {
   373          unsigned long flags;
   374          struct device *dev = epc->dev.parent;
                                     ^^^^^^^^^^^^^^^
Dereference.

   375  
   376          if (epf->epc)
   377                  return -EBUSY;
   378  
   379          if (IS_ERR(epc))
                    ^^^^^^^^^^^
Can't be an error pointer or we would already have Oopsed.

   380                  return -EINVAL;
   381  
   382          if (epf->func_no > epc->max_functions - 1)
   383                  return -EINVAL;
   384  
   385          epf->epc = epc;
   386          if (dev->of_node) {
   387                  of_dma_configure(&epf->dev, dev->of_node);
   388          } else {
   389                  dma_set_coherent_mask(&epf->dev, epc->dev.coherent_dma_mask);
   390                  epf->dev.dma_mask = epc->dev.dma_mask;
   391          }
   392  
   393          spin_lock_irqsave(&epc->lock, flags);
   394          list_add_tail(&epf->list, &epc->pci_epf);
   395          spin_unlock_irqrestore(&epc->lock, flags);
   396  
   397          return 0;

regards,
dan carpenter
