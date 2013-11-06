Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:65150 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab3KFAZJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2013 19:25:09 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so16240716iec.41
        for <linux-pci@vger.kernel.org>; Tue, 05 Nov 2013 16:25:08 -0800 (PST)
Date: Tue, 5 Nov 2013 17:25:05 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rajat Jain <rajatjain.linux@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Guenter Roeck <groeck@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
Message-ID: <20131106002505.GC3359@google.com>
References: <52797238.8070304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52797238.8070304@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 05, 2013 at 02:33:28PM -0800, Rajat Jain wrote:
> In case of a spurious "cmd completed", pcie_write_cmd() does not
> clear it, but yet expects more "cmd completed" events to be generated.
> This does not happen because the previous (spurious) event has not
> been acknowledged. Fix that.
> 
> Signed-off-by: Rajat Jain <rajatjain@juniper.net>
> Signed-off-by: Guenter Roeck <groeck@juniper.net>
> ---
> This is how I saw it in action: my controller does not implement any
> hot-plug elements (LED, power ctrl, EMI etc) but still supports Command
> completed bit.
>  - During initialization,
>       pcie_disable_notification()
>       -> pcie_write_cmd()
>          -> writes to Slot control register
>             -> which causes PCI_EXP_SLTSTA_CC to get set, which is not
>                cleared, because IRQ is not generated (we just disabled
>                notifications).
>  - After some time,
>       pcie_enable_notification()
>       -> pcie_write_cmd()
>           -> finds PCI_EXP_SLTSTA_CC is set, assumes it is spurious.
>           -> Does not clear it, yet expects more command completed
>              events to be generated (never happens).

I'm not sure this "cmd completed" is actually spurious.  Spec section
7.8.10 is very clear that any write to Slot Control must cause a
hot-plug command to be generated (if the port is hot-plug capable).

Can you collect "lspci -vv" output for your controller?  I assume
you're hitting this case in pcie_init() (added by 5808639bfa98
("pciehp: fix slow probing")):

        /*
         * Controller doesn't notify of command completion if the "No
         * Command Completed Support" bit is set in Slot Capability
         * register or the controller supports none of power
         * controller, attention led, power led and EMI.
         */
        if (NO_CMD_CMPL(ctrl) ||
            !(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) | EMI(ctrl)))
            ctrl->no_cmd_complete = 1;

and we're setting "no_cmd_complete = 1" for your controller, which
keeps us from waiting for completion in pcie_write_cmd().

I'm dubious about the assertion that a controller without power
control, attention LED, power LED, or EMI can't support command
completion.  I don't see anything in the spec to that effect.

Since you're seeing PCI_EXP_SLTSTA_CC=1, your controller *should*
support Command Completion notification and PCI_EXP_SLTCAP_NCCS should
be 0 (per Table 7-20), so I wonder what happens on your system if you
change pcie_init() so it leaves "ctrl->no_cmd_complete = 0" instead?
Does it work correctly then?

I know we can't just drop the "!(POWER_CTRL(ctrl) | ...)" tests
because we don't want to reintroduce the problem fixed by
5808639bfa98, but I wonder if we can find a better fix that addresses
both problems.

Bjorn

> 
>  drivers/pci/hotplug/pciehp_hpc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 5b8d749..ba8e06f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -185,6 +185,7 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>  	}
>  
>  	if (slot_status & PCI_EXP_SLTSTA_CC) {
> +		pciehp_writew(ctrl, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_CC);
>  		if (!ctrl->no_cmd_complete) {
>  			/*
>  			 * After 1 sec and CMD_COMPLETED still not set, just
> -- 
> 1.7.9.5
> 
