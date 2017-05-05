Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33752 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdEEPyf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2017 11:54:35 -0400
Subject: Re: [RFC] pci: using new interrupt API to enable MSI and MSI-X
To: Marc Zyngier <marc.zyngier@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, <kishon@ti.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>
References: <806903036508ae5246084cbc3b796083d76f8917.1493992929.git.jpinto@synopsys.com>
 <58f3a6ca-a051-a7dc-805f-ee3eb0f3ac3b@arm.com>
CC: <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <6617cd15-5d79-cad8-879b-a8c953ba9a41@synopsys.com>
Date: Fri, 5 May 2017 16:54:30 +0100
MIME-Version: 1.0
In-Reply-To: <58f3a6ca-a051-a7dc-805f-ee3eb0f3ac3b@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Mark,

Às 3:57 PM de 5/5/2017, Marc Zyngier escreveu:
> Joao,
> 
> On 05/05/17 15:11, Joao Pinto wrote:

snip (...)

> It looks to me like the first mistake is just above. You don't seem to
> propagate the mask/unmask operations into the parent domain, so your
> interrupts are never enabled... You'd need something like this:
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 28ed32ba4f1b..d42b8b12f168 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -45,12 +45,22 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>  	return dw_pcie_write(pci->dbi_base + where, size, val);
>  }
>  
> +static void dw_msi_mask_irq(struct irq_data *d)
> +{
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void dw_msi_unmask_irq(struct irq_data *d)
> +{
> +	pci_msi_unmask_irq(d);
> +	irq_chip_unmask_parent(d);
> +}
> +
>  static struct irq_chip dw_msi_irq_chip = {
>  	.name = "PCI-MSI",
> -	.irq_enable = pci_msi_unmask_irq,
> -	.irq_disable = pci_msi_mask_irq,
> -	.irq_mask = pci_msi_mask_irq,
> -	.irq_unmask = pci_msi_unmask_irq,
> +	.irq_mask = dw_msi_mask_irq,
> +	.irq_unmask = dw_msi_unmask_irq,
>  };
> 
> I haven't dug any further, but this should be fixed first.
> 
> Thanks,
> 
> 	M.
> 

I added the changes that you suggested and firstly it crashed, and then I found
out that in the domain parent structure (dw_pci_msi_bottom_irq_chip) did not
have irq_mask and irq_unmask functions. I put it like this, just for testing:

static struct irq_chip dw_pci_msi_bottom_irq_chip = {
	.name			= "DW MSI",
	.irq_compose_msi_msg	= dw_pci_compose_msi_msg,
	.irq_set_affinity	= dw_pci_msi_set_affinity,
+	.irq_mask		= pci_msi_mask_irq,
+	.irq_unmask		= pci_msi_unmask_irq,
};

Maybe irq_mask and irq_unmask should not be pci_msi_mask_irq /
pci_msi_unmask_irq, but I did not find any existing case that needed it. Do we
have any documentation about IRQ domains that I can check?

Interrupts
 45:          0   PCI-MSI   0  aerdrv
 46:          0   PCI-MSI 524288  xhci_hcd

The MSI seems to be well configured in the Bridge and in the Endpoint, so some
glue is missing in the driver.

00:00.0 PCI bridge: Synopsys, Inc. Device eddc (rev 01) (prog-if 00 [Normal decode])
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 000000009a238000  Data: 0000


01:00.0 USB controller: ASMedia Technology Inc. ASM1142 USB 3.1 Host Controller
(prog-if 30 [XHCI])
(...)
Capabilities: [50] MSI: Enable+ Count=1/8 Maskable- 64bit+
Address: 000000009a238000  Data: 0001

Thanks for the support.

Joao
