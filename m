Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754367AbeDBVXF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Apr 2018 17:23:05 -0400
Date: Mon, 2 Apr 2018 16:23:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCHv2 1/7] PCI/DPC: Enable ERR_COR
Message-ID: <20180402212302.GN9322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402162203.3370-1-keith.busch@intel.com>
 <20180402162203.3370-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180402162203.3370-2-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 02, 2018 at 10:21:57AM -0600, Keith Busch wrote:
> A DPC port may be configured to send ERR_COR message when the
> triggered. This patch enables this feature so additional notification
> of the event is possible.

Who is the intended consumer of the ERR_COR message?  I guess if the
root port supports AER, we'll see AER logging when we didn't before?
Is that what you mean by "additional notification"?

Or, since the DPC ERR_COR implementation note (sec 6.2.10.2) suggests
that ERR_COR is primarily intended for use by platform firmware, does
this change enable notification via the firmware?  If so, how does
that work?  Does it require the platform to retain control of AER so
it can see these events?  But if the platform retains AER control, I
don't think we'd be enabling DPC in Linux.  I'm confused.

The similar implementation note in 6.2.10.5 suggests that
DL_ACTIVE_ERR_COR is also intended for use by the platform.  Should we
be setting that for the same reason we're setting
PCI_EXP_DPC_CTL_ERR_COR?

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/pcie-dpc.c   | 5 ++++-
>  include/uapi/linux/pci_regs.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 38e40c6c576f..a9be6938417f 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -269,7 +269,10 @@ static int dpc_probe(struct pcie_device *dev)
>  		}
>  	}
>  
> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
> +	ctl = (ctl & 0xfff4) |
> +		PCI_EXP_DPC_CTL_EN_NONFATAL |
> +		PCI_EXP_DPC_CTL_INT_EN |
> +		PCI_EXP_DPC_CTL_ERR_COR;

The 0xfff4 is a little confusing because it:

  - Clears DPC Trigger Enable (0x0003), then sets
    PCI_EXP_DPC_CTL_EN_NONFATAL.  That makes good sense.  Maybe we
    should have a mask for the 0x0003 value.

  - Preserves whatever the firmware set for DPC Completion Control
    (0x0004).  Seems like maybe we should decide and set this
    explicitly, unless there's a reason we should respect the
    platform's choice.  But that's a separate issue.

  - Clears DPC Interrupt Enable (0x0008), then sets it again.
    Clearing seems pointless.

  - Preserves DPC ERR_COR Enable (0x0010), then sets it.

I think the most readable thing would be:

  ctl = (ctl & 0xfffc) | PCI_EXP_DPC_CTL_EN_NONFATAL;
  ctl |= PCI_EXP_DPC_CTL_INT_EN | PCI_EXP_DPC_CTL_ERR_COR;

or maybe:

  ctl = (ctl & 0xfffc) | PCI_EXP_DPC_CTL_EN_NONFATAL;
  ctl |= PCI_EXP_DPC_CTL_INT_EN;

  /* Platform firmware may rely on these ERR_COR messages */
  ctl |= PCI_EXP_DPC_CTL_ERR_COR | PCI_EXP_DPC_CTL_DL_ACT_ERR_COR;

(If that comment is accurate.)

>  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>  
>  	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 0c79eac5e9b8..9cfcecdc3ec7 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -980,6 +980,7 @@
>  #define PCI_EXP_DPC_CTL			6	/* DPC control */
>  #define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
>  #define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
> +#define  PCI_EXP_DPC_CTL_ERR_COR 	0x0010	/* DPC ERR_COR Enable */
>  
>  #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
>  #define  PCI_EXP_DPC_STATUS_TRIGGER	    0x0001 /* Trigger Status */
> -- 
> 2.14.3
> 
