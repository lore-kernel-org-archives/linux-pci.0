Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48074 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679Ab3C3WJi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 30 Mar 2013 18:09:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Huang Ying <ying.huang@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
Date: Sat, 30 Mar 2013 23:17:08 +0100
Message-ID: <7002385.bZCFl3xJQg@vostro.rjw.lan>
In-Reply-To: <5156457C.9020201@fold.natur.cuni.cz>
References: <513E7E1E.80508@fold.natur.cuni.cz> <2764533.egTWJWstJg@vostro.rjw.lan> <5156457C.9020201@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, March 30, 2013 02:53:00 AM Martin Mokrejs wrote:
> Rafael J. Wysocki wrote:
> > On Saturday, March 30, 2013 02:17:38 AM Martin Mokrejs wrote:
> >> Rafael J. Wysocki wrote:
> >>> On Friday, March 29, 2013 03:11:13 PM Martin Mokrejs wrote:
> >>>> Hi Ying,
> >>>>   thank you for the patch. Here are the results.
> >>>>
> >>>> Huang Ying wrote:
> >>>>> On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
> >>>>>> Hi Ying,
> >>>>>>   would you please tell me how this report relate to this patch?
> >>>>>>
> >>>>>> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
> >>>>>>
> >>>>>>   Could you tell me why this PME was being flipped back and forth now?
> >>>>>> Actually, does that make finally some sense to you, pci/acpi devs?
> >>>
> >>> Can you please test this patch:
> >>>
> >>> https://patchwork.kernel.org/patch/2359611/
> >>>
> >>> and report back as I asked you?
> >>
> >> Sorry for the delay I just had to sort out what belongs under what thread
> >> and the patch was under the other. But I agree its testing with this
> >> particular eSATA/ExpressCardSlot/PM fits better here.
> >>
> >>
> >> The good news is that the eSATA card hotplug works almost perfectly with the patch.
> >> I cold booted as always with the card in the slot already loaded, same kernel
> >> .config and commandline options as described under this thread. But the kernel
> >> was 3.8.3! Not 3.9-rc1.
> > 
> > Good.  The goal was to fix the problem with eSATA hotplug.
> 
> I thought that was aimed at the XHCI dead port issue. ;-)
> 
> > 
> >> What is important is the fact that this patch resulted in runtime_status set to
> >> "active" instead of "auto" (3.8.3 with incidentally enabled laptop-mode-tools)
> >> or "on" (also tested on 3.8.3 once laptop-mode-tools were uninstalled). With this
> >> patch, devices did not get suspended during the tests (per /sys/*/power/runtime_status
> >> files).
> > 
> > You seem to be confusing power/runtime_status with power/control.  runtime_status
> > can never be "on", while control can never be "active".
> 
> Too late here, but yes, I likely swapped the two filename and value pairs. Thanks.
> 
> > 
> >> I haven't realized so far that the rtl8169 card at 05:00 and the TI xHCI
> >> controller at 0b:00 support D2 state.
> > 
> > Which probably doesn't matter, because that state isn't used by the kernel
> > anyway.
> > 
> >> # grep PME dmesg_final.txt 
> >> [    1.571475] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> >> [    1.571500] pci 0000:00:16.0: PME# disabled
> >> [    1.571760] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> >> [    1.571766] pci 0000:00:1a.0: PME# disabled
> >> [    1.571991] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> >> [    1.571997] pci 0000:00:1b.0: PME# disabled
> >> [    1.572200] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> >> [    1.572205] pci 0000:00:1c.0: PME# disabled
> >> [    1.572409] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> >> [    1.572414] pci 0000:00:1c.1: PME# disabled
> >> [    1.572618] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> >> [    1.572623] pci 0000:00:1c.3: PME# disabled
> >> [    1.572826] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> >> [    1.572832] pci 0000:00:1c.4: PME# disabled
> >> [    1.573042] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
> >> [    1.573047] pci 0000:00:1c.7: PME# disabled
> >> [    1.573292] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> >> [    1.573297] pci 0000:00:1d.0: PME# disabled
> >> [    1.573765] pci 0000:00:1f.2: PME# supported from D3hot
> >> [    1.573770] pci 0000:00:1f.2: PME# disabled
> >> [    1.574521] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> >> [    1.574528] pci 0000:05:00.0: PME# disabled
> >> [    1.587449] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
> >> [    1.587500] pci 0000:09:00.0: PME# disabled
> >> [    1.605568] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> >> [    1.605575] pci 0000:0b:00.0: PME# disabled
> >> [  362.712584] sata_sil24 0000:11:00.0: PME# disabled
> >> [ 1069.949732] sata_sil24 0000:11:00.0: PME# disabled
> >> [ 1083.878783] sata_sil24 0000:11:00.0: PME# disabled
> >> [ 1096.679536] sata_sil24 0000:11:00.0: PME# disabled
> >> [ 1107.503274] sata_sil24 0000:11:00.0: PME# disabled
> >> #
> > 
> > The part above is totally irrelevant.  It's just the initial configuration.
> > 
> >> Seems the sata_sil24 does not report an equivalent of, for example:
> >> [    1.605568] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> > 
> > Apparently, they don't support PME and pci_pme_active() should check
> > dev->pme_support, but it doesn't.  Still not relevant, though.
> > 
> >> The states before/after tests (did not change):
> > 
> > What tests?
> 
> Tests with express card plugged in, unloaded, but also USB devices bing plugged
> into the xHCI port to test whether it detects the change or not.
> 
> > 
> > And why would you expect them to change?
> 
> It is my impression the xHCI port can be suspended after a device is unplugged.
> I might be wrong but doing just echo "auto" > /sys/.../control does not
> cause a device suspend in a few seconds. I have to plugin a device and only
> its unplug the "new setting" kicks in. Whether am right or not, I just wanted
> to know whether any of them felt a sleep, etc. So "no change" was a good news
> for me. ;-)
> 
> > 
> >> /sys/bus/pci/devices/0000:00:00.0/power/control:on
> >> /sys/bus/pci/devices/0000:00:02.0/power/control:on
> >> /sys/bus/pci/devices/0000:00:16.0/power/control:on
> >> /sys/bus/pci/devices/0000:00:1a.0/power/control:on
> >> /sys/bus/pci/devices/0000:00:1b.0/power/control:on
> >> /sys/bus/pci/devices/0000:00:1c.0/power/control:on
> >> /sys/bus/pci/devices/0000:00:1c.1/power/control:on
> >> /sys/bus/pci/devices/0000:00:1c.3/power/control:on
> >> /sys/bus/pci/devices/0000:00:1c.4/power/control:on
> >> /sys/bus/pci/devices/0000:00:1c.7/power/control:on
> >> /sys/bus/pci/devices/0000:00:1d.0/power/control:on
> >> /sys/bus/pci/devices/0000:00:1f.0/power/control:on
> >> /sys/bus/pci/devices/0000:00:1f.2/power/control:on
> >> /sys/bus/pci/devices/0000:00:1f.3/power/control:on
> >> /sys/bus/pci/devices/0000:05:00.0/power/control:on
> >> /sys/bus/pci/devices/0000:09:00.0/power/control:on
> >> /sys/bus/pci/devices/0000:0b:00.0/power/control:on
> >> /sys/bus/pci/devices/0000:11:00.0/power/control:on
> > 
> > Sure, all of these devices are always on.  You need to write "auto" to their
> > power/control files to change that, which still doesn't mean they will be
> > runtime-suspended.
> 
> That's what I learned. ;-)
> 
> > 
> > The patch in question doesn't have any effect on those settings.
> 
> Oh it does! There are "active" values instead of "on" or "auto".

This actually isn't even possible, because "on" or "auto" are values for one
sysfs attribute, while "active" is for another.

And I really know what I'm talking about in case you had any doubts.  I know
what the patch does.  I'm not sure, though, if we're talking about the same
patch.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
