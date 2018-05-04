Return-Path: <SRS0=f9Y7=HX=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=f9Y7=HX=codeaurora.org=okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 04 May 2018 15:24:33 +0100
From: okaya@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
 linux-pci-owner@vger.kernel.org
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
In-Reply-To: <20180504133327.GF15790@bhelgaas-glaptop.roam.corp.google.com>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <43b8ab4a-f8ee-dc96-40ec-e6fdfedd8309@molgen.mpg.de>
 <20180504024527.GE15790@bhelgaas-glaptop.roam.corp.google.com>
 <aa72d3ba089c76449600c22b58a2cafe@codeaurora.org>
 <20180504133327.GF15790@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <002363e27f3e9e6e8a6d71231a8a71d1@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-04 14:33, Bjorn Helgaas wrote:
> On Fri, May 04, 2018 at 07:37:40AM +0100, okaya@codeaurora.org wrote:
>> On 2018-05-04 03:45, Bjorn Helgaas wrote:
>> > On Thu, May 03, 2018 at 10:49:24AM +0200, Paul Menzel wrote:
>> > > On 04/27/18 21:22, Bjorn Helgaas wrote:
>> > > > [+cc Lukas, Sinan]
>> > >
>> > > > On Thu, Apr 26, 2018 at 12:17:53PM +0200, Paul Menzel wrote:
>> > >
>> > > > > On the Lenovo X60t, during resume from ACPI suspend and during shutdown, the
>> > > > > message below is shown in the logs.
>> > > > >
>> > > > >      pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038 (issued
>> > > > > 65284 msec ago)
>> > > >
>> > > > This is an Intel root port:
>> > > >
>> > > >    00:1c.0 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])
>> > > >
>> > > > and probably has the CF118 erratum (see
>> > > > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3461a068661c
>> > > > for details).  I bet if you changed "msecs" in pcie_wait_cmd() to 30000
>> > > > you'd see a 30 second delay during shutdown because we write a command to
>> > > > tell the port not to generate any more hotplug interrupts, and we wait for
>> > > > that command to complete, but the port never tells us it has completed.
>> > > >
>> > > > Lukas reported a similar issue in
>> > > > https://lkml.kernel.org/r/20180112104929.GA10599@wunner.de, which we sort
>> > > > of worked around by assuming that Thunderbolt controllers never support
>> > > > that "command complete" interrupt (see
>> > > > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=493fb50e958c)
>> > > >
>> > > > Sinan mooted the idea of using a "no-wait" path of sending the "don't
>> > > > generate hotplug interrupts" command.  I think we should work on this
>> > > > idea a little more.  If we're shutting down the whole system, I can't
>> > > > believe there's much value in *anything* we do in the pciehp_remove()
>> > > > path.
>> > > >
>> > > > Maybe we should just get rid of pciehp_remove() (and probably
>> > > > pcie_port_remove_service() and the other service driver remove methods)
>> > > > completely.  That dates from when the service drivers could be modules that
>> > > > could be potentially unloaded, but unloading them hasn't been possible for
>> > > > years.
>> > > >
>> > > > As far as the resume path, my guess is that in pciehp_resume(), we
>> > > > write a command to enable interrupts, then it looks like we get a
>> > > > PCI_EXP_SLTSTA_DLLSC "Link Up" interrupt, and apparently we issue
>> > > > another command.  Not sure exactly what's going on here.
>> >
>> > > Thank you for the quick reply and sorry for only being able to test
>> > > it now.
>> > > Please find the relevant bits from the ACPI S3 suspend “action”
>> > > below. The
>> > > full log is attached.
>> >
>> > No problem.  I think we need to bite the bullet and just do a quirk
>> > for the Intel erratum.  I tried to avoid it by waiting for command
>> > completion lazily, but I think that ended up being unnecessarily
>> > clever and it didn't even solve the whole problem.
>> >
>> > Can you try the patch below?  I think it should solve the problem
>> > you're seeing.
>> > ...
> 
>> > +	/* Assume all Intel controllers have erratum CF118 */
>> > +	if (pdev->vendor == PCI_VENDOR_ID_INTEL)
>> > +		ctrl->cc_erratum = 1;
>> > +
>> 
>> Can we build a table like quirks.c?
>> 
>> Qdf2400 root ports have the same problem. I will do a follow up patch 
>> once
>> this finds its way in.
> 
> Yes, definitely.  I intended to do that but got a little lazy.  What
> do you think about the following?  Paul, if you haven't tested the
> first patch, can you try this one instead?  The logic is pretty much
> the same.
> 

