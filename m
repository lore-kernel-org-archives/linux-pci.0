Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:61257 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab3KWB74 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2013 20:59:56 -0500
Date: Fri, 22 Nov 2013 17:59:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatjain.linux@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Rajat Jain <rajatjain@juniper.net>,
	Guenter Roeck <groeck@juniper.net>
Subject: Re: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
Message-ID: <20131123015953.GA6177@roeck-us.net>
References: <52797238.8070304@gmail.com>
 <20131106002505.GC3359@google.com>
 <CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
 <CADTPrLQpaCDo_YCC2=MmT1iCrWRPqzDpnqQZrE8OMjRMc6WYmQ@mail.gmail.com>
 <20131108012352.GE2955@google.com>
 <CADTPrLTYOXsGovL8HJ7=+K30OWVeSdMKTma_UuMV8ZRFB6CkYA@mail.gmail.com>
 <CAErSpo7MH=+Jk-ujBoHquk2e+no1cqEV6p=R1E6LGvcLSJQyKw@mail.gmail.com>
 <CADTPrLRJD0er1kijjm2SEE6wUA9eQaz+OOd67E3MpHLu6k-R6Q@mail.gmail.com>
 <20131123005102.GA14690@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131123005102.GA14690@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 22, 2013 at 05:51:02PM -0700, Bjorn Helgaas wrote:
> On Mon, Nov 11, 2013 at 01:26:06PM -0800, Rajat Jain wrote:
> > Hello,
> > 
> > >> With my patch, we'd eliminate the 1 second delay and the second line
> > >> of output above. If we also want to get rid of the first line
> > >> "Unexpected CMD_COMPLETED..." also, that would probably have to be
> > >> solved by changing the behavior to assume that CC shall be generated
> > >> for every SLOTCTRL register write.
> > >
> > > I *do* want to get rid of the "Unexpected CMD_COMPLETED" complaint.
> > > We shouldn't complain about hardware that is working perfectly fine.
> > > I don't know the best way to do that yet.  I have found a box with the
> > > same hardware that was fixed by 5808639bfa98, so I hope to play with
> > > it and figure out something that will work nicely for both scenarios.
> > 
> > Please keep posted :-)
> > 
> > >
> > > BTW, can you open a report at bugzilla.kernel.org and attach your
> > > "lspci -vvxxx" and dmesg output?  When we eventually merge a fix, I'd
> > > like to have the details archived somewhere.
> > 
> > Done:
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=64821
> > 
> > Please let me know if you need any help in trying something out - I'd
> > be more than keen to help - write code or test.
> 
> What do you think of the patch below?  I'm afraid we'll trip over
> a few other old parts similar to the 82801H, but I'd rather do that
> than penalize the parts that work correctly.
> 
Works nicely as far as I can see. Tested on P2020 and P5040 based systems
with IDT 89HPES48H12G2.

Tested-by: Guenter Roeck <groeck@juniper.net>

Guenter

> 
> PCI: pciehp: Support command completion even with no hotplug hardware
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Commit 5808639bfa98 ("pciehp: fix slow probing") fixed a slow probing
> problem on hardware that doesn't conform to the spec, but caused a
> similar problem for hardware that *does* conform to the spec.
> 
> Per PCIe 3.0, sec 7.8.10 and 6.7.3.2, any write to Slot Control generates a
> hot-plug command.  Ports that can accept new commands with no delay can set
> the "No Command Completed Support" bit.  Otherwise the port must indicate
> its completion of the command and readiness to accept a new command with a
> "command completed event."
> 
> 5808639bfa98 assumes ports that lack a power controller, power indicator,
> attention indicator, and interlock will not generate completion events,
> even if they neglect to set "No Command Completed Support." But on ports
> that lack those elements and *do* support command completion notification,
> it causes:
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
>  drivers/pci/hotplug/pciehp_hpc.c |   39 +++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 3eea3fdd4b0b..2fd2bd59e07f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -881,6 +881,34 @@ static inline void dbg_ctrl(struct controller *ctrl)
>  	ctrl_info(ctrl, "Slot Control           : 0x%04x\n", reg16);
>  }
>  
> +static int pciehp_no_command_complete(struct controller *ctrl)
> +{
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
> +	if (!(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) | EMI(ctrl))) {
> +		vendor = pdev->vendor;
> +		device = pdev->device;
> +		if (vendor == PCI_VENDOR_ID_INTEL &&
> +		    device >= 0x283f && device <= 0x2849) {
> +			dev_info(&dev->device, "device [%04x:%04x] does not notify on hotplug command completion\n",
> +				 vendor, device);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  struct controller *pcie_init(struct pcie_device *dev)
>  {
>  	struct controller *ctrl;
> @@ -902,15 +930,8 @@ struct controller *pcie_init(struct pcie_device *dev)
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
> -	    !(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) | EMI(ctrl)))
> -	    ctrl->no_cmd_complete = 1;
> +
> +	ctrl->no_cmd_complete = pciehp_no_command_complete(ctrl);
>  
>          /* Check if Data Link Layer Link Active Reporting is implemented */
>          if (pciehp_readl(ctrl, PCI_EXP_LNKCAP, &link_cap)) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hotplug" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
