Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42236 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969317AbeEXLo5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 07:44:57 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
To: Xu Zaibo <xuzaibo@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org
Cc: will.deacon@arm.com, okaya@codeaurora.org,
        liguozhu <liguozhu@hisilicon.com>, ashok.raj@intel.com,
        bharatku@xilinx.com, rfranz@cavium.com, rgummal@xilinx.com,
        dwmw2@infradead.org, ilias.apalodimas@linaro.org,
        christian.koenig@amd.com
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-14-jean-philippe.brucker@arm.com>
 <5B0536A3.1000304@huawei.com>
Message-ID: <cd13f60d-b282-3804-4ca7-2d34476c597f@arm.com>
Date: Thu, 24 May 2018 12:44:47 +0100
MIME-Version: 1.0
In-Reply-To: <5B0536A3.1000304@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 23/05/18 10:38, Xu Zaibo wrote:
>> +static int vfio_iommu_bind_group(struct vfio_iommu *iommu,
>> +                 struct vfio_group *group,
>> +                 struct vfio_mm *vfio_mm)
>> +{
>> +    int ret;
>> +    bool enabled_sva = false;
>> +    struct vfio_iommu_sva_bind_data data = {
>> +        .vfio_mm    = vfio_mm,
>> +        .iommu        = iommu,
>> +        .count        = 0,
>> +    };
>> +
>> +    if (!group->sva_enabled) {
>> +        ret = iommu_group_for_each_dev(group->iommu_group, NULL,
>> +                           vfio_iommu_sva_init);
> Do we need to do *sva_init here or do anything to avoid repeated
> initiation?
> while another process already did initiation at this device, I think
> that current process will get an EEXIST.

Right, sva_init() must be called once for any device that intends to use
bind(). For the second process though, group->sva_enabled will be true
so we won't call sva_init() again, only bind().

Thanks,
Jean
