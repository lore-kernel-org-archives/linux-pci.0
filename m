Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:20472 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752142Ab3KZFyB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Nov 2013 00:54:01 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: pciehp LinkState
Date: Tue, 26 Nov 2013 05:53:54 +0000
Message-ID: <cfeb9976fbb74028b600c9f86fcdd9ad@BLUPR05MB118.namprd05.prod.outlook.com>
References: <528D4739.80700@fold.natur.cuni.cz>
 <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
 <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com>
 <20131125194044.GA9710@google.com> <5293F3FB.6000401@fold.natur.cuni.cz>
 <20131126031317.GA6258@google.com>
In-Reply-To: <20131126031317.GA6258@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Monday, November 25, 2013 7:13 PM
> To: Martin Mokrejs
> Cc: Rajat Jain; linux-pci@vger.kernel.org; Rajat Jain; Guenter Roeck
> Subject: Re: pciehp LinkState
> 
> On Tue, Nov 26, 2013 at 02:06:03AM +0100, Martin Mokrejs wrote:
> > Hi Rajat and Bjorn,
> >   I tested all the patches, comments below:

Thanks a lot! This was very helpful.

> >
> > Bjorn Helgaas wrote:
> > > On Mon, Nov 25, 2013 at 07:00:01PM +0000, Rajat Jain wrote:
> > >> Hello Martin,
> > >>
> > >>>>
> > >>>> Below is the overview since cold boot with no card inserted with
> all
> > >>> those hotplug events. You see,
> > >>>> pciehp never sets LinkState back to minus once the slot is empty:
> > >>>>
> > >>>> vostro ~ # grep LinkState
> > >>>
> pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__eject
> > >>> ed_but_not_realized__inserted__ejected.txt
> > >>>>                         Changed: MRL- PresDet- LinkState-
> > >>>>                         Changed: MRL- PresDet- LinkState+
> > >>>>                         Changed: MRL- PresDet- LinkState+
> > >>>>                         Changed: MRL- PresDet- LinkState+
> > >>>>                         Changed: MRL- PresDet- LinkState+
> > >>>
> > >>> I opened https://bugzilla.kernel.org/show_bug.cgi?id=65521 for
> this
> > >>> issue.  I agree that pciehp should probably clear this bit.  Rajat
> > >>> recently posted some patches [1] that add support for link state
> > >>> changes.  I haven't look at them in detail yet, but I wouldn't be
> > >>> surprised if they will fix this issue.  If you wanted to test
> them,
> > >>> that would be awesome!
> >
> > In brief, the patch works, note below on every 5th line there is
> LinkState-,
> > so the LinkState is not stuck at plus anymore. Why I never see it plus
> > I do not know, maybe it is cleared too quickly?
> >
> > # grep Changed lspci_vvv_initial* | grep LinkState
> > lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
> LinkState-
> > lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
> LinkState+
> > lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
> LinkState+
> > lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
> LinkState+
> > lspci_vvv_initial.txt:                  Changed: MRL- PresDet-
> LinkState-
> 
> 
> Great, thanks for testing this.  The bit labelled "LinkState" here is
> the
> "Data Link Layer State *Changed*" bit in the Slot Status register.  It
> is
> set whenever the Data Link Layer Link Active bit in the Link Status
> register is changed.  So this LinkState bit doesn't tell you the state
> of
> the link; basically it just tells you that the link changed from "down"
> to
> "up", or from "up" to "down."
> 
> You should not normally see this "LinkStateChanged" bit set via lspci
> because pciehp will get an interrupt when it is set, and the ISR will
> notice that the link state has changed and immediately clear the
> LinkStateChanged bit.

Martin: You mention "LinkState-" on every 5th line of the log, I am assuming that the remaining 4 lines (specially the ones with "LinkState+") are for PCI bridges that are not handled by the pciehp - may be because they do not represent hot-pluggable ports. With this patch, I'll be surprised if you ever saw "LinkState+" in the lspci output of a bridge for hot-pluggable port.

> >
> >
> > I read a bit too quickly your comments in the patch and while am no
> kernel developer I will post
> > silly questions. Maybe you would like to polish the comments in
> patches.
> > 1. You speak about some 'bells and whistles' ... you mean PresDet bit
> handled by my SandyBridge chip
> > is also one of those fancy things like an eject button? The LinkState
> is another example of fancy thing?
> > Why aren't or weren't these supported before some eject buttons you
> speak about?

The PresDet changed bit *IS* supported today - however only if the port supports "Surprise" addition or removal. My patch is aimed at systems that do not even have that in place, and want to only rely on link state changes. 

> 
> I think this is just a consequence of the fact that we typically add
> support for things as we need them, and people haven't needed LinkState
> in
> the past.  Rajat has a somewhat unusual system that needs it, so he's
> now
> adding support for it.

:-)

