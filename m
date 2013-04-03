Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <515C1DB8.5020905@fold.natur.cuni.cz>
Date: Wed, 03 Apr 2013 14:16:56 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <51548C9E.9090703@fold.natur.cuni.cz> <2990024.LMTIBUbM3d@vostro.rjw.lan> <51564804.9000700@fold.natur.cuni.cz> <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com> <515AF312.1010507@fold.natur.cuni.cz> <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com> <515B17D9.6030805@fold.natur.cuni.cz> <515B45A6.1020404@fold.natur.cuni.cz>
In-Reply-To: <515B45A6.1020404@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Meanwhile, the raw data: http://195.113.57.32/~mmokrejs/tmp/20130402.tar.bz2
(size 468641 bytes)

They were collected by:

# cat ~/bin/collect_runtime_status.sh 
#!/bin/sh
grep . /sys/bus/pci/devices/*/power/runtime_status > runtime_status_"$1".txt
grep . /sys/bus/pci/devices/*/power/control > control_"$1".txt
cat /proc/interrupts > interrupts_"$1".txt
cat /proc/iomem > iomem_"$1".txt
lspci -vvv > lspci_vvv_"$1".txt
dmesg > dmesg_"$1".txt
#

Just do 'ls -latr' to see the ordering of the files as they were created.
The longer the filename, the later in the test process. The names should be
relatively self-explaining. Definitely, from the log files you should see
what happened in real and therefore, can figure out what the (maybe weird)
long filename really meant.

Sometimes I manually recorded lsusb of dmesg_final.txt, mostly after I did some
extra tests but but not want to record every step by the above 6 files.

In one or two places I added some my own notes into COMMENTS file.




I will try to guide your below where you can study which of the bugs. Mostly,
for each bug you need just one subdirectory to look into, the other are just
repeated the same bug under different kernel version or another patch.
However, Sarah for the xHCI dead port issue will need to compare by diff
two directories, one with the TI-based controller tests, the other with the
NEC-based tests. Especially there, I would do something like:

