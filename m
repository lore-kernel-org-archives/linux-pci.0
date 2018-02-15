Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 15 Feb 2018 13:51:34 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 08/37] iommu/fault: Handle mm faults
Message-ID: <800c2efe-10d7-5711-37d6-fb45df9b6e5c@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-9-jean-philippe.brucker@arm.com>
 <20180214104621.7675579c@jacob-builder>
MIME-Version: 1.0
In-Reply-To: <20180214104621.7675579c@jacob-builder>
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

On 14/02/18 18:46, Jacob Pan wrote:
> On Mon, 12 Feb 2018 18:33:23 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
[...]
>> +	if (!evt->pasid_valid)
>> +		return ret;
> I guess for not we don't handle PRQ without PASID, right?

No. I'm not sure how to implement it, though there have been some requests
(see discussion on 1/37)

>> +	/*
>> +	 * Special case: PASID Stop Marker (LRW = 0b100) doesn't
>> expect a
>> +	 * response. A Stop Marker may be generated when disabling a
>> PASID
>> +	 * (issuing a PASID stop request) in some PCI devices.
>> +	 *
>> +	 * When the mm_exit() callback returns from the device
>> driver, no page
>> +	 * request is generated for this PASID anymore and
>> outstanding ones have
>> +	 * been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
>> and 10.4.1.2 -
>> +	 * Managing PASID TLP Prefix Usage). Some PCI devices will
>> wait for all
>> +	 * outstanding page requests to come back with a response
>> before
>> +	 * completing the PASID stop request. Others do not wait for
>> page
>> +	 * responses, and instead issue this Stop Marker that tells
>> us when the
>> +	 * PASID can be reallocated.
>> +	 *
>> +	 * We ignore the Stop Marker because:
>> +	 * a. Page requests, which are posted requests, have been
>> flushed to the
>> +	 *    IOMMU when mm_exit() returns,
>> +	 * b. We flush all fault queues after mm_exit() returns and
>> before
>> +	 *    freeing the PASID.
>> +	 *
>> +	 * So even though the Stop Marker might be issued by the
>> device *after*
>> +	 * the stop request completes, outstanding faults will have
>> been dealt
>> +	 * with by the time we free the PASID.
>> +	 */
>> +	if (evt->last_req &&
>> +	    !(evt->prot & (IOMMU_FAULT_READ | IOMMU_FAULT_WRITE)))
>> +		return IOMMU_PAGE_RESP_HANDLED;
>> +
> If we don't expect a page response, shouldn't it be filtered by the
> IOMMU vendor driver in the first place? i.e. in the vendor IOMMU driver
> PRQ handler, it will sanitize the request anyway, for anything that
> does not need response, it will not call iommu_report_device_fault().

Right, we're not doing anything with the stop marker anyway. This encoding
is also specific to PCI PRI, and maybe in future architectures, LRW =
0b100 will mean something else and will require a response. So filtering
it in the IOMMU driver makes more sense.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
