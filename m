Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:56533 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753317Ab3CKBBM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Mar 2013 21:01:12 -0400
Message-ID: <513D2CD3.5000309@fold.natur.cuni.cz>
Date: Mon, 11 Mar 2013 02:01:07 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
References: <50EDF8FE.6040607@fold.natur.cuni.cz> <CAErSpo6etF7_fZH9nNoAhtRXdGEmBrNE7v84TRkoawyG9s4AGw@mail.gmail.com> <51371AD9.4040801@fold.natur.cuni.cz> <CAErSpo5wmM8+Qd4FH0WeNS_DJEk2Tmmivk-FgEbD-UbTMQf+ZQ@mail.gmail.com> <51394317.20104@fold.natur.cuni.cz> <CAErSpo7wsduVN1Q6k_D7r24AhpVcARZRXtv6FvSfMMjFNJMcRA@mail.gmail.com>
In-Reply-To: <CAErSpo7wsduVN1Q6k_D7r24AhpVcARZRXtv6FvSfMMjFNJMcRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas wrote:
> On Thu, Mar 7, 2013 at 6:47 PM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>> Bjorn Helgaas wrote:
>>> On Wed, Mar 6, 2013 at 3:30 AM, Martin Mokrejs
>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>> Bjorn Helgaas wrote:
>>>>> On Wed, Jan 9, 2013 at 4:10 PM, Martin Mokrejs
>>>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>>>>   I am following up on a former thread
>>>>>> Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
>>>>>> about the same issue. I think I found some new info while playing with 3.7.1 kernel.
>>>>>> It happened to me that my hotplug of express cards stopped working so it made me to
>>>>>> to dive in a figure out what driver did I do to my .config, and what combinations
>>>>>> of drivers and kernel command-line parameters work and which not. This email will
>>>>>> cover just one case.
>>>>>>
>>>>>> On this Dell Vostro 3550 express card slot works if kernel is without pciehp
>>>>>> altogether and pci_hotplug+acpiphp are loaded as modules later on. The problem
>>>>>> is that I must use pcie_aspm=off.
>>>>>
>>>>> I confess I am completely bewildered here.  Something is clearly badly
>>>>> broken, but I'm having a hard time figuring out exactly what it is.  I
>>>>> think I'm overwhelmed by all the data :)
>>
>> It won't be easier now but you asked for it. ;)
> 
> Well, I didn't really ask for 500kB of logs with 150-character
> pathnames.  I am unable to process that much stuff.  I'm not
> interested in random lspci differences, virtual console bugs, or OHCI
> driver crashes at this point, so let's not muddy the waters with them.
>  I only want to figure out if pciehp can correctly detect and
> enumerate a newly inserted card, and if it can correctly clean up when
> a card is removed.  After we figure that out, we can worry about more
> complicated issues.
> 
> I *think* the bottom line of the Slot Status experiment is that the
> Presence Detect bit was reported correctly in every case, for every

I suspect you mean the shell "setpci" experiment. Please try:

s=`find . -name slot_status* | while read f; do echo -n "$f "; done`; \
 ls -latr $s | awk '{print $9}' | while read ss; do echo $ss; cat $ss; \
 done | less



and tell me why sometimes I saw 0000 -> 0140 during insert but sometimes
0100 ->  0140. For eject I always saw 0140 -> 0100. That means when repeatedly
inserting and removing a card, on the very first insert pciehp starts with 0000
and after first eject of the card it enters into the 0100 state and since that
it should always flips between expected values: 0100->0140->0100->0140 and so
on. I think am I still not correct here because I observed in the past that 
only on every second insert "kernel" recognized the card. I bet something
else comes into play otherwise I should have realized that only very first
card removal is unnoticed, not every odd removal.
However, the collected data confirms 0000->0140->0100->0140->0100->0140:

Please see ./without_USB_no_ACPIPHP_with_PCIEHP_without_microphone_USB_wakeup_USB_emulation_USB_powershare/USB3_eSATA_FireWire/slot_status_inserting_and_removing_USB3_eSATA_FireWire.txt

