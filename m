Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sous-sol.org ([216.99.217.87]:41073 "EHLO sequoia.sous-sol.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755854Ab1KPK2r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Nov 2011 05:28:47 -0500
Date: Wed, 16 Nov 2011 02:28:29 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: dwmw2@infradead.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrisw@sous-sol.org, ddutile@redhat.com
Subject: Re: [PATCH] intel-iommu: Manage iommu_coherency globally
Message-ID: <20111116102829.GA3477@sequoia.sous-sol.org>
References: <20111116040752.11878.18642.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116040752.11878.18642.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> We currently manage iommu_coherency on a per domain basis,
> choosing the safest setting across the iommus attached to a
> particular domain.  This unfortunately has a bug that when
> no iommus are attached, the domain defaults to coherent.
> If we fall into this mode, then later add a device behind a
> non-coherent iommu to that domain, the context entry is
> updated using the wrong coherency setting, and we get dmar
> faults.
> 
> Since we expect chipsets to be consistent in their coherency
> setting, we can instead determine the coherency once and use
> it globally.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Looks good to me.

Acked-by: Chris Wright <chrisw@sous-sol.org>
