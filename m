Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34084 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbbHMHxh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Aug 2015 03:53:37 -0400
Date: Thu, 13 Aug 2015 09:53:33 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Gregor Dick <gdick@solarflare.com>,
	iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3 01/11] iommu/vt-d: Cache PCI ATS state and Invalidate
 Queue Depth
Message-ID: <20150813075333.GF12342@suse.de>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150811155107.21078.24884.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150811155107.21078.24884.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 11, 2015 at 10:51:07AM -0500, Bjorn Helgaas wrote:
> We check the ATS state (enabled/disabled) and fetch the PCI ATS Invalidate
> Queue Depth in performance-sensitive paths.  It's easy to cache these,
> which removes dependencies on PCI.
> 
> Remember the ATS enabled state.  When enabling, read the queue depth once
> and cache it in the device_domain_info struct.  This is similar to what
> amd_iommu.c does.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/iommu/intel-iommu.c |   28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>

