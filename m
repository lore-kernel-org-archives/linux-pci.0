Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:53472 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbaIWCwD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 22:52:03 -0400
Received: by mail-ig0-f174.google.com with SMTP id r10so3893733igi.7
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 19:52:01 -0700 (PDT)
Date: Mon, 22 Sep 2014 20:51:59 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: more debug printout for pcie_write_cmd in pciehp
Message-ID: <20140923025159.GP1880@google.com>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
 <1408756512-16885-5-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408756512-16885-5-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 22, 2014 at 06:15:11PM -0700, Yinghai Lu wrote:
> Also move down one printout after pcie_write_cmd to be consistent with
> other debug print out.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Applied to pci/hotplug for v3.18, thanks!

> 
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> @@ -422,9 +422,9 @@ void pciehp_set_attention_status(struct
>  	default:
>  		return;
>  	}
> +	pcie_write_cmd(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
>  	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>  		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
> -	pcie_write_cmd(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
>  }
>  
>  void pciehp_green_led_on(struct slot *slot)
> @@ -602,6 +602,8 @@ void pcie_enable_notification(struct con
>  		PCI_EXP_SLTCTL_DLLSCE);
>  
>  	pcie_write_cmd(ctrl, cmd, mask);
> +	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> +		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
>  }
>  
>  static void pcie_disable_notification(struct controller *ctrl)
> @@ -613,6 +615,8 @@ static void pcie_disable_notification(st
>  		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
>  		PCI_EXP_SLTCTL_DLLSCE);
>  	pcie_write_cmd(ctrl, 0, mask);
> +	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> +		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
>  }
>  
>  /*
> @@ -640,6 +644,8 @@ int pciehp_reset_slot(struct slot *slot,
>  	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
>  
>  	pcie_write_cmd(ctrl, 0, ctrl_mask);
> +	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> +		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
>  	if (pciehp_poll_mode)
>  		del_timer_sync(&ctrl->poll_timer);
>  
> @@ -647,6 +653,8 @@ int pciehp_reset_slot(struct slot *slot,
>  
>  	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
>  	pcie_write_cmd(ctrl, ctrl_mask, ctrl_mask);
> +	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> +		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
>  	if (pciehp_poll_mode)
>  		int_poll_timeout(ctrl->poll_timer.data);
>  
