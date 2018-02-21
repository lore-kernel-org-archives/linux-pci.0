Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 09/37] iommu/fault: Let handler return a fault response
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-10-jean-philippe.brucker@arm.com>
 <20180220151933.022f1036@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <11811f62-10d8-836c-f184-742d510bbdbc@arm.com>
Date: Wed, 21 Feb 2018 10:28:04 +0000
MIME-Version: 1.0
In-Reply-To: <20180220151933.022f1036@jacob-builder>
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

On 20/02/18 23:19, Jacob Pan wrote:
> On Mon, 12 Feb 2018 18:33:24 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>>  
>> +/**
>> + * enum page_response_code - Return status of fault handlers,
>> telling the IOMMU
>> + * driver how to proceed with the fault.
>> + *
>> + * @IOMMU_FAULT_STATUS_HANDLED: Stop processing the fault, and do
>> not send a
>> + *	reply to the device.
>> + * @IOMMU_FAULT_STATUS_CONTINUE: Fault was not handled. Call the
>> next handler,
>> + *	or terminate.
>> + * @IOMMU_FAULT_STATUS_SUCCESS: Fault has been handled and the page
>> tables
>> + *	populated, retry the access. This is "Success" in PCI PRI.
>> + * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent
>> faults from
>> + *	this device if possible. This is "Response Failure" in PCI
>> PRI.
>> + * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't
>> retry the
>> + *	access. This is "Invalid Request" in PCI PRI.
>> + */
>> +enum page_response_code {
>> +	IOMMU_PAGE_RESP_HANDLED = 0,
>> +	IOMMU_PAGE_RESP_CONTINUE,
>> +	IOMMU_PAGE_RESP_SUCCESS,
>> +	IOMMU_PAGE_RESP_INVALID,
>> +	IOMMU_PAGE_RESP_FAILURE,
>> +};
> it seems to me two things are mixed here:
> 1. driver handler response status (HANDLED, CONTINUE)
> 2. PCI standard page response code (the rest)
> Can we leave them separate? then we don't have to convert this enum
> to/from PCI ATS page response code.

Except when the producer is a platform device instead of PCI :) But I get
your point. I liked combining them into one enum because it may simplify
some device drivers. I can separate HANDLED/CONTINUE and have drivers
always call page_response().

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
