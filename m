Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:51382 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752591Ab3CFKax (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 05:30:53 -0500
Message-ID: <51371AD9.4040801@fold.natur.cuni.cz>
Date: Wed, 06 Mar 2013 11:30:49 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
References: <50EDF8FE.6040607@fold.natur.cuni.cz> <CAErSpo6etF7_fZH9nNoAhtRXdGEmBrNE7v84TRkoawyG9s4AGw@mail.gmail.com>
In-Reply-To: <CAErSpo6etF7_fZH9nNoAhtRXdGEmBrNE7v84TRkoawyG9s4AGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
  thank you for your time on this issue.

Bjorn Helgaas wrote:
> On Wed, Jan 9, 2013 at 4:10 PM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>> Hi,
>>   I am following up on a former thread
>> Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
>> about the same issue. I think I found some new info while playing with 3.7.1 kernel.
>> It happened to me that my hotplug of express cards stopped working so it made me to
>> to dive in a figure out what driver did I do to my .config, and what combinations
>> of drivers and kernel command-line parameters work and which not. This email will
>> cover just one case.
>>
>> On this Dell Vostro 3550 express card slot works if kernel is without pciehp
>> altogether and pci_hotplug+acpiphp are loaded as modules later on. The problem
>> is that I must use pcie_aspm=off.
> 
> I confess I am completely bewildered here.  Something is clearly badly
> broken, but I'm having a hard time figuring out exactly what it is.  I
> think I'm overwhelmed by all the data :)
> 
>>From your previous "3.2.11: PCI Express card cannot be re-detected
> withing cca 60sec timeframe" thread, I think:
> 
> 1) With pciehp, insertion and removal of an NEC uPD720200 USB3.0 card
> doesn't work correctly [1].  The insertion/removal events don't seem
> to be detected immediately.

... except for the FireWire, serial/parallel and eSATA port-providing cards in 2) and 3).
The one doing SATA is based on Silicon Image3132 chip, using sata_sil24
driver.

> 2) Insertion/removal of firewire card works correctly [2]

Yes.

> 3) Insertion/removal of AXAGO ECA-SP serial/parallel card works correctly [3]

Yes.

> 4) When the xhci driver is not loaded, insertion/removal events of the
> NEC USB3.0 card *are* detected correctly [4]

And my suspicion was that when a USB device is attached to the
ExpressCard USB3.0 controller the "usb-storage?" or whichever driver"
realizes much earlier (in time) that the ExpressCard is gone and system thus
behaves properly. I think something is delayed by xhci driver until a poll
happens after every 60 seconds. With usb-storage the change gets visible
"immediately". Or, the card is not PCI or PCIe hotplug capable [6]?
Could that be the difference in behior?


