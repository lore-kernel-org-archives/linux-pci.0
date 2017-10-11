Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 11 Oct 2017 13:33:48 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to
 and from devices
Message-ID: <20171011113348.GE30803@8bytes.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171006133203.22803-6-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean-Philipe,

Thanks for your patches, this is definitly a step in the right direction
to get generic support for IO virtual memory into the IOMMU core code.

But I see an issue with the design around task_struct, please see
below.

On Fri, Oct 06, 2017 at 02:31:32PM +0100, Jean-Philippe Brucker wrote:
> +int iommu_process_bind_device(struct device *dev, struct task_struct *task,
> +			      int *pasid, int flags)

I just took this patch as an example, it is in the other patches as
well. The code is designed around 'struct task_struct' while it should
really be designed around 'struct mm_struct'. You are not attaching a
specific process to a device, but the address-space of one or more
processes. And that should be reflected in the design.

There are several bad implications of building it around task_struct,
one is the life-time of the binding. If the address space is detached
from the device when the process exits, only the thread that did the
setup can can safely make use of the device, because if the device is
accessed from another thread it will crash when the setup-thread exits.

There are other benefits of using mm_struct, for example that you can
use mmu_notifiers to exit-handling.

Here is how I think the base API should look like:

	* iommu_iovm_device_init(struct device *dev);
	  iommu_iovm_device_shutdown(struct device *dev);

	  These two functions do the device specific setup/shutdown. For
	  PCI this would include enabling the PRI, PASID, and ATS
	  capabilities and setting up a PASID table for the device.

	* iommu_iovm_bind_mm(struct device *dev, struct mm_struct *mm,
			     iovm_shutdown_cb *cb);
	  iommu_iovm_unbind_mm(struct device *dev, struct mm_struct *mm);

	  These functions add and delete the entries in the PASID table
	  for the device and setup mmu_notifiers for the mm_struct to
	  keep IOMMU TLBs in sync with the CPU TLBs.

	  The shutdown_cb is invoked by the IOMMU core code when the
	  mm_struct goes away, for example because the process
	  segfaults.

	The PASID handling is best done these functions as well, unless
	there is a strong reason to allow device drivers to do the
	handling themselves.

The context data can be stored directly in mm_struct, including the
PASID for that mm.

There is of course more functionality needed, the above only outlines
the very basic needs.


Regards,

	Joerg

