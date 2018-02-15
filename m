Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
To: Joerg Roedel <joro@8bytes.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-2-jean-philippe.brucker@arm.com>
 <20180215095909.r4nwqjhuijusssuy@8bytes.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <69405fb7-7453-8575-e020-2ded7b2b92f5@arm.com>
Date: Thu, 15 Feb 2018 12:43:06 +0000
MIME-Version: 1.0
In-Reply-To: <20180215095909.r4nwqjhuijusssuy@8bytes.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
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
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 15/02/18 09:59, Joerg Roedel wrote:
> On Mon, Feb 12, 2018 at 06:33:16PM +0000, Jean-Philippe Brucker wrote:
>   
>> +config IOMMU_SVA
>> +	bool "Shared Virtual Addressing API for the IOMMU"
>> +	select IOMMU_API
>> +	help
>> +	  Enable process address space management for the IOMMU API. In systems
>> +	  that support it, device drivers can bind process address spaces to
>> +	  devices and share their page tables using this API.
>> +
>> +	  If unsure, say N here.
> 
> I think this should be an option selected by IOMMU driver and not be
> activly selectable by the user.

Ok

>> +/**
>> + * iommu_sva_device_shutdown() - Shutdown Shared Virtual Addressing for a device
>> + * @dev: the device
>> + *
>> + * Disable SVA. The device should not be performing any DMA while this function
>> + * is running.
> 
> Is this a good idea? How about devices that get hot-unplugged while
> processes still use them and there is DMA going back and forth? This
> function can be the point to shut down all ongoing stuff first and the
> shutdown the device.

To be honest I don't know how hot-unplug works. But sva_device_shutdown()
may be called, for instance, by the device driver before the device
disappears, so it has to know how to stop DMA before calling it. The IOMMU
driver can't really do anything more.

For hot-unplug I guess that device_driver::remove() is called first,
allowing it to stop all DMA and call sva_device_shutdown().

Then the IOMMU gets a BUS_NOTIFY_REMOVED_DEVICE notification and calls
iommu_ops::remove_device(), allowing to clean up SVA structure if the
device driver didn't call unbind_device() and sva_device_shutdown(). But
at that point we don't have a way to cooperate with the driver to stop DMA
anymore.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
