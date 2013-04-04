Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1365075019.8901.9.camel@yhuang-mobile.sh.intel.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup
 notifications
From: Huang Ying <ying.huang@intel.com>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
In-Reply-To: <515C1DB8.5020905@fold.natur.cuni.cz>
References: <2282655.IicBMMa6jN@vostro.rjw.lan>
	 <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
	 <51548C9E.9090703@fold.natur.cuni.cz> <2990024.LMTIBUbM3d@vostro.rjw.lan>
	 <51564804.9000700@fold.natur.cuni.cz>
	 <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com>
	 <515AF312.1010507@fold.natur.cuni.cz>
	 <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com>
	 <515B17D9.6030805@fold.natur.cuni.cz> <515B45A6.1020404@fold.natur.cuni.cz>
	 <515C1DB8.5020905@fold.natur.cuni.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Apr 2013 19:30:19 +0800
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Martin,

On Wed, 2013-04-03 at 14:16 +0200, Martin Mokrejs wrote:
> Meanwhile, the raw data: http://195.113.57.32/~mmokrejs/tmp/20130402.tar.bz2
> (size 468641 bytes)

Thanks a lot!  Your information is very complete and clear :)

> They were collected by:
> 
> # cat ~/bin/collect_runtime_status.sh 
> #!/bin/sh
> grep . /sys/bus/pci/devices/*/power/runtime_status > runtime_status_"$1".txt
> grep . /sys/bus/pci/devices/*/power/control > control_"$1".txt
> cat /proc/interrupts > interrupts_"$1".txt
> cat /proc/iomem > iomem_"$1".txt
> lspci -vvv > lspci_vvv_"$1".txt
> dmesg > dmesg_"$1".txt
> #
> 
> Just do 'ls -latr' to see the ordering of the files as they were created.
> The longer the filename, the later in the test process. The names should be
> relatively self-explaining. Definitely, from the log files you should see
> what happened in real and therefore, can figure out what the (maybe weird)
> long filename really meant.
> 
> Sometimes I manually recorded lsusb of dmesg_final.txt, mostly after I did some
> extra tests but but not want to record every step by the above 6 files.
> 
> In one or two places I added some my own notes into COMMENTS file.
> 
> 
> 
> 
> I will try to guide your below where you can study which of the bugs. Mostly,
> for each bug you need just one subdirectory to look into, the other are just
> repeated the same bug under different kernel version or another patch.
> However, Sarah for the xHCI dead port issue will need to compare by diff
> two directories, one with the TI-based controller tests, the other with the
> NEC-based tests. Especially there, I would do something like:
> 
> cd *TI-based; for f in dmesg*; do cut -c 15- $f > /tmp/TI/$f; done
> cd ../*NEC-based; for f in dmesg*; do cut -c 15- $f > /tmp/NEC/$f; done
> 
> Then it should be easier to poke through file captured at the same test step,
> like:
> 
> diff -u -w /tmp/TI/dmesg_initial__mouse_attached__unplugged__reattached_but_port_dead.txt \
> /tmp/NEC/dmesg_initial__mouse_attached__detached__reattached.txt
> 
> 
> 
> Other than that, just diff pairs of files with each other, like:
> 
> diff -u -w lspci_vvv_initial.txt lspci_vvv_initial__mouse_attached.txt
> 
> 
> Sorry that I sometimes used only a single underscore instead of double underscores
> to separate the test steps from each other in the filename.
> 
> 
> Martin Mokrejs wrote:
> > [ +linux-pci and Yinghai as they suffered already those many emails on individual
> >  threads so one overviewing email hopefully won't harm] ;-)
> > 
> > Martin Mokrejs wrote:
> >>
> >>
> >> Bjorn Helgaas wrote:
> >>> On Tue, Apr 2, 2013 at 9:02 AM, Martin Mokrejs
> >>> <mmokrejs@fold.natur.cuni.cz> wrote:
> >>>> Hi Ying,
> >>>>
> >>>> huang ying wrote:
> >>>
> >>>>> And please give me the full dmesg for boot and incremental dmesg for
> >>>>> operations.
> >>>>
> >>>>
> >>>> The incremental bits here, the full dmesg will send only directly to your email, due to its size.
> >>>
> >>> Is there a bugzilla for this issue?  Please attach the complete dmesg
> >>> there or somewhere similar so we can all benefit.
> >>
> >> I changed my mind. I am attaching the dmesg here but omitting linux-acpi
> >> list. After I hear a proposal from Rafel/Bjorn I will open separate bugs.
> >> I thought that the threads I started so far were enough but yes, dmesg
> >> files don't pass through list filters so I should move that to bugzilla.
> >>
> >> so far my view of the the bugs was:
> >>
> >> 1) acpiphp hotplug broken due to upstream pcieport 1c.7 PME# enabled
> >>   (eSATA-based card)
> > 
> > Fixed by Ying Huang port_dbg.patch applied over 3.8.5 (fixes acpiphp hotplug
> > of eSATA and Firewire cards, NOT the hotplug of a NEC-based USB3 card -> hence
> > the bug 4) below). Now I can continue using laptop-mode-tools.
> 
> 20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_eSATA_testing
> 20130402/3.8.3-vanilla__with_laptop-mode-tools (with some comments in
>                                                 COMMENTS file)

Thanks for your testing!

> >> 2) xHCI dead due to to its suspend - 3.8 series and above
> > 
> > Not fixed by port_dbg.patch applied over 3.8.5. Interestingly, a NEC-based
> > XHCI card *in an express card slot* does not suffer this suspend issue.
> > Although it is being put into suspend if a device is unplugged.
> 
> 20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_xHCI_test_TI-based
> 20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_xHCI_test_NEC-based
> 
> Same thing but yet without the port_dbg.patch:
> 20130402/3.9-rc5__with_2368081__with-latop-mode-tools_xhci_testing/

It appears that TI xHCI dead port issue will present even if the PCIe
port will never go suspended.  So I think this bug is not related to
PCIe port runtime PM but related to USB xHCI.

Do you agree Sarah?

[snip]

Best Regards,
Huang Ying


