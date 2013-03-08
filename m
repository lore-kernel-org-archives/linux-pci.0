Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:50141 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754041Ab3CHBrH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2013 20:47:07 -0500
Message-ID: <51394317.20104@fold.natur.cuni.cz>
Date: Fri, 08 Mar 2013 02:47:03 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
References: <50EDF8FE.6040607@fold.natur.cuni.cz> <CAErSpo6etF7_fZH9nNoAhtRXdGEmBrNE7v84TRkoawyG9s4AGw@mail.gmail.com> <51371AD9.4040801@fold.natur.cuni.cz> <CAErSpo5wmM8+Qd4FH0WeNS_DJEk2Tmmivk-FgEbD-UbTMQf+ZQ@mail.gmail.com>
In-Reply-To: <CAErSpo5wmM8+Qd4FH0WeNS_DJEk2Tmmivk-FgEbD-UbTMQf+ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alan because it looks in general, USB is involved and compared to MS Win7
 with the most restrictive BIOS settings no eSATA/FireWireOHCI cards work
 under linux ('nousb' on kernel commandline) while they both do under Win7. Hope
 we will fork that stuff under a new bug #]

Bjorn Helgaas wrote:
> [+cc Sarah because problem only seems to happen with xhci.  I'm
> assuming this is a pciehp issue for now]
> 
> On Wed, Mar 6, 2013 at 3:30 AM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>> Hi Bjorn,
>>   thank you for your time on this issue.
>>
>> Bjorn Helgaas wrote:
>>> On Wed, Jan 9, 2013 at 4:10 PM, Martin Mokrejs
>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>> Hi,
>>>>   I am following up on a former thread
>>>> Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
>>>> about the same issue. I think I found some new info while playing with 3.7.1 kernel.
>>>> It happened to me that my hotplug of express cards stopped working so it made me to
>>>> to dive in a figure out what driver did I do to my .config, and what combinations
>>>> of drivers and kernel command-line parameters work and which not. This email will
>>>> cover just one case.
>>>>
>>>> On this Dell Vostro 3550 express card slot works if kernel is without pciehp
>>>> altogether and pci_hotplug+acpiphp are loaded as modules later on. The problem
>>>> is that I must use pcie_aspm=off.
>>>
>>> I confess I am completely bewildered here.  Something is clearly badly
>>> broken, but I'm having a hard time figuring out exactly what it is.  I
>>> think I'm overwhelmed by all the data :)

It won't be easier now but you asked for it. ;)

[cut]

> 
> I'm going to ignore this speculation about xhci and other drivers for
> now and see if we can just get pciehp to work.  We need to reduce the
> number of variables here.
> 
> I opened https://bugzilla.kernel.org/show_bug.cgi?id=54921
> "pciehp/xhci ExpressCard failure on Dell Vostro 3550" for this issue.
> 
>> Or, the card is not PCI or PCIe hotplug capable [6]?
>> Could that be the difference in behior?
> 
> All ExpressCards should support hotplug.  The hotplug support is in
> the root port and other circuitry on the motherboard.
> 
>>> But I think it's a bad idea to go down the road of using acpiphp.
>>
>> Unfortunately I was forced to switch to acpiphp because commit
>> 0d52f54e2ef64c189dedc332e680b2eb4a34590a (as diagnosed by Yinghai)
>> becuase pciehp stopped working (although it worked badly anyways).
> 
> I understand you have to use acpiphp to make things work right now.
> But I think we can make pciehp work, and I think that's what distros
> will want to use in this situation, so that's what I want to debug.
> 
> As background for the whole collection of hotplug drivers we have,
> here's my understanding of the history:
> 
> 1) Originally there was no standard for PCI hotplug hardware, and we
> have drivers like cpqphp, ibmphp, etc. to deal with various hardware
> designs.
> 
> 2) ACPI defined an abstract hotplug model so an OS can have a single
> driver, e.g., acpiphp, for that model, and the BIOS can map the
> abstract model to various hardware designs.
> 
> 3) PCIe defined a single hardware model, so an OS can have a single
> driver, e.g., pciehp.  ACPI is not really involved here except that
> the OS has to ask the BIOS for permission to use this native hotplug
> driver.
> 
> Many machines, including yours, support both ACPI (acpiphp) and PCIe
> native (pciehp) hotplug so they can run both old OSes that don't have
> pciehp, and newer OSes that prefer to use pciehp.
> 
>> Yighai in the 3.2.x thread postulated it is a BIOS or silicon bug
>> incorrectly providing PresDet status. I was glad that I can show
>> that with acpiphp the PresDet is *always* correct (3.7. kernel)
>> *provided* I disabled MediaCard reader in BIOS.
> 
> Can you build a v3.9-rc1 kernel with this config:
> 
>   CONFIG_HOTPLUG_PCI_PCIE=y
>   CONFIG_HOTPLUG_PCI_ACPI=n
>   CONFIG_USB_XHCI_HCD=n
> 
> I want to use pciehp, not acpiphp, and leave the xhci driver out of
> the picture for now.  Boot it with pciehp.pciehp_debug=1 and the
> ExpressCard slot empty, and run this command:
> 
>   # while true; do echo -n "$(date +%T) SlotStatus "; setpci -s1c.7
> 0x5a.w; sleep 1; done
> 
> That command reads the SlotStatus register from the bridge leading to
> your ExpressCard slot every second.  While that command is running, do
> insertions and removals of all your ExpressCards.  Bit 6 (0x0040) is
> the Presence Detect bit.  It should change as you insert and remove
> cards.
> 
> I'd like to see the complete dmesg log, the output of "lspci -vv", and
> the output of the above command while you insert/remove cards (with
> notes about which card is being hotplugged when).  Since there seems
> to be some interaction with the MediaCard reader BIOS settings, maybe
> you could do this whole experiment with the reader disabled, then with
> it enabled.
> 
> You can attach these logs to the bugzilla
> (https://bugzilla.kernel.org/show_bug.cgi?id=54921) if you want, or
> point me to them and I'll do it.

I exposed the collected data (500kB) at http://195.113.57.32/~mmokrejs/tmp/ExpressCard_hotplug_tests_3.9-rc1.tar.bz2


1)
This is 3.9-rc1 kernel. From a quick glance I think it is different from 3.7.x
and 3.2.x in a way that after ejecting eSATA card there is too many diffs in
"lspci -vv" output when comparing cold boot state with the state after card
is ejected. I don't remember that from the past and I don't see that with the
USB3 card nor FireWireOHCI card. Could it be the drivers is in 3.9-rc1 still
loaded? If yes, maybe the multiple attempts to insert/eject card are affected
by this. Please verify what I say and summarize in bugzilla. I won't spoil it
(this email is enough).


