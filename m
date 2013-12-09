Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:55243 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759129Ab3LICKJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Dec 2013 21:10:09 -0500
MIME-Version: 1.0
In-Reply-To: <aaaa948b964642859fa142779846211f@DM2PR05MB671.namprd05.prod.outlook.com>
References: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5BnfmRJjXBqM7pWrMgvUt60hfC9oRbGy7=h6+Gftepqg@mail.gmail.com>
	<aaaa948b964642859fa142779846211f@DM2PR05MB671.namprd05.prod.outlook.com>
Date: Mon, 9 Dec 2013 10:10:08 +0800
Message-ID: <CABawtvPMSGc+7HqqtE9NXxCo11Vp-Yu+feF6UqS18k+jwPxoVw@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
From: Ethan Zhao <ethan.kernel@gmail.com>
To: Rajat Jain <rajatjain@juniper.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rajat,

    Do you have a draft to extend the hotplug spec ?  seem you wanna
introduce link change interrupt to
the your chip or just poll the link status register ?

Thanks,
Ethan

On Mon, Dec 9, 2013 at 5:29 AM, Rajat Jain <rajatjain@juniper.net> wrote:
> Hello,
>
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
>> Sent: Saturday, December 07, 2013 10:36 AM
>> To: Yinghai Lu
>> Cc: linux-pci@vger.kernel.org; Kenji Kaneshige; stable@vger.kernel.org
>> Subject: Re: [PATCH] PCI, pciehp: Turn on link a while to workaround
>> presense detection
>>
>> On Fri, Dec 6, 2013 at 1:22 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> > During hotplug test on platform, found slot status register does not
>> > report present status correctly. That present bit does not get cleared
>> > even after that card is removed.
>> >
>> > That problem is caused by commit:
>> > | commit 2debd9289997fc5d1c0043b41201a8b40d5e11d0
>> > |
>> > |    PCI: pciehp: Disable/enable link during slot power off/on
>> >
>> > It looks like chipset bug, that PresDet bit is "OR" operation between
>> > sideband input from FPGA, and chipset inband detection from pcie link.
>>
>> This doesn't sound like a chipset bug.  It sounds like exactly what the
>> spec describes: "Presence Detect State - This bit indicates the presence
>> of an adapter in the slot, reflected by the logical "OR" of the Physical
>> Layer in-band presence detect mechanism and, if present, any out-of-band
>> presence detect mechanism defined for the slot's corresponding form
>> factor" (PCIe 3.0, sec 7.8.11).
>>
>> So I want to fix this pciehp problem, but between 2debd9289997 and this
>> patch, pciehp_power_off_slot() is accumulating warts that make it look
>> like we're just reacting to things that break rather than making a
>> robust design to start with.
>
> Yes.
>
> In fact things do get more complicated if we introduce link state based hot-plug, because then that requires that we do NOT disable the link permanently during power off. (Because we would want to receive future hot-plug link-up events).
>
>>
>> > It does not like if we disable pcie link at first and power off other
>> > side device, and it has input from inband detection always 1.
>> >
>> > Workaround: Try turn on link a while after power off.
>> >
>> > After this patch, PresDet report correct status when removing or
>> > adding card later.
>> >
>> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> > Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>> > Cc: <stable@vger.kernel.org> 3.4+
>> >
>> > ---
>> >  drivers/pci/hotplug/pciehp_hpc.c |    9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
>> > ===================================================================
>> > --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
>> > +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
>> > @@ -637,6 +637,15 @@ int pciehp_power_off_slot(struct slot *
>> >         }
>> >         ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
>> >                  pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
>> > slot_cmd);
>> > +
>> > +       /*
>> > +        * Enable link for a while so chipset could settle down
>> > +        * inband presence detection logic
>> > +        */
>> > +       pciehp_link_enable(ctrl);
>> > +       msleep(20);
>> > +       pciehp_link_disable(ctrl);
>> > +
>> >         return 0;
>> >  }
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org More majordomo info
>> at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
