Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:39091 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbaIWC3s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 22:29:48 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so3850821igc.8
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 19:29:48 -0700 (PDT)
Date: Mon, 22 Sep 2014 20:29:45 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: fix pcie_wait_cmd with poll mode timeout
Message-ID: <20140923022945.GN1880@google.com>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
 <1408756512-16885-2-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408756512-16885-2-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 22, 2014 at 06:15:08PM -0700, Yinghai Lu wrote:
> pcie_poll_cmd() take msecs instead of jiffies, need to convert
> timeout to msecs.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Thanks for the fix.  I applied this to for-linus for v3.17, because it
fixes a change (40b960831cfa) that we merged for v3.17, and the bug may
cause us to wait less than we should before timing out and issuing a new
hotplug command.

> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> @@ -160,7 +160,7 @@ static void pcie_wait_cmd(struct control
>  	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
>  		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
>  	else
> -		rc = pcie_poll_cmd(ctrl, timeout);
> +		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
>  
>  	/*
>  	 * Controllers with errata like Intel CF118 don't generate
