Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46641 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab2GaLC2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2012 07:02:28 -0400
From: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
To: Shlomo Pongratz <shlomopongratz@gmail.com>,
	Greg KH <greg@kroah.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>
Subject: RE: Cabled PCIE device hotplug/hot-removal
Date: Tue, 31 Jul 2012 11:02:24 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A477A44@G01JPEXMBYT03>
References: <CAHzK-V0XpkVJHgqWiWpYP1jx5DPX=voE0eymK+5FG-zhrJOwAQ@mail.gmail.com>
 <20120726170925.GA24751@kroah.com>
 <CAHzK-V0idPrHhf-YuC_HAxxxQABExW7mUUWN31f-ZpdnC8W+GA@mail.gmail.com>
In-Reply-To: <CAHzK-V0idPrHhf-YuC_HAxxxQABExW7mUUWN31f-ZpdnC8W+GA@mail.gmail.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org
> [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Shlomo Pongratz
> Sent: Sunday, July 29, 2012 9:36 PM
> To: Greg KH
> Cc: linux-pci@vger.kernel.org; linux-hotplug@vger.kernel.org
> Subject: Re: Cabled PCIE device hotplug/hot-removal
> 
> On Thu, Jul 26, 2012 at 8:09 PM, Greg KH <greg@kroah.com> wrote:
> > On Thu, Jul 26, 2012 at 08:03:09PM +0300, Shlomo Pongratz wrote:
> >> Hi,
> >>
> >> I have a  PCIe device connected with cables to a host (kernel 3.5.0-rc7+).
> >> What are the handler I need to add to a driver in order to catch cable
> >> pull-out / push-in?
> >
> > You shouldn't need anything special, aren't you already getting probe
> > and disconnect callbacks when the device is discovered and removed?
> 

Note that if the controller doesn't support "surprise removal", pciehp does
nothing (just print a message) when plugging/unplugging the device. You need
to power on the slot by "echo 1 > /sys/bus/pci/slots/XXX/power" after plugging
the device. By this, pciehp will power on the slot and driver's .prove
callback will be called. And for removal, you need to
"echo 0 > /sys/bus/pci/slots/XXX/power" before unplugging the device. By doing
this, driver's .remove callback will be called and then pciehp will power
down the slot.

If the controller supports "surprise removal" driver's .probe/.remove callbacks
are called automatically by the pciehp's event handler when plugging/unplugging
event (presence change detect event) happens.


> When the device is loaded the probe is called
> When I "echo 1" to the remove sysfs entry the remove callback is called.
> But when I power down the card no callback is called.

You need to "echo 0 > /sys/bus/pci/slots/XXX/power" to remove the device
if you are using pciehp.


> >
> >> The pcisig presentation
> >>
> "http://www.pcisig.com/developers/main/training_materials/get_document
> ?doc_id=f4ca40ec1721aa7fadd05e2903b0172c36656294"
> >> talks about PERST# detection for cabled PCIe hotplug.
> >>
> >> Does the kernel detect it?
> >>
> >> None of the pci_driver or pci_error_handlers callbacks were called
> >> when using powered down/up the device (electrically).

How did you power down/up the device (electrically)?

> >
> > Do you have the pciehp driver loaded properly when this happens?
> 
> My {dot}config includes it into the kernel, i.e.
> CONFIG_HOTPLUG_PCI_PCIE=y
> 

You can see what kind of hot-plug driver manages the slot by checking
/sys/bus/pci/slots/XXX/module symbolic link. On my system which has some
PCIe hot-plug slots, I can see the following

$ ls /sys/bus/pci/slots/* -l
/sys/bus/pci/slots/21:
total 0
-r--r--r--. 1 root root 4096 Aug  1 02:55 adapter
-r--r--r--. 1 root root 4096 Aug  1 02:55 address
-rw-r--r--. 1 root root 4096 Aug  1 02:55 attention
-r--r--r--. 1 root root 4096 Aug  1 02:55 cur_bus_speed
-r--r--r--. 1 root root 4096 Aug  1 02:55 latch
-r--r--r--. 1 root root 4096 Aug  1 02:55 max_bus_speed
lrwxrwxrwx. 1 root root    0 Aug  1 02:55 module -> ../../../../module/pciehp
-rw-r--r--. 1 root root 4096 Aug  1 02:55 power

/sys/bus/pci/slots/22:
<snip.>

And pciehp_debug option might help you. With this option, you can get the
controller infomation like below.

pciehp 0000:0d:00.0:pcie24: Hotplug Controller:
pciehp 0000:0d:00.0:pcie24:   Seg/Bus/Dev/Func/IRQ : 0000:0d:00.0 IRQ 51
pciehp 0000:0d:00.0:pcie24:   Vendor ID            : 0x111d
pciehp 0000:0d:00.0:pcie24:   Device ID            : 0x807f
pciehp 0000:0d:00.0:pcie24:   Subsystem ID         : 0x159c
pciehp 0000:0d:00.0:pcie24:   Subsystem Vendor ID  : 0x10cf
pciehp 0000:0d:00.0:pcie24:   PCIe Cap offset      : 0x40
pciehp 0000:0d:00.0:pcie24:   PCI resource [14]     : [mem 0x92a00000-0x92bfffff]
pciehp 0000:0d:00.0:pcie24:   PCI resource [15]     : [mem 0x92000000-0x921fffff 64bit pref]
pciehp 0000:0d:00.0:pcie24: Slot Capabilities      : 0x00a8005e
pciehp 0000:0d:00.0:pcie24:   Physical Slot Number : 21
pciehp 0000:0d:00.0:pcie24:   Attention Button     :  no
pciehp 0000:0d:00.0:pcie24:   Power Controller     : yes
pciehp 0000:0d:00.0:pcie24:   MRL Sensor           : yes
pciehp 0000:0d:00.0:pcie24:   Attention Indicator  : yes
pciehp 0000:0d:00.0:pcie24:   Power Indicator      : yes
pciehp 0000:0d:00.0:pcie24:   Hot-Plug Surprise    :  no
pciehp 0000:0d:00.0:pcie24:   EMI Present          :  no
pciehp 0000:0d:00.0:pcie24:   Command Completed    : yes
pciehp 0000:0d:00.0:pcie24: Slot Status            : 0x0000
pciehp 0000:0d:00.0:pcie24: Slot Control           : 0x07c0
pciehp 0000:0d:00.0:pcie24: Link Active Reporting supported

Regards,
Kenji Kaneshige

