Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 18 Nov 2016 14:49:02 +0000
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: iommu@lists.linux-foundation.org,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v8 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
Message-ID: <20161118144902.GQ13470@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
 <20161116152936.22955-5-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161116152936.22955-5-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 16, 2016 at 03:29:24PM +0000, Lorenzo Pieralisi wrote:
> The of_iommu_{set/get}_ops() API is used to associate a device
> tree node with a specific set of IOMMU operations. The same
> kernel interface is required on systems booting with ACPI, where
> devices are not associated with a device tree node, therefore
> the interface requires generalization.
> 
> The struct device fwnode member represents the fwnode token associated
> with the device and the struct it points at is firmware specific;
> regardless, it is initialized on both ACPI and DT systems and makes an
> ideal candidate to use it to associate a set of IOMMU operations to a
> given device, through its struct device.fwnode member pointer, paving
> the way for representing per-device iommu_ops (ie an iommu instance
> associated with a device).
> 
> Convert the DT specific of_iommu_{set/get}_ops() interface to
> use struct device.fwnode as a look-up token, making the interface
> usable on ACPI systems and rename the data structures and the
> registration API so that they are made to represent their usage
> more clearly.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/iommu.c    | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/of_iommu.c | 39 ---------------------------------------
>  include/linux/iommu.h    | 14 ++++++++++++++
>  include/linux/of_iommu.h | 12 ++++++++++--
>  4 files changed, 64 insertions(+), 41 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
