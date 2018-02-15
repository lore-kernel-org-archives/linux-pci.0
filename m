Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 15 Feb 2018 13:49:41 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 07/37] iommu: Add a page fault handler
Message-ID: <2be857f1-cde2-a448-2bca-045f068396e7@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
 <20180213231821.5863ef99@jacob-builder>
MIME-Version: 1.0
In-Reply-To: <20180213231821.5863ef99@jacob-builder>
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
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
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

On 14/02/18 07:18, Jacob Pan wrote:
[...]
>> +/* Used to store incomplete fault groups */
>> +static LIST_HEAD(iommu_partial_faults);
>> +static DEFINE_SPINLOCK(iommu_partial_faults_lock);
>> +
> should partial fault list be per iommu?

That would be good, but I don't see an easy way to retrieve the iommu
instance in report_device_fault(). Maybe the driver should pass it to
report_device_fault(), and we can then store partial faults in struct
iommu_device.

[...]
>> +/**
>> + * iommu_report_device_fault() - Handle fault in device driver or mm
>> + *
>> + * If the device driver expressed interest in handling fault, report
>> it through
>> + * the callback. If the fault is recoverable, try to page in the
>> address.
>> + */
>> +int iommu_report_device_fault(struct device *dev, struct
>> iommu_fault_event *evt) +{
>> +	int ret = -ENOSYS;
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +
>> +	if (!domain)
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * if upper layers showed interest and installed a fault
>> handler,
>> +	 * invoke it.
>> +	 */
>> +	if (iommu_has_device_fault_handler(dev)) {
> I think Alex pointed out this is racy, so adding a mutex to the
> iommu_fault_param and acquire it would help. Do we really
> atomic handler?

Yes I think a few IOMMU drivers will call this function from IRQ context,
so a spinlock might be better for acquiring iommu_fault_param.

>> +		struct iommu_fault_param *param =
>> dev->iommu_param->fault_param; +
>> +		return param->handler(evt, param->data);
> Even upper layer (VFIO) registered handler to propagate PRQ to a guest
> to fault in the pages, we may still need to keep track of the page
> requests that need page response later, i.e. last page in group or
> stream request in vt-d. This will allow us sanitize the page response
> come back from the guest/VFIO.
> In my next round, I am adding a per device list under iommu_fault_param
> for pending page request. This will also address the situation where
> guest failed to send response. We can enforce time or credit limit of
> pending requests based on this list.

Sounds good

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
