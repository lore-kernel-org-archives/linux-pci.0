Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0772e71e-4861-1e7b-f248-88aaba8bf2fc@codeaurora.org>
Date: Thu, 18 Jan 2018 23:52:03 -0500
MIME-Version: 1.0
In-Reply-To: <20171006133203.22803-6-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, gabriele.paoloni@huawei.com,
 catalin.marinas@arm.com, will.deacon@arm.com, yi.l.liu@intel.com,
 lorenzo.pieralisi@arm.com, ashok.raj@intel.com, tn@semihalf.com,
 joro@8bytes.org, rfranz@cavium.com, lenb@kernel.org,
 jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, robh+dt@kernel.org,
 thunder.leizhen@huawei.com, bhelgaas@google.com, dwmw2@infradead.org,
 liubo95@huawei.com, rjw@rjwysocki.net, robdclark@gmail.com,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean-Philippe,

On 10/6/2017 9:31 AM, Jean-Philippe Brucker wrote:
>  /**
> + * iommu_process_bind_device - Bind a process address space to a device
> + * @dev: the device
> + * @task: the process to bind
> + * @pasid: valid address where the PASID will be stored
> + * @flags: bond properties (IOMMU_PROCESS_BIND_*)
> + *
> + * Create a bond between device and task, allowing the device to access the
> + * process address space using the returned PASID.
> + *
> + * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
> + * is returned.
> + */
> +int iommu_process_bind_device(struct device *dev, struct task_struct *task,
> +			      int *pasid, int flags)

This API doesn't play nice with endpoint device drivers that have PASID limitations.

The AMD driver seems to have PASID limitations per product that are not being
advertised in the PCI capability.

device_iommu_pasid_init()
{
        pasid_limit = min_t(unsigned int,
                        (unsigned int)(1 << kfd->device_info->max_pasid_bits),
                        iommu_info.max_pasids);
        /*
         * last pasid is used for kernel queues doorbells
         * in the future the last pasid might be used for a kernel thread.
         */
        pasid_limit = min_t(unsigned int,
                                pasid_limit,
                                kfd->doorbell_process_limit - 1);
}

kfd->device_info->max_pasid_bits seems to contain per device limitations.

Would you be willing to extend the API so that the requester can impose some limit
on the PASID value that is getting allocated.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
