Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbdCISWM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Mar 2017 13:22:12 -0500
Date: Thu, 9 Mar 2017 12:22:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Oza Oza <oza.oza@broadcom.com>,
        JD Zheng <jiandong.zheng@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: pcie-iproc: broken 2nd (& 3rd?) controller support by
 c3245a566400 ("PCI: iproc: Request host bridge window resources")
Message-ID: <20170309182205.GB3685@bhelgaas-glaptop.roam.corp.google.com>
References: <faab6b85-58e8-3e62-8763-56a94b13fba1@gmail.com>
 <f40bbf2f-3ba9-3992-d417-6588085f3d62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <f40bbf2f-3ba9-3992-d417-6588085f3d62@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 09, 2017 at 08:39:07AM +0100, Rafał Miłecki wrote:
> On 03/08/2017 01:56 PM, Rafał Miłecki wrote:
> >I just tried upgrading BCM5301X from 4.4 to 4.9 and noticed I don't see card
> >connected to the 2nd controller.
> >
> > pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
> > pcie_iproc_bcma bcma0:7: link: UP
> > PCI: bus0: Fast back to back transfers disabled
> > pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > PCI: bus1: Fast back to back transfers disabled
> > pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
> > pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
> > pci 0000:00:00.0: PCI bridge to [bus 01]
> > pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]
> >
> > pcie_iproc_bcma bcma0:8: resource collision: [mem 0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem 0x40000000-0x47ffffff]
> > pcie_iproc_bcma bcma0:8: PCIe controller setup failed
> > pcie_iproc_bcma: probe of bcma0:8 failed with error -16
> >
> >
> >This used to work with older kernels because there wasn't any collision check:
> >
> > pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
> > pcie_iproc_bcma bcma0:7: link: UP
> > PCI: bus0: Fast back to back transfers disabled
> > pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > PCI: bus1: Fast back to back transfers disabled
> > pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
> > pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
> > pci 0000:00:00.0: PCI bridge to [bus 01]
> > pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]
> >
> > pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
> > pci_bus 0001:00: root bus resource [mem 0x40000000-0x47ffffff]
> > pcie_iproc_bcma bcma0:8: link: UP
> > PCI: bus0: Fast back to back transfers disabled
> > pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > PCI: bus1: Fast back to back transfers disabled
> > pci 0001:00:00.0: BAR 8: assigned [mem 0x40000000-0x400fffff]
> > pci 0001:01:00.0: BAR 0: assigned [mem 0x40000000-0x40007fff 64bit]
> > pci 0001:00:00.0: PCI bridge to [bus 01]
> > pci 0001:00:00.0:   bridge window [mem 0x40000000-0x400fffff]
> >
> >
> >I guess the check is OK after all and the real problem is iproc driver assigning
> >the same resource.
> >
> >Broadcom team: could you take a look at this, please?
> 
> I found a reason of this conflict (and probably random crashes I started
> seeing with 4.9). I believe we have a memory corruption.

Yep, we're using a resource structure on the stack when we shouldn't.  Can
you try the patch below?

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index bd4c9ec25edc..8cebbbff1e72 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -44,8 +44,7 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 {
 	struct device *dev = &bdev->dev;
 	struct iproc_pcie *pcie;
-	LIST_HEAD(res);
-	struct resource res_mem;
+	LIST_HEAD(resources);
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -63,22 +62,23 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 
 	pcie->base_addr = bdev->addr;
 
-	res_mem.start = bdev->addr_s[0];
-	res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
-	res_mem.name = "PCIe MEM space";
-	res_mem.flags = IORESOURCE_MEM;
-	pci_add_resource(&res, &res_mem);
+	pcie->mem.start = bdev->addr_s[0];
+	pcie->mem.end = bdev->addr_s[0] + SZ_128M - 1;
+	pcie->mem.name = "PCIe MEM space";
+	pcie->mem.flags = IORESOURCE_MEM;
+	pci_add_resource(&resources, &pcie->mem);
 
 	pcie->map_irq = iproc_pcie_bcma_map_irq;
 
-	ret = iproc_pcie_setup(pcie, &res);
+	ret = iproc_pcie_setup(pcie, &resources);
 	if (ret)
 		dev_err(dev, "PCIe controller setup failed\n");
-
-	pci_free_resource_list(&res);
+		pci_free_resource_list(&resources);
+		return ret;
+	}
 
 	bcma_set_drvdata(bdev, pcie);
-	return ret;
+	return 0;
 }
 
 static void iproc_pcie_bcma_remove(struct bcma_device *bdev)
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index f4909bb0b2ad..5f6361f27c69 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -51,7 +51,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct resource reg;
 	resource_size_t iobase = 0;
-	LIST_HEAD(res);
+	LIST_HEAD(resources);
 	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
@@ -96,10 +96,10 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		pcie->phy = NULL;
 	}
 
-	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &iobase);
+	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &resources,
+					       &iobase);
 	if (ret) {
-		dev_err(dev,
-			"unable to get PCI host bridge resources\n");
+		dev_err(dev, "unable to get PCI host bridge resources\n");
 		return ret;
 	}
 
@@ -112,14 +112,15 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		pcie->map_irq = of_irq_parse_and_map_pci;
 	}
 
-	ret = iproc_pcie_setup(pcie, &res);
+	ret = iproc_pcie_setup(pcie, &resources);
 	if (ret)
 		dev_err(dev, "PCIe controller setup failed\n");
-
-	pci_free_resource_list(&res);
+		pci_free_resource_list(&resources);
+		return ret;
+	}
 
 	platform_set_drvdata(pdev, pcie);
-	return ret;
+	return 0;
 }
 
 static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index 04fed8e907f1..0bbe2ea44f3e 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -90,6 +90,7 @@ struct iproc_pcie {
 #ifdef CONFIG_ARM
 	struct pci_sys_data sysdata;
 #endif
+	struct resource mem;
 	struct pci_bus *root_bus;
 	struct phy *phy;
 	int (*map_irq)(const struct pci_dev *, u8, u8);
