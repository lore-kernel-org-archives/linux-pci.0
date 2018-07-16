Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbeGPPeO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Jul 2018 11:34:14 -0400
Date: Mon, 16 Jul 2018 09:06:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 0/4] Add parameter for disabling ACS redirection for
 P2P
Message-ID: <20180716090620.0caa3d79@t450s.home>
In-Reply-To: <710e15b2-89f8-a658-656f-84492ef78898@ozlabs.ru>
References: <20180713233158.19528-1-logang@deltatee.com>
        <710e15b2-89f8-a658-656f-84492ef78898@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 16 Jul 2018 15:01:21 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 14/7/18 9:31 am, Logan Gunthorpe wrote:
> > Changes since v5:
> > * Add a quirk to handle the Intel SPT PCH case (as pointed out by Alex)
> > * Warn in the case that we try to disable ACS redirect on a device
> >   that doesn't have the ACS capability (also suggested by Alex)
> > * Collect reviewed-by tag from Alex
> > * Rebased onto v4.18-rc4 (no conflicts)
> > 
> > Changes since v4:
> > * Fixed a couple documentation mistakes spotted by Randy
> > 
> > Changes since v3:
> > * Removed some of the cruft that was copied from the resource_alignment
> >   paramater (per Alex)
> > * A number of docuemntation fixes as noticed by Alex and Willy
> > 
> > Changes since v2:
> > * Rebased onto v4.18-rc1 (no conflicts)
> > * Minor tweaks to the documentation per Andy
> > * Removed the "path:" prefix and use the path parsing code
> >   for simple devices (as it works the same). Per a suggestion from Alex
> > 
> > Changes since v1:
> > * Reworked pci_dev_str_match_path using strrchr as suggested by Alex
> > * Collected Christian's Acks
> > 
> > --
> > 
> > Hi,
> > 
> > As discussed in our PCI P2PDMA series, we'd like to add a kernel
> > parameter for selectively disabling ACS redirection for select
> > bridges. Seeing this turned out to be a small series in itself, we've
> > decided to send this separately from the P2P work.
> > 
> > This series generalizes the code already done for the resource_alignment
> > option that already exists. The first patch creates a helper function
> > to match PCI devices against strings based on the code that already
> > existed in pci_specified_resource_alignment().
> > 
> > The second patch expands the new helper to optionally take a path of
> > PCI devfns. This is to address Alex's renumbering concern when using
> > simple bus-devfns. The implementation is essentially how he described it and
> > similar to the Intel VT-d spec (Section 8.3.1).
> > 
> > The final patch adds the disable_acs_redir kernel parameter which takes
> > a list of PCI devices and will disable the ACS P2P Request Redirect,
> > ACS P2P Completion Redirect and ACS P2P Egress Control bits for the
> > selected devices. This allows P2P traffic between selected bridges and
> > seeing it's done at boot, before the IOMMU groups will be created, the
> > groups will match the security provided by ACS.  
> 
> 
> I am pretty sure it's been discussed but just to make sure I understand the
> whole picture - why exactly does ACS have to be disabled at the boot time?
> We could enable it, for example, for 2 devices in the same VFIO container
> if there are in isolatable part of the PCI tree, or we just do not want to
> make VFIO containers or QEMU aware of PCI hierarchy (I can see why, just
> double checking)? Thanks.

AIUI, vfio is not necessarily a primary use case here, native bare
metal drivers might also want to perform direct p2p.  In the vfio case,
any time we're allowing p2p via ACS, we're poking holes into the IOVA
space presented to the user.  We don't have a good way for the user to
handle that, or even learn about it, so there are quite a few issues if
vfio were a use case here.  Currently the intersection with vfio is
that when ACS is disabled, it introduces p2p channels which breaks
device isolation.  These need to be reflected in the IOMMU groups so
it's done at boot time, before the groups are created.  If we wanted to
allow dynamic manipulation, we'd effectively need to soft unplug entire
sub-hierarchies around the point where ACS is modified and re-add the
devices in order to get the grouping correct.  Thanks,

Alex
