Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bob Liu <liubo95@huawei.com>
Subject: Re: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yisheng Xie
 <xieyisheng1@huawei.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
 <0fecd29e-eaf7-9503-b087-7bfbc251da88@arm.com>
 <c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
 <8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
Message-ID: <79f3610e-e522-29ad-8a93-be7e05df2973@huawei.com>
Date: Wed, 8 Nov 2017 09:21:50 +0800
MIME-Version: 1.0
In-Reply-To: <8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
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
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>, Lorenzo
 Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

On 2017/10/12 20:55, Jean-Philippe Brucker wrote:
> On 12/10/17 13:05, Yisheng Xie wrote:
> [...]
>>>>> * An iommu_process can be bound to multiple domains, and a domain can have
>>>>>   multiple iommu_process.
>>>> when bind a task to device, can we create a single domain for it? I am thinking
>>>> about process management without shared PT(for some device only support PASID
>>>> without pri ability), it seems hard to expand if a domain have multiple iommu_process?
>>>> Do you have any idea about this?
>>>
>>> A device always has to be in a domain, as far as I know. Not supporting
>>> PRI forces you to pin down all user mappings (or just the ones you use for
>>> DMA) but you should sill be able to share PT. Now if you don't support
>>> shared PT either, but only PASID, then you'll have to use io-pgtable and a
>>> new map/unmap API on an iommu_process. I don't understand your concern
>>> though, how would the link between process and domains prevent this use-case?
>>>
>> So you mean that if an iommu_process bind to multiple devices it should create
>> multiple io-pgtables? or just share the same io-pgtable?
> 
> I don't know to be honest, I haven't thought much about the io-pgtable
> case, I'm all about sharing the mm :)
> 

Sorry to get back to this thread, but traditional DMA_MAP use case may also want to
enable Substreamid/PASID.
As a general framework, you may also consider SubStreamid/Pasid support for dma map/io-pgtable.

We're considering make io-pgtables per SubStreamid/Pasid, but haven't decide put all 
io-pgtables into a single domain or iommu_process.

Thanks,
Liubo

> It really depends on what the user (GPU driver I assume) wants. I think
> that if you're not sharing an mm with the device, then you're trying to
> hide parts of the process to the device, so you'd also want the
> flexibility of having different io-pgtables between devices. Different
> devices accessing isolated parts of the process requires separate io-pgtables.
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
