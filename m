Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55954 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbcAVWTz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jan 2016 17:19:55 -0500
Date: Fri, 22 Jan 2016 14:16:19 -0800
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz, bhelgaas@google.com,
	alex.williamson@redhat.com
Cc: david.daney@cavium.com
Subject: Re: [PATCH 0/2] pci/lspci: Identify Enhanced Allocation (EA)
 Resources
Message-ID: <20160122221619.GA3202@sean.stalley.intel.com>
References: <1453500294-3140-1-git-send-email-sean.stalley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453500294-3140-1-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry, I forgot to increment the patch version.

This is V2. The only difference from V1 is the commit message on 1/2.
No functional changes.

-Sean

On Fri, Jan 22, 2016 at 02:04:52PM -0800, Sean O. Stalley wrote:
> Identify BAR-equivalent resources that are described by EA entries
> with the IORESOURCE_PCI_EA_BEI flag.
> 
> lspci cannot distinguish between resources from VF BARs and resources from EA.
> This results in EA Resources being incorrectly identified as [virtual].
> Adding this flag allows EA resources to be marked more accurately as [enhanced].
> 
> Although this patchset only add support for this flag to lspci,
> there are other use cases (such as vfio) where knowing a resource
> comes from EA would be useful.
> 
> [PATCH 1/2] is for the kernel, [PATCH 2/2] is for lspci.
> 
> 
> Alex Williamson (1):
>   pci: Identify Enhanced Allocation (EA) BAR Equivalent resources
> 
> Sean O. Stalley (1):
>   Add support for enhanced allocation regions
> 
> linux changes:
>  drivers/pci/pci.c      | 2 +-
>  include/linux/ioport.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> lspci changes:
>  lib/header.h |  4 ++++
>  lib/pci.h    |  2 ++
>  lib/sysfs.c  |  5 ++++-
>  lspci.c      | 17 ++++++++++++++---
>  4 files changed, 24 insertions(+), 4 deletions(-)
> 
> 
> -- 
> 1.9.1
> 
