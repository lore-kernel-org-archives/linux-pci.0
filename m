Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeHUULk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Aug 2018 16:11:40 -0400
Date: Tue, 21 Aug 2018 11:50:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mmyangfl@gmail.com, Ashok Raj <ashok.raj@intel.com>,
        Rajat Jain <rajatja@google.com>
Subject: Re: Enumeration issue with QCA9005 AR9462
Message-ID: <20180821165042.GC154536@bhelgaas-glaptop.roam.corp.google.com>
References: <20180820230624.GB154536@bhelgaas-glaptop.roam.corp.google.com>
 <20180821054704.jlqk5zrlbbsjsd4g@wunner.de>
 <20180821072541.tcdg5fkk4zrwxahj@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180821072541.tcdg5fkk4zrwxahj@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rajat, Ashok]

On Tue, Aug 21, 2018 at 09:25:41AM +0200, Lukas Wunner wrote:
> On Tue, Aug 21, 2018 at 07:47:04AM +0200, Lukas Wunner wrote:
> > On Mon, Aug 20, 2018 at 06:06:24PM -0500, Bjorn Helgaas wrote:
> > > mmyangfl@gmail.com reported a problem [1]: on v4.17, a QCA9005 AR9462
> > > wifi device was present at boot, but disappeared after suspend/resume.
> > > 
> > > He also tested a recent kernel (5c60a7389d79, from Thu Aug 16),
> > > where the suspend/resume problem doesn't seem to happen, but the wifi
> > > device isn't enumerated correctly at boot-time.
> > > 
> > > [    0.928714] pciehp 0000:04:00.0:pcie204: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> > > [    0.928752] pciehp 0000:04:00.0:pcie204: Slot(0-1): Card not present
> > > [    0.928811] pciehp 0000:04:00.0:pcie204: Slot(0-1): Link Up
> > > [    0.928815] pciehp 0000:04:00.0:pcie204: Slot(0-1): No adapter
> > > 
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=200839
> > > [2] https://bugzilla.kernel.org/attachment.cgi?id=277923
> > 
> > The hardware appears to be broken in that the Presence Detect State bit
> > in the Slot Status register is 0 (Slot Empty) even though the slot is
> > occupied.
> [...]
> > Possible solutions:
> > 
> > (a) Be lenient towards broken hardware and accept DLActive+ as a proxy
> >     for PresDet+.
> > 
> > (b) Add a blacklist to pciehp such that it doesn't bind to [1ae9:0200].
> >     The bug reporter writes that "it's a single Half Mini PCIe card,
> >     with two chipsets (Wil6110? + AR9462) combined by a PCIe hub".
> >     This sounds like it's not really hotpluggable.
> >     (Is Mini PCIe hotplug capable at all?)
> > 
> > Let me go through the driver and see if (a) is feasible and how intrusive
> > it would be.
> 
> So (a) would seem to be feasible, we could add a quirk for devices like
> this to call pciehp_check_link_active() in pciehp_get_adapter_status().
> 
> Alternatively, we could generally add a call to pciehp_check_link_active()
> in get_adapter_status(), pciehp_check_presence() and pcie_init() and thus
> avoid a quirk for this specific device.
> The existing call in __pciehp_enable_slot() could actually be removed,
> this code path is only entered if either PDS or DLLLA is set.
> 
> And the third option would be to add a quirk like quirk_hotplug_bridge()
> which sets is_hotplug_bridge = 0 on this broken device such that pciehp
> doesn't bind to it in the first place.

It sounds like with (a), you could make this work without having a
Wil6110-specific quirk, i.e., if the Link Status says the link is
active, we assume a device is present.  That seems reasonable to me
and it sort of fits with these previous changes:

  385895fef6b5 ("PCI: pciehp: Prioritize data-link event over presence detect")
  e48f1b67f668 ("PCI: pciehp: Use link change notifications for hot-plug and removal")

Bjorn
