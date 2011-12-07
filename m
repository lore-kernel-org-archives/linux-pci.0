Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51811 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab1LGPyk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2011 10:54:40 -0500
MIME-Version: 1.0
Date: Wed, 7 Dec 2011 09:54:39 -0600
Message-ID: <CALRxmdDS4qas9fyHXeDVw2e_yMCTqzMi6VXUF-q+eYwgMwg7tw@mail.gmail.com>
Subject: vfio / iommu domain attributes
From: Stuart Yoder <b08248@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	Alexey Kardashevskiy <aik@au1.ibm.com>
Cc: aafabbri@cisco.com, kvm@vger.kernel.org, pmac@au1.ibm.com,
	qemu-devel@nongnu.org, joerg.roedel@amd.com,
	konrad.wilk@oracle.com, agraf@suse.de, dwg@au1.ibm.com,
	chrisw@sous-sol.org, B08248@freescale.com,
	iommu@lists.linux-foundation.org, avi@redhat.com,
	linux-pci@vger.kernel.org, B07421@freescale.com, benve@cisco.com,
	benh@kernel.crashing.org,
	David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the vfio RFC thread there seemed to be convergence that some new
iommu_ops API is needed to set some platform specific aspects of an
iommu domain.

On Wed, Nov 30, 2011 at 10:58 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
[cut]
> In that case, you should definitely be following what Alexey is thinking
> about with an iommu_setup IOMMU API callback.  I think it's shaping up
> to do:
>
> x86:
>  - Report any IOVA range restrictions imposed by hw implementation
> POWER:
>  - Request IOVA window size, report size and base
> powerpc:
>  - Set domain attributes, probably report range as well.

Alex, Alexey I'm wondering if you've had any new thoughts on this over
the last week.

For Freescale, our iommu domain attributes would look something like:
    -domain iova base address
    -domain iova window size
    -domain enable/disable
    -number of subwindows
    -operation mapping table index
    -stash destination CPU
    -stash target (cache– L1, L2, L3)

These are all things that need to be set by the creator of the domain.

Since the domain attributes are going to be so different for each platform does
it make sense to define a new iommu_ops call back that just takes a void pointer
that can be implemented in a platform specific way?   For example:

    struct iommu_ops {
        [cut]
        int (*domain_set_attrs)(struct iommu_domain *domain,
                              void *attrs);
        int (*domain_get_attrs)(struct iommu_domain *domain,
                              void *attrs);
    }

Whatever this API winds up looking like it needs to be reflected in
the vfio interface to user space as well.

Thanks,
Stuart
