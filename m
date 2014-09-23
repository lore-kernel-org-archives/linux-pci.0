Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:64923 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbaIWCx3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 22:53:29 -0400
Received: by mail-ig0-f173.google.com with SMTP id l13so3891685iga.12
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 19:53:29 -0700 (PDT)
Date: Mon, 22 Sep 2014 20:53:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: remove not needed pcie_disable_notification
Message-ID: <20140923025326.GQ1880@google.com>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
 <1408756512-16885-6-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408756512-16885-6-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 22, 2014 at 06:15:12PM -0700, Yinghai Lu wrote:
> disable and enable notification in a row will cause 1 second delay
> per hotplug slot on system with Intel chip that only have command
> complete for real hotplut operations.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Applied to pci/hotplug for v3.18, thanks!

> 
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> @@ -785,9 +785,6 @@ struct controller *pcie_init(struct pcie
>  		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
>  		PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
>  
> -	/* Disable software notification */
> -	pcie_disable_notification(ctrl);
> -
>  	ctrl_info(ctrl, "Slot #%d AttnBtn%c AttnInd%c PwrInd%c PwrCtrl%c MRL%c Interlock%c NoCompl%c LLActRep%c\n",
>  		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
