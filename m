Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 12 Oct 2017 14:47:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to
 and from devices
Message-ID: <20171012124738.r5lihlxaedwkw4oq@8bytes.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
 <20171011113348.GE30803@8bytes.org>
 <ee7f80e3-ca30-0ee7-53f3-3e57b2b58df6@arm.com>
MIME-Version: 1.0
In-Reply-To: <ee7f80e3-ca30-0ee7-53f3-3e57b2b58df6@arm.com>
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
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>,
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

Hi Jean-Philippe,

On Thu, Oct 12, 2017 at 12:13:20PM +0100, Jean-Philippe Brucker wrote:
> On 11/10/17 12:33, Joerg Roedel wrote:
> > Here is how I think the base API should look like:
> > 
> > 	* iommu_iovm_device_init(struct device *dev);
> > 	  iommu_iovm_device_shutdown(struct device *dev);
> > 
> > 	  These two functions do the device specific setup/shutdown. For
> > 	  PCI this would include enabling the PRI, PASID, and ATS
> > 	  capabilities and setting up a PASID table for the device.
> 
> Ok. On SMMU the PASID table also hosts the non-PASID page table pointer,
> so the table and capability cannot be setup later than attach_device (and
> we'll probably have to enable PASID in add_device). But I suppose it's an
> implementation detail.

Right, when the capabilities are enabled is an implementation detail of
the iommu-drivers. 

> Some device drivers will want to use ATS alone, for accelerating IOVA
> traffic. Should we enable it automatically, or provide device drivers with
> a way to enable it manually? According to the PCI spec, PASID has to be
> enabled before ATS, so device_init would have to first disable ATS in that
> case.

Yes, driver can enable ATS for normal use of a device, and
disable/re-enable it when the driver requests PASID/PRI functionality.
That is also an implementation detail. You should probably also document
that the init/shutdown functions may interrupt device operation, so that
driver writers are aware of that.

> 
> > 	* iommu_iovm_bind_mm(struct device *dev, struct mm_struct *mm,
> > 			     iovm_shutdown_cb *cb);
> > 	  iommu_iovm_unbind_mm(struct device *dev, struct mm_struct *mm);
> > 
> > 	  These functions add and delete the entries in the PASID table
> > 	  for the device and setup mmu_notifiers for the mm_struct to
> > 	  keep IOMMU TLBs in sync with the CPU TLBs.
> > 
> > 	  The shutdown_cb is invoked by the IOMMU core code when the
> > 	  mm_struct goes away, for example because the process
> > 	  segfaults.
> > 
> > 	The PASID handling is best done these functions as well, unless
> > 	there is a strong reason to allow device drivers to do the
> > 	handling themselves.
> > 
> > The context data can be stored directly in mm_struct, including the
> > PASID for that mm.
> 
> Changing mm_struct probably isn't required at the moment, since the mm
> subsystem won't use the context data or the PASID. Outside of
> drivers/iommu/, only the caller of bind_mm needs the PASID in order to
> program it into the device. The only advantage I see would be slightly
> faster bind(), when finding out if a mm is already bound to devices. But
> we don't really need fast bind(), so I don't think we'd have enough
> material to argue for a change in mm_struct.

The idea behind storing the PASID in mm_struct is that we have a
system-wide PASID-allocator and only one PASID per address space, even
when accessed from multiple devices.

There will be hardware implemenations where this is required, afaik. It
doesn't mean that it _needs_ to be part of mm_struct, but it is
certainly easier than tracking this 1-1 relation separatly.

> We do need to allocate a separate "iommu_mm_struct" wrapper to store the
> mmu_notifier. Maybe bind() could return this structure (that contains the
> PASID), and unbind() would take this iommu_mm_struct as argument?

I'd like to track this iommu_mm_struct only in iommu-code, otherwise
drivers need to track the pointer somewhere. And we need to track the
mm_struct->iommu_mm_struct relation anyway in core-code to handle events
like segfaults, when the whole mm_struct goes away under us. So when we
track this in core code, there is no need to track this again in the
device drivers.


Regards,

	Joerg


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
