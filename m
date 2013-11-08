Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34753 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433Ab3KHRak (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Nov 2013 12:30:40 -0500
MIME-Version: 1.0
In-Reply-To: <20131108012352.GE2955@google.com>
References: <52797238.8070304@gmail.com>
	<20131106002505.GC3359@google.com>
	<CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
	<CADTPrLQpaCDo_YCC2=MmT1iCrWRPqzDpnqQZrE8OMjRMc6WYmQ@mail.gmail.com>
	<20131108012352.GE2955@google.com>
Date: Fri, 8 Nov 2013 09:30:38 -0800
Message-ID: <CADTPrLTYOXsGovL8HJ7=+K30OWVeSdMKTma_UuMV8ZRFB6CkYA@mail.gmail.com>
Subject: Re: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
From: Rajat Jain <rajatjain.linux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Guenter Roeck <groeck@juniper.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Rajat Jain <rajatjain@juniper.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,


On Thu, Nov 7, 2013 at 5:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Nov 07, 2013 at 01:53:44PM -0800, Rajat Jain wrote:
>> Hi Bjorn / list,
>>
>> I think there are two independent problems that need to be addressed.
>>
>> Problem #1: In any condition where (e.g. spurious interrupt) once the
>> execution reaches inside the if condition below, the PCI_EXP_SLTSTA_CC
>> bit is already set, and needs to be cleared. This does not happen
>> today and hence this patch was aimed at solving that. Please note that
>> this will not cause any problems to the systems that were fixed by
>> 5808639bfa98, because this is equally applicable to any case.
>
> Your patch might be the right thing to do, but something still niggles
> at me, and I can't quite put my finger on it yet.
>
>> >>>
>> >>>  drivers/pci/hotplug/pciehp_hpc.c |    1 +
>> >>>  1 file changed, 1 insertion(+)
>> >>>
>> >>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> >>> index 5b8d749..ba8e06f 100644
>> >>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> >>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> >>> @@ -185,6 +185,7 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>> >>>       }
>> >>>
>> >>>       if (slot_status & PCI_EXP_SLTSTA_CC) {
>> >>> +             pciehp_writew(ctrl, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_CC);
>> >>>               if (!ctrl->no_cmd_complete) {
>> >>>                       /*
>> >>>                        * After 1 sec and CMD_COMPLETED still not set, just
>> >>> --
>> >>> 1.7.9.5
>> >>>
>>
>>  Problem #2: Looks like we have now 2 classes of systems:
>>
>> a) The 5808639bfa98 was addressed towards systems that advertise the
>> "Command completion notification" capability, but do not notify of
>> command completion in case MRL, Power Ctrl, Attn LED and Pwr LED bits
>> are not written in SLOT_CTRL register (not implemented in
>> capabilities). Thus no command completion shall be generated for
>> pcie_disable_notifications() for e.g.
>
> This seems pretty clearly out of spec.  I read the 82801H spec for the
> part used in the system in bz 10751, and the documentation seems to
> comply with the spec.  Possibly the part doesn't work as advertised,
> but I think it's more likely there's some subtlety we're still missing.
>
> I'm a little bit surprised that we'd be using pciehp on that Thinkpad R61
> instead of acpiphp.  The kernel in bz 10751 is so ancient that it might
> not be negotiating correctly for control of pciehp.
>
>> b) I have a system that where none of the above described HP elements
>> are present implemented, but the controller supports command
>> completion, and sends it out for every write of the slot control
>> register. Thus notification for command complete is generated for
>> pcie_disable_notifiction().
>>
>> I don't believe there is a way to differentiate between these 2
>> classes of systems at init time, unless we try to generate a
>> notification and do or do not get one.
>>
>> The PCIe specification section 7.8.10 seems to lean towards category
>> (b) of systems, but today this class of systems shall get penalized by
>> delay of 1 second (per controller) during probe.
>
> Where does this delay happen on your system?  I tried to work through
> the path but I don't see it yet.  Here's what I expect to happen on your
> system:
>
>     pciehp_probe
>       pcie_init
>         readl(SLTCAP)
>         if (NO_CMD_CMPL || !(POWER_CTRL | ATTN_LED | PWR_LED | EMI))  # true
>           ctrl->no_cmd_complete = 1     # set (condition above is true)
>         writew(SLTSTA, 0x1f)            # clear ABP PFD MRLSC PDC CC
>         pcie_disable_notification
>           pcie_write_cmd(0, PDCE | ABPE | MRLSCE | PFDE | HPIE | CCIE | DLLSCE)
>             readw(SLTSTA)               # CC == 0 (was cleared above)
>             writew(SLTCTL)
>             ...
>             # no waiting here because no_cmd_complete == 1
>             ...
>             hardware sets SLTSTA.CC
>             ...
>       pcie_init_notification
>         pcie_enable_notification
>           pcie_write_cmd
>             readw(SLTSTA)               # CC == 1 (was set by HW above)
>             if (SLTSTA.CC)              # true
>               if (!NO_CMD_CMPL))        # true
>                 dbg("Unexpected CMD_COMPLETED. ...")
>                 ctrl->no_cmd_complete = 0
>             writew(SLTCTL)
>             ...
>             # this time we wait because no_cmd_complete == 0
>             ...
>             pcie_wait_cmd(..., poll == 1)       # now no_cmd_complete == 0

Actually pcie_wait_cmd() shall be called with poll=0. That is because
the following conditions are both false (we just enabled both the
interrupts while enabling notifications):

                if (!(slot_ctrl & PCI_EXP_SLTCTL_HPIE) ||
                    !(slot_ctrl & PCI_EXP_SLTCTL_CCIE))
                        poll = 1;

Thus it does not poll, but waits for interrupt. Which does not happen
because the CC bit in the slot status register was not cleared. As a
result, we get the following messages on the console for each
controller (and 1 second delay):
===========================
Unexpected CMD_COMPLETED. Need to wait for command completed event.
Command not completed in 1000 msec
===========================
With my patch, we'd eliminate the 1 second delay and the second line
of output above. If we also want to get rid of the first line
"Unexpected CMD_COMPLETED..." also, that would probably have to be
solved by changing the behavior to assume that CC shall be generated
for every SLOTCTRL register write.

Please suggest.

Thanks,

Rajat

>               pcie_poll_cmd
>                 readw(SLTSTA)           # CC == 1 on first read
>                 if (SLTSTA.CC)
>                   writew(SLTSTA, CC)
>                   return 1
>
> I would think you'd see the "Unexpected CMD_COMPLETED. Need to wait for
> command completed event" message (if enabled),
> but I don't see where the
> one second timeout would happen.  It looks like we would call
> pcie_poll_cmd(), but it would return immediately because SLTSTA.CC is
> already set.
>
