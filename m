Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
To: Xu Zaibo <xuzaibo@huawei.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-14-jean-philippe.brucker@arm.com>
 <5B83B11E.7010807@huawei.com> <1d5b6529-4e5a-723c-3f1b-dd5a9adb490c@arm.com>
 <5B89F818.7060300@huawei.com> <3a961aff-e830-64bb-b6a9-14e08de1abf5@arm.com>
 <5B8DEA15.7020404@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <bc27f902-4d12-21b7-b9e9-18bcae170503@arm.com>
Date: Tue, 4 Sep 2018 11:57:02 +0100
MIME-Version: 1.0
In-Reply-To: <5B8DEA15.7020404@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
 fanghao11 <fanghao11@huawei.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 wangzhou1 <wangzhou1@hisilicon.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "rgummal@xilinx.com" <rgummal@xilinx.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 =?UTF-8?B?57Gz57Gz?= <kenneth-lee-2012@foxmail.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 04/09/2018 03:12, Xu Zaibo wrote:
> On 2018/9/3 18:34, Jean-Philippe Brucker wrote:
>> On 01/09/18 03:23, Xu Zaibo wrote:
>>> As one application takes a whole function while using VFIO-PCI, why do
>>> the application and the
>>> function need to enable PASID capability? (Since just one I/O page table
>>> is enough for them.)
>> At the moment the series doesn't provide support for SVA without PASID
>> (on the I/O page fault path, 08/40). In addition the BIND ioctl could be
>> used by the owner application to bind other processes (slaves) and
>> perform sub-assignment. But that feature is incomplete because we don't
>> send stop_pasid notification to the owner when a slave dies.
>>
> So, Could I understand like this?
> 
>      1. While the series are finished well, VFIO-PCI device can be held 
> by only one process
>          through binding IOCTL command without PASID (without PASID 
> being exposed user space).

It could, but isn't supported at the moment. In addition to adding
support in the I/O page fault code, we'd also need to update the VFIO
API. Currently a VFIO_TYPE1 domain always supports the MAP/UNMAP ioctl.
The case you describe isn't compatible with MAP/UNMAP, since the process
manages the shared address space with mmap or malloc. We'd probably need
to introduce a new VFIO IOMMU type, in which case the bind could be
performed implicitly when the process does VFIO_SET_IOMMU. Then the
process wouldn't need to send an additional BIND IOCTL.

>      2. While using VFIO-PCI device to support multiple processes with 
> SVA series, a primary
>          process with multiple secondary processes must be deployed just 
> like DPDK(https://www.dpdk.org/).
>          And, the PASID still has to be exposed to user land.

Right. A third case, also implemented by this patch (and complete), is
the primary process simply doing a BIND for itself, and using the
returned PASID to share its own address space with the device.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
