Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:51081 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbaIWCfF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 22:35:05 -0400
Received: by mail-ig0-f172.google.com with SMTP id a13so3872099igq.5
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 19:35:04 -0700 (PDT)
Date: Mon, 22 Sep 2014 20:35:01 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: print out exact timeout in pciehp for wait_cmd
Message-ID: <20140923023501.GO1880@google.com>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org>
 <1408756512-16885-3-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408756512-16885-3-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 22, 2014 at 06:15:09PM -0700, Yinghai Lu wrote:
> debug print out should add back timeout that pass during wait event or
> polling.
> 
> That now is cached vaule before wait.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
> @@ -173,7 +173,7 @@ static void pcie_wait_cmd(struct control
>  	if (!rc)
>  		ctrl_info(ctrl, "Timeout on hotplug command %#010x (issued %u msec ago)\n",
>  			  ctrl->slot_ctrl,
> -			  jiffies_to_msecs(now - ctrl->cmd_started));
> +			  jiffies_to_msecs(now - ctrl->cmd_started + timeout));
>  }
>  
>  /**

I propose the modification below because I think it's more direct.  Does it
make sense to you, or am I still missing something?


commit 83d752536aa9dfb1fddb04d6ef8c6bdc75492d4f
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Mon Sep 22 20:07:35 2014 -0600

    PCI: pciehp: Fix wait time in timeout message
    
    When we warned about a timeout on a hotplug command, we previously printed
    the time between calls to pcie_write_cmd(), without accounting for any time
    spent actually waiting.  Consider this sequence:
    
      pcie_write_cmd
        write SLTCTL
        cmd_started = jiffies          # T1
    
      pcie_write_cmd
        pcie_wait_cmd
          now = jiffies                # T2
          wait_event_timeout           # we may wait here
          if (timeout)
            ctrl_info("Timeout on command issued %u msec ago",
                      jiffies_to_msecs(now - cmd_started))
    
    We previously printed (T2 - T1), but that doesn't include the time spent in
    wait_event_timeout().
    
    Fix this by using the current jiffies value, not the one cached before
    calling wait_event_timeout().
    
    [bhelgaas: changelog, use current jiffies instead of adding timeout]
    Fixes: 40b960831cfa ("PCI: pciehp: Compute timeout from hotplug command start time")
    Signed-off-by: Yinghai Lu <yinghai@kernel.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 9e0f4aec5f0c..3673a913379f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -173,7 +173,7 @@ static void pcie_wait_cmd(struct controller *ctrl)
 	if (!rc)
 		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
 			  ctrl->slot_ctrl,
-			  jiffies_to_msecs(now - ctrl->cmd_started));
+			  jiffies_to_msecs(jiffies - ctrl->cmd_started));
 }
 
 /**
