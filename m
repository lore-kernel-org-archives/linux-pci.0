Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49167 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbaFDRp4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Jun 2014 13:45:56 -0400
Date: Wed, 4 Jun 2014 10:44:40 -0700
From: Jon Mason <jon.mason@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: Debugging incorrect mps settings detected
Message-ID: <20140604174440.GA17837@jonmason-lab>
References: <alpine.LRH.2.03.1406031308200.11244@AMR>
 <CAErSpo6B76KL=PVGuuLjvC77kvxSjjYNnngXxPEjj_3dMbA0yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6B76KL=PVGuuLjvC77kvxSjjYNnngXxPEjj_3dMbA0yg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 03, 2014 at 03:01:31PM -0600, Bjorn Helgaas wrote:
> [+cc Yijing, Jon]
> 
> On Tue, Jun 3, 2014 at 2:04 PM, Keith Busch <keith.busch@intel.com> wrote:
> > Hello,
> >
> > Hot adding a pci device results in improper MPS settings detected,
> > reading 128 even though the upstream port is 256. This causes a warning
> > print to be logged suggesting I should report a bug. :)
> >
> > Here's the dmesg of the hot plug event:
> >
> > [ 2105.051941] pciehp 0000:05:07.0:pcie24: Card present on Slot(27)
> > [ 2107.012811] pci 0000:09:00.0: [8086:0953] type 00 class 0x010802
> > [ 2107.012838] pci 0000:09:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> > [ 2107.012873] pci 0000:09:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> > [ 2107.014986] pcieport 0000:05:07.0: bridge window [io  0x1000-0x0fff] to
> > [bus 09] add_size 1000
> > [ 2107.014996] pcieport 0000:05:07.0: res[13]=[io  0x1000-0x0fff]
> > get_res_add_size add_size 1000
> > [ 2107.015001] pcieport 0000:05:07.0: BAR 13: can't assign io (size 0x1000)
> > [ 2107.015006] pcieport 0000:05:07.0: BAR 13: can't assign io (size 0x1000)
> > [ 2107.015013] pci 0000:09:00.0: BAR 6: assigned [mem 0xd5200000-0xd520ffff
> > pref]
> > [ 2107.015018] pci 0000:09:00.0: BAR 0: assigned [mem 0xdb600000-0xdb603fff
> > 64bit]
> > [ 2107.015030] pcieport 0000:05:07.0: PCI bridge to [bus 09]
> > [ 2107.015037] pcieport 0000:05:07.0:   bridge window [mem
> > 0xdb600000-0xdb7fffff]
> > [ 2107.015042] pcieport 0000:05:07.0:   bridge window [mem
> > 0xd5200000-0xd52fffff 64bit pref]
> > [ 2107.015060] pci 0000:09:00.0: Max Payload Size 128, but upstream
> > 0000:05:07.0 set to 256; if necessary, use "pci=pcie_bus_safe" and report a
> > bug
> > [ 2107.015079] pci 0000:09:00.0: no hotplug settings from platform
> >
> > The commit message that added the warning indicates it may be a BIOS
> > issue that incorrectly configures this, but BIOS isn't involved with
> > setting the MPS on a device hot add, am I right? Or is that wrong?
> 
> The BIOS is not involved in setting MPS on a device hot-add.
> 
> > This is a Dell R620 server, if that matters, though we see this on other
> > platforms as well.
> >
> > Using pci=pcie_bus_perf works around the issue, but that seems a bit
> > odd to suggest to users. Is setting MPS on hot-add something the PCI
> > driver layer ought to be doing, or should I be looking into the platform
> > BIOS instead?
> 
> The PCI core should be doing something intelligent here.  If we can't
> configure MPS safely, we should prevent the device from being enabled.
>  But this is stuff the PCI core doesn't implement yet.

The tuning of the MPS is disabled by default, which is why the warning
is there.  Now, we can attempt to tune it regardless of whether tuning
is enabled (assuming this device is the only one under the root port),
we can fail to all the hotplug, or we can enable "safe" tuning by
default.  The first option seems a bit hacky.  The second will fail
too often, since the MPSS of the hotplugged device would have to match
the MPS setting of slot/fabric.  The third seems like the best option.

> It's hard to reconfigure MPS after boot because it affects other
> devices in the system, and I don't think we can always change the
> settings of other devices while they're active.

Unless the slot is under its own root port, otherwise the MPS will
have to be floored.  This is the behavior in the "safe" tuning.

I suggest that the "safe" tuning get made the default behavior and we
let it soak for a little while to shake out any issues that there may
be.

Thanks,
Jon

> I'm not sure that warning is correct.  It seems like it should suggest
> pcie_bus_peer2peer, which is documented as guaranteeing that hot-added
> devices will work.  But this is always confusing to me, and I could be
> wrong about this.
> 
> Bjorn
