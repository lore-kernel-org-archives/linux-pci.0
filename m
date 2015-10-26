Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:7047 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbJZRSV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2015 13:18:21 -0400
Subject: Re: [RFC PATCH 1/3] PCI: iproc: generate proper configuration access
 cycles
To: Jisheng Zhang <jszhang@marvell.com>, <bhelgaas@google.com>,
	<thierry.reding@gmail.com>, <swarren@wwwdotorg.org>,
	<gnurou@gmail.com>, <tinamdar@apm.com>, <sbranden@broadcom.com>,
	<linux@arm.linux.org.uk>
References: <1445857334-6936-1-git-send-email-jszhang@marvell.com>
 <1445857334-6936-2-git-send-email-jszhang@marvell.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <562E6056.3040203@broadcom.com>
Date: Mon, 26 Oct 2015 10:18:14 -0700
MIME-Version: 1.0
In-Reply-To: <1445857334-6936-2-git-send-email-jszhang@marvell.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jisheng,

On 10/26/2015 4:02 AM, Jisheng Zhang wrote:
> Inspired by Russell King's patch[1], I found current iproc also has the
> same issue of "reading 32-bits from the command register, modifying the
> command register, and then writing it back has the effect of clearing
> any status bits that were indicating at that time" as pointed out by
> Russell. This patch fix this issue by using the pci_generic_config_write.
>
> [1]http://www.spinics.net/lists/linux-pci/msg44869.html
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   drivers/pci/host/pcie-iproc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index fe2efb1..0c423f2 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -111,7 +111,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>   static struct pci_ops iproc_pcie_ops = {
>   	.map_bus = iproc_pcie_map_cfg_bus,
>   	.read = pci_generic_config_read32,
> -	.write = pci_generic_config_write32,
> +	.write = pci_generic_config_write,
>   };
>
>   static void iproc_pcie_reset(struct iproc_pcie *pcie)
>

I have already confirmed with the ASIC team that the current iProc PCIe 
controller requires 32-bit aligned access into the configuration space 
due to the way how it was integrated into various iProc SoCs including 
NSP, Cygnus, and NS2.

This change will prevent the driver from working properly.

I've informed our ASIC team about this issue and all future iProc based 
SoCs should be able to support 8-bit, 16-bit access and therefore 
pci_generic_config_write/read can be used for those SoCs.

Thanks,

Ray