2)
I will go straight where the USB interference is. I noticed in the past (email
threads were recapped in this thread already) that after insertion of some cards
"USB" bus is reset or at least, a Media Card reader is detected, or re-detected,
simply appears in dmesg. In dmesg outputs you will see ehci-pci driver being
involved. I tried to disable more and more USB devices in BIOS and also used
'nousb' commandline option to disable BIOS. I do not understand why that completely
ExpressCard slot functionality under Linux while not under Win7. In Linux pciehp
still complains about Surprise Removal even when I insert the card for the very
first time after a coldboot (so the ExpressCard slot is not completely dead but
neither sata_sil24 nor fw_ohci pickus up the device). USB drivers had no chance
to bind because of the 'nousb', of course. Alan/Sarah, please look possibly in
this order into the following dirs (well, don't waste too much time on the first
one, focus more on on difference between the second and third, and I placed a
file Win7.txt in the third to recap the Win7 vs. Linux differences):

without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/
without_USB_no_ACPIPHP_with_PCIEHP/
without_USB_no_ACPIPHP_with_PCIEHP_without_microphone_USB_wakeup_USB_emulation_USB_powershare/

My question is. Has the laptop hardwired the ExpressCard slot somehow through USB
to the SandyBridge chip? It seems not only the UVC Camera is, but also a CD/DVD
optical drive is and the item "Microphone" in BIOS possibly involves whole Intel
HD Audio soundcard. If that is true then I understand why under linux 'nousb'
prevents functionality of all the three ExpressCard tested.

Puzzlingly, while 'nousb' was used my Alps touchpad still worked in VT console.
Further, what I might have had always screwed in my .config is that there are SDHC drivers
and some other which might be competing with some USB drivers (under normal .config)
for the say MediaCardReader, etc.). Please compare without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/.config.gz
with without_USB_no_ACPIPHP_with_PCIEHP_without_microphone_USB_wakeup_USB_emulation_USB_powershare/config.gz.


3)
The hotplug issue itself. I do not understand the PCI(e) hotplug, lspci output but
why is there any difference between a cold booted status of an empty expresscard slot
compared to the status when a card is unloaded?


 # diff -u without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/lspci_vv_initial.txt without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/lspci_vv_unloading_USB3_card.txt
--- without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/lspci_vv_initial.txt   2013-03-07 22:27:30.000000000 +0100
+++ without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/lspci_vv_unloading_USB3_card.txt       2013-03-07 22:40:25.000000000 +0100
@@ -287,7 +287,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
#

Shouldn't the MAbort been cleared sometimes? Doesn't this fool the PresDet interpretation in kernel?

The eSATA behaves differently maybe because 0100 does not change to 0140 like USB3 card but to 0103?
Um, the shell while loop calling setpci does not report 0103 but the driver say this:

[  211.879397] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)


I did not check myself whether the lspci differs between the odd and even unplug of USB3 card
or not, but from the win7 behavior it should be the still same under Linux like it
always was.

I do not remember with 3.2.x and 3.7x kernels seeing this with the USB3 card:
+[  594.622211] pci 0000:11:00.0: calling quirk_usb_early_handoff+0x0/0x657
+[  594.622223] pci 0000:11:00.0: device not available (can't reserve [mem 0x00000000-0x00001fff 64bit])
+[  594.622225] pci 0000:11:00.0: Can't enable PCI device, BIOS handoff failed.
But somebody better check the previous tarball. ;-) Ah, well, with 3.7 I used acpiphp,
hmm, and how was it with 3.2.x I for sure forgot. ;)


I do not know what else to disable in BIOS except eSATA port to make the SandyBridge chip doing
better. Actually, I might have also tried to disable ExpressCard to see what it really does.
;)


4)
A new 3.9-rc1 bug is that sometimes, while switching a virtual console I get
(file without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/dmesg_VT12_switching_while_reading_slot_status_caused_slowpath.txt):
[  458.113692] WARNING: at drivers/tty/tty_buffer.c:428 flush_to_ldisc+0x55/0x189()
[  458.113693] Hardware name: Vostro 3550
[  458.113693] tty is NULL
Will try to find a proper maintainer for that.


5)
I believe I reported already in the past that repeatedly inserting and removing the FireWireOHCI
card can crash the kernel, completely. That is nothing new since 3.2 at least and although I captured
a partial stacktrace I won't anymore. There are several OOPSes after each other in a row.

Well, thank you for your time. I would have already returned the whole laptop
but I don't know what other piece of HW to buy. I need eSATA, at least 2x USB3.0 ports (4 USB ports
in total), expressCard for extra 2 eSATA ports or Firewire, anti-reflex display, HDMI or DVI at least.
Keyboard with a back-light is a plus. ;-) 8GB RAM is a minimum, currently have 16GB in this thingie.
;)

Martin
