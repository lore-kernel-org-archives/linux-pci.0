Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:33743 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbEGSLO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2015 14:11:14 -0400
Received: by qcvo8 with SMTP id o8so1580257qcv.0
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2015 11:11:13 -0700 (PDT)
Date: Thu, 7 May 2015 14:11:10 -0400
From: Jerome Glisse <j.glisse@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: William Davis <wdavis@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jerome Glisse <jglisse@redhat.com>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Terence Ripperda <TRipperda@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
Message-ID: <20150507181110.GB5966@gmail.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <20150506221818.GH24643@google.com>
 <554AC48A.2030209@huawei.com>
 <CAErSpo6xp5kM57PX9RkXKr5MM4BQM7-uXPtvCBL8=9Br8FYLdA@mail.gmail.com>
 <ec4d9f89290441a79e0caf986383c5df@HQMAIL106.nvidia.com>
 <CAErSpo7dv=q+v+zEvT8Fbt26_Xq+AVZQBjJOZX9y5o+A5kFhTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAErSpo7dv=q+v+zEvT8Fbt26_Xq+AVZQBjJOZX9y5o+A5kFhTA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 07, 2015 at 12:16:30PM -0500, Bjorn Helgaas wrote:
> On Thu, May 7, 2015 at 11:23 AM, William Davis <wdavis@nvidia.com> wrote:
> >> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> >> Sent: Thursday, May 7, 2015 8:13 AM
> >> To: Yijing Wang
> >> Cc: William Davis; Joerg Roedel; open list:INTEL IOMMU (VT-d); linux-
> >> pci@vger.kernel.org; Terence Ripperda; John Hubbard; Jerome Glisse; Dave
> >> Jiang; David S. Miller; Alex Williamson
> >> Subject: Re: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
> >>
> >> On Wed, May 6, 2015 at 8:48 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> >> > On 2015/5/7 6:18, Bjorn Helgaas wrote:
> >> >> [+cc Yijing, Dave J, Dave M, Alex]
> >> >>
> >> >> On Fri, May 01, 2015 at 01:32:12PM -0500, wdavis@nvidia.com wrote:
> >> >>> From: Will Davis <wdavis@nvidia.com>
> >> >>>
> >> >>> Hi,
> >> >>>
> >> >>> This patch series adds DMA APIs to map and unmap a struct resource
> >> >>> to and from a PCI device's IOVA domain, and implements the AMD,
> >> >>> Intel, and nommu versions of these interfaces.
> >> >>>
> >> >>> This solves a long-standing problem with the existing DMA-remapping
> >> >>> interfaces, which require that a struct page be given for the region
> >> >>> to be mapped into a device's IOVA domain. This requirement cannot
> >> >>> support peer device BAR ranges, for which no struct pages exist.
> >> >>> ...
> >>
> >> >> I think we currently assume there's no peer-to-peer traffic.
> >> >>
> >> >> I don't know whether changing that will break anything, but I'm
> >> >> concerned about these:
> >> >>
> >> >>   - PCIe MPS configuration (see pcie_bus_configure_settings()).
> >> >
> >> > I think it should be ok for PCIe MPS configuration, PCIE_BUS_PEER2PEER
> >> > force every device's MPS to 128B, what its concern is the TLP payload
> >> > size. In this series, it seems to only map a iova for device bar region.
> >>
> >> MPS configuration makes assumptions about whether there will be any peer-
> >> to-peer traffic.  If there will be none, MPS can be configured more
> >> aggressively.
> >>
> >> I don't think Linux has any way to detect whether a driver is doing peer-
> >> to-peer, and there's no way to prevent a driver from doing it.
> >> We're stuck with requiring the user to specify boot options
> >> ("pci=pcie_bus_safe", "pci=pcie_bus_perf", "pci=pcie_bus_peer2peer",
> >> etc.) that tell the PCI core what the user expects to happen.
> >>
> >> This is a terrible user experience.  The user has no way to tell what
> >> drivers are going to do.  If he specifies the wrong thing, e.g., "assume no
> >> peer-to-peer traffic," and then loads a driver that does peer-to-peer, the
> >> kernel will configure MPS aggressively and when the device does a peer-to-
> >> peer transfer, it may cause a Malformed TLP error.
> >>
> >
> > I agree that this isn't a great user experience, but just want to clarify
> > that this problem is orthogonal to this patch series, correct?
> >
> > Prior to this series, the MPS mismatch is still possible with p2p traffic,
> > but when an IOMMU is enabled p2p traffic will result in DMAR faults. The
> > aim of the series is to allow drivers to fix the latter, not the former.
> 
> Prior to this series, there wasn't any infrastructure for drivers to
> do p2p, so it was mostly reasonable to assume that there *was* no p2p
> traffic.
> 
> I think we currently default to doing nothing to MPS.  Prior to this
> series, it might have been reasonable to optimize based on a "no-p2p"
> assumption, e.g., default to pcie_bus_safe or pcie_bus_perf.  After
> this series, I'm not sure what we could do, because p2p will be much
> more likely.
> 
> It's just an issue; I don't know what the resolution is.

Can't we just have each device update its MPS at runtime. So if device A
decide to map something from device B then device A update MPS for A and
B to lowest common supported value.

Of course you need to keep track of that per device so that if a device C
comes around and want to exchange with device B and both C and B support
higher payload than A then if C reprogram B it will trigger issue for A.

I know we update other PCIE configuration parameter at runtime for GPU,
dunno if it is widely tested for other devices.

Cheers,
Jérôme
