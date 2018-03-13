Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56763 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbeCMIyp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 04:54:45 -0400
Date: Tue, 13 Mar 2018 09:54:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com
Subject: Re: [pci PATCH v5 3/4] ena: Migrate over to unmanaged SR-IOV
        support
Message-ID: <20180313085442.GA1537@lst.de>
References: <20180312171813.3487.94803.stgit@localhost.localdomain> <20180312172309.3487.76690.stgit@localhost.localdomain> <1520928772.28745.53.camel@infradead.org> <20180313081628.GA618@lst.de> <1520930719.11412.2.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1520930719.11412.2.camel@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 13, 2018 at 08:45:19AM +0000, David Woodhouse wrote:
> 
> 
> On Tue, 2018-03-13 at 09:16 +0100, Christoph Hellwig wrote:
> > On Tue, Mar 13, 2018 at 08:12:52AM +0000, David Woodhouse wrote:
> > > 
> > > I'd also *really* like to see a way to enable this for PFs which don't
> > > have (and don't need) a driver. We seem to have lost that along the
> > > way.
> > We've been forth and back on that.  I agree that not having any driver
> > just seems dangerous.  If your PF really does nothing we should just
> > have a trivial pf_stub driver that does nothing but wiring up
> > pci_sriov_configure_simple.  We can then add PCI IDs to it either
> > statically, or using the dynamic ids mechanism.
> 
> Or just add it to the existing pci-stub. What's the point in having a
> new driver? 

Because binding to pci-stub means that you'd now enable the simple
SR-IOV for any device bound to PCI stub.  Which often might be the wrong
thing.
