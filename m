Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFCv2 PATCH 26/36] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-27-jean-philippe.brucker@arm.com>
CC: <joro@8bytes.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <hanjun.guo@linaro.org>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <tn@semihalf.com>,
        <liubo95@huawei.com>, <thunder.leizhen@huawei.com>,
        <gabriele.paoloni@huawei.com>, <nwatters@codeaurora.org>,
        <okaya@codeaurora.org>, <rfranz@cavium.com>, <dwmw2@infradead.org>,
        <jacob.jun.pan@linux.intel.com>, <yi.l.liu@intel.com>,
        <ashok.raj@intel.com>, <robdclark@gmail.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <d2ec2e61-f758-0394-41d2-555ae65feb0d@huawei.com>
Date: Wed, 6 Dec 2017 14:51:59 +0800
MIME-Version: 1.0
In-Reply-To: <20171006133203.22803-27-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> If the SMMU supports it and the kernel was built with HTTU support, enable
> +	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && (reg & (IDR0_HA | IDR0_HD))) {
> +		smmu->features |= ARM_SMMU_FEAT_HA;
> +		if (reg & IDR0_HD)
> +			smmu->features |= ARM_SMMU_FEAT_HD;
> +	}

What is relationship of armv8.1 HW_AFDBM and SMMUv3 HTTU? I mean why we need
IS_ENABLED(CONFIG_ARM64_HW_AFDBM) ?

If CONFIG_ARM64_HW_AFDBM=y but the process do not support ARMv8.1, should it also
enable related feature for SMMUv3?

Thanks
Yisheng Xie
> +
>  	/*
>  	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
>  	 * will create TLB entries for NH-EL1 world and will miss the
> 

