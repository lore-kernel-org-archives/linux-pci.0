Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbdBGOsB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 09:48:01 -0500
Date: Tue, 7 Feb 2017 08:47:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V3] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
Message-ID: <20170207144754.GA11769@bhelgaas-glaptop.roam.corp.google.com>
References: <1486362304-56261-1-git-send-email-liudongdong3@huawei.com>
 <20170206224041.GB27899@bhelgaas-glaptop.roam.corp.google.com>
 <89c7b769-f410-1526-b147-b3361b4fa9d7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <89c7b769-f410-1526-b147-b3361b4fa9d7@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 07, 2017 at 09:34:43AM +0800, Dongdong Liu wrote:
> Hi Bjorn
> 
> 在 2017/2/7 6:40, Bjorn Helgaas 写道:
> >On Mon, Feb 06, 2017 at 02:25:04PM +0800, Dongdong Liu wrote:
> >>The PCIe controller in Hip06/Hip07 SoCs is not completely
> >>ECAM-compliant. It is non-ECAM only for the RC bus config space; for
> >>any other bus underneath the root bus it does support ECAM access.
> >>This is to add the almost ECAM support in DT way.
> >>
> >>Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >>Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >>Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> >
> >Applied to pci/host-hisi for v4.11, thanks!
> 
> Thanks for applying this patch.
> 
> >
> >>-#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> >>+#if defined(CONFIG_PCI_HISI) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
> >>
> >> static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> >> 				  int size, u32 *val)
> >
> >These "_acpi_" accessors are now used for both the ACPI and the DT
> >model, and the accessors aren't ACPI-specific anyway.  So these are
> >slight misnomers.
> 
> Yes, It is better to change hisi_pcie_acpi_rd_conf()/ hisi_pcie_acpi_wr_conf() to hisi_pcie_rd_conf()/hisi_pcie_wr_conf().

I added a trivial patch to do this rename.

> >>+static int hisi_pcie_platform_init(struct pci_config_window *cfg)
> >>+{
> >>+	struct device *dev = cfg->parent;
> >>+	struct platform_device *pdev = to_platform_device(dev);
> >>+	struct resource *res;
> >>+	void __iomem *reg_base;
> >>+
> >>+	if (!dev->of_node)
> >>+		return -EINVAL;
> >
> >What's the point of testing dev->of_node here?  There's no obvious
> >dependency on of_node in this code.  Could we just drop this test?
> 
> Yes, only DT driver will call this function, we should drop this test.
> Thanks for pointing this.

I dropped this test.

Please check out
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-hisi
to make sure it looks OK.

I haven't applied the IRQ patch yet, but am looking at that next.

Bjorn
