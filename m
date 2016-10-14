Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57154 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbcJNNNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Oct 2016 09:13:47 -0400
Subject: Re: [REGRESSION, bisect] pci: artpec-6: imprecise external abort
To: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <Joao.Pinto@synopsys.com>
References: <b53d5807-8199-5789-6184-e37324a1d79e@axis.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Carlos Palminha" <CARLOS.PALMINHA@synopsys.com>,
        <jose.abreu@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <ca0419f5-ad15-8db7-bf42-5c6752a8a3be@synopsys.com>
Date: Fri, 14 Oct 2016 14:02:35 +0100
MIME-Version: 1.0
In-Reply-To: <b53d5807-8199-5789-6184-e37324a1d79e@axis.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,


On 10/14/2016 1:41 PM, Niklas Cassel wrote:
> Hello
> 
> Because of recent changes to drivers/pci/host/pcie-artpec6.c,
> I was going to try out Bjorn's tag pci-v4.9-changes-2,
> however I was greeted by an imprecise external abort:
> 
> 
> [    0.613082] Trying to unpack rootfs image as initramfs...
> [    0.886577] Freeing initrd memory: 4724K (c2900000 - c2d9d000)

(snip)


> [    1.282723] [<c07a1710>] (driver_register) from [<c0301eb4>] (do_one_initcall+0x44/0x174)
> [    1.290919] [<c0301eb4>] (do_one_initcall) from [<c1000dc0>] (kernel_init_freeable+0x158/0x1e8)
> [    1.299636] [<c1000dc0>] (kernel_init_freeable) from [<c0b047fc>] (kernel_init+0x8/0x10c)
> [    1.307828] [<c0b047fc>] (kernel_init) from [<c0307e78>] (ret_from_fork+0x14/0x3c)
> [    1.315404] Code: eafffef9 e5943008 e5930900 f57ff04f (eaffff69)
> [    1.321503] ---[ end trace b458093682b1fb9a ]---
> 
> 
> a git bisect later and the cause appears to be a0601a470537 ("PCI: designware: Add iATU Unroll feature")
> 
> the following patch gives me a working system again:
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 035f50c03281..74510508fafc 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -637,11 +637,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                 }
>         }
>  
> -       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> -
>         if (pp->ops->host_init)
>                 pp->ops->host_init(pp);
>  
> +       pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> +
>         pp->root_bus_nr = pp->busn->start;
>         if (IS_ENABLED(CONFIG_PCI_MSI)) {
>                 bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,

Before invoking the host initialization routine, the pcie driver must check if
it going to work in Unroll Mode or not. Your work around un fortunately is not
valid, because you are forcing the host init to be always in legacy mode since
pp->iatu_unroll_enabled will be 0 (Legacy).

If you check the driver will consider the iATU mode to be Unroll if the PortView
register has the value 0xFFFFFFFF, which in 4.80 core means that the Core has
Unroll activated. From what you are refering, I think that in your setup, the
driver is assuming that your Core is in Unroll Mode for some reason. Could you
please check the value of the PortView Register?

Thanks.

Joao

> 
> 
> From the ARTPEC-6 SoC manual:
> By default, the PCI Express interface shall be held in reset and clock-gated.
> Software is required to enable the relevant modules
> (turns on clocks and de-asserts reset) before these modules can be used.
> 
> Turning on the clocks and de-asserting reset is done in pp->ops->host_init().
> We get an external abort when calling dw_pcie_iatu_unroll_enabled,
> since that function does a read from the IP before we are allowed to do
> AXI transfers (at least in the ARTPEC-6 case, might be the same for some
> other SoCs).
> 
> It appears that dw_pcie_iatu_unroll_enabled was actually called _before_
> host_init() in v4 of Joao's patch, but was changed to after host_init() in v5,
> unfortunately the patch doesn't state a reason for the move.
> 

