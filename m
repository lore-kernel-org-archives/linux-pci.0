Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 28/37] iommu/arm-smmu-v3: Maintain a SID->device structure
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-29-jean-philippe.brucker@arm.com>
 <20180308183431.00005f86@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <4d83c676-604c-6003-5284-81e3535689a8@arm.com>
Date: Wed, 14 Mar 2018 13:09:10 +0000
MIME-Version: 1.0
In-Reply-To: <20180308183431.00005f86@huawei.com>
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

On 08/03/18 17:34, Jonathan Cameron wrote:
>>  static int arm_smmu_add_device(struct device *dev)
>> @@ -2198,6 +2298,7 @@ static int arm_smmu_add_device(struct device *dev)
>>  
>>  	group = iommu_group_get_for_dev(dev);
>>  	if (!IS_ERR(group)) {
>> +		arm_smmu_insert_master(smmu, master);
> There are some error cases it would be good to take notice off when
> inserting the master.  Admittedly the same is true of iommu_device_link
> so I guess you are keeping with the existing code style.
> 
> Would also be nice if the later bit of rework to drop these out
> of the if statement was done before this patch in the series.

Not sure that's worth a separate patch, maybe we can do it here.

Thanks,
Jean

> 
>>  		iommu_group_put(group);
>>  		iommu_device_link(&smmu->iommu, dev);
>>  	}
>> @@ -2218,6 +2319,7 @@ static void arm_smmu_remove_device(struct device *dev)
>>  	smmu = master->smmu;
>>  	if (master && master->ste.assigned)
>>  		arm_smmu_detach_dev(dev);
>> +	arm_smmu_remove_master(smmu, master);
>>  	iommu_group_remove_device(dev);
>>  	iommu_device_unlink(&smmu->iommu, dev);
>>  	kfree(master);
>> @@ -2527,6 +2629,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>>  	int ret;
>>  
>>  	atomic_set(&smmu->sync_nr, 0);
>> +	mutex_init(&smmu->streams_mutex);
>> +	smmu->streams = RB_ROOT;
>> +
>>  	ret = arm_smmu_init_queues(smmu);
>>  	if (ret)
>>  		return ret;
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
