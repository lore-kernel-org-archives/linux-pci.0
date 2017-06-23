Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC,20/30] iommu/arm-smmu-v3: Enable PCI PASID in masters
To: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
References: <20170227195441.5170-21-jean-philippe.brucker@arm.com>
 <f18163da-30a6-a7d4-0a2c-bca4fc1b0fff@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <fad6510f-922a-550b-0429-bc59f857c307@codeaurora.org>
Date: Fri, 23 Jun 2017 10:39:06 -0400
MIME-Version: 1.0
In-Reply-To: <f18163da-30a6-a7d4-0a2c-bca4fc1b0fff@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Harv Abdulhamid <harba@qti.qualcomm.com>, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean-Philippe,
 
> On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
> Enable PASID for PCI devices that support it.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 499dc1cd07eb..37fd061405e9 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -730,6 +730,8 @@ struct arm_smmu_master_data {
>  
>  	struct arm_smmu_stream		*streams;
>  	struct rb_root			contexts;
> +
> +	u32				avail_contexts;
>  };
>  

According to the PASID ECN here (https://pcisig.com/sites/default/files/specification_documents/ECN-PASID-ATS-2011-03-31.pdf),
PASID should be enabled only if all switches between the root port and
a device support TLP prefix. 
 
I'm only seeing a call to pci_enable_pasid() in this patch but I don't
see anybody checking for TLP prefix support on the hierarchy.

This could potentially be an addition to the PCI core code.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
