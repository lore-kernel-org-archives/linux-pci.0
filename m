Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:51529 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbaCYU5f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 16:57:35 -0400
Date: Tue, 25 Mar 2014 13:57:31 -0700
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v5 8/9] ARM: koelsch: Add PCIe to defconfig
Message-ID: <20140325205731.GB27673@verge.net.au>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>
 <1395766604-30926-9-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395766604-30926-9-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please update the subject of this patch to:

ARM: shmobile: koelsch: Add PCIe to defconfig

On Tue, Mar 25, 2014 at 04:56:43PM +0000, Phil Edworthy wrote:
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  arch/arm/configs/koelsch_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
> index 86faab5..ec14547 100644
> --- a/arch/arm/configs/koelsch_defconfig
> +++ b/arch/arm/configs/koelsch_defconfig
> @@ -15,6 +15,9 @@ CONFIG_MACH_KOELSCH=y
>  CONFIG_CPU_BPREDICT_DISABLE=y
>  CONFIG_PL310_ERRATA_588369=y
>  CONFIG_ARM_ERRATA_754322=y
> +CONFIG_PCI=y
> +CONFIG_PCI_MSI=y
> +CONFIG_PCI_RCAR_GEN2_PCIE=y
>  CONFIG_SMP=y
>  CONFIG_SCHED_MC=y
>  CONFIG_NR_CPUS=8
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
