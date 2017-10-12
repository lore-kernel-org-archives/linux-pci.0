Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
To: Joerg Roedel <joro@8bytes.org>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "liubo95@huawei.com" <liubo95@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
 <20171011113348.GE30803@8bytes.org>
Message-ID: <ee7f80e3-ca30-0ee7-53f3-3e57b2b58df6@arm.com>
Date: Thu, 12 Oct 2017 12:13:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171011113348.GE30803@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,

On 11/10/17 12:33, Joerg Roedel wrote:
> Hi Jean-Philipe,
> 
> Thanks for your patches, this is definitly a step in the right direction
> to get generic support for IO virtual memory into the IOMMU core code.
> 
> But I see an issue with the design around task_struct, please see
> below.
> 
> On Fri, Oct 06, 2017 at 02:31:32PM +0100, Jean-Philippe Brucker wrote:
>> +int iommu_process_bind_device(struct device *dev, struct task_struct *task,
>> +			      int *pasid, int flags)
> 
> I just took this patch as an example, it is in the other patches as
> well. The code is designed around 'struct task_struct' while it should
> really be designed around 'struct mm_struct'. You are not attaching a
> specific process to a device, but the address-space of one or more
> processes. And that should be reflected in the design.

Agreed. The task struct is only really needed for obtaining the mm in my
code. It also keeps hold of a pid, but that's wrong and easy to remove.

> There are several bad implications of building it around task_struct,
> one is the life-time of the binding. If the address space is detached
> from the device when the process exits, only the thread that did the
> setup can can safely make use of the device, because if the device is
> accessed from another thread it will crash when the setup-thread exits.
> 
> There are other benefits of using mm_struct, for example that you can
> use mmu_notifiers to exit-handling.
> 
> Here is how I think the base API should look like:
> 
> 	* iommu_iovm_device_init(struct device *dev);
> 	  iommu_iovm_device_shutdown(struct device *dev);
> 
> 	  These two functions do the device specific setup/shutdown. For
> 	  PCI this would include enabling the PRI, PASID, and ATS
> 	  capabilities and setting up a PASID table for the device.

Ok. On SMMU the PASID table also hosts the non-PASID page table pointer,
so the table and capability cannot be setup later than attach_device (and
we'll probably have to enable PASID in add_device). But I suppose it's an
implementation detail.

Some device drivers will want to use ATS alone, for accelerating IOVA
traffic. Should we enable it automatically, or provide device drivers with
a way to enable it manually? According to the PCI spec, PASID has to be
enabled before ATS, so device_init would have to first disable ATS in that
case.

> 	* iommu_iovm_bind_mm(struct device *dev, struct mm_struct *mm,
> 			     iovm_shutdown_cb *cb);
> 	  iommu_iovm_unbind_mm(struct device *dev, struct mm_struct *mm);
> 
> 	  These functions add and delete the entries in the PASID table
> 	  for the device and setup mmu_notifiers for the mm_struct to
> 	  keep IOMMU TLBs in sync with the CPU TLBs.
> 
> 	  The shutdown_cb is invoked by the IOMMU core code when the
> 	  mm_struct goes away, for example because the process
> 	  segfaults.
> 
> 	The PASID handling is best done these functions as well, unless
> 	there is a strong reason to allow device drivers to do the
> 	handling themselves.
> 
> The context data can be stored directly in mm_struct, including the
> PASID for that mm.

Changing mm_struct probably isn't required at the moment, since the mm
subsystem won't use the context data or the PASID. Outside of
drivers/iommu/, only the caller of bind_mm needs the PASID in order to
program it into the device. The only advantage I see would be slightly
faster bind(), when finding out if a mm is already bound to devices. But
we don't really need fast bind(), so I don't think we'd have enough
material to argue for a change in mm_struct.

We do need to allocate a separate "iommu_mm_struct" wrapper to store the
mmu_notifier. Maybe bind() could return this structure (that contains the
PASID), and unbind() would take this iommu_mm_struct as argument?

Thanks
Jean
