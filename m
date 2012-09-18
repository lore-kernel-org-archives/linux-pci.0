Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:43226 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751574Ab2IRL6L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 07:58:11 -0400
Date: Tue, 18 Sep 2012 13:58:02 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: <dwmw2@infradead.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chrisw@sous-sol.org>,
	<iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v2] intel-iommu: Default to non-coherent for domains
 unattached to iommus
Message-ID: <20120918115802.GJ2505@amd.com>
References: <20111112002421.10875.8307.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111112002421.10875.8307.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2011 at 05:26:44PM -0700, Alex Williamson wrote:
> domain_update_iommu_coherency() currently defaults to setting domains
> as coherent when the domain is not attached to any iommus.  This
> allows for a window in domain_context_mapping_one() where such a
> domain can update context entries non-coherently, and only after
> update the domain capability to clear iommu_coherency.
> 
> This can be seen using KVM device assignment on VT-d systems that
> do not support coherency in the ecap register.  When a device is
> added to a guest, a domain is created (iommu_coherency = 0), the
> device is attached, and ranges are mapped.  If we then hot unplug
> the device, the coherency is updated and set to the default (1)
> since no iommus are attached to the domain.  A subsequent attach
> of a device makes use of the same dmar domain (now marked coherent)
> updates context entries with coherency enabled, and only disables
> coherency as the last step in the process.
> 
> To fix this, switch domain_update_iommu_coherency() to use the
> safer, non-coherent default for domains not attached to iommus.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Tested-by: Donald Dutile <ddutile@redhat.com>
> Acked-by: Donald Dutile <ddutile@redhat.com>
> Acked-by: Chris Wright <chrisw@sous-sol.org>

Applied, thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

