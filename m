Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 09/36] iommu/fault: Allow blocking fault handlers
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-10-jean-philippe.brucker@arm.com>
 <7e1c8ea4-e568-1000-17de-62f8562c7169@huawei.com>
 <74891e35-17d8-5831-1ebd-18e00ce00d74@arm.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <3156bbca-e588-5c57-6df6-05bf9c25c747@huawei.com>
Date: Thu, 30 Nov 2017 10:45:36 +0800
MIME-Version: 1.0
In-Reply-To: <74891e35-17d8-5831-1ebd-18e00ce00d74@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, Lorenzo
 Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

hi jean,

On 2017/11/29 23:01, Jean-Philippe Brucker wrote:
> Hello,
> 
> On 29/11/17 06:15, Yisheng Xie wrote:
>> Hi Jean,
>>
>> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>>> -	if (domain->ext_handler) {
>>> +	if (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC) {
>>> +		fault->flags |= IOMMU_FAULT_ATOMIC;
>>
>> Why remove the condition of domain->ext_handler? should it be much better like:
>>   if ((domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC) && domain->ext_handler)
>>
>> If domain->ext_handler is NULL, and (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC)
>> is true. It will oops, right?
> 
> I removed the check because ext_handler shouldn't be NULL if handler_flags
> has a bit set (as per iommu_set_ext_fault_handler). But you're right that
> this is fragile, and I overlooked the case where users could call
> set_ext_fault_handler to clear the fault handler.
> 
> (Note that this ext_handler will most likely be replaced by the fault
> infrastructure that Jacob is working on:
> https://patchwork.kernel.org/patch/10063385/ to which we should add the
> atomic/blocking flags)
> 

Get it, thanks for your explanation.

Thanks
Yisheng Xie

> Thanks,
> Jean
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