Although you don't seem to like the long dirnames/filenames the find command
output should make you immediately aware what was collected under what 
BIOS and kernel settings.


> card, regardless of BIOS settings.  Right?

No. The SltSta Status: and Changed: lines do not agree with each other whether
MediaCardReader is enabled or disabled in BIOS.



# without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3
# diff -u -w lspci_vv_initial.txt lspci_vv_inserting_USB3_card_attempt_2.txt
--- lspci_vv_initial.txt        2013-03-07 22:27:30.000000000 +0100
+++ lspci_vv_inserting_USB3_card_attempt_2.txt  2013-03-07 22:38:05.000000000 +0100
@@ -301,12 +301,12 @@
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
[cut]


# cd without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/enabled_MediaCard_reader/USB3
# diff -u -w lspci_vv_initial.txt lspci_vv_inserting_USB3_card.txt
--- lspci_vv_initial.txt        2013-03-07 23:19:21.000000000 +0100
+++ lspci_vv_inserting_USB3_card.txt    2013-03-07 23:21:01.000000000 +0100
@@ -297,17 +297,17 @@
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
-               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <16us
+               LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
-               LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
+               LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
-               LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
+               LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
                        Slot #7, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
-               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
-                       Changed: MRL- PresDet- LinkState-
+               SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
[cut]


> 
> There are three cards on the table now:
> 
>   pci 0000:11:00.0: [1095:3132] SiI 3132 Serial ATA Raid II Controller
>   pci 0000:11:00.0: [1106:3403] VT6315 Series Firewire Controller
>   pci 0000:11:00.0: [1033:0194] NEC Corporation uPD720200 USB 3.0 Host
> Controller
> 
> I assume all the cards work fine if there's no hotplug, i.e., if the
> card is present at boot and you never remove it.  Right?

Yes with 3.7 and earlier. I did not test any of them under the required
3.9-rc1 with attached devices. And, I thought you ;-) will tell me that
from reading 
./without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/dmesg_inserting_USB3_card_attempt_2.txt
it looks that card won't work: ;-)

[  755.519874] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
[  755.519877] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
[  755.519881] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
[  755.519950] pciehp 0000:00:1c.7:pcie04: Surprise Removal
[  755.523258] pciehp 0000:00:1c.7:pcie04: check_link_active: lnk_status = 7011
[  755.631276] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7011
[  755.631380] pci 0000:11:00.0: [1033:0194] type 00 class 0x0c0330
[  755.631435] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x00001fff 64bit]
[  755.631700] pci 0000:11:00.0: PME# supported from D0 D3hot
[  755.631711] pci 0000:11:00.0: PME# disabled
[  755.631763] pci 0000:11:00.0: calling quirk_usb_early_handoff+0x0/0x657
[  755.631776] pci 0000:11:00.0: device not available (can't reserve [mem 0x00000000-0x00001fff 64bit])
[  755.631777] pci 0000:11:00.0: Can't enable PCI device, BIOS handoff failed.
[  755.651366] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c00000-0xf6c01fff 64bit]
[  755.651391] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c00000-0xf6c01fff 64bit] (PCI address [0xf6c00000-0xf6c01fff])
[  755.651398] pcieport 0000:00:1c.7: PCI bridge to [bus 11-16]
[  755.651401] pcieport 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
[  755.651408] pcieport 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
[  755.651413] pcieport 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]



> 
>> In Linux pciehp
>> still complains about Surprise Removal even when I insert the card for the very
>> first time after a coldboot
> 
> Hmm.  pciehp prints "Surprise Removal" whether you inserted or removed
> the card.  Stupid driver.

Still you don't say if acpiphp driver is ever able to print something like that
to tell the user that a surprise event happened. Until that I will never be sure
if acpipho just did not report the issue or whether there is really no PresDet
bug with acpiphp. From my experience the latter is true but still would like to
hear that acpiphp is able to print a warning like pciehp. ;-)

