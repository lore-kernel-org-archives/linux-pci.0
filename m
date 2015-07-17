Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35195 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbGQHvT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jul 2015 03:51:19 -0400
Date: Fri, 17 Jul 2015 09:51:15 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Gregor Dick <gdick@solarflare.com>,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] PCI: Don't use SR-IOV lock for ATS
Message-ID: <20150717075114.GA12578@suse.de>
References: <1434617420-18313-1-git-send-email-joro@8bytes.org>
 <20150716230831.GF25591@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150716230831.GF25591@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thu, Jul 16, 2015 at 06:08:31PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 18, 2015 at 10:50:20AM +0200, Joerg Roedel wrote:
> > The problem is that the VFs will be added to the bus with
> > the SR-IOV lock held. While added to the bus the
> > device-notifiers will run and invoke AMD IOMMU code, which
> > itself will assign the device to a domain try to enable ATS.
> > When it calls pci_enable_ats() this will dead-lock.
> 
> I'm trying to connect the dots here.  What's the notifier that invokes the
> AMD IOMMU code?  I thought it would be a BUS_NOTIFY_ADD_DEVICE notifier,
> but I haven't found it yet.

Yes, it is the BUS_NOTIFY_ADD_DEVICE notifier. In the case of the AMD
IOMMU driver the call-chain is:

	   pci_enable_sriov()
	-> sriov_enable()
	-> virtfn_add()
	-> pci_device_add()		<-- Called with phys_dev->sriov->lock held
	-> device_add()
	-> BUS_NOTIFY_ADD_DEVICE notifier-chain
	-> iommu_bus_notifier()
	-> amd_iommu_add_device()	[through iommu_ops->add_device]
	-> init_iommu_group()
	-> iommu_group_get_for_dev()
	-> iommu_group_add_device()
	-> __iommu_attach_device()
	-> amd_iommu_attach_device()	[through iommu_ops->attach_device]
	-> attach_device()
	-> pci_enable_ats()		<-- tries to take phys_dev->sriov->lock,
					    if virtfn has ATS capability,
					    and deadlocks

In virtfn_add the sriov->lock is dropped right after pci_device_add
returned. But I don't know why it needs to be protected by this lock,
maybe it can be called without it?

The problem in the end is that the ATS code uses the same lock as the
IOV code, so another solution would be to use another lock for ATS.

> The mutex was originally added by e277d2fc79d6 ("PCI: handle Virtual
> Function ATS enabling").  I assume the purpose is to protect the
> ats_alloc_one().
> 
> This seems overly complicated.  I think we can simplify this by doing some
> of this work earlier, in pci_init_capabilities().  I'll work this up and
> you can see what you think.

Hmm, the purpose of the lock is to prevent a race when pci_enable_ats is
called concurrently for the virtual functions and it tries to allocate
an ATS structure for the physical function too.

Allocating the ats structure for the physical function earlier sounds
like a good solution too.


	Joerg

