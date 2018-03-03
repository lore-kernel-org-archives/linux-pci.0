Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41176 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935377AbeCCA7V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 19:59:21 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Don Dutile <ddutile@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: RE: [PATCH] pci-iov: Add support for unmanaged SR-IOV
Date: Sat, 3 Mar 2018 00:59:15 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1910274F6@SHSMSX101.ccr.corp.intel.com>
References: <20180227190520.3273.79728.stgit@localhost.localdomain>
        <20180227144015.228d4f5c@w520.home>
        <CAKgT0Ucq8vF9Kxx31QMG=OUwRr61vurHCPw5NCjxPhR_2JM5MQ@mail.gmail.com>
        <CAKgT0Ufq7EHCErECEbK2urHczZSpOoJKR2a5GWn5BxhZshx0vA@mail.gmail.com>
        <20180228155949.00fde8ae@w520.home>
        <CAKgT0UeVZUB7h6g=Eqppt-6VP=X4=Ko3=kB_rh_1JanFJXZF9g@mail.gmail.com>
        <20180301132224.1ca06949@w520.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D1910253B9@SHSMSX101.ccr.corp.intel.com>
 <20180302111411.47a58371@t450s.home>
In-Reply-To: <20180302111411.47a58371@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Saturday, March 3, 2018 2:14 AM
> 
> On Fri, 2 Mar 2018 06:54:17 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Alex Williamson
> > > Sent: Friday, March 2, 2018 4:22 AM
> > > >
> > > > I am pretty sure that you are describing is true of some, but not for
> > > > all. I think the Amazon solutions and the virtio solution are doing
> > > > hard partitioning of the part. I will leave it to those guys to speak
> > > > for themselves since I don't know anything about the hardware design
> > > > of those parts.
> > >
> > > I think we'd need device specific knowledge and enablement to be able
> > > to take advantage of any hardware partitioning, otherwise we need to
> > > assume the pf is privileged, as implemented in other sriov devices.
> > >
> > > I'm also trying to imagine whether there's a solution via the new
> > > vfio/mdev interface, where the mdev vendor driver would bind to the
> pf
> > > and effectively present itself as the mdev device.  The vendor driver
> > > could provide sriov capabilities and bear the burden of ensuring that
> > > the pf is used cooperatively.  The only existing mdev vendor drivers are
> > > vGPUs and rely on on-device DMA translation and isolation, such as
> > > through GTTs, but there have been some thoughts on providing IOMMU
> > > based
> > > isolation of mdev/sriov mixed devices (assuming DMA is even required
> > > for userspace management of the pf in this use case).  [Cc Kirti]
> > > Thanks,
> > >
> >
> > Hope not distracting this thread, but above sounds like an interesting
> > idea. Actually we ever brainstormed similar thought for another
> > potential usage - supporting VF live migration. We are already working
> > on an generic extension to allow state save/restore of mdev instance.
> > If vendor driver could further wrap pf as a mdev instance, it could
> > leverage the same framework for a clean state migration on VF. based
> > on mmap callback the vendor driver can easily switch back-and-forth
> > between pass through and trap/emulation of the VF resources. Of
> > course doing so alone doesn't address all the demands of VF live
> > migration (e.g. dirty page tracking still requires other techniques),
> > but it does pave a way toward a general framework to support VF
> > live migration.
> >
> > If above is feasible, finally we could use one mdev framework to
> > manage both mdev and pf/vf assignment, while providing added
> > values which are difficult to achieve today. :-)
> 
> mdev drivers may be the first to support migration, but I wonder if a
> full mdev implementation is necessary for it.  Once the vfio api is
> define, device specific extensions to vfio-pci might be able to
> implement migration more directly.  Thanks,
> 
> Alex

yes technically a full mdev implementation is not necessary. If
device specific extensions will be placed within vfio module, it's
obviously straightforward. What I thought earlier was in case vfio
wants to stay device-agnostic then we probably want device
specific extensions in vendor driver which is loaded but in a 
dummy mode which simply do basic PCI initialization as vfio-pci
and then wrap vf as mdev (since vfio-pci is not the vf driver in
this scenario). It's especially useful for vendor drivers which aim
to support both mdev and sr-iov by sharing common state mgmt.
knowledge, but looks an overkill to other vendor drivers. Possibly
finally we'll allow both - simple device extensions in vfio-pci and 
complex device extensions in vendor drivers through vfio-mdev.

Thanks
Kevin