The thing that pciehp always prints the message might mean that it always interprets
some info from the chip in a wrong way? Unless the driver just prints is capabilities
during its loading ...

Finally, both acpiphp and pciehp should be able to print same type of warnings
to the user.

> 
>> (so the ExpressCard slot is not completely dead but
>> neither sata_sil24 nor fw_ohci picks up the device).
> 
> I thought the only card with a problem was the USB3.0 card.  But here
> you suggest that there *is* a problem with the SATA and Firewire
> cards.  Can you describe that problem in one sentence?

One sentence? No. ;-)

None of the cards works when 'nousb' and while are disabled USB
devices in BIOS (which can be altered at all, don't know whether that really
disables all USB in BIOS or not, hence I used the 'nousb' to be sure).

The below appears to me like a USDB3 card not detected at PCI level. I would
undersdtand ehci-pci could not pickup the device due to 'nousb' but 
[  155.846929] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
[  155.846933] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
[  155.846936] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
[  155.847403] pciehp 0000:00:1c.7:pcie04: Surprise Removal
[  155.853089] pciehp 0000:00:1c.7:pcie04: check_link_active: lnk_status = 3011
[  157.459550] pci 0000:11:00.0 id reading try 50 times with interval 20 ms to get ffffffff
[  157.459573] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 3011
[  157.459580] pciehp 0000:00:1c.7:pcie04: Failed to check link status
Same for eSATA card:
[  125.568940] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
[  125.568942] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
[  125.568946] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
[  125.569213] pciehp 0000:00:1c.7:pcie04: Surprise Removal
[  125.573782] pciehp 0000:00:1c.7:pcie04: check_link_active: lnk_status = 3011
[  127.181635] pci 0000:11:00.0 id reading try 50 times with interval 20 ms to get ffffffff
[  127.181659] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 3011
[  127.181668] pciehp 0000:00:1c.7:pcie04: Failed to check link status
Same for Firewire card:
[  211.755452] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
[  211.755455] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
[  211.755458] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
[  211.755656] pciehp 0000:00:1c.7:pcie04: Surprise Removal
[  211.758989] pciehp 0000:00:1c.7:pcie04: check_link_active: lnk_status = 3011
[  213.368708] pci 0000:11:00.0 id reading try 50 times with interval 20 ms to get ffffffff
[  213.368730] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 3011
[  213.368737] pciehp 0000:00:1c.7:pcie04: Failed to check link status
[  218.439730] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
[  218.439733] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
[  218.439737] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
[  218.439877] pciehp 0000:00:1c.7:pcie04: Surprise Removal
[  218.442988] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
[  218.442990] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00



There are more problem with the eSATA and FireWire Cards:

eSATA inserts and removals fool likely sata_sil24 driver so that the system
cannot shutdown. It locks up during shutdown when it should have unmounted all
non-root devices and is doing: "Remounting / readonly". USB HUB leds are turned
off at that time, no local keyboard was working anymore either, no sysrq, short
PWR button press gave on console: "Disabling IRQ #16. I had to hold PWR button
for 5s to turn off completely. Provided there was no disk attached ever to the
eSATA card I wonder what was so difficult for the driver. ;-)

Firewire card is completely undetected when MediacardReader is enabled in BIOS.






> 
>> My question is. Has the laptop hardwired the ExpressCard slot somehow through USB
>> to the SandyBridge chip?
> 
> An ExpressCard slot (spec at [1]) supports both a PCIe interface and a
> USB interface, so the slot *should* be connected to a USB controller
> as well as to a PCIe root port.  An ExpressCard can contain either a
> PCIe device or a USB device or both.  Section 6.3 of the spec talks
> about ACPI requirements to describe the relationship between the PCIe
> and USB devices.  I'm not sure that Linux pays any attention to this
> in the hotplug paths, so I'm a little worried about this.  (Maybe it
> doesn't need to in the PCIe-aware case; I don't know.)


