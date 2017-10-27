Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:61971 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932279AbdJ0WaX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Oct 2017 18:30:23 -0400
From: "Wang, Liang-min" <liang-min.wang@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Subject: RE: [PATCH] Enable SR-IOV instantiation through /sys file
Date: Fri, 27 Oct 2017 22:30:21 +0000
Message-ID: <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5AE00@FMSMSX110.amr.corp.intel.com>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
        <20171024234351.0af0ff4a@t450s.home>
        <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E36@FMSMSX110.amr.corp.intel.com>
        <20171025000654.7621b84e@t450s.home>
        <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5ADD3@FMSMSX110.amr.corp.intel.com>
 <20171028001907.7b8fa60d@t450s.home>
In-Reply-To: <20171028001907.7b8fa60d@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, October 27, 2017 6:19 PM
> To: Wang, Liang-min <liang-min.wang@intel.com>
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; kvm@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; Duyck, Alexander H <alexander.h.duyck@intel.com>
> Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
> 
> On Fri, 27 Oct 2017 21:50:43 +0000
> "Wang, Liang-min" <liang-min.wang@intel.com> wrote:
> 
> > > -----Original Message-----
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Tuesday, October 24, 2017 6:07 PM
> > > To: Wang, Liang-min <liang-min.wang@intel.com>
> > > Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; kvm@vger.kernel.org;
> > > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > bhelgaas@google.com; Duyck, Alexander H
> <alexander.h.duyck@intel.com>
> > > Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
> > >
> > > On Tue, 24 Oct 2017 21:49:15 +0000
> > > "Wang, Liang-min" <liang-min.wang@intel.com> wrote:
> > >
> > > > Just like any PCIe devices that supports SR-IOV. There are restrictions set
> for
> > > VF. Also, there is a concept of trust VF now available for PF to manage
> certain
> > > features that only selected VF could exercise. Are you saying all the devices
> > > supporting SR-IOV all have security issue?
> > >
> > > Here's a simple example, most SR-IOV capable NICs, including those from
> > > Intel, require the PF interface to be up in order to route traffic from
> > > the VF.  If the user controls the PF interface and VFs are used
> > > elsewhere in the host, the PF driver in userspace can induce a denial
> > > of service on the VFs.  That doesn't even take into account that VFs
> > > might be in separate IOMMU groups from the PF and therefore not
> > > isolated from the host like the PF and that the PF driver can
> > > potentially manipulate the VF, possibly performing DMA on behalf of the
> > > PF.  VFs are only considered secure today because the PF is managed by
> > > a driver in the host kernel.  Allowing simple enablement of VFs for a
> > > user owned PF seems inherently insecure to me.  Thanks,
> > >
> > > Alex
> >
> > Firstly, the concern is on user-space PF driver based upon vfio-pci, this patch
> doesn't
> > change PF behavior so with/without this patch, the concern remains the
> same.
> 
> This patch enables SR-IOV to be enabled via the host on a user-owned
> PF, how is this not a change in behavior?
> 
Are you saying without this patch, you have no concern denial-of-service on
Vfio-pci based user-space driver

> > Secondly, the security concern (including denial of service) in general is to
> ensure trust
> > entity to be trust-worthy. No matter the PF driver is in kernel-space or in
> user- space,
> > necessary mechanism needs to be enforced on the device driver to ensure it's
> > trusted worthy. For example, ixgbe kernel driver introduces a Tx hang
> detection
> > to avoid driver stays in a bad state. Therefore, it's the responsibility of user-
> space
> > driver function, which based upon vfio-pci, to enforce necessary mechanism
> to ensure
> > its trust-ness. That's a given.
> 
> Userspace is not trustworthy, therefore the host kernel cannot place
> responsibility on a userspace driver for anything, including the
> behavior of VFs.  I'm sorry, but it's a NAK unless you intend to
> follow-up with some proposal to quarantine the VFs enabled by the
> userspace PF driver.  Thanks,
> 
> Alex
So, your suggestion is to have VF instantiated through user-space driver
"quarantine". Could you elaborate your definition of "quarantine"? Do you
expect the enforcement is in vfio-pci or in user-space driver function, or both?

Liang-Min
