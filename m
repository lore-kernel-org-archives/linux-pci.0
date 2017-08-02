Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbdHBRcx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 13:32:53 -0400
Date: Wed, 2 Aug 2017 12:32:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pciehp: Enable hot plug capable detection
Message-ID: <20170802173249.GB20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1501650907-10969-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501650907-10969-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Wed, Aug 02, 2017 at 01:15:07AM -0400, Keith Busch wrote:
> The PCIe specification ties presence detect change enabling to the hot plug
> capable bit in Slot Capabilities. This capability is not mutally exclusive
> with attention buttons, so enabing detection should not be tied it.

Can you clarify this a little?

  - Please include the spec section you're referring to.

  - I'm not sure what "This capability is not ..." refers to.  There
    is not a "presence detect change enabling" capability.  I agree
    that the "Hot-Plug Capable" bit is independent of the "Attention
    Button Present" bit.

  - Slot Control (PCIe r3.1, sec 7.8.10) says PDCE *is permitted* to
    be read-only zero if PCI_EXP_SLTCAP_HPC is zero.  It doesn't say
    PDCE is *required* to be read-only in that case.

My initial reaction is that it probably makes sense per the spec to
enable PDCE unconditionally, but I would want to do some archaeology
to figure out why it wasn't that way from the beginning.  There's
probably some reason for it being the way it is, so we have to take
that into account.  Maybe it works around some flaky presence detect
hardware or something.

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/hotplug/pciehp.h     | 1 +
>  drivers/pci/hotplug/pciehp_hpc.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 06109d4..610e295 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -120,6 +120,7 @@ struct controller {
>  #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
>  #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
>  #define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
> +#define HP_CAP(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPC)
>  #define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
>  #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
>  #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 026830a..43a86ed 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -691,7 +691,7 @@ void pcie_enable_notification(struct controller *ctrl)
>  	cmd = PCI_EXP_SLTCTL_DLLSCE;
>  	if (ATTN_BUTTN(ctrl))
>  		cmd |= PCI_EXP_SLTCTL_ABPE;
> -	else
> +	if (HP_CAP(ctrl))
>  		cmd |= PCI_EXP_SLTCTL_PDCE;
>  	if (!pciehp_poll_mode)
>  		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
> -- 
> 2.5.5
> 