They don't work if I disable as much USB stuff in BIOS as possible and disable
USB in kernel via 'nousb'.

BTW I used to have for a few days an RS232/LPT express card
but that one was labeled on a package as using a USB bus and it really used
some USB driver. I returned the crap as it just eate up my express card slot.
There is plenty of USB dongles providing serial/parallel port and those can eat up
just a port in an external USB hub and leave with an unoccupied express card slot.
I find it silly to fill up an express card slot (the only one in a laptop) with
such a card. Back to the devices "on the table", I don't see the sata_sil24 nor the
firewire card use any usb driver ehci/xhci and the vendor did not tell me they will
be slow due to the usb overhead. I therefore conclude the SATA and FW cards are just
PCIe capable.

So could a bad/misconfigured USB remnant in the USB3eSATA/FW card
cause an EHCI bus reset, trigerring that a MediaCardReader is detected
by Linux? Note that I am not saying re-detected. MediaCardReader really
did not appear in lsusb nor dmesg until the USB3 card was inserted into
the slot.


> 
> It would be interesting to know exactly what devices are on your
> cards.  Assuming they all work when present at boot, you could find
> that by doing a single "lspci -vv" and "lsusb -v" after a boot with an
> empty slot, and doing it again after a boot with a card in the slot.

I will try this later. Now, I can conclude that somehow, PCI Express Port
disappears from lspci when I disable in BIOS all USB stuff which can be
tweaked. Importantly, I left enabled expresscard slot support. To ensure
you I did not mess up, please do realize that in lspci you can see the
SATA Sil 3132 card being loaded in the express slot as 11:00.0. The slot
works! but why Expres Port 00:1c.4 is gone is you task now. ;-) The BIOS
tweaks disabled the internal TexasInstruments USB3 controller, so do not
worry about 0b:00.0 being gone. Please execute:
diff -u -w without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/enabled_MediaCard_reader/eSATA/lspci_vv_inserting_eSATA_card.txt without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader_and_OpticalDevice_and_Camera_and_external_USB_Ports_but_enabled_expresscard_microphone_eSATA/eSATA/lspci_vv_inserting_eSATA_card.txt 




Further, regarding the USB3 card from NEC I wonder why there is:

# s=`find . -name lspci* | while read f; do echo -n "$f "; done`; ls -latr $s | awk '{print $9}' | while read ss; do echo $ss; cat $ss; done | grep 'IRQ 0'
        Interrupt: pin A routed to IRQ 0
        Interrupt: pin A routed to IRQ 0
        Interrupt: pin A routed to IRQ 0
        Interrupt: pin A routed to IRQ 0
        Interrupt: pin A routed to IRQ 0
        Interrupt: pin A routed to IRQ 0
        Interrupt: pin A routed to IRQ 0
#

If you inspect the affected lspci filenames ;-) you can see that this
was the second and third insert of the USB3 card into its slot (so not
the very first during which it acquired IRQ 16) while MediaCardReader was
disabled in BIOS. I do not see the IRQ 0 issue with eSATA nor Firewire cards
under same BIOS setup.

But, when *MediaCardReader was enabled in BIOS* I got IRQ 0 upon the very first
insert of the USB3 card as well. Still, does not happen with eSATA. The Firewire
card appears dead under this BIOS/kernel setup.


> The difference should be the ExpressCard devices.  I'm sure this is
> buried in your tarball somewhere, but all I want is the info from a
> machine in default configuration -- MediaCard enabled, etc.  Just the
> way a typical user would be using the machine.

Well, I spotted the issues in my reply above. Quite a lot more when
the MediacardReader is enabled.

