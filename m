Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbdH3TXo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Aug 2017 15:23:44 -0400
Date: Wed, 30 Aug 2017 14:23:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        David Fugate <david.fugate@intel.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 0/4] VMD fixups
Message-ID: <20170830192342.GV8154@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817181014.1257-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817181014.1257-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Joerg]

On Thu, Aug 17, 2017 at 12:10:10PM -0600, Jon Derrick wrote:
> Mostly just cleanup in this revision, eg, trying to limit scope of vmd code to
> x86
> 
> Previous:
> https://patchwork.kernel.org/patch/9886095/
> https://patchwork.kernel.org/patch/9886097/
> https://patchwork.kernel.org/patch/9886101/
> 
> 
> Jon Derrick (4):
>   MAINTAINERS: Add Jonathan Derrick as VMD maintainer
>   pci/x86: Move VMD quirks to x86 fixups
>   x86/PCI: Use is_vmd rather than relying on the domain number
>   iommu: Prevent VMD child devices from being remapping targets
> 
>  MAINTAINERS                 |  1 +
>  arch/x86/pci/fixup.c        | 18 ++++++++++++++++++
>  drivers/iommu/intel-iommu.c |  5 +++++
>  drivers/pci/quirks.c        | 17 -----------------
>  4 files changed, 24 insertions(+), 17 deletions(-)

I haven't heard anything from IOMMU folks, so I applied these to
pci/host-vmd for v4.14.  Let me know if there's any objection.
