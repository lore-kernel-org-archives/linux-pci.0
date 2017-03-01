Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5a7822f2-3991-aa51-169f-78ef49567feb@codeaurora.org>
Date: Wed, 1 Mar 2017 14:24:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170227195441.5170-5-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Harb Abdulhamid <harba@codeaurora.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org,
 Sinan Kaya <okaya@codeaurora.org>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
> /* Initialise command lazily */
> +		if (!cmd.opcode)
> +			arm_smmu_atc_invalidate_to_cmd(smmu, iova, size, &cmd);
> +
> +		spin_lock(&smmu_group->devices_lock);
> +
> +		list_for_each_entry(master, &smmu_group->devices, group_head)
> +			arm_smmu_atc_invalidate_master(master, &cmd);
> +
> +		/*
> +		 * TODO: ensure we do a sync whenever we have sent ats_queue_depth
> +		 * invalidations to the same device.
> +		 */
> +		arm_smmu_cmdq_issue_cmd(smmu, &sync_cmd);
> +

It is possible to observe ATS invalidation timeout up to 90 seconds according to PCIe
spec. How does the current code deal with this?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
