Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
To: Xu Zaibo <xuzaibo@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-mm@kvack.org
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-14-jean-philippe.brucker@arm.com>
 <5B83B11E.7010807@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <1d5b6529-4e5a-723c-3f1b-dd5a9adb490c@arm.com>
Date: Fri, 31 Aug 2018 14:34:52 +0100
MIME-Version: 1.0
In-Reply-To: <5B83B11E.7010807@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: xieyisheng1@huawei.com, liubo95@huawei.com, thunder.leizhen@huawei.com,
 will.deacon@arm.com, okaya@codeaurora.org, liguozhu <liguozhu@hisilicon.com>,
 fanghao11 <fanghao11@huawei.com>, yi.l.liu@intel.com, ashok.raj@intel.com,
 tn@semihalf.com, joro@8bytes.org, wangzhou1 <wangzhou1@hisilicon.com>,
 bharatku@xilinx.com, liudongdong3@huawei.com, rfranz@cavium.com,
 kevin.tian@intel.com, jacob.jun.pan@linux.intel.com, jcrouse@codeaurora.org,
 rgummal@xilinx.com, jonathan.cameron@huawei.com,
 =?UTF-8?B?57Gz57Gz?= <kenneth-lee-2012@foxmail.com>,
 shunyong.yang@hxt-semitech.com, dwmw2@infradead.org,
 ilias.apalodimas@linaro.org, alex.williamson@redhat.com, robdclark@gmail.com,
 robin.murphy@arm.com, christian.koenig@amd.com, nwatters@codeaurora.org,
 baolu.lu@linux.intel.com
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Zaibo,

On 27/08/18 09:06, Xu Zaibo wrote:
>> +struct vfio_iommu_type1_bind_process {
>> +=A0=A0=A0 __u32=A0=A0=A0 flags;
>> +#define VFIO_IOMMU_BIND_PID=A0=A0=A0=A0=A0=A0=A0 (1 << 0)
>> +=A0=A0=A0 __u32=A0=A0=A0 pasid;
> As I am doing some works on the SVA patch set. I just consider why the
> user space need this pasid.
> Maybe, is it much more reasonable to set the pasid into all devices
> under the vfio container by
> a call back function from 'vfio_devices'=A0 while
> 'VFIO_IOMMU_BIND_PROCESS' CMD is executed
> in kernel land? I am not sure because there exists no suitable call back
> in 'vfio_device' at present.

When using vfio-pci, the kernel doesn't know how to program the PASID
into the device because the only kernel driver for the device is the
generic vfio-pci module. The PCI specification doesn't describe a way of
setting up the PASID, it's vendor-specific. Only the userspace
application owning the device (and calling VFIO_IOMMU_BIND) knows how to
do it, so we return the allocated PASID.

Note that unlike vfio-mdev where applications share slices of a
function, with vfio-pci one application owns the whole function so it's
safe to let userspace set the PASID in hardware. With vfio-mdev it's the
kernel driver that should be in charge of setting the PASID as you
described, and we wouldn't have a reason to return the PASID in the
vfio_iommu_type1_bind_process structure.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
