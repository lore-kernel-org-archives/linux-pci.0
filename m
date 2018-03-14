Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 31/37] iommu/arm-smmu-v3: Add support for PCI ATS
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-32-jean-philippe.brucker@arm.com>
 <20180308171725.0000763c@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <31673218-f051-3e31-e5fe-37de44edd443@arm.com>
Date: Wed, 14 Mar 2018 13:09:50 +0000
MIME-Version: 1.0
In-Reply-To: <20180308171725.0000763c@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>, Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 08/03/18 16:17, Jonathan Cameron wrote:
>> +	arm_smmu_enable_ats(master);
> It's a bit nasty not to handle the errors that this could output (other than
> the ENOSYS for when it's not available). Seems that it would be nice to at
> least add a note to the log if people are expecting it to work and it won't
> because some condition or other isn't met.

I agree it's not ideal. Last time this came up the problem was that
checking if ATS is supported requires an ugly ifdef. A proper
implementation requires more support in the PCI core, e.g. a
pci_ats_supported() function.

https://www.spinics.net/lists/kvm/msg145932.html

>> +
>>  	group = iommu_group_get_for_dev(dev);
>> -	if (!IS_ERR(group)) {
>> -		arm_smmu_insert_master(smmu, master);
>> -		iommu_group_put(group);
>> -		iommu_device_link(&smmu->iommu, dev);
>> +	if (IS_ERR(group)) {
>> +		ret = PTR_ERR(group);
>> +		goto err_disable_ats;
>>  	}
>>  
>> -	return PTR_ERR_OR_ZERO(group);
>> +	iommu_group_put(group);
>> +	arm_smmu_insert_master(smmu, master);
>> +	iommu_device_link(&smmu->iommu, dev);
>> +
>> +	return 0;
>> +
>> +err_disable_ats:
>> +	arm_smmu_disable_ats(master);
> master is leaked here I think...
> Possibly other things as this doesn't line up with the
> remove which I'd have mostly expected it to do.

> There are some slightly fishy bits of ordering in the original code
> anyway that I'm not seeing justification for (why is
> the iommu_device_unlink later than one might expect for
> example).

Yeah, knowing the rest of the probing code, there may exist subtle legacy
reasons for not freeing the master here and the strange orderings. I try
to keep existing behaviors where possible since I barely even have the
bandwidth to fix my own code.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
