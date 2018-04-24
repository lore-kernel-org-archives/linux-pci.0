Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
To: Sinan Kaya <okaya@codeaurora.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <57d77955-caa7-ddac-df7d-7eef1f05dbb2@codeaurora.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <66ec18ca-ea4e-d224-c9c5-8dbee5da8a72@arm.com>
Date: Tue, 24 Apr 2018 10:33:03 +0100
MIME-Version: 1.0
In-Reply-To: <57d77955-caa7-ddac-df7d-7eef1f05dbb2@codeaurora.org>
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
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 24/04/18 02:32, Sinan Kaya wrote:
> On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
>> /**
>>   * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a device
>>   * @dev: the device
>> @@ -129,7 +439,10 @@ EXPORT_SYMBOL_GPL(iommu_sva_device_shutdown);
>>  int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>>  			  unsigned long flags, void *drvdata)
>>  {
>> +	int i, ret;
>> +	struct io_mm *io_mm = NULL;
>>  	struct iommu_domain *domain;
>> +	struct iommu_bond *bond = NULL, *tmp;
>>  	struct iommu_param *dev_param = dev->iommu_param;
>>  
>>  	domain = iommu_get_domain_for_dev(dev);
>> @@ -145,7 +458,42 @@ int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int *pasid,
>>  	if (flags != (IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF))
>>  		return -EINVAL;
>>  
>> -	return -ENOSYS; /* TODO */
>> +	/* If an io_mm already exists, use it */
>> +	spin_lock(&iommu_sva_lock);
>> +	idr_for_each_entry(&iommu_pasid_idr, io_mm, i) {
>> +		if (io_mm->mm != mm || !io_mm_get_locked(io_mm))
>> +			continue;
>> +
>> +		/* Is it already bound to this device? */
>> +		list_for_each_entry(tmp, &io_mm->devices, mm_head) {
>> +			if (tmp->dev != dev)
>> +				continue;
>> +
>> +			bond = tmp;
>> +			refcount_inc(&bond->refs);
>> +			io_mm_put_locked(io_mm);
>> +			break;
>> +		}
>> +		break;
>> +	}
>> +	spin_unlock(&iommu_sva_lock);
>> +
>> +	if (bond)
> 
> Please return pasid when you find an io_mm that is already bound. Something like
> *pasid = io_mm->pasid should do the work here when bond is true.

Right. I think we should also keep returning 0, not switch to -EEXIST or
similar. So in next version a driver can call bind(devX, mmY) multiple
times, but the first unbind() removes the bond.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
