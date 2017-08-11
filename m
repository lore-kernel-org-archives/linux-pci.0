Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753378AbdHKRUj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Aug 2017 13:20:39 -0400
Date: Fri, 11 Aug 2017 12:20:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        David Fugate <david.fugate@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MAINTAINERS: Add Jonathan Derrick as VMD maintainer
Message-ID: <20170811172037.GD17039@bhelgaas-glaptop.roam.corp.google.com>
References: <20170807195713.10963-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170807195713.10963-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 07, 2017 at 01:57:11PM -0600, Jon Derrick wrote:
> Add myself as VMD maintainer
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Keith, I'm looking for an ack from you since you're currently
listed in MAINTAINERS.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f66488d..3ec39df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10090,6 +10090,7 @@ F:	drivers/pci/dwc/*imx6*
>  
>  PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
>  M:	Keith Busch <keith.busch@intel.com>
> +M:	Jonathan Derrick <jonathan.derrick@intel.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	drivers/pci/host/vmd.c
> -- 
> 2.9.4
> 
