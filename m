Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
To: "Raj, Ashok" <ashok.raj@intel.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <A2975661238FB949B60364EF0F2C257439AFD88A@SHSMSX104.ccr.corp.intel.com>
 <7aaf9851-9546-f34d-1496-cbeea404abbd@arm.com>
 <20171025180546.GA12356@otc-nc-03>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <5c48f76c-d139-76a5-c4e5-ac40cf2bd5ea@arm.com>
Date: Mon, 30 Oct 2017 10:28:05 +0000
MIME-Version: 1.0
In-Reply-To: <20171025180546.GA12356@otc-nc-03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "tn@semihalf.com" <tn@semihalf.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
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
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 25/10/17 19:05, Raj, Ashok wrote:
> Hi Jean
> 
> On Mon, Oct 23, 2017 at 01:17:07PM +0100, Jean-Philippe Brucker wrote:
>> On 23/10/17 12:04, Liu, Yi L wrote:
>>>> +	idr_preload(GFP_KERNEL);
>>>> +	spin_lock(&iommu_process_lock);
>>>> +	pasid = idr_alloc_cyclic(&iommu_process_idr, process, domain->min_pasid,
>>>> +				 domain->max_pasid + 1, GFP_ATOMIC);
>>>> +	process->pasid = pasid;
>>>
>>> [Liu, Yi L] If I'm understanding well, here is managing the pasid allocation in iommu
>>> layer instead of vendor iommu driver? Is there strong reason here? I think pasid
>>> management may be better within vendor iommu driver as pasid management
>>> could differ from vendor to vendor.
>>
>> But that's the thing, we're trying to abstract PASID and process
>> management to have it in the core, because there shouldn't be many
>> differences from vendor to vendor. This way we have the allocation code in
>> one place and vendor drivers don't have to copy paste it from other drivers.
> 
> I think this makes sense for the native case and also in the vIOMMU
> if the PASID tables and allocation are completely managed by the guest.
> 
> If the vIOMMU requires any co-ordination in how the PASID's are allocated
> for guest devices there might need to be some control on how these are 
> allocated that ultimately need to be managed by VMM/Physical IOMMU. For 
> instance if the PASID space is sparse for e.g

(I don't have your example)

> if we make the PASID allocation as one of the ops, the IOMMU implementation
> will choose the default function, or if it choose a differnt mechanism it would
> have that flexibility.
> 
> Does this make sense?

If the PASID space is sparse, maybe we can add a firmware or probe
mechanism to declare reserved PASIDs, like we have for reserved IOVAs,
that feeds into the core IOMMU driver. But I agree that we can always let
vendor drivers implement their own allocator if they need one in the
future. For the moment it can stay generic.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
