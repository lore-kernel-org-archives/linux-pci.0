Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:60682 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbaBLAtb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2014 19:49:31 -0500
Received: by mail-ig0-f175.google.com with SMTP id uq10so10139207igb.2
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2014 16:49:30 -0800 (PST)
Date: Tue, 11 Feb 2014 17:49:27 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org,
	Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix the problem that the present bit is not
 cleared though slot is empty
Message-ID: <20140212004927.GH21057@google.com>
References: <20140203160724.949a0ee5.izumi.taku@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140203160724.949a0ee5.izumi.taku@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rajat]

On Mon, Feb 03, 2014 at 04:07:24PM +0900, Taku Izumi wrote:
> 
> I found the problem that the present bit does not be cleared
> though the slot is empty.
> 
>  Step to reproduce:
> 
>   # cd /sys/bus/pci/slots/66
>   # cat adapter
>   0
>   --- (insert PCIe card on slot#66) ---
>   # cat adapter
>   1
>   # echo 1 > power
>   # echo 0 > power
>   --- (eject PCIe card on slot#66) ---
>   # cat adapter
>   1
>     ==> should be 0.
> 
> According to git-bisect this is caused by:
>     2debd9289997fc5d1c0043b41201a8b40d5e11d0
>        PCI: pciehp: Disable/enable link during slot power off/on
>     is the first bad commit
> 
> By reverting the above patch, this bug can be solved.
> And I also found this can be fixed by changing the timing of link-disable
> during power off the slot.
> So, this patch changes the timing of link-disable during power off.

Hi Taku,

Thanks a lot for finding and bisecting this problem.  I recently merged
some patches from Rajat that partially revert 2debd9289997.  Can you try
out my pci/pciehp branch and see whether it is enough to fix the problem
for you?

Here's the branch:
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/pciehp

and the specific change Rajat made is:
http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/pciehp&id=b1811d2455f32754cc3d8725bf2e961c5eda2a72

Let me know if that isn't enough to fix the problem you're seeing, and we
can work on it some more.

Bjorn

> 
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 14acfcc..163f0b4 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -508,7 +508,12 @@ void pciehp_power_off_slot(struct slot * slot)
>  {
>  	struct controller *ctrl = slot->ctrl;
>  
> -	/* Disable the link at first */
> +	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
> +	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> +		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
> +		 PCI_EXP_SLTCTL_PWR_OFF);
> +
> +	/* Disable the link */
>  	pciehp_link_disable(ctrl);
>  	/* wait the link is down */
>  	if (ctrl->link_active_reporting)
> @@ -516,10 +521,6 @@ void pciehp_power_off_slot(struct slot * slot)
>  	else
>  		msleep(1000);
>  
> -	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
> -	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
> -		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
> -		 PCI_EXP_SLTCTL_PWR_OFF);
>  }
>  
>  static irqreturn_t pcie_isr(int irq, void *dev_id)
> -- 
> 1.8.3.1
> 
