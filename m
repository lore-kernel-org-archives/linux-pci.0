Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36801 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907AbbKRAfg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2015 19:35:36 -0500
Message-ID: <564BC79D.9010705@gmail.com>
Date: Tue, 17 Nov 2015 16:34:37 -0800
From: Florian Fainelli <f.fainelli@gmail.com>
MIME-Version: 1.0
To: Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: iproc: Add PAXC interface support
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com> <1447806715-30043-3-git-send-email-rjui@broadcom.com>
In-Reply-To: <1447806715-30043-3-git-send-email-rjui@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17/11/15 16:31, Ray Jui wrote:
> Traditionally, all iProc PCIe root complexes use PAXB based wrapper,
> with an integrated on-chip Serdes to support external endpoint devices.
> On newer iProc platforms, a PAXC based wrapper is introduced, for
> connection with internally emulated PCIe endpoint devices in the ASIC
> 
> This patch adds support for PAXC based iProc PCIe root complex in the
> iProc PCIe core driver. This change fators out common logic between
> PAXB and PAXC, and use tables to store register offsets that are
> different between PAXB and PAXC. This allows the driver to be scaled to
> support subsequent PAXC revisions in the future
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc-platform.c |   8 ++
>  drivers/pci/host/pcie-iproc.c          | 202 +++++++++++++++++++++++++++------
>  drivers/pci/host/pcie-iproc.h          |  19 ++++
>  3 files changed, 195 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index c9550dc..716b56b 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -42,6 +42,13 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  	pcie->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, pcie);
>  
> +	if (of_device_is_compatible(np, "brcm,iproc-pcie"))
> +		pcie->type = IPROC_PCIE_PAXB;
> +	else if (of_device_is_compatible(np, "brcm,iproc-pcie-paxc"))
> +		pcie->type = IPROC_PCIE_PAXC;
> +	else
> +		return -ENODEV;

Sorry for not noticing earlier, but typically, to avoid repeating the
same compatible string twice (once if of_device_id, and somewhere else),
you would put the type in the .data member of the of_device_id lookup
table and you could fetch this directly here. So something like this:

 static const struct of_device_id iproc_pcie_of_match_table[] = {
 	{ .compatible = "brcm,iproc-pcie", .data = (int *)IPROC_PCIE_PAXB },
+	{ .compatible = "brcm,iproc-pcie-paxc", .data = (int *)IPROC_PCIE_PAXC },
 	{ /* sentinel */ }
-- 
Florian
