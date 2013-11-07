Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:39125 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab3KGVxp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2013 16:53:45 -0500
MIME-Version: 1.0
In-Reply-To: <CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
References: <52797238.8070304@gmail.com>
	<20131106002505.GC3359@google.com>
	<CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
Date: Thu, 7 Nov 2013 13:53:44 -0800
Message-ID: <CADTPrLQpaCDo_YCC2=MmT1iCrWRPqzDpnqQZrE8OMjRMc6WYmQ@mail.gmail.com>
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

Hi Bjorn / list,

I think there are two independent problems that need to be addressed.

Problem #1: In any condition where (e.g. spurious interrupt) once the
execution reaches inside the if condition below, the PCI_EXP_SLTSTA_CC
bit is already set, and needs to be cleared. This does not happen
today and hence this patch was aimed at solving that. Please note that
this will not cause any problems to the systems that were fixed by
5808639bfa98, because this is equally applicable to any case.

>>>
>>>  drivers/pci/hotplug/pciehp_hpc.c |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>>> index 5b8d749..ba8e06f 100644
>>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>>> @@ -185,6 +185,7 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>>>       }
>>>
>>>       if (slot_status & PCI_EXP_SLTSTA_CC) {
>>> +             pciehp_writew(ctrl, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_CC);
>>>               if (!ctrl->no_cmd_complete) {
>>>                       /*
>>>                        * After 1 sec and CMD_COMPLETED still not set, just
>>> --
>>> 1.7.9.5
>>>

 Problem #2: Looks like we have now 2 classes of systems:

a) The 5808639bfa98 was addressed towards systems that advertise the
"Command completion notification" capability, but do not notify of
command completion in case MRL, Power Ctrl, Attn LED and Pwr LED bits
are not written in SLOT_CTRL register (not implemented in
capabilities). Thus no command completion shall be generated for
pcie_disable_notifications() for e.g.

b) I have a system that where none of the above described HP elements
are present implemented, but the controller supports command
completion, and sends it out for every write of the slot control
register. Thus notification for command complete is generated for
pcie_disable_notifiction().

I don't believe there is a way to differentiate between these 2
classes of systems at init time, unless we try to generate a
notification and do or do not get one.

The PCIe specification section 7.8.10 seems to lean towards category
(b) of systems, but today this class of systems shall get penalized by
delay of 1 second (per controller) during probe. I can try and address
that, but admittedly I could not think of a better solution than
moving this code from pcie_init() to pcie_write_cmd().

>         if (NO_CMD_CMPL(ctrl) ||
>             !(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) | EMI(ctrl)))
>             ctrl->no_cmd_complete = 1;

Please advise.

Also, I'd appreciate if you could please let me know if there are any
comments on the patch for problem #1 above.

Thanks,

Rajat
