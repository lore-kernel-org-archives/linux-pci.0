Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFCv2 PATCH 26/36] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
To: Yisheng Xie <xieyisheng1@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "liubo95@huawei.com" <liubo95@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-27-jean-philippe.brucker@arm.com>
 <d2ec2e61-f758-0394-41d2-555ae65feb0d@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <8bdba799-49ec-edc9-dbcf-9277424dea57@arm.com>
Date: Wed, 6 Dec 2017 11:06:59 +0000
MIME-Version: 1.0
In-Reply-To: <d2ec2e61-f758-0394-41d2-555ae65feb0d@huawei.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/12/17 06:51, Yisheng Xie wrote:
> Hi Jean,
> 
> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>> If the SMMU supports it and the kernel was built with HTTU support, enable
>> +	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && (reg & (IDR0_HA | IDR0_HD))) {
>> +		smmu->features |= ARM_SMMU_FEAT_HA;
>> +		if (reg & IDR0_HD)
>> +			smmu->features |= ARM_SMMU_FEAT_HD;
>> +	}
> 
> What is relationship of armv8.1 HW_AFDBM and SMMUv3 HTTU? I mean why we need
> IS_ENABLED(CONFIG_ARM64_HW_AFDBM) ?

I think the reason we needed this was that, without CONFIG_ARM64_HW_AFDBM,
the CPU wouldn't update the pte atomically and pte_dirty() wouldn't check
the DBM bit 51 (only the SW dirty bit 55).

Since af29678fe785 ("arm64: Remove the !CONFIG_ARM64_HW_AFDBM alternative
code paths") removed lots of #ifdefs, I'll see if we can remove the above
IS_ENABLED as well.

> If CONFIG_ARM64_HW_AFDBM=y but the process do not support ARMv8.1, should it also
> enable related feature for SMMUv3?

Yes I think we can enable HTTU in the SMMU even if the CPU doesn't support
it (though HTTU is only useful when sharing process address spaces). The
mm code checks for both HW and SW bits even when the CPU doesn't support
ARMv8.1

Thanks,
Jean
