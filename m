Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:42917 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbbGUP4h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jul 2015 11:56:37 -0400
Date: Tue, 21 Jul 2015 17:56:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>
Subject: Re: Since Linux 4.1: A lot of AMD-Vi IO_PAGE_FAULTs
Message-ID: <20150721155635.GE10969@8bytes.org>
References: <55AE5F84.5020204@01019freenet.de>
 <1437492886.1391.847.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437492886.1391.847.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andreas,

On Tue, Jul 21, 2015 at 09:34:46AM -0600, Alex Williamson wrote:
> > Since Linux 4.1, I'm getting a lot of IO_PAGE_FAULT like this one
> > 
> > [   17.048609] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:11.0
> > domain=0x0008 address=0x40ebaaab00618000 flags=0x0010]
> > 
> > with different addresses:
> > 
> > 0x40ebaaab00618000
> > 0x40ebaaab00618040
> > 0x0000000000000000
> > 0x0000000000000180
> > 0x00000000000000c0
> > 0x0000000000000080
> > 0x0000000000000100
> > 0x0000000000000040
> > 0x0000000000000140
> > 0x00000000000001c0
> > 0x0000000000000200
> > 0x0000000000000240
> > 0x0000000000000280

These addresses are not returned from the address allocator of the AMD
IOMMU driver. Hard to tell what went wrong here, can you probably get a
complete boot-log (dmesg output after boot) and send it to me?

Please also boot with amd_iommu_dump on the kernel command line.

Thanks,

	Joerg
