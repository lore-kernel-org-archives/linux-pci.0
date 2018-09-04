Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
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
CC: "joro@8bytes.org" <joro@8bytes.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "liubo95@huawei.com" <liubo95@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
        "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        "rgummal@xilinx.com" <rgummal@xilinx.com>,
        =?UTF-8?B?57Gz57Gz?= <kenneth-lee-2012@foxmail.com>,
        wangzhou1 <wangzhou1@hisilicon.com>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        fanghao11 <fanghao11@huawei.com>
From: Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <5B8DEA15.7020404@huawei.com>
Date: Tue, 4 Sep 2018 10:12:37 +0800
MIME-Version: 1.0
In-Reply-To: <3a961aff-e830-64bb-b6a9-14e08de1abf5@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2018/9/3 18:34, Jean-Philippe Brucker wrote:
> On 01/09/18 03:23, Xu Zaibo wrote:
>> As one application takes a whole function while using VFIO-PCI, why do
>> the application and the
>> function need to enable PASID capability? (Since just one I/O page table
>> is enough for them.)
> At the moment the series doesn't provide support for SVA without PASID
> (on the I/O page fault path, 08/40). In addition the BIND ioctl could be
> used by the owner application to bind other processes (slaves) and
> perform sub-assignment. But that feature is incomplete because we don't
> send stop_pasid notification to the owner when a slave dies.
>
So, Could I understand like this?

     1. While the series are finished well, VFIO-PCI device can be held 
by only one process
         through binding IOCTL command without PASID (without PASID 
being exposed user space).

     2. While using VFIO-PCI device to support multiple processes with 
SVA series, a primary
         process with multiple secondary processes must be deployed just 
like DPDK(https://www.dpdk.org/).
         And, the PASID still has to be exposed to user land.


Thanks,
Zaibo

.
