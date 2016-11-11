Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 11 Nov 2016 16:22:48 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: iommu@lists.linux-foundation.org,
        Will Deacon <will.deacon@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
Message-ID: <20161111152248.GS2078@8bytes.org>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 09, 2016 at 02:19:36PM +0000, Lorenzo Pieralisi wrote:
> +struct iommu_fwentry {
> +	struct list_head list;
> +	struct fwnode_handle *fwnode;
> +	const struct iommu_ops *ops;
> +};

Is there a reason the iommu_ops need to be stored there? Currently it
seems that the ops are only needed to get the of_xlate fn-ptr later. And
the place where it is called the iommu-ops should also be available
through pdev->dev->bus->iommu_ops.


	Joerg
