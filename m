Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 21/36] iommu/arm-smmu-v3: Implement process
 operations
To: Yisheng Xie <xieyisheng1@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-22-jean-philippe.brucker@arm.com>
 <084b1848-0939-5e73-3890-3aab8dc4bc70@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <812aa54c-1cda-d4a4-640f-4aa2d8eb81fa@arm.com>
Date: Thu, 9 Nov 2017 12:08:59 +0000
MIME-Version: 1.0
In-Reply-To: <084b1848-0939-5e73-3890-3aab8dc4bc70@huawei.com>
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
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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

Hi,

On 09/11/17 03:32, Yisheng Xie wrote:
> Hi Jean,
> 
> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>> Hook process operations to support PASID and page table sharing with the
>> SMMUv3:
>>
>> +
>> +static void arm_smmu_process_exit(struct iommu_domain *domain,
>> +				  struct iommu_process *process)
>> +{
>> +	struct arm_smmu_master_data *master;
>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +
>> +	if (!domain->process_exit)
>> +		return;
> 
> If domain do not set process_exit handler, just return? smmu do not
> need invalid ATC, clear cd entry, etc.? Maybe you should check when
> call domain->process_exit?

Indeed, that doesn't make sense. I'll move the check below.

Thanks,
Jean

>> +
>> +	spin_lock(&smmu_domain->devices_lock);
>> +	list_for_each_entry(master, &smmu_domain->devices, list) {
>> +		if (!master->processes)
>> +			continue;
>> +
>> +		master->processes--;
> Add
> 		if (domain->process_exit)
> here?
>> +		domain->process_exit(domain, master->dev, process->pasid,
>> +				     domain->process_exit_token);
>> +
>> +		/* TODO: inval ATC */
>> +	}
>> +	spin_unlock(&smmu_domain->devices_lock);
>> +
>> +	arm_smmu_write_ctx_desc(smmu_domain, process->pasid, NULL);
>> +
>> +	/* TODO: Invalidate all mappings if not DVM */
>> +}
>> +
> Thanks
> Yisheng Xie
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
