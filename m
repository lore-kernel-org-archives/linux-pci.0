Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39676 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947Ab1K2XUE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2011 18:20:04 -0500
MIME-Version: 1.0
In-Reply-To: <1322594768.19120.194.camel@bling.home>
References: <20111103195452.21259.93021.stgit@bling.home>
	<4ED43AD9.5090509@au1.ibm.com>
	<4ED43CFE.8040009@au1.ibm.com>
	<1322538856.19120.126.camel@bling.home>
	<1322594768.19120.194.camel@bling.home>
Date: Tue, 29 Nov 2011 17:20:02 -0600
Message-ID: <CALRxmdDEGwA787gEgC3d_yU99TqOZOtWeDJ9N-QCQ3gxV8yyMw@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH] vfio: VFIO Driver core framework
From: Stuart Yoder <b08248@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, aafabbri@cisco.com,
	kvm@vger.kernel.org, pmac@au1.ibm.com, qemu-devel@nongnu.org,
	joerg.roedel@amd.com, konrad.wilk@oracle.com, agraf@suse.de,
	dwg@au1.ibm.com, chrisw@sous-sol.org, B08248@freescale.com,
	iommu@lists.linux-foundation.org, avi@redhat.com,
	linux-pci@vger.kernel.org, B07421@freescale.com, benve@cisco.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>
> BTW, github now has updated trees:
>
> git://github.com/awilliam/linux-vfio.git vfio-next-20111129
> git://github.com/awilliam/qemu-vfio.git vfio-ng

Hi Alex,

Have been looking at vfio a bit.   A few observations and things
we'll need to figure out as it relates to the Freescale iommu.

__vfio_dma_map() assumes that mappings are broken into
4KB pages.   That will not be true for us.   We normally will be mapping
much larger physically contiguous chunks for our guests.  Guests will
get hugetlbfs backed memory with very large pages (e.g. 16MB,
64MB) or very large chunks allocated by some proprietary
means.

Also, mappings will have additional Freescale-specific attributes
that need to get passed through to dma_map somehow.   For
example, the iommu can stash directly into a CPU's cache
and we have iommu mapping properties like the cache stash
target id and an operation mapping attribute.

How do you envision handling proprietary attributes
in struct vfio_dma_map?

Stuart
