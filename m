Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 06 Mar 2018 07:52:37 -0500
From: okaya@codeaurora.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 07/37] iommu: Add a page fault handler
In-Reply-To: <430e9754-4cf7-0aa8-7899-fc13e6a2e079@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
 <77afa195-4842-a112-eba5-409b861b5315@codeaurora.org>
 <430e9754-4cf7-0aa8-7899-fc13e6a2e079@arm.com>
Message-ID: <93dc46c9f4c9f5f6f9dc50c26333398b@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>, xieyisheng1@huawei.com,
 ilias.apalodimas@linaro.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 xuzaibo@huawei.com, jonathan.cameron@huawei.com,
 Will Deacon <Will.Deacon@arm.com>, yi.l.liu@intel.com,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, ashok.raj@intel.com,
 tn@semihalf.com, joro@8bytes.org, robdclark@gmail.com, bharatku@xilinx.com,
 linux-acpi@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>,
 rfranz@cavium.com, lenb@kernel.org, devicetree@vger.kernel.org,
 jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, robh+dt@kernel.org,
 thunder.leizhen@huawei.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, shunyong.yang@hxt-semitech.com,
 dwmw2@infradead.org, liubo95@huawei.com, rjw@rjwysocki.net,
 jcrouse@codeaurora.org, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, Sudeep Holla <Sudeep.Holla@arm.com>,
 linux-acpi-owner@vger.kernel.org, Robin Murphy <Robin.Murphy@arm.com>,
 christian.koenig@amd.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-03-06 05:46, Jean-Philippe Brucker wrote:
> On 05/03/18 21:53, Sinan Kaya wrote:
>> On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
>>> +static struct workqueue_struct *iommu_fault_queue;
>> 
>> Is there anyway we can make this fault queue per struct device?
>> Since this is common code, I think it needs some care.
> 
> I don't think it's better, the workqueue struct seems large. Maybe 
> having
> one wq per IOMMU is a good compromise?

Yes, one per iommu sounds reasonable.


As said in my other reply for this
> patch, doing so isn't completely straightforward. I'll consider adding 
> an
> iommu pointer to the iommu_param struct attached to each device.
> 
> Thanks,
> Jean
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
