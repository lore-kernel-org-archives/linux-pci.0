Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
To: Sinan Kaya <okaya@codeaurora.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
 <683a518d-0e22-c855-2416-2e097ec3291d@codeaurora.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <146ab3f9-6031-fba8-6aea-86e392ad7ec5@arm.com>
Date: Thu, 2 Nov 2017 16:21:17 +0000
MIME-Version: 1.0
In-Reply-To: <683a518d-0e22-c855-2416-2e097ec3291d@codeaurora.org>
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
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
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

On 21/10/17 16:47, Sinan Kaya wrote:
> Just some improvement suggestions.
> 
> On 10/6/2017 9:31 AM, Jean-Philippe Brucker wrote:
>> +	spin_lock(&iommu_process_lock);
>> +	idr_for_each_entry(&iommu_process_idr, process, i) {
>> +		if (process->pid != pid)
>> +			continue;
> if you see this construct a lot, this could be a for_each_iommu_process.
> 
>> +
>> +		if (!iommu_process_get_locked(process)) {
>> +			/* Process is defunct, create a new one */
>> +			process = NULL;
>> +			break;
>> +		}
>> +
>> +		/* Great, is it also bound to this domain? */
>> +		list_for_each_entry(cur_context, &process->domains,
>> +				    process_head) {
>> +			if (cur_context->domain != domain)
>> +				continue;
> if you see this construct a lot, this could be a for_each_iommu_process_domain.
> 
>> +
>> +			context = cur_context;
>> +			*pasid = process->pasid;
>> +
>> +			/* Splendid, tell the driver and increase the ref */
>> +			err = iommu_process_attach_locked(context, dev);
>> +			if (err)
>> +				iommu_process_put_locked(process);
>> +
>> +			break;
>> +		}
>> +		break;
>> +	}
>> +	spin_unlock(&iommu_process_lock);
>> +	put_pid(pid);
>> +
>> +	if (context)
>> +		return err;
> 
> I think you should make the section above a independent function and return here when the
> context is found.

Hopefully this code will only be needed for bind(), but moving it to a
separate function should look better.

Thanks,
Jean


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
