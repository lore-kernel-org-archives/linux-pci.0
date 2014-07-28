Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:47722 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaG1UJp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jul 2014 16:09:45 -0400
From: <Jordan_Hargrave@Dell.com>
To: <bhelgaas@google.com>, <keith.busch@intel.com>
CC: <linux-pci@vger.kernel.org>, <wangyijing@huawei.com>,
	<jon.mason@intel.com>, <Austin_Bolen@Dell.com>
Date: Mon, 28 Jul 2014 14:59:52 -0500
Subject: RE: Debugging incorrect mps settings detected
Message-ID: <5B3AAEAF6B46EA4D955DF7AD46C2C48515F8318AA4@AUSX7MCPS303.AMER.DELL.COM>
References: <alpine.LRH.2.03.1406031308200.11244@AMR>,<CAErSpo6B76KL=PVGuuLjvC77kvxSjjYNnngXxPEjj_3dMbA0yg@mail.gmail.com>
In-Reply-To: <CAErSpo6B76KL=PVGuuLjvC77kvxSjjYNnngXxPEjj_3dMbA0yg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are still seeing issues too with the maxpayload default setting being incorrect for hotplug PCIE systems on Linux.

The default setting doesn't work if any root port is configured with MPS>128.  Adding in a hotplug device will default to MPS=128 and will cause PCIE error.
Clamping to pci_bus_safe causes the whole system to run inefficiently at MPS=128

Windows and VMWare are already using the equivalent of pcie_bus_perf and not seeing problems. 

--jordan hargrave
Dell Enterprise Linux Engineering
________________________________________
From: linux-pci-owner@vger.kernel.org [linux-pci-owner@vger.kernel.org] On Behalf Of Bjorn Helgaas [bhelgaas@google.com]
Sent: Tuesday, June 03, 2014 4:01 PM
To: Keith Busch
Cc: linux-pci@vger.kernel.org; Yijing Wang; Jon Mason
Subject: Re: Debugging incorrect mps settings detected

[+cc Yijing, Jon]

On Tue, Jun 3, 2014 at 2:04 PM, Keith Busch <keith.busch@intel.com> wrote:
> Hello,
>
> Hot adding a pci device results in improper MPS settings detected,
> reading 128 even though the upstream port is 256. This causes a warning
> print to be logged suggesting I should report a bug. :)
>
> Here's the dmesg of the hot plug event:
>
> [ 2105.051941] pciehp 0000:05:07.0:pcie24: Card present on Slot(27)
> [ 2107.012811] pci 0000:09:00.0: [8086:0953] type 00 class 0x010802
> [ 2107.012838] pci 0000:09:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> [ 2107.012873] pci 0000:09:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [ 2107.014986] pcieport 0000:05:07.0: bridge window [io  0x1000-0x0fff] to
> [bus 09] add_size 1000
> [ 2107.014996] pcieport 0000:05:07.0: res[13]=[io  0x1000-0x0fff]
> get_res_add_size add_size 1000
> [ 2107.015001] pcieport 0000:05:07.0: BAR 13: can't assign io (size 0x1000)
> [ 2107.015006] pcieport 0000:05:07.0: BAR 13: can't assign io (size 0x1000)
> [ 2107.015013] pci 0000:09:00.0: BAR 6: assigned [mem 0xd5200000-0xd520ffff
> pref]
> [ 2107.015018] pci 0000:09:00.0: BAR 0: assigned [mem 0xdb600000-0xdb603fff
> 64bit]
> [ 2107.015030] pcieport 0000:05:07.0: PCI bridge to [bus 09]
> [ 2107.015037] pcieport 0000:05:07.0:   bridge window [mem
> 0xdb600000-0xdb7fffff]
> [ 2107.015042] pcieport 0000:05:07.0:   bridge window [mem
> 0xd5200000-0xd52fffff 64bit pref]
> [ 2107.015060] pci 0000:09:00.0: Max Payload Size 128, but upstream
> 0000:05:07.0 set to 256; if necessary, use "pci=pcie_bus_safe" and report a
> bug
> [ 2107.015079] pci 0000:09:00.0: no hotplug settings from platform
>
> The commit message that added the warning indicates it may be a BIOS
> issue that incorrectly configures this, but BIOS isn't involved with
> setting the MPS on a device hot add, am I right? Or is that wrong?

The BIOS is not involved in setting MPS on a device hot-add.

> This is a Dell R620 server, if that matters, though we see this on other
> platforms as well.
>
> Using pci=pcie_bus_perf works around the issue, but that seems a bit
> odd to suggest to users. Is setting MPS on hot-add something the PCI
> driver layer ought to be doing, or should I be looking into the platform
> BIOS instead?

The PCI core should be doing something intelligent here.  If we can't
configure MPS safely, we should prevent the device from being enabled.
 But this is stuff the PCI core doesn't implement yet.

It's hard to reconfigure MPS after boot because it affects other
devices in the system, and I don't think we can always change the
settings of other devices while they're active.

I'm not sure that warning is correct.  It seems like it should suggest
pcie_bus_peer2peer, which is documented as guaranteeing that hot-added
devices will work.  But this is always confusing to me, and I could be
wrong about this.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
