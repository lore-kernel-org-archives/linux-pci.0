Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:26547
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751580Ab3KWO43 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 23 Nov 2013 09:56:29 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatjain.linux@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
Date: Sat, 23 Nov 2013 14:56:22 +0000
Message-ID: <a3dc3d613f274e4d993d6a7612f1dde6@BLUPR05MB118.namprd05.prod.outlook.com>
References: <52797238.8070304@gmail.com> <20131106002505.GC3359@google.com>
 <CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
 <CADTPrLQpaCDo_YCC2=MmT1iCrWRPqzDpnqQZrE8OMjRMc6WYmQ@mail.gmail.com>
 <20131108012352.GE2955@google.com>
 <CADTPrLTYOXsGovL8HJ7=+K30OWVeSdMKTma_UuMV8ZRFB6CkYA@mail.gmail.com>
 <CAErSpo7MH=+Jk-ujBoHquk2e+no1cqEV6p=R1E6LGvcLSJQyKw@mail.gmail.com>
 <CADTPrLRJD0er1kijjm2SEE6wUA9eQaz+OOd67E3MpHLu6k-R6Q@mail.gmail.com>
 <20131123005102.GA14690@google.com>
In-Reply-To: <20131123005102.GA14690@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=64821
> >
> > Please let me know if you need any help in trying something out - I'd
> > be more than keen to help - write code or test.
> 
> What do you think of the patch below?  I'm afraid we'll trip over a few
> other old parts similar to the 82801H, but I'd rather do that than
> penalize the parts that work correctly.

Tested and works fine. Looks good (on a side note, we are introducing device specific check in a common code, but I do not think there is any other cleaner way). I think this patch should be applied as it solves the problem of slow probing.

On a different note, I feel there is still a need to apply my original patch. There is still an open problem in case of spurious interrupts (or in any case where the condition "if (slot_status & PCI_EXP_SLTSTA_CC)" becomes true in pcie_write_cmd()). That is because once that happens, we never clear that interrupt, and no further hotplug interrupts shall be received unless we do that.

Thanks,

Rajat

> 
> 
> PCI: pciehp: Support command completion even with no hotplug hardware
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Commit 5808639bfa98 ("pciehp: fix slow probing") fixed a slow probing
> problem on hardware that doesn't conform to the spec, but caused a
> similar problem for hardware that *does* conform to the spec.
> 
> Per PCIe 3.0, sec 7.8.10 and 6.7.3.2, any write to Slot Control
> generates a hot-plug command.  Ports that can accept new commands with
> no delay can set the "No Command Completed Support" bit.  Otherwise the
> port must indicate its completion of the command and readiness to accept
> a new command with a "command completed event."
> 
> 5808639bfa98 assumes ports that lack a power controller, power
> indicator, attention indicator, and interlock will not generate
> completion events, even if they neglect to set "No Command Completed
> Support." But on ports that lack those elements and *do* support command
> completion notification, it causes:
> 
>   Unexpected CMD_COMPLETED. Need to wait for command completed event.
>   Command not completed in 1000 msec
> 
> and forces us to wait for a 1 second timeout.
> 
> This patch makes the 5808639bfa98 workaround into a quirk that's applied
> only to devices known to be broken, currently just Intel 82801H ports.
> There are probably other similarly-broken devices that may now probe
> slowly, but I don't know how to catch them all without penalizing the
> ones that play by the rules.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=64821
> Reported-by: Rajat Jain <rajatjain@juniper.net>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |   39 +++++++++++++++++++++++++++++--
> -------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> b/drivers/pci/hotplug/pciehp_hpc.c
> index 3eea3fdd4b0b..2fd2bd59e07f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -881,6 +881,34 @@ static inline void dbg_ctrl(struct controller
> *ctrl)
>  	ctrl_info(ctrl, "Slot Control           : 0x%04x\n", reg16);
>  }
> 
> +static int pciehp_no_command_complete(struct controller *ctrl) {
> +	struct pcie_device *dev = ctrl->pcie;
> +	struct pci_dev *pdev = dev->port;
> +	u16 vendor, device;
> +
> +	if (NO_CMD_CMPL(ctrl))
> +		return 1;
> +
> +	/*
> +	 * Controller should notify on command completion unless the "No
> +	 * Command Completed Support" bit is set.  But some hardware does
> +	 * not.  See https://bugzilla.kernel.org/show_bug.cgi?id=10751
> +	 */
> +	if (!(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) |
> EMI(ctrl))) {
> +		vendor = pdev->vendor;
> +		device = pdev->device;
> +		if (vendor == PCI_VENDOR_ID_INTEL &&
> +		    device >= 0x283f && device <= 0x2849) {
> +			dev_info(&dev->device, "device [%04x:%04x] does not
> notify on hotplug command completion\n",
> +				 vendor, device);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  struct controller *pcie_init(struct pcie_device *dev)  {
>  	struct controller *ctrl;
> @@ -902,15 +930,8 @@ struct controller *pcie_init(struct pcie_device
> *dev)
>  	mutex_init(&ctrl->ctrl_lock);
>  	init_waitqueue_head(&ctrl->queue);
>  	dbg_ctrl(ctrl);
> -	/*
> -	 * Controller doesn't notify of command completion if the "No
> -	 * Command Completed Support" bit is set in Slot Capability
> -	 * register or the controller supports none of power
> -	 * controller, attention led, power led and EMI.
> -	 */
> -	if (NO_CMD_CMPL(ctrl) ||
> -	    !(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) |
> EMI(ctrl)))
> -	    ctrl->no_cmd_complete = 1;
> +
> +	ctrl->no_cmd_complete = pciehp_no_command_complete(ctrl);
> 
>          /* Check if Data Link Layer Link Active Reporting is
> implemented */
>          if (pciehp_readl(ctrl, PCI_EXP_LNKCAP, &link_cap)) {
> 


