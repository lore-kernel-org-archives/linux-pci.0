Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:47588
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758020Ab1LGQjA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Dec 2011 11:39:00 -0500
Date: Wed, 7 Dec 2011 17:38:42 +0100
From: Joerg Roedel <joerg.roedel@amd.com>
To: Stuart Yoder <b08248@gmail.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Alexey Kardashevskiy <aik@au1.ibm.com>, <aafabbri@cisco.com>,
	<kvm@vger.kernel.org>, <pmac@au1.ibm.com>, <qemu-devel@nongnu.org>,
	<konrad.wilk@oracle.com>, <agraf@suse.de>, <dwg@au1.ibm.com>,
	<chrisw@sous-sol.org>, <B08248@freescale.com>,
	<iommu@lists.linux-foundation.org>, <avi@redhat.com>,
	<linux-pci@vger.kernel.org>, <B07421@freescale.com>,
	<benve@cisco.com>, <benh@kernel.crashing.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: vfio / iommu domain attributes
Message-ID: <20111207163842.GC29680@amd.com>
References: <CALRxmdDS4qas9fyHXeDVw2e_yMCTqzMi6VXUF-q+eYwgMwg7tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <CALRxmdDS4qas9fyHXeDVw2e_yMCTqzMi6VXUF-q+eYwgMwg7tw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 07, 2011 at 09:54:39AM -0600, Stuart Yoder wrote:
> Alex, Alexey I'm wondering if you've had any new thoughts on this over
> the last week.
> 
> For Freescale, our iommu domain attributes would look something like:
>     -domain iova base address
>     -domain iova window size

I agree with that.

>     -domain enable/disable
>     -number of subwindows
>     -operation mapping table index
>     -stash destination CPU
>     -stash target (cache– L1, L2, L3)

Why does the user of the IOMMU-API need to have control over these
things?

> These are all things that need to be set by the creator of the domain.
> 
> Since the domain attributes are going to be so different for each platform does
> it make sense to define a new iommu_ops call back that just takes a void pointer
> that can be implemented in a platform specific way?   For example:
> 
>     struct iommu_ops {
>         [cut]
>         int (*domain_set_attrs)(struct iommu_domain *domain,
>                               void *attrs);
>         int (*domain_get_attrs)(struct iommu_domain *domain,
>                               void *attrs);
>     }

A void pointer is certainly the worst choice for an interface. I think
it is better to have at least a set of common attributes. Somthing like
this:

iommu_domain_set_attr(struct iommu_domain *domain, enum attr_type, void *data)
iommu_domain_get_attr(struct iommu_domain *domain, enum attr_type, void *data)

The iova base/size options make sense for more IOMMUs than just
Freescale. For example it would allow to manage GART-like IOMMUs with
the IOMMU-API too.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