> 
> The ExpressCard slot is below the 00:1c.7 root port, and this port
> supports native PCIe hotplug.  When CONFIG_HOTPLUG_PCI_PCIE=y, Linux
> requests control over PCIe native hotplug, and I think your BIOS
> grants it.
> 
> In this thread ("Dell Vostro 3550: pci_hotplug+acpiphp require
> 'pcie_aspm=force' on kernel command-line for hotplug to work"), I
> think you are saying that if you disable pciehp and use acpiphp and
> the "pcie_aspm=off" parameter, the ExpressCard slot works perfectly.
> 
> But I think it's a bad idea to go down the road of using acpiphp.

Unfortunately I was forced to switch to acpiphp because commit
0d52f54e2ef64c189dedc332e680b2eb4a34590a (as diagnosed by Yinghai)
becuase pciehp stopped working (although it worked badly anyways).
The commit went in about 3.5 kernel. For me, practially I had to switch
from "pcie_aspm=force" (kernels 3.2 - 3.4) to "pcie_aspm=off" (3.7 for sure).
See the note Yijing in [5].

> Native PCIe hotplug (pciehp) is the default when it is supported, and
> as far as I can tell, it *is* supported on this system.  If we had
> some indication that it's not supported, e.g., if the BIOS declined to
> grant us control over PCIe native hotplug, then of course we would
> fall back to using acpiphp.  But I don't think we do, so we should
> figure out how to make pciehp work.

I do not understand the diffs between PCI hotplug, PCIe hotplug and their
requriements by pciehp versus acpiphp so do not want to comment on that.
I just linked to Yijing's comments in other threads [5, 6] and judge
what is more generic option.

Yighai in the 3.2.x thread postulated it is a BIOS or silicon bug
incorrectly providing PresDet status. I was glad that I can show
that with acpiphp the PresDet is *always* correct (3.7. kernel)
*provided* I disabled MediaCard reader in BIOS.


So although I do not believe into a hardware bug in case of PresDet reporting
I smell there is one in cross-interaction between ExpressCard slot,
EHCI port and MediaCard reader (via EHCI as well), all hooked up to SandyBridge
C6/C200 intel chip. What I saw is that the MediaCard reader gets detected when
an Expresscard is plugged into its slot (that is, much later after a bootup, and
triggered only by express card insertion). I speculate further that the EHCI port
sometimes resets again just due to some ExpressCard interference. I reported such
problems in the past on usb mailing list we could not make any conclusion
out of it except that my external USB hub might be bad. Buying a new
one did not help. Instead, I disabled the MediaCard reader in BIOS.
Note: My motherboard was already exchanged and also the ExpressCard metalic
slot thing.

> 
> If it's really true that pciehp works perfectly except when xhci is
> loaded, that seems like a good clue, and we should look for some
> interaction between xhci and pciehp.

And also, why is presence of Firewire, RS232/LPT and sata_sil24 cards is
reported correctly by pciehp while not NEC-based USB3 card.

The (mis)behavior with the USB3 card was that it's removal was not notified.
On subsequent re-insertion of the card the software status bits were
wrong and pciehp reported Surprise removal. The bits were not adjusted
properly (I am intentionally not saying they should have been reset).
If I again unplugged the card, the PresDet correctly reported the card
was just removed. In other words, every second (even) removal of a card resulted
in correct slot status values reported. On every odd removal, the status
reported by pciehp was wrong.

> 
> Martin, can you confirm my assumptions above or correct any mistakes I made?

Several questions I had were never answered.

Why is the IRQ40 not reported in pciehp (see the original message in thsi thread).
Because it is really not used, compared to pciehp?

Is acpiphp capable reporting Surprise removal like pciehp does or is acpiphp silent
just because it does not print a similar message?

sata_sil24 should not be allowed to bind to newly hotplugged controller
too quickly because sometimes the card slips out immediately. A delay of 6 seconds
would be helpful to prevent eventual Oops, as shown in kernel timings in this email
thread (nicely colored at https://patchwork.kernel.org/patch/1957681/, btw).

Could the CorrErr+ device status bits prevent PresDet change from PresDet+ to PresDet-?

Once I saw the "Changed: MRL. PresDet. LinkState." line in lspci output under SltSta:
reports badly PresDet difference while SltSta: Status: line itself reports correct current
value. How is this value determined?

In the original email in this thread I showed down below from
"And showing, that acpiphp works here while 'pcie_aspm=off':" lien that acpiphp
also reports badly PresDet when the MediaCardReader is enabled in BIOS. I think
acpiphp driver should complain if there are conflicting values. For example, is it
meaningful to see in lspci output the following: "Changed: MRL- PresDet- LinkState+"?
>From "SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-" we know
the card is in the slot so why is the "Changed: line summary wrong?
Why does kernel claim the card has a virtual ROM after hotplug while coldplugged
card reports "Expansion ROM at f6c00000 [disabled] [size=512K]"? Why the differences
in cache line sizes, etc? Simply, why do not both scenarios lead to exactly same card
configuration?



> 
> Bjorn
> 
> 
> [1] http://marc.info/?l=linux-pci&m=133236584826563&w=1
> [2] http://marc.info/?l=linux-pci&m=133457374507707&w=1
> [3] http://marc.info/?l=linux-pci&m=133460527222076&w=1
> [4] http://marc.info/?l=linux-kernel&m=133547823904339&w=1
> 

[5] http://marc.info/?l=linux-kernel&m=135928915003566&w=4
[6] http://marc.info/?l=linux-kernel&m=135937601131152&w=4



I hope I made things a bit clearer.
Martin
