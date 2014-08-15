Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:52522 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaHOXfS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Aug 2014 19:35:18 -0400
Received: by mail-ig0-f174.google.com with SMTP id c1so3370837igq.13
        for <linux-pci@vger.kernel.org>; Fri, 15 Aug 2014 16:35:17 -0700 (PDT)
Date: Fri, 15 Aug 2014 17:35:13 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"Jan C. Nordholz" <jckn@gmx.net>,
	Rajat Jain <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC 0/4] PCI: pciehp: Fix Command Completion handling
Message-ID: <20140815233513.GA1130@google.com>
References: <CAE9FiQUbw7OUhRB+gKMxkuE9+nm9097+mwZ2z4adO8Hv_NjF1Q@mail.gmail.com>
 <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAE9FiQV8fOokkn0dkNzr0eY_Ew+RV2pg10NtFYMPV03fKpqo+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQV8fOokkn0dkNzr0eY_Ew+RV2pg10NtFYMPV03fKpqo+g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 15, 2014 at 03:05:39PM -0700, Yinghai Lu wrote:
> On Sat, Jun 14, 2014 at 2:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > Yinghai has been working on pciehp timeouts related to a hardware
> > erratum in Intel, AMD, and Nvidia hotplug controllers.  This affects
> > the way we wait for command completion on those controllers.
> >
> > I had some suggestions about how to change pciehp to make this work
> > better in general, without having to check for specific vendors.  We
> > need something that works well on hardware that conforms to the spec,
> > as well as the stuff that doesn't.
> >
> > I haven't heard anything for a while, so I wrote up these patches to
> > make my proposals concrete.  Unfortunately, I can't easily test any of
> > this, so I'm posting these for comment and possible testing if anybody
> > is ambitious.
> >
> > The Intel erratum is CF118, described here:
> > http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
> > ---
> >
> > Bjorn Helgaas (4):
> >       PCI: pciehp: Make pcie_wait_cmd() self-contained
> >       PCI: pciehp: Wait for hotplug command completion lazily
> >       PCI: pciehp: Compute timeout from hotplug command start time
> >       PCI: pciehp: Remove assumptions about which commands cause completion events
> >
> >
> >  drivers/pci/hotplug/pciehp.h     |    2 +
> >  drivers/pci/hotplug/pciehp_hpc.c |   91 +++++++++++++++++---------------------
> >  2 files changed, 42 insertions(+), 51 deletions(-)
> 
> Looks like we missed something. With last kernel I still saw the 1s
> delay per slot.
> 
> After adding more debug printout patches, I got following:
> 
> [   67.476898] calling  pcied_init+0x0/0x74 @ 1
> [   67.477114] pciehp 0000:00:02.0:pcie04: Hotplug Controller:
> [   67.477115] pciehp 0000:00:02.0:pcie04:   Seg/Bus/Dev/Func/IRQ :
> 0000:00:02.0 IRQ 58
> [   67.477117] pciehp 0000:00:02.0:pcie04:   Vendor ID            : 0x8086
> [   67.477118] pciehp 0000:00:02.0:pcie04:   Device ID            : 0x2f04
> [   67.477119] pciehp 0000:00:02.0:pcie04:   Subsystem ID         : 0x0000
> [   67.477120] pciehp 0000:00:02.0:pcie04:   Subsystem Vendor ID  : 0x8086
> [   67.477121] pciehp 0000:00:02.0:pcie04:   PCIe Cap offset      : 0x90
> [   67.477124] pciehp 0000:00:02.0:pcie04:   PCI resource [13]     :
> [io  0x5000-0x5fff]
> [   67.477125] pciehp 0000:00:02.0:pcie04:   PCI resource [14]     :
> [mem 0x98000000-0x9bffffff]
> [   67.477127] pciehp 0000:00:02.0:pcie04:   PCI resource [15]     :
> [mem 0x381800000000-0x381bffffffff 64bit pref]
> [   67.477128] pciehp 0000:00:02.0:pcie04: Slot Capabilities      : 0x00088cdb
> [   67.477129] pciehp 0000:00:02.0:pcie04:   Physical Slot Number : 1
> [   67.477130] pciehp 0000:00:02.0:pcie04:   Attention Button     : yes
> [   67.477131] pciehp 0000:00:02.0:pcie04:   Power Controller     : yes
> [   67.477132] pciehp 0000:00:02.0:pcie04:   MRL Sensor           :  no
> [   67.477132] pciehp 0000:00:02.0:pcie04:   Attention Indicator  : yes
> [   67.477133] pciehp 0000:00:02.0:pcie04:   Power Indicator      : yes
> [   67.477134] pciehp 0000:00:02.0:pcie04:   Hot-Plug Surprise    :  no
> [   67.477135] pciehp 0000:00:02.0:pcie04:   EMI Present          :  no
> [   67.477136] pciehp 0000:00:02.0:pcie04:   Command Completed    : yes
> [   67.477137] pciehp 0000:00:02.0:pcie04: Slot Status            : 0x0010
> [   67.477138] pciehp 0000:00:02.0:pcie04: Slot Control           : 0x07cb
> [   67.477140] pciehp 0000:00:02.0:pcie04: Link Active Reporting supported
> [   67.477144] pciehp 0000:00:02.0:pcie04: pcie_disable_notification:
> SLOTCTRL a8 write cmd 0
> [   67.477145] pciehp 0000:00:02.0:pcie04: Slot #1 AttnBtn+ AttnInd+
> PwrInd+ PwrCtrl+ MRL- Interlock- NoCompl- LLActRep+
> [   67.479926] pciehp 0000:00:02.0:pcie04: Registering
> domain:bus:dev=0000:01:00 sun=1
> [   67.479975] pci_bus 0000:01: dev 00, created physical slot 1
> [   67.480041] pci_hotplug: __pci_hp_register: Added slot 1 to the list
> [   69.078753] pciehp 0000:00:02.0:pcie04: Timeout on hotplug command
> 0x000007c0 (issued 1604 msec ago)
> [   69.078758] pciehp 0000:00:02.0:pcie04: pcie_enable_notification:
> SLOTCTRL a8 write cmd 1031
> [   69.078763] pciehp 0000:00:02.0:pcie04: pciehp_get_power_status:
> SLOTCTRL a8 value read 17f1
> [   69.078765] pciehp 0000:00:02.0:pcie04: service driver pciehp loaded
> 
> so there are pcie_disable_notification and pcie_enable_notification.
> 
> pcie_enable_notification will wait 1s.
> 
> wonder if we can just remove pcie_disable_notification calling from
> pciehp_hpc.c::pcie_init()  at all.

Yes, I agree.  I think it looks safe to drop the
pcie_disable_notification() call from pcie_init().

Bjorn
