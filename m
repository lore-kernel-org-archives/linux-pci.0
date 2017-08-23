Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdHWWwO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Aug 2017 18:52:14 -0400
Date: Wed, 23 Aug 2017 17:52:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Honghui Zhang <honghui.zhang@mediatek.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pci:pci/host-mediatek 11/11]
 drivers/pci/host/pcie-mediatek.c:541:43: error: 'node' undeclared
Message-ID: <20170823225211.GI8498@bhelgaas-glaptop.roam.corp.google.com>
References: <201708232205.SymULNVt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201708232205.SymULNVt%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 10:53:07PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-mediatek
> head:   8e8ed61600e99258ff59bf36b85b671eed25a462
> commit: 8e8ed61600e99258ff59bf36b85b671eed25a462 [11/11] PCI: mediatek: Add MSI support for MT2712 and MT7622
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 8e8ed61600e99258ff59bf36b85b671eed25a462
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 

The "node" and "dev" undeclared errors are my fault, and I fixed them.  But
I don't think I introduced the casting warnings.  These warnings are on a
32-bit build.

I pushed the update to fix the node/dev errors.  Please take a look at the
remaining casting warnings.

> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/clk.h:16:0,
>                     from drivers/pci/host/pcie-mediatek.c:18:
>    drivers/pci/host/pcie-mediatek.c: In function 'mtk_pcie_msi_setup_irq':
> >> drivers/pci/host/pcie-mediatek.c:488:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      msg.address_lo = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
>                                     ^
>    include/linux/kernel.h:178:33: note: in definition of macro 'lower_32_bits'
>     #define lower_32_bits(n) ((u32)(n))
>                                     ^
>    drivers/pci/host/pcie-mediatek.c: In function 'mtk_pcie_enable_msi':
> >> drivers/pci/host/pcie-mediatek.c:541:43: error: 'node' undeclared (first use in this function)
>      port->msi_domain = irq_domain_add_linear(node, MTK_MSI_IRQS_NUM,
>                                               ^~~~
>    drivers/pci/host/pcie-mediatek.c:541:43: note: each undeclared identifier is reported only once for each function it appears in
> >> drivers/pci/host/pcie-mediatek.c:545:11: error: 'dev' undeclared (first use in this function)
>       dev_err(dev, "failed to create MSI IRQ domain\n");
>               ^~~
>    In file included from include/linux/clk.h:16:0,
>                     from drivers/pci/host/pcie-mediatek.c:18:
>    drivers/pci/host/pcie-mediatek.c:549:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
>                          ^
>    include/linux/kernel.h:178:33: note: in definition of macro 'lower_32_bits'
>     #define lower_32_bits(n) ((u32)(n))
>                                     ^
> 
> vim +/node +541 drivers/pci/host/pcie-mediatek.c
> 
>    459	
>    460	static int mtk_pcie_msi_setup_irq(struct msi_controller *chip,
>    461					  struct pci_dev *pdev, struct msi_desc *desc)
>    462	{
>    463		struct mtk_pcie_port *port;
>    464		struct msi_msg msg;
>    465		unsigned int irq;
>    466		int hwirq;
>    467	
>    468		port = mtk_pcie_find_port(pdev->bus, pdev->devfn);
>    469		if (!port)
>    470			return -EINVAL;
>    471	
>    472		hwirq = mtk_pcie_msi_alloc(port);
>    473		if (hwirq < 0)
>    474			return hwirq;
>    475	
>    476		irq = irq_create_mapping(port->msi_domain, hwirq);
>    477		if (!irq) {
>    478			mtk_pcie_msi_free(port, hwirq);
>    479			return -EINVAL;
>    480		}
>    481	
>    482		chip->dev = &pdev->dev;
>    483	
>    484		irq_set_msi_desc(irq, desc);
>    485	
>    486		/* MT2712/MT7622 only support 32-bit MSI addresses */
>    487		msg.address_hi = 0;
>  > 488		msg.address_lo = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
>    489		msg.data = hwirq;
>    490	
>    491		pci_write_msi_msg(irq, &msg);
>    492	
>    493		return 0;
>    494	}
>    495	
>    496	static void mtk_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
>    497	{
>    498		struct pci_dev *pdev = to_pci_dev(chip->dev);
>    499		struct irq_data *d = irq_get_irq_data(irq);
>    500		irq_hw_number_t hwirq = irqd_to_hwirq(d);
>    501		struct mtk_pcie_port *port;
>    502	
>    503		port = mtk_pcie_find_port(pdev->bus, pdev->devfn);
>    504		if (!port)
>    505			return;
>    506	
>    507		irq_dispose_mapping(irq);
>    508		mtk_pcie_msi_free(port, hwirq);
>    509	}
>    510	
>    511	static struct msi_controller mtk_pcie_msi_chip = {
>    512		.setup_irq = mtk_pcie_msi_setup_irq,
>    513		.teardown_irq = mtk_msi_teardown_irq,
>    514	};
>    515	
>    516	static struct irq_chip mtk_msi_irq_chip = {
>    517		.name = "MTK PCIe MSI",
>    518		.irq_enable = pci_msi_unmask_irq,
>    519		.irq_disable = pci_msi_mask_irq,
>    520		.irq_mask = pci_msi_mask_irq,
>    521		.irq_unmask = pci_msi_unmask_irq,
>    522	};
>    523	
>    524	static int mtk_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
>    525				    irq_hw_number_t hwirq)
>    526	{
>    527		irq_set_chip_and_handler(irq, &mtk_msi_irq_chip, handle_simple_irq);
>    528		irq_set_chip_data(irq, domain->host_data);
>    529	
>    530		return 0;
>    531	}
>    532	
>    533	static const struct irq_domain_ops msi_domain_ops = {
>    534		.map = mtk_pcie_msi_map,
>    535	};
>    536	
>    537	static int mtk_pcie_enable_msi(struct mtk_pcie_port *port)
>    538	{
>    539		u32 val;
>    540	
>  > 541		port->msi_domain = irq_domain_add_linear(node, MTK_MSI_IRQS_NUM,
>    542							 &msi_domain_ops,
>    543							 &mtk_pcie_msi_chip);
>    544		if (!port->msi_domain) {
>  > 545			dev_err(dev, "failed to create MSI IRQ domain\n");
>    546			return -ENOMEM;
>    547		}
>    548	
>    549		val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
>    550		writel(val, port->base + PCIE_IMSI_ADDR);
>    551	
>    552		val = readl(port->base + PCIE_INT_MASK);
>    553		val &= ~MSI_MASK;
>    554		writel(val, port->base + PCIE_INT_MASK);
>    555	
>    556		return 0;
>    557	}
>    558	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
