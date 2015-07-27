Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49304 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbbG0Mk2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jul 2015 08:40:28 -0400
Date: Mon, 27 Jul 2015 14:40:24 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 02/11] PCI: Allocate ATS struct during enumeration
Message-ID: <20150727124024.GB27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150721001405.28145.43004.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721001405.28145.43004.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 07:14:05PM -0500, Bjorn Helgaas wrote:
> Previously, we allocated pci_ats structures when an IOMMU driver called
> pci_enable_ats().  An SR-IOV VF shares the STU setting with its PF, so when
> enabling ATS on the VF, we allocated a pci_ats struct for the PF if it
> didn't already have one.  We held the sriov->lock to serialize threads
> concurrently enabling ATS on several VFS so only one would allocate the PF
> pci_ats.
> 
> Gregor reported a deadlock here:
> 
>   pci_enable_sriov
>     sriov_enable
>       virtfn_add
>         mutex_lock(dev->sriov->lock)      # acquire sriov->lock
>         pci_device_add
>           device_add
>             BUS_NOTIFY_ADD_DEVICE notifier chain
>             iommu_bus_notifier
>               amd_iommu_add_device        # iommu_ops.add_device
>                 init_iommu_group
>                   iommu_group_get_for_dev
>                     iommu_group_add_device
>                       __iommu_attach_device
>                         amd_iommu_attach_device  # iommu_ops.attach_device
>                           attach_device
>                             pci_enable_ats
>                               mutex_lock(dev->sriov->lock) # deadlock
> 
> There's no reason to delay allocating the pci_ats struct, and if we
> allocate it for each device at enumeration-time, there's no need for
> locking in pci_enable_ats().
> 
> Allocate pci_ats struct during enumeration, when we initialize other
> capabilities.
> 
> Note that this implementation requires ATS to be enabled on the PF first,
> before on any of the VFs because the PF controls the STU for all the VFs.
> 
> Link: http://permalink.gmane.org/gmane.linux.kernel.iommu/9433
> Reported-by: Gregor Dick <gdick@solarflare.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c       |   98 ++++++++++++++++++++---------------------------
>  drivers/pci/probe.c     |    3 +
>  drivers/pci/remove.c    |    1 
>  include/linux/pci-ats.h |    2 -
>  include/linux/pci.h     |    9 ++++
>  5 files changed, 56 insertions(+), 57 deletions(-)

Looks good to me now.


Reviewed-by: Joerg Roedel <jroedel@suse.de>