Yes, this works for me.


> 3461a068661c ("PCI: pciehp: Wait for hotplug command completion
> lazily") mentions AMD and Nvidia devices with the same issue, but
> unfortunately doesn't include any specifics.
> 
> 
> commit b0d6f2230e12c85ae3b65a854a53c67c7c1f6406
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu May 3 18:39:38 2018 -0500
> 
>     PCI: pciehp: Add quirk for Intel Command Completed erratum
> 
>     The Intel CF118 erratum means the controller does not set the 
> Command
>     Completed bit unless writes to the Slot Command register change 
> "Control"
>     bits.  Command Completed is never set for writes that only change 
> software
>     notification "Enable" bits.  This results in timeouts like this:
> 
>       pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
> (issued 65284 msec ago)
> 
>     When this erratum is present, avoid these timeouts by marking 
> commands
>     "completed" immediately unless they change the "Control" bits.
> 
>     Here's the text of the erratum from the Intel document:
> 
>       CF118        PCIe Slot Status Register Command Completed bit not 
> always
>                    updated on any configuration write to the Slot 
> Control
>                    Register
> 
>       Problem:     For PCIe root ports (devices 0 - 10) supporting 
> hot-plug,
>                    the Slot Status Register (offset AAh) Command 
> Completed
>                    (bit[4]) status is updated under the following 
> condition:
>                    IOH will set Command Completed bit after delivering 
> the new
>                    commands written in the Slot Controller register 
> (offset
>                    A8h) to VPP. The IOH detects new commands written in 
> Slot
>                    Control register by checking the change of value for 
> Power
>                    Controller Control (bit[10]), Power Indicator 
> Control
>                    (bits[9:8]), Attention Indicator Control 
> (bits[7:6]), or
>                    Electromechanical Interlock Control (bit[11]) 
> fields. Any
>                    other configuration writes to the Slot Control 
> register
>                    without changing the values of these fields will not 
> cause
>                    Command Completed bit to be set.
> 
>                    The PCIe Base Specification Revision 2.0 or later 
> describes
>                    the “Slot Control Register” in section 7.8.10, as 
> follows
>                    (Reference section 7.8.10, Slot Control Register, 
> Offset
>                    18h). In hot-plug capable Downstream Ports, a write 
> to the
>                    Slot Control register must cause a hot-plug command 
> to be
>                    generated (see Section 6.7.3.2 for details on 
> hot-plug
>                    commands). A write to the Slot Control register in a
>                    Downstream Port that is not hotplug capable must not 
> cause a
>                    hot-plug command to be executed.
> 
>                    The PCIe Spec intended that every write to the Slot 
> Control
>                    Register is a command and expected a command 
> complete status
>                    to abstract the VPP implementation specific nuances 
> from the
>                    OS software. IOH PCIe Slot Control Register 
> implementation
>                    is not fully conforming to the PCIe Specification in 
> this
>                    respect.
> 
>       Implication: Software checking on the Command Completed status 
> after
>                    writing to the Slot Control register may time out.
> 
>       Workaround:  Software can read the Slot Control register and 
> compare the
>                    existing and new values to determine if it should 
> check the
>                    Command Completed status after writing to the Slot 
> Control
>                    register.
> 
>     Link:
> http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
>     Link:
> https://lkml.kernel.org/r/8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de
>     Reported-by: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c 
> b/drivers/pci/hotplug/pciehp_hpc.c
> index 18a42f8f5dc5..e70eba5ea906 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -10,7 +10,6 @@
>   * All rights reserved.
>   *
>   * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
> - *
>   */
> 
>  #include <linux/kernel.h>
> @@ -147,25 +146,22 @@ static void pcie_wait_cmd(struct controller 
> *ctrl)
>  	else
>  		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
> 
> -	/*
> -	 * Controllers with errata like Intel CF118 don't generate
> -	 * completion notifications unless the power/indicator/interlock
> -	 * control bits are changed.  On such controllers, we'll emit this
> -	 * timeout message when we wait for completion of commands that
> -	 * don't change those bits, e.g., commands that merely enable
> -	 * interrupts.
> -	 */
>  	if (!rc)
>  		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec 
> ago)\n",
>  			  ctrl->slot_ctrl,
>  			  jiffies_to_msecs(jiffies - ctrl->cmd_started));
>  }
> 
> +#define CC_ERRATUM_MASK		(PCI_EXP_SLTCTL_PCC |	\
> +				 PCI_EXP_SLTCTL_PIC |	\
> +				 PCI_EXP_SLTCTL_AIC |	\
> +				 PCI_EXP_SLTCTL_EIC)
> +
>  static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
>  			      u16 mask, bool wait)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
> -	u16 slot_ctrl;
> +	u16 slot_ctrl_orig, slot_ctrl;
> 
>  	mutex_lock(&ctrl->ctrl_lock);
> 
> @@ -180,6 +176,7 @@ static void pcie_do_write_cmd(struct controller
> *ctrl, u16 cmd,
>  		goto out;
>  	}
> 
> +	slot_ctrl_orig = slot_ctrl;
>  	slot_ctrl &= ~mask;
>  	slot_ctrl |= (cmd & mask);
>  	ctrl->cmd_busy = 1;
> @@ -188,6 +185,17 @@ static void pcie_do_write_cmd(struct controller
> *ctrl, u16 cmd,
>  	ctrl->cmd_started = jiffies;
>  	ctrl->slot_ctrl = slot_ctrl;
> 
> +	/*
> +	 * Controllers with the Intel CF118 and similar errata advertise
> +	 * Command Completed support, but they only set Command Completed
> +	 * if we change the "Control" bits for power, power indicator,
> +	 * attention indicator, or interlock.  If we only change the
> +	 * "Enable" bits, they never set the Command Completed bit.
> +	 */
> +	if (pdev->broken_cmd_compl &&
> +	    (slot_ctrl_orig & CC_ERRATUM_MASK) == (slot_ctrl & 
> CC_ERRATUM_MASK))
> +		ctrl->cmd_busy = 0;
> +
>  	/*
>  	 * Optionally wait for the hardware to be ready for a new command,
>  	 * indicating completion of the above issued command.
> @@ -861,7 +869,7 @@ struct controller *pcie_init(struct pcie_device 
> *dev)
>  		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
>  		PCI_EXP_SLTSTA_DLLSC);
> 
> -	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c
> PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c\n",
> +	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c
> PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
>  		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
> @@ -872,7 +880,8 @@ struct controller *pcie_init(struct pcie_device 
> *dev)
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_HPS),
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
> -		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC));
> +		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
> +		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
> 
>  	if (pcie_init_slot(ctrl))
>  		goto abort_ctrl;
> @@ -891,3 +900,17 @@ void pciehp_release_ctrl(struct controller *ctrl)
>  	pcie_cleanup_slot(ctrl);
>  	kfree(ctrl);
>  }
> +
> +static void quirk_cmd_compl(struct pci_dev *pdev)
> +{
> +	u32 slot_cap;
> +
> +	if (pci_is_pcie(pdev)) {
> +		pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
> +		if (slot_cap & PCI_EXP_SLTCAP_HPC &&
> +		    !(slot_cap & PCI_EXP_SLTCAP_NCCS))
> +			pdev->broken_cmd_compl = 1;
> +	}
> +}
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 73178a2fcee0..60cb5350ad28 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -406,6 +406,9 @@ struct pci_dev {
>  	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file
> for resources */
>  	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs
> file for WC mapping of resources */
> 
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE
> +	unsigned int	broken_cmd_compl:1;	/* Command Complete broken */
> +#endif
>  #ifdef CONFIG_PCIE_PTM
>  	unsigned int	ptm_root:1;
>  	unsigned int	ptm_enabled:1;
