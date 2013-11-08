Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33974 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758494Ab3KHXQI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Nov 2013 18:16:08 -0500
Received: by mail-ie0-f170.google.com with SMTP id at1so4489139iec.29
        for <linux-pci@vger.kernel.org>; Fri, 08 Nov 2013 15:16:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADTPrLTYOXsGovL8HJ7=+K30OWVeSdMKTma_UuMV8ZRFB6CkYA@mail.gmail.com>
References: <52797238.8070304@gmail.com> <20131106002505.GC3359@google.com>
 <CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
 <CADTPrLQpaCDo_YCC2=MmT1iCrWRPqzDpnqQZrE8OMjRMc6WYmQ@mail.gmail.com>
 <20131108012352.GE2955@google.com> <CADTPrLTYOXsGovL8HJ7=+K30OWVeSdMKTma_UuMV8ZRFB6CkYA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 8 Nov 2013 16:15:46 -0700
Message-ID: <CAErSpo7MH=+Jk-ujBoHquk2e+no1cqEV6p=R1E6LGvcLSJQyKw@mail.gmail.com>
Subject: Re: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
To: Rajat Jain <rajatjain.linux@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Guenter Roeck <groeck@juniper.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Rajat Jain <rajatjain@juniper.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 8, 2013 at 10:30 AM, Rajat Jain <rajatjain.linux@gmail.com> wrote:
> On Thu, Nov 7, 2013 at 5:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>> Where does this delay happen on your system?  I tried to work through
>> the path but I don't see it yet.  Here's what I expect to happen on your
>> system:
>>
>>     pciehp_probe
>>       pcie_init
>>         readl(SLTCAP)
>>         if (NO_CMD_CMPL || !(POWER_CTRL | ATTN_LED | PWR_LED | EMI))  # true
>>           ctrl->no_cmd_complete = 1     # set (condition above is true)
>>         writew(SLTSTA, 0x1f)            # clear ABP PFD MRLSC PDC CC
>>         pcie_disable_notification
>>           pcie_write_cmd(0, PDCE | ABPE | MRLSCE | PFDE | HPIE | CCIE | DLLSCE)
>>             readw(SLTSTA)               # CC == 0 (was cleared above)
>>             writew(SLTCTL)
>>             ...
>>             # no waiting here because no_cmd_complete == 1
>>             ...
>>             hardware sets SLTSTA.CC
>>             ...
>>       pcie_init_notification
>>         pcie_enable_notification
>>           pcie_write_cmd
>>             readw(SLTSTA)               # CC == 1 (was set by HW above)
>>             if (SLTSTA.CC)              # true
>>               if (!NO_CMD_CMPL))        # true
>>                 dbg("Unexpected CMD_COMPLETED. ...")
>>                 ctrl->no_cmd_complete = 0
>>             writew(SLTCTL)
>>             ...
>>             # this time we wait because no_cmd_complete == 0
>>             ...
>>             pcie_wait_cmd(..., poll == 1)       # now no_cmd_complete == 0
>
> Actually pcie_wait_cmd() shall be called with poll=0. That is because
> the following conditions are both false (we just enabled both the
> interrupts while enabling notifications):
>
>                 if (!(slot_ctrl & PCI_EXP_SLTCTL_HPIE) ||
>                     !(slot_ctrl & PCI_EXP_SLTCTL_CCIE))
>                         poll = 1;
>
> Thus it does not poll, but waits for interrupt. Which does not happen
> because the CC bit in the slot status register was not cleared.

Right, of course.  Thanks for pointing out my error.

> As a
> result, we get the following messages on the console for each
> controller (and 1 second delay):
> ===========================
> Unexpected CMD_COMPLETED. Need to wait for command completed event.
> Command not completed in 1000 msec
> ===========================
> With my patch, we'd eliminate the 1 second delay and the second line
> of output above. If we also want to get rid of the first line
> "Unexpected CMD_COMPLETED..." also, that would probably have to be
> solved by changing the behavior to assume that CC shall be generated
> for every SLOTCTRL register write.

I *do* want to get rid of the "Unexpected CMD_COMPLETED" complaint.
We shouldn't complain about hardware that is working perfectly fine.
I don't know the best way to do that yet.  I have found a box with the
same hardware that was fixed by 5808639bfa98, so I hope to play with
it and figure out something that will work nicely for both scenarios.

BTW, can you open a report at bugzilla.kernel.org and attach your
"lspci -vvxxx" and dmesg output?  When we eventually merge a fix, I'd
like to have the details archived somewhere.

Bjorn
