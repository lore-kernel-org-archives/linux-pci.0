Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Oct 2017 10:39:36 +0200
From: Alex Williamson <alex.williamson@redhat.com>
To: "Wang, Liang-min" <liang-min.wang@intel.com>
Cc: "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
Message-ID: <20171025103936.21eaeb8e@t450s.home>
In-Reply-To: <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E7F@FMSMSX110.amr.corp.intel.com>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
        <20171024234351.0af0ff4a@t450s.home>
        <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E36@FMSMSX110.amr.corp.intel.com>
        <20171025000654.7621b84e@t450s.home>
        <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E7F@FMSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 24 Oct 2017 22:29:00 +0000
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
> So, I assume over PF+SR-IOV usage model, you would agree that PF is trusted, and not VF. So, the "potential" insecure issue occurs on both native device kernel driver and vfio-pci. The interface that is used to create SR-IOV is also considered trusted, either it's a script run by a network manager or manually done by network manager. So, it's up to the trusted network manager to give privileges to each individual VF according to respective policy. BTW, there is a separate effort on a similar support (https://lkml.org/lkml/2017/9/27/348). Do you have the same concern for uio_pci_generic?

That thread doesn't seem to support this as a safe thing to do.  Do we
expect existing userspace PF drivers through vfio to recognize that
SR-IOV is enabled?  How would we coordinate enabling SR-IOV on a PF
while the PF is up and running in a userspace driver?  Plus the security
concerns of a VF under the influence of a user owned PF.  I would think
that UIO would have all of these same concerns, but in reality UIO is
severely abused and mostly used in insecure ways already, so security
is already compromised through UIO.

Host kernel drivers and core code is necessarily trusted, there's no
memory protection between such code.  A VF driver, in kernel or
userspace, must trust the PF driver is operating benevolently, we have
no other choice.  We cannot make such assumptions about a userspace PF
driver.  VFs managed by a user owned PF would need to be quarantined in
some way by default, IMO.  Thanks,

Alex