> 
> > 2. Concerning eject detection, is there any order of precedence of the
> information being collected
> > and interpreted? Like, is PresDet more important than LinkChange or
> some "eject button" of whatever
> > you mean under those 'bells and whistles'.

No, all events are processed eventually, and there is no precedence as such. The only "ordering" (if you may call it so) is the order in which handler functions are called from pcie_isr():

      /* Check Command Complete Interrupt Pending */
        if (intr_loc & PCI_EXP_SLTSTA_CC) {
                ctrl->cmd_busy = 0;
                smp_mb();
                wake_up(&ctrl->queue);
        }

        if (!(intr_loc & ~PCI_EXP_SLTSTA_CC))
                return IRQ_HANDLED;

        /* Check MRL Sensor Changed */
        if (intr_loc & PCI_EXP_SLTSTA_MRLSC)
                pciehp_handle_switch_change(slot);

        /* Check Attention Button Pressed */
        if (intr_loc & PCI_EXP_SLTSTA_ABP)
                pciehp_handle_attention_button(slot);

        /* Check Presence Detect Changed */
        if (intr_loc & PCI_EXP_SLTSTA_PDC)
                pciehp_handle_presence_change(slot);

        /* Check Power Fault Detected */
        if ((intr_loc & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
                ctrl->power_fault_detected = 1;
                pciehp_handle_power_fault(slot);
        }

        if (intr_loc & PCI_EXP_SLTSTA_DLLSC)
                pciehp_handle_linkstate_change(slot);


> >
> > 3. Related to point 2., should xhci_hcd behave in a different way and
> say let more happily a USB device
> > fall asleep if the LinkState is now being cleared? (Note: to do the
> above tests I had to redo my test
> > of teh patched kernel because I forgot that likely while testing
> vanilla kernel I had attached USB
> > mouse and keyboard to my SandyBridge chip and the TexaInstruments
> chip. While inspecting lspci differences
> > I wondered why in unpatched kernel I had changes between ASPM L0s L1
> vs. Disabled while on patched
> > kernel the insert/eject changes resulted in ASPM L0s vs L1 only
> difference. It seem that was because
> > I did not have attached USB devices to the ports. But, funny is that
> these differences were on all
> > USB-capable PCI devices (hence am speaking about SandyBridge's USB2
> ports, the onboard TexasInstuments
> > USB3 chip while affected should have been only the NEC-based USB3 chip
> presenton the hotpluggable card --
> > or its rootport. So, I somehow suspect your patch changed a bit more
> in behavior or my system.

Ummm, I doubt if my patch could have any effect at all on the ASPM, but I'll let more experts comment. 

> >
> >
> > I do not want to spoil this message thread anymore, try to check this
> ASPM stuff yourself if you care.
> > I am not the right person to test this. ;-)
> >
> > LinkState is being changed and that is enough for my curiosity ATM. ;)
> You can add my Tested-by:
> > if you do not wonder why there is no LinkState+ in my tests. If
> anybody wants tar.bz2 of the collected
> > logs please email me. I have attached only the very last dmesg
> collected covering all the tests.
> >
> > Thank you,
> > Martin
> 
> > [  174.623769] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 108
> > [  174.623781] pciehp 0000:00:1c.7:pcie04: Presence/Notify input
> change
> > [  174.623784] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> > [  174.623798] pciehp 0000:00:1c.7:pcie04: Data Link Layer State
> change
> > [  174.623801] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_active:
> lnk_status = 7011
> > [  174.623802] pciehp 0000:00:1c.7:pcie04: slot(7): Link Up event
> > [  174.624040] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> > [  174.624075] pciehp 0000:00:1c.7:pcie04: Link Up event ignored on
> slot(7): already powering on
> > [  174.625660] pciehp 0000:00:1c.7:pcie04: Enabling
> domain:bus:device=0000:11:00
> > [  174.625690] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_active:
> lnk_status = 7011
> > [  174.726003] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status:
> lnk_status = 7011
> 
> These messages are more verbose and possibly more alarming than
> necessary.
> We should clean this up somehow.  Some of it is probably debug stuff
> that
> is no longer relevant.  But I guess you're booting with
> "pciehp_debug=1",
> so maybe the normal messages aren't so verbose.

Bjorn: Actually this threads brings up an good point. Is "DLL State changed" bit in "Slot Status" ALWAYS updated without regard to whether the Link state notifications were enabled or not? Looks like it. If yes, I'll take this as an input to make a 1 line change to my patch:

Currently in my patch, the pciehp_use_link_events=1 is used to only enable link state change notifications, but in case pcie_isr() finds "DLL changed" bit set in "Slot status", it processes the link state change. I'll make the single line change to pcie_isr() to process the event only if pciehp_use_link_events=1. Let me know if this sounds alright.

I'd still wait for other comments before sending out a revised version of the patch though.

Thanks both Bjorn & Martin for paying attention to this patch set!

Rajat

> 
> Bjorn
> 


