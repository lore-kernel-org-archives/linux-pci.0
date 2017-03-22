Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:39881 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935106AbdCVPiw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Mar 2017 11:38:52 -0400
Date: Wed, 22 Mar 2017 16:38:50 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shanker Donthineni <shankerd@qti.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@qti.qualcomm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Nate Watterson <nwatters@qti.qualcomm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
Message-ID: <20170322153850.GD7266@8bytes.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170227195441.5170-23-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean-Philippe,

On Mon, Feb 27, 2017 at 07:54:33PM +0000, Jean-Philippe Brucker wrote:
> +extern int iommu_set_svm_ops(struct device *dev,
> +			     const struct iommu_svm_ops *svm_ops);
> +extern int iommu_bind_task(struct device *dev, struct task_struct *task,
> +			   int *pasid, int flags, void *priv);
> +
> +extern int iommu_unbind_task(struct device *dev, int pasid, int flags);

I really like that API, it is simpler than what the AMD driver
currently implements but should work for it too (once we adapt the
AMD-KFD driver to it).

One issue I like to have discussed is whether we can make a global PASID
allocation (with a one-PASID per-task model) workable with SMMU too.



	Joerg