> 
> [1] http://www.usb.org/developers/expresscard/EC_specifications/ExpressCard_2_0_FINAL.pdf
> 
>> The hotplug issue itself. I do not understand the PCI(e) hotplug, lspci output but
>> why is there any difference between a cold booted status of an empty expresscard slot
>> compared to the status when a card is unloaded?
> 
> In principle there shouldn't be any difference, but Linux isn't that good yet.
> 
>> --- without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/lspci_vv_initial.txt   2013-03-07 22:27:30.000000000 +0100
>> +++ without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/USB3/lspci_vv_unloading_USB3_card.txt       2013-03-07
> 
>> -       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
>> +       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>>
>> Shouldn't the MAbort been cleared sometimes? Doesn't this fool the PresDet interpretation in kernel?
> 
> I doubt it.  Presence Detect is a very simple mechanism that basically
> just reports the current state of the CPPE# signal in the ExpressCard
> slot.  There's no reason this should be related to MAbort.

Let me say it in another way. It is meaningless to have MAbort+ while the
slot is physically empty. If the slot is empty the status bits should be
cleared to some default state like on cold boot with no card inserted.

Second, while I don't understand kernel code nor PCI at all, I wouldn't be
surprised on a general basis that some driver refuses to do some action if
the slot report some error status. But I won't argue because I really do not
know what MAbort really means and how other should interpret is status.

Until the kernel is not "there" then probably there is no explanation for
these differences caused by BIOS change? Or are those just random differences?
I always did a cold boot. I can't do more I think. :(

# diff -u -w without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/eSATA/lspci_vv_inserting_eSATA_card.txt without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/enabled_MediaCard_reader/eSATA/lspci_vv_inserting_eSATA_card.txt 
--- without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/disabled_MediaCard_reader/eSATA/lspci_vv_inserting_eSATA_card.txt     2013-03-07 22:53:14.000000000 +0100
+++ without_XHCI_with_EHCI_no_ACPIPHP_with_PCIEHP/enabled_MediaCard_reader/eSATA/lspci_vv_inserting_eSATA_card.txt      2013-03-07 23:31:42.000000000 +0100
@@ -287,7 +287,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR+ <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
@@ -296,7 +296,7 @@
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
-               DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
+               DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #8, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
@@ -521,7 +521,7 @@
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
        Physical Slot: 7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
-       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f6c04000 (64-bit, non-prefetchable) [size=128]
@@ -539,17 +539,17 @@
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
-               DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
+               DevSta: CorrErr+ UncorrErr+ FatalErr+ UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
-               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
+               UESta:  DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
-               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
+               CESta:  RxErr- BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: sata_sil24



> 
>> The eSATA behaves differently maybe because 0100 does not change to 0140 like USB3 card but to 0103?
>> Um, the shell while loop calling setpci does not report 0103 but the driver say this:
>>
>> [  211.879397] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
> 
> This is completely unrelated.  The shell "setpci" command is printing
> the Slot Status register; the "0100 -> 0103" above is a change in the
> PCI Command register.

OK, I mixed up two different things, sorry.

> 
>> I do not remember with 3.2.x and 3.7x kernels seeing this with the USB3 card:
>> +[  594.622211] pci 0000:11:00.0: calling quirk_usb_early_handoff+0x0/0x657
>> +[  594.622223] pci 0000:11:00.0: device not available (can't reserve [mem 0x00000000-0x00001fff 64bit])
>> +[  594.622225] pci 0000:11:00.0: Can't enable PCI device, BIOS handoff failed.
> 
> This is a result of trying to run the quirk on a hot-inserted device
> where we haven't assigned resources to it yet.  I don't think we
> should really be running quirks on a device that early.  We can look
> at that later, if we think this is related to the immediate problem.

Unless you make me to boot again into 3.9-rc1 I will believe the USB3 card
won't work under that kernel with pciehp at all, or at least while xhci is
disabled in kernel as was your requirement. The message looks scary to me
but I don't care now either. ;)

I think you really should poke through the files and check their diffs, at
least briefly. They have timestamps and the meaning of filenames should be
clear after you realize there are for each state of the computer three files:
dmesg, lspci, slot_status. From their contents you can always learn whether
card was in the slot or not.

Martin
