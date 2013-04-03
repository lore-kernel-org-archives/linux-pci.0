Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:49549 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762611Ab3DCKfR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2013 06:35:17 -0400
Message-ID: <515C05E1.8060706@fold.natur.cuni.cz>
Date: Wed, 03 Apr 2013 12:35:13 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <51548C9E.9090703@fold.natur.cuni.cz> <2990024.LMTIBUbM3d@vostro.rjw.lan> <51564804.9000700@fold.natur.cuni.cz> <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com> <515AF312.1010507@fold.natur.cuni.cz> <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com> <515B17D9.6030805@fold.natur.cuni.cz> <515B45A6.1020404@fold.natur.cuni.cz> <20130402221652.GB3693@xanatos>
In-Reply-To: <20130402221652.GB3693@xanatos>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sarah Sharp wrote:
> On Tue, Apr 02, 2013 at 10:55:02PM +0200, Martin Mokrejs wrote:
>>> 2) xHCI dead due to to its suspend - 3.8 series and above
>>
>> Not fixed by port_dbg.patch applied over 3.8.5. Interestingly, a NEC-based
>> XHCI card *in an express card slot* does not suffer this suspend issue.
>> Although it is being put into suspend if a device is unplugged.
> 
> Wait, wait, wait.  Time out.  You have *two* xHCI host controllers?  Are
> they different vendors?  Are they exhibiting different broken behaviors?
> Please state for each host controller exactly the symptoms you are
> seeing (no dmesg or other log files yet, just one paragraph for each
> host).

The laptop has TexasInstruments controller, which suffers the problem that
once it is suspended (0b:00) it does not observe that a new device was plugged
into the socket, so the end USB device gets no power and is dead. Manual wakeup
using echo 'on' > /sys/.../*0b:00/control wakes up the upstream PCIe root port
1c.4 (at least with the patch) and the 0b:00 itself as intended by the echo
command. That enables the TI controller realize e.g. a mouse is connected to
the socket and picks it up.
What is not clear to me why the xHCI socket is not dead upon bootup with no
USB devices attached. That also yields the controller 0b:00 in suspended state
but the very first plugin of the e.g. mouse is picked up and the mouse works.
Upon unplug of the mouse something gets screwed. We thought that it is due to
the upstream port being suspended but even with the patch preventing that
(port_dbg.patch) the broken gets is entered: the 0b:00 falls asleep, its
runtime_status files says 'suspended' a the socket is dead.

You maybe remember that I started a year ago the threads with Express Card
hotplug issues with another, USB3 NEC-based controller I have. To test better
the patch from Ying Huang I also tried what happens to the NEC-based controller.
It works. I did not provide you the logs although from the debug info Ying added
it seems the code flow in a different way. I had XHCI_DEBUG enabled while no
external USB devices attached and because I tested with a USB2 device (the mouse)
the xhci_hcd did not flood the logs too much.


Martin