cd *TI-based; for f in dmesg*; do cut -c 15- $f > /tmp/TI/$f; done
cd ../*NEC-based; for f in dmesg*; do cut -c 15- $f > /tmp/NEC/$f; done

Then it should be easier to poke through file captured at the same test step,
like:

diff -u -w /tmp/TI/dmesg_initial__mouse_attached__unplugged__reattached_but_port_dead.txt \
/tmp/NEC/dmesg_initial__mouse_attached__detached__reattached.txt



Other than that, just diff pairs of files with each other, like:

diff -u -w lspci_vvv_initial.txt lspci_vvv_initial__mouse_attached.txt


Sorry that I sometimes used only a single underscore instead of double underscores
to separate the test steps from each other in the filename.


Martin Mokrejs wrote:
> [ +linux-pci and Yinghai as they suffered already those many emails on individual
>  threads so one overviewing email hopefully won't harm] ;-)
> 
> Martin Mokrejs wrote:
>>
>>
>> Bjorn Helgaas wrote:
>>> On Tue, Apr 2, 2013 at 9:02 AM, Martin Mokrejs
>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>> Hi Ying,
>>>>
>>>> huang ying wrote:
>>>
>>>>> And please give me the full dmesg for boot and incremental dmesg for
>>>>> operations.
>>>>
>>>>
>>>> The incremental bits here, the full dmesg will send only directly to your email, due to its size.
>>>
>>> Is there a bugzilla for this issue?  Please attach the complete dmesg
>>> there or somewhere similar so we can all benefit.
>>
>> I changed my mind. I am attaching the dmesg here but omitting linux-acpi
>> list. After I hear a proposal from Rafel/Bjorn I will open separate bugs.
>> I thought that the threads I started so far were enough but yes, dmesg
>> files don't pass through list filters so I should move that to bugzilla.
>>
>> so far my view of the the bugs was:
>>
>> 1) acpiphp hotplug broken due to upstream pcieport 1c.7 PME# enabled
>>   (eSATA-based card)
> 
> Fixed by Ying Huang port_dbg.patch applied over 3.8.5 (fixes acpiphp hotplug
> of eSATA and Firewire cards, NOT the hotplug of a NEC-based USB3 card -> hence
> the bug 4) below). Now I can continue using laptop-mode-tools.

20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_eSATA_testing
20130402/3.8.3-vanilla__with_laptop-mode-tools (with some comments in
                                                COMMENTS file)


>> 2) xHCI dead due to to its suspend - 3.8 series and above
> 
> Not fixed by port_dbg.patch applied over 3.8.5. Interestingly, a NEC-based
> XHCI card *in an express card slot* does not suffer this suspend issue.
> Although it is being put into suspend if a device is unplugged.

20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_xHCI_test_TI-based
20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_xHCI_test_NEC-based

Same thing but yet without the port_dbg.patch:
20130402/3.9-rc5__with_2368081__with-latop-mode-tools_xhci_testing/


>> 3) pciehp completely broken since about 3.6, still 3.9-rc5
> 
> Even 3.9-rc5 with patch 2368081 and port_dbg.patch from Ying Huang this is
> still broken (the eject of a cold plugged device from an express card slot).
> That results in /proc/interrupts claiming IRQ19 is still used by the driver.
> Non-forced but manual 'rmmod sata_sil24' removes the IRQ 19 from the listing.
> The rmmod also removes association with sata_sil24 from the /proc/iomem but
> the device 11:00 is retained in the file with its memory ranges.
> lspci provides, as many times described by me, conflicting information.
> Actually, I trust more lspci than /proc/ files.

Tests with express cards SATA SiI3132 and FireWire VT6315:
20130402/3.9-rc5__with_2368081__and__ying_port-dbg__with-latop-mode-tools_eSATA_testing
20130402/3.9-rc5__with_2368081__and__ying_port-dbg__with-latop-mode-tools_FireWire_testing

A bit more testing but yet without port_dbg.patch (but contains more data for your
so look into it after the above two):
20130402/3.9-rc5__with_2368081__with-latop-mode-tools_eSATA_testing


>> There is one more which actually brought me into all of this in May2012 at about
>> 3.2.x kernels:
>>
>> 4) Even when upstream port 1c.7 is force control to 'on' hot removal of
>>    USB3 express card is broken, only every second eject is recognized.
>>    Is likely related to xhci_hcd having a special privilege to handle IRQ/PM
>>    in its own way. In contrast, Firewire and eSATA cards work under same
>>    circumstances. I see different sleep states listed as supported by those
>>    cards but my bet is that is due to the exceptional xhci_hcd privilege.
>>    I briefly repeated that already with 3.9-rc5.
> 
> Still broken even with port_dbg.patch applied over 3.8.5. Turns out the unnoticed
> ejects and inserts are actually detected, but later, with 30sec delay of so.
> Hmm, in my original thread back in 2012 I said 60sec delay but seems is likely
> still the same problem:
> 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe

20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_NEC-based_eject_testing


> Before I forget, I will sketch several more bugs I hit and are all documented
> in my postings from last week or two. I can provide the URLs to those postings
> already in archives and maybe summarize them in bugzilla, after we agree what
> will be worked on and where (email ... bugzilla), under the best matching subject
> you will propose.
> 
> 
> 5) lspci causes wake and suspend of pcieport handled devices. I fear this is
> not good. Maybe it does the same to other pci devices but the "problem" is
> that no other pci drivers report same type of message. I would like to see
> the PME# enabled/disabled generated by other drivers as well, ideally by some
> upstream, common driver.

At least in some cases, lspci -vv causes 7x these:

lspci -vvv causes 11x same message.


> 
> 
> 6) sata_sil24 sometimes initializes badly under pciehp. Provided you once fix
> the pciehp and still would like to get the init of sata_sil24 fixed as well.
> The are two wrong paths in the driver. One is:
> 
> [  899.894862] sata_sil24 0000:11:00.0: version 1.1
> [  899.894880] sata_sil24 0000:11:00.0: enabling device (0000 -> 0003)
> [  899.985994] sata_sil24 0000:11:00.0: failed to clear port RST
> [  900.086097] sata_sil24 0000:11:00.0: failed to clear port RST
> [  900.086119] sata_sil24 0000:11:00.0: enabling bus mastering

20130402/3.9-rc5__with_2368081__with-laptop-mode-tools_eSATA_testing/

> 
> while the other is:
> 
> [  974.021661] pcieport 0000:00:1c.0: PME# disabled
> [  974.041697] pcieport 0000:00:1c.7: PME# disabled
> [ 1048.450168] sata_sil24 0000:11:00.0: version 1.1
> [ 1048.463692] sata_sil24 0000:11:00.0: Refused to change power state, currently in D3
> [ 1048.563818] sata_sil24 0000:11:00.0: failed to clear port RST
> [ 1048.663935] sata_sil24 0000:11:00.0: failed to clear port RST

20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_NEC-based_eject_testing






The bugs below you will come across in multiple places in the tar.bz2 archive but
were also well described in the past email threads. It does not make sense to repeat
that all here or there. I suggest you come up with a debug patch to help with
these and then we can dive into more crafted log data.

> 
> Both lead to a broken device and I would prefer the driver to fail to load.
> It seems they are at least in part related to early device eject while the
> driver did not yet turn down an unused external SATA port.
> 
> 
> 7) It seems Rafael or Bjorn have a clue why sometimes I see only PME# disabled
> or just PME# enabled in dmesg for a particular device and I am worried when was
> it silently switched to the other state. I would like to hear this can be prevented
> in future by some cross-checks, by design.
> 
> 
> 8) I don't know whether one can ensure that a driver releases either both
> IRQ and memory ranges it has allocated, or just nothing, or an oops happens,
> whatever. Maybe something could track what the driver grabbed once and make
> sure both are released. even a background scan or /proc files would be fine.
> The disagreement with lspci is not good.
> 
> 
> 9) In the thread 
> Re: 3.8.2: stale pci device info for a previously inserted express card
> I already showed an example that chimeric entries in 'lspci -vvv' output
> can appear. Some data describe the previously loaded card in an Express
> Card Slot while the other the one currently loaded in the slot.
> This might lead to an explanation why are there those lines in lspci like:
> 
> a)
> Latency: 0
> Latency: 0, Cache Line Size: 64 bytes
> or the Latency: line missing altogether
> 
> b)
> [virtual] Expansion ROM at f6c00000 [disabled] [size=512K]
> Expansion ROM at f6c00000 [size=512K]
> 
> c)
> Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
> Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [disabled] [size=128]
> 
> 
> If kernel does not give a hint what is wrong with a device/driver then
> maybe lspci do do a runtime check and give some more useful user-oriented warning.


Martin
