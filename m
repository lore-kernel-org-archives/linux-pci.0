Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 28 Oct 2017 00:19:07 +0200
From: Alex Williamson <alex.williamson@redhat.com>
To: "Wang, Liang-min" <liang-min.wang@intel.com>
Cc: "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
Message-ID: <20171028001907.7b8fa60d@t450s.home>
In-Reply-To: <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5ADD3@FMSMSX110.amr.corp.intel.com>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
        <20171024234351.0af0ff4a@t450s.home>
        <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E36@FMSMSX110.amr.corp.intel.com>
        <20171025000654.7621b84e@t450s.home>
        <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5ADD3@FMSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 27 Oct 2017 21:50:43 +0000
"Wang, Liang-min" <liang-min.wang@intel.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Tuesday, October 24, 2017 6:07 PM
> > To: Wang, Liang-min <liang-min.wang@intel.com>
> > Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; kvm@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > bhelgaas@google.com; Duyck, Alexander H <alexander.h.duyck@intel.com>
> > Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
> > 
> > On Tue, 24 Oct 2017 21:49:15 +0000
> > "Wang, Liang-min" <liang-min.wang@intel.com> wrote:
> >   
> > > Just like any PCIe devices that supports SR-IOV. There are restrictions set for  
> > VF. Also, there is a concept of trust VF now available for PF to manage certain
> > features that only selected VF could exercise. Are you saying all the devices
> > supporting SR-IOV all have security issue?
> > 
> > Here's a simple example, most SR-IOV capable NICs, including those from
> > Intel, require the PF interface to be up in order to route traffic from
> > the VF.  If the user controls the PF interface and VFs are used
> > elsewhere in the host, the PF driver in userspace can induce a denial
> > of service on the VFs.  That doesn't even take into account that VFs
> > might be in separate IOMMU groups from the PF and therefore not
> > isolated from the host like the PF and that the PF driver can
> > potentially manipulate the VF, possibly performing DMA on behalf of the
> > PF.  VFs are only considered secure today because the PF is managed by
> > a driver in the host kernel.  Allowing simple enablement of VFs for a
> > user owned PF seems inherently insecure to me.  Thanks,
> > 
> > Alex  
> 
> Firstly, the concern is on user-space PF driver based upon vfio-pci, this patch doesn't
> change PF behavior so with/without this patch, the concern remains the same.

This patch enables SR-IOV to be enabled via the host on a user-owned
PF, how is this not a change in behavior?

> Secondly, the security concern (including denial of service) in general is to ensure trust
> entity to be trust-worthy. No matter the PF driver is in kernel-space or in user- space,
> necessary mechanism needs to be enforced on the device driver to ensure it's
> trusted worthy. For example, ixgbe kernel driver introduces a Tx hang detection
> to avoid driver stays in a bad state. Therefore, it's the responsibility of user-space
> driver function, which based upon vfio-pci, to enforce necessary mechanism to ensure
> its trust-ness. That's a given.

Userspace is not trustworthy, therefore the host kernel cannot place
responsibility on a userspace driver for anything, including the
behavior of VFs.  I'm sorry, but it's a NAK unless you intend to
follow-up with some proposal to quarantine the VFs enabled by the
userspace PF driver.  Thanks,

Alex
