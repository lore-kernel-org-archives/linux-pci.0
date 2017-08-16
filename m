Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751969AbdHPUfp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 16:35:45 -0400
Date: Wed, 16 Aug 2017 15:35:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/host-xilinx 8/8] drivers/pci/host/pcie-xilinx.c:225:62:
 warning: format '%x' expects argument of type 'unsigned int', but argument 4
 has type 'irq_hw_number_t {aka long unsigned int}'
Message-ID: <20170816203543.GF28977@bhelgaas-glaptop.roam.corp.google.com>
References: <201708170457.hTqAwlWn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201708170457.hTqAwlWn%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 17, 2017 at 04:01:01AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-xilinx
> head:   3869791df25e649d3d05c0129cfc25cd3dea8ee7
> commit: 3869791df25e649d3d05c0129cfc25cd3dea8ee7 [8/8] Speculative ... is this what other drivers do?
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 3869791df25e649d3d05c0129cfc25cd3dea8ee7
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pci/host/pcie-xilinx.c: In function 'xilinx_pcie_destroy_msi':
> >> drivers/pci/host/pcie-xilinx.c:225:62: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'irq_hw_number_t {aka long unsigned int}' [-Wformat=]
>       dev_err(port->dev, "Trying to free unused MSI#%d (hwirq 0x%x)\n",

My fault.  I included a draft patch by mistake.  I dropped it.

> vim +225 drivers/pci/host/pcie-xilinx.c
> 
>    210	
>    211	/**
>    212	 * xilinx_pcie_destroy_msi - Free MSI number
>    213	 * @irq: IRQ to be freed
>    214	 */
>    215	static void xilinx_pcie_destroy_msi(unsigned int irq)
>    216	{
>    217		struct msi_desc *msi;
>    218		struct xilinx_pcie_port *port;
>    219		struct irq_data *d = irq_get_irq_data(irq);
>    220		irq_hw_number_t hwirq = irqd_to_hwirq(d);
>    221	
>    222		if (!test_bit(hwirq, msi_irq_in_use)) {
>    223			msi = irq_get_msi_desc(irq);
>    224			port = msi_desc_to_pci_sysdata(msi);
>  > 225			dev_err(port->dev, "Trying to free unused MSI#%d (hwirq 0x%x)\n",
>    226				irq, hwirq);
>    227			return;
>    228		}
>    229	
>    230		clear_bit(hwirq, msi_irq_in_use);
>    231	}
>    232	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
