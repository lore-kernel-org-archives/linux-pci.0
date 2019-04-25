Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3362C10F03
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 11:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89246217D7
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 11:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfDYLIg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:08:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41156 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDYLIf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Apr 2019 07:08:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C07F374;
        Thu, 25 Apr 2019 04:08:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A95A23F5C1;
        Thu, 25 Apr 2019 04:08:33 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:08:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ellie Reeves <ellierevves@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Use LTSSM state to build link training
 flag
Message-ID: <20190425110830.GC10833@e121166-lin.cambridge.arm.com>
References: <20190316161243.29517-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316161243.29517-1-repk@triplefau.lt>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 16, 2019 at 05:12:43PM +0100, Remi Pommarel wrote:
> The PCI_EXP_LNKSTA_LT flag in the emulated root device's PCI_EXP_LNKSTA
> config register does not reflect the actual link training state and is
> always cleared. The Link Training and Status State Machine (LTSSM) flag
> in LMI config register could be used as a link training indicator.
> Indeed if the LTSSM is in L0 or upper state then link training has
> completed (see [1]).
> 
> Unfortunately because setting the PCI_EXP_LINCTL_RL flag does not
> instantly imply a LTSSM state change (e.g. L0s to recovery state
> transition takes some time), LTSSM can be in L0 but link training has
> not finished yet. Thus a lower L0 LTSSM state followed by a L0 or upper
> state sequence has to be seen to be sure that link training has been
> done.

Hi Remi,

I am a bit confused, so you are saying that the LTSSM flag in the
LMI config register can't be used to detect when training is completed ?

Certainly it can't be used by ASPM core that relies on:

PCI_EXP_LNKSTA_LT flag

in the PCI_EXP_LNKSTA register, and that's what you are setting through
this timeout mechanism IIUC.

Please elaborate on that.

I am picking Bjorn's brain on this patch since what you are doing
seems quite arbitrary and honestly it is a bit of a hack.

I wonder whether it is not better to avoid advertising ASPM support.

Lorenzo

> Because one may not call a pcie conf register read on LNKSTA after
> doing a retrain link or may miss the link down state due to timing, a
> 20ms timeout is used. Passing this timeout link is considered retrained.
> 
> This fixes boot hang or kernel panic with the following callstack due to
> ASPM setup doing a link re-train and polling for PCI_EXP_LNKSTA_LT flag
> to be cleared before using it.
> 
> -------------------- 8< -------------------
> 	[    0.915389]  dump_backtrace+0x0/0x140
> 	[    0.915391]  show_stack+0x14/0x20
> 	[    0.915393]  dump_stack+0x90/0xb4
> 	[    0.915394]  panic+0x134/0x2c0
> 	[    0.915396]  nmi_panic+0x6c/0x70
> 	[    0.915398]  arm64_serror_panic+0x74/0x80
> 	[    0.915400]  is_valid_bugaddr+0x0/0x8
> 	[    0.915402]  el1_error+0x7c/0xe4
> 	[    0.915404]  advk_pcie_rd_conf+0x4c/0x250
> 	[    0.915406]  pci_bus_read_config_word+0x7c/0xd0
> 	[    0.915408]  pcie_capability_read_word+0x90/0xc8
> 	[    0.915410]  pcie_get_aspm_reg+0x68/0x118
> 	[    0.915412]  pcie_aspm_init_link_state+0x460/0xa98
> 	[    0.915414]  pci_scan_slot+0xe8/0x100
> 	[    0.915416]  pci_scan_child_bus_extend+0x50/0x288
> 	[    0.915418]  pci_scan_bridge_extend+0x348/0x4f0
> 	[    0.915420]  pci_scan_child_bus_extend+0x1dc/0x288
> 	[    0.915423]  pci_scan_root_bus_bridge+0xc4/0xe0
> 	[    0.915424]  pci_host_probe+0x14/0xa8
> 	[    0.915426]  advk_pcie_probe+0x838/0x910
> 	[...]
> -------------------- 8< -------------------
> 
> [1] "PCI Express Base Specification", REV. 2.1
>     PCI Express, March 4 2009, Table 4-7
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
> Changes since v1:
>   - Rename retraining flag field
>   - Fix DEVCTL register writing
> ---
>  drivers/pci/controller/pci-aardvark.c | 33 ++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index eb58dfdaba1b..47b707b5fc2c 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -180,6 +180,7 @@
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
>  #define LINK_WAIT_USLEEP_MAX		100000
> +#define LINK_RETRAIN_DELAY_MAX		(20 * HZ / 1000) /* 20 ms */
>  
>  #define MSI_IRQ_NUM			32
>  
> @@ -199,6 +200,8 @@ struct advk_pcie {
>  	u16 msi_msg;
>  	int root_bus_nr;
>  	struct pci_bridge_emul bridge;
> +	unsigned long rl_deadline; /* Retrain link jiffies deadline */
> +	u8 rl_asked; /* Retraining has been asked and is in transition */
>  };
>  
>  static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
> @@ -400,6 +403,19 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
>  	return -ETIMEDOUT;
>  }
>  
> +static int advk_pcie_link_retraining(struct advk_pcie *pcie)
> +{
> +	if (!advk_pcie_link_up(pcie)) {
> +		pcie->rl_asked = 0;
> +		return 1;
> +	}
> +
> +	if (pcie->rl_asked && time_before(jiffies, pcie->rl_deadline))
> +		return 1;
> +
> +	pcie->rl_asked = 0;
> +	return 0;
> +}
>  
>  static pci_bridge_emul_read_status_t
>  advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
> @@ -426,11 +442,19 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
>  		return PCI_BRIDGE_EMUL_HANDLED;
>  	}
>  
> +	case PCI_EXP_LNKCTL: {
> +		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg) &
> +			~(PCI_EXP_LNKSTA_LT << 16);
> +		if (advk_pcie_link_retraining(pcie))
> +			val |= (PCI_EXP_LNKSTA_LT << 16);
> +		*value = val;
> +		return PCI_BRIDGE_EMUL_HANDLED;
> +	}
> +
>  	case PCI_CAP_LIST_ID:
>  	case PCI_EXP_DEVCAP:
>  	case PCI_EXP_DEVCTL:
>  	case PCI_EXP_LNKCAP:
> -	case PCI_EXP_LNKCTL:
>  		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
>  		return PCI_BRIDGE_EMUL_HANDLED;
>  	default:
> @@ -447,8 +471,15 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>  
>  	switch (reg) {
>  	case PCI_EXP_DEVCTL:
> +		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
> +		break;
> +
>  	case PCI_EXP_LNKCTL:
>  		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
> +		if (new & PCI_EXP_LNKCTL_RL) {
> +			pcie->rl_asked = 1;
> +			pcie->rl_deadline = jiffies + LINK_RETRAIN_DELAY_MAX;
> +		}
>  		break;
>  
>  	case PCI_EXP_RTCTL:
> -- 
> 2.20.1
> 
