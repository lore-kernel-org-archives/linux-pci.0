Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932218AbdHYNjJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Aug 2017 09:39:09 -0400
Date: Fri, 25 Aug 2017 08:39:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Cc: mtk11102 <honghui.zhang@mediatek.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        kbuild-all@01.org, linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [pci:pci/host-mediatek 11/11]
 drivers/pci/host/pcie-mediatek.c:541:43: error: 'node' undeclared
Message-ID: <20170825133905.GA1304@bhelgaas-glaptop.roam.corp.google.com>
References: <201708232205.SymULNVt%fengguang.wu@intel.com>
 <20170823225211.GI8498@bhelgaas-glaptop.roam.corp.google.com>
 <1503544447.19072.7.camel@mhfsdcap03>
 <20170824134451.GA31858@bhelgaas-glaptop.roam.corp.google.com>
 <f3b302a9-d478-96b5-98d0-49d4d4433358@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f3b302a9-d478-96b5-98d0-49d4d4433358@free.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 25, 2017 at 12:01:21PM +0200, Mason wrote:
> On 24/08/2017 15:44, Bjorn Helgaas wrote:
> 
> > On Thu, Aug 24, 2017 at 11:14:07AM +0800, mtk11102 wrote:
> >
> >> @@ -531,8 +533,10 @@ static const struct irq_domain_ops msi_domain_ops =
> >> {
> >>  static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> >>  {
> >>         u32 val;
> >> +       phys_addr_t msg_addr;
> >>
> >> -       val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
> >> +       msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> >> +       val = lower_32_bits(msg_addr);
> >>         writel(val, port->base + PCIE_IMSI_ADDR);
> >>
> >>         val = readl(port->base + PCIE_INT_MASK);
> > 
> > I don't think this is quite right: virt_to_phys() converts a CPU
> > virtual address to a CPU physical address, but the msg_addr is a PCI
> > bus address.  In many cases, PCI bus addresses are identical to CPU
> > physical addresses, but not always.
> 
> Is the virt_to_bus() function not appropriate?

virt_to_bus() is deprecated because there's no way for the caller to
specify which bus.  I don't have a better suggestion than
virt_to_phys(), so I shouldn't have said anything :)

Bjorn
