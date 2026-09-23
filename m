Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F26CA4E;
	Wed, 23 Sep 2026 02:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131357; cv=none; b=JJKfe+0I3YNS6lg5mqqmGRgtgz0hvNkv6oZRZpBbBk9b4My3YhNEdX0hDbN18Gps8LilZX44Zp/7+YoIN2Yd2vv07yUM2/kppzRdR1gqnTwX212mreWgm2z/M6/6Ansb6nS2jyH8hw09dyRSLm/lp0kShHA+arnOlIHq7IkkDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131357; c=relaxed/simple;
	bh=IFBrc8JwH7fWhhDwOK0psqh+d1lB3YVMvd7QbKDUBYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITpLKo3AZeuBB3pbHfO1xJia+5kbt4rpam20ONgWQZQ/bZ9k8+9xV+6dSDSZtPmdg+ul7ihdyNdk4aI0uoUeOHAL3DOoV69tBTYBo5fhai9oqNzcrAtYdBQdHTDX/LPYNHhS4VRB18WnnaQzZgDZvdxwgrPOU6KdbjJerVmHUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dtQ7WEKo; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dtQ7WEKo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790131342; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/MPCMLWhVWed6lAuchXj9qWxjvfgii46TcRSsYW/BqE=;
	b=dtQ7WEKo/h/VKQJ15wQGH9aAHCLuN+TQVmenqErd+UYAbiji0SIt7pxFtfpJ69vjMNxN8uOV/rXtp9QDsN7kaFUDA4C4Bs8ZVdeMSuV4CZJ4UYCHk98ouFXEFAsjw165re1O6y9g0lXVlsoPmgATCs2HZNG2e/mDo6sfKxX3wtc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0XBVRu3C_1790131338;
Received: from 30.246.177.121(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XBVRu3C_1790131338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 10:42:19 +0800
Message-ID: <355969e6-aef1-41c8-8b0d-ad9cdc5c22c7@linux.alibaba.com>
Date: Wed, 23 Sep 2026 10:42:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/27] selftests/vfio: Add CXL Type-2 passthrough
 corner-case tests
To: Manish Honap <mhonap@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>,
 Srirangan Madhavan <smadhavan@nvidia.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "iweiny@kernel.org" <iweiny@kernel.org>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "dmatlack@google.com" <dmatlack@google.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>
Cc: Neo Jia <cjia@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
 <20260813093631.2288172-28-mhonap@nvidia.com>
 <8b6a3086-c491-4eff-938f-aecaac53b813@linux.alibaba.com>
 <IA1PR12MB90306A910BAD865421629212BDAE2@IA1PR12MB9030.namprd12.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <IA1PR12MB90306A910BAD865421629212BDAE2@IA1PR12MB9030.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/27/26 12:17 AM, Manish Honap wrote:
> 
> 
>> -----Original Message-----
>> From: Shuai Xue <xueshuai@linux.alibaba.com>
>> Sent: Wednesday, August 26, 2026 12:59 PM
>> To: Manish Honap <mhonap@nvidia.com>; alex@shazbot.org; jgg@ziepe.ca;
>> Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org; dave.jiang@intel.com;
>> alejandro.lucero-palau@amd.com; Srirangan Madhavan
>> <smadhavan@nvidia.com>; corbet@lwn.net; skhan@linuxfoundation.org;
>> dave@stgolabs.net; alison.schofield@intel.com; vishal.l.verma@intel.com;
>> iweiny@kernel.org; ming.li@zohomail.com; Yishai Hadas
>> <yishaih@nvidia.com>; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
>> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org
>> Cc: Neo Jia <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram
>> Sethi <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
>> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
>> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org
>> Subject: Re: [PATCH v4 27/27] selftests/vfio: Add CXL Type-2 passthrough
>> corner-case tests
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 8/13/26 5:36 PM, mhonap@nvidia.com wrote:
>>> From: Manish Honap <mhonap@nvidia.com>
>>>
>>> Exercise the vfio-cxl contract on a bound CXL Type-2 device: the two
>>> VFIO regions and the geometry capability, the HDM memory mmap
>>> (including a 2 MB huge fault), the dword-aligned trapped decoder
>>> block, and the lock-on-commit FSM. The decoder writes land in the
>>> per-open shadow and each test reopens the device, so the FSM tests repeat
>> cleanly.
>>>
>>> Cover the HDM memory two ways: a host-CPU load/store of the mmap, and
>>> the path a VMM actually uses, mmap plus a stage-2 IOAS map for the
>>> device's ATS access. The mmap flag is required for the IOAS path, so
>>> assert it is advertised rather than skipping when it is absent.
>>>
>>> Signed-off-by: Manish Honap <mhonap@nvidia.com>
>>> ---
>>>    MAINTAINERS                                   |   1 +
>>>    tools/testing/selftests/vfio/Makefile         |   1 +
>>>    .../selftests/vfio/lib/vfio_pci_device.c      |  57 +-
>>>    .../selftests/vfio/vfio_cxl_type2_test.c      | 799 ++++++++++++++++++
>>>    4 files changed, 855 insertions(+), 3 deletions(-)
>>>    create mode 100644
>>> tools/testing/selftests/vfio/vfio_cxl_type2_test.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS index
>>> b9361a8d618e..192b1681b3bd 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -28319,6 +28319,7 @@ L:    linux-cxl@vger.kernel.org
>>>    S:  Supported
>>>    F:  Documentation/driver-api/vfio-pci-cxl.rst
>>>    F:  drivers/vfio/pci/cxl/
>>> +F:   tools/testing/selftests/vfio/vfio_cxl_type2_test.c
>>>
>>>    VFIO DRIVER
>>>    M:  Alex Williamson <alex@shazbot.org> diff --git
>>> a/tools/testing/selftests/vfio/Makefile
>>> b/tools/testing/selftests/vfio/Makefile
>>> index 2c32c48db509..08f88e88cb4d 100644
>>> --- a/tools/testing/selftests/vfio/Makefile
>>> +++ b/tools/testing/selftests/vfio/Makefile
>>> @@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
>>>    TEST_GEN_PROGS += vfio_pci_device_init_perf_test
>>>    TEST_GEN_PROGS += vfio_pci_driver_test
>>>    TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
>>> +TEST_GEN_PROGS += vfio_cxl_type2_test
>>>
>>>    TEST_FILES += scripts/cleanup.sh
>>>    TEST_FILES += scripts/lib.sh
>>> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
>>> b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
>>> index 94dc5fcecbeb..ab49b41653c4 100644
>>> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
>>> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
>>> @@ -160,9 +160,31 @@ static void vfio_pci_region_get(struct
>> vfio_pci_device *device, int index,
>>>        ioctl_assert(device->fd, VFIO_DEVICE_GET_REGION_INFO, info);
>>>    }
>>>
>>> +/* Return the sparse-mmap capability in @info, or NULL if the region
>>> +has none. */ static struct vfio_region_info_cap_sparse_mmap *
>>> +vfio_pci_sparse_mmap_cap(struct vfio_region_info *info) {
>>> +     struct vfio_info_cap_header *hdr;
>>> +     u32 offset;
>>> +
>>> +     if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS))
>>> +             return NULL;
>>> +
>>> +     for (offset = info->cap_offset; offset; offset = hdr->next) {
>>> +             hdr = (void *)info + offset;
>>> +             if (hdr->id == VFIO_REGION_INFO_CAP_SPARSE_MMAP)
>>> +                     return (struct vfio_region_info_cap_sparse_mmap *)hdr;
>>> +     }
>>> +
>>> +     return NULL;
>>> +}
>>> +
>>>    static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
>>>    {
>>>        struct vfio_pci_bar *bar = &device->bars[index];
>>> +     struct vfio_region_info_cap_sparse_mmap *sparse;
>>> +     u8 infobuf[1024] = {};
>>> +     struct vfio_region_info *info = (void *)infobuf;
>>>        size_t align, size;
>>>        int prot = 0;
>>>        void *vaddr;
>>> @@ -190,9 +212,38 @@ static void vfio_pci_bar_map(struct
>> vfio_pci_device *device, int index)
>>>        align = min_t(size_t, size, SZ_1G);
>>>
>>>        vaddr = mmap_reserve(size, align, 0);
>>> -     bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
>>> -                       device->fd, bar->info.offset);
>>> -     VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
>>> +
>>> +     /*
>>> +      * A BAR that is only partially mmappable, such as a CXL Type-2
>> component
>>> +      * BAR with the HDM decoder block trapped, advertises the mmappable
>>> +      * ranges through a sparse-mmap capability. Map each area within the
>>> +      * reservation and leave the excluded ranges unmapped; mapping the
>> whole
>>> +      * BAR would be rejected.
>>> +      */
>>> +     info->argsz = sizeof(infobuf);
>>> +     info->index = index;
>>> +     ioctl_assert(device->fd, VFIO_DEVICE_GET_REGION_INFO, info);
>>> +     sparse = vfio_pci_sparse_mmap_cap(info);
>>> +     if (sparse) {
>>> +             u32 i;
>>> +
>>> +             bar->vaddr = vaddr;
>>> +             for (i = 0; i < sparse->nr_areas; i++) {
>>> +                     void *p;
>>> +
>>> +                     if (!sparse->areas[i].size)
>>> +                             continue;
>>> +                     p = mmap(vaddr + sparse->areas[i].offset,
>>> +                              sparse->areas[i].size, prot,
>>> +                              MAP_SHARED | MAP_FIXED, device->fd,
>>> +                              bar->info.offset + sparse->areas[i].offset);
>>> +                     VFIO_ASSERT_NE(p, MAP_FAILED);
>>> +             }
>>> +     } else {
>>> +             bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
>>> +                               device->fd, bar->info.offset);
>>> +             VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
>>> +     }
>>>
>>>        madvise(bar->vaddr, size, MADV_HUGEPAGE);
>>>    }
>>> diff --git a/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
>>> b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
>>> new file mode 100644
>>> index 000000000000..8c23ddd014ca
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
>>> @@ -0,0 +1,799 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * vfio_cxl_type2_test - corner-case tests for the vfio-cxl kernel contract.
>>> + *
>>> + * Exercises the user-visible surface the vfio-cxl module adds to a
>>> +CXL Type-2
>>> + * device: the two VFIO regions (HDM memory and the trapped HDM
>>> +decoder block),
>>> + * the component-register geometry capability, and the lock-on-commit
>>> +decoder
>>> + * FSM the kernel runs on the trapped block.
>>> + *
>>> + * Unlike a plain vfio-pci device the guest programs its own endpoint
>>> +decoder,
>>> + * so the trapped block enforces the commit handshake and freezes a
>>> +locked
>>> + * decoder. These tests drive that FSM directly. Writes to the
>>> +decoder block
>>> + * land in the per-open kernel shadow only, never on the physical
>>> +decoder, and
>>> + * each test reopens the device (fresh shadow), so the FSM tests are
>>> +safe to
>>> + * repeat and do not leak state between tests.
>>> + *
>>> + * Usage: ./vfio_cxl_type2_test <BDF>  (or export
>> VFIO_SELFTESTS_BDF=<BDF>).
>>> + * The device must be bound to vfio-pci with the vfio-cxl module available.
>>> + *
>>> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.
>>> + */
>>> +
>>> +#include <fcntl.h>
>>> +#include <stdint.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <unistd.h>
>>> +
>>> +#include <sys/ioctl.h>
>>> +#include <sys/mman.h>
>>> +
>>> +#include <linux/pci_regs.h>
>>> +#include <linux/sizes.h>
>>> +#include <linux/vfio.h>
>>> +
>>> +#include <cxl/cxl_regs.h>
>>> +
>>> +#include <libvfio.h>
>>> +
>>> +#include "kselftest_harness.h"
>>> +
>>> +#define PCI_DVSEC_VENDOR_ID_CXL              0x1e98
>>> +#define PCI_DVSEC_ID_CXL_DEVICE              0x0000
>>> +
>>> +/* CXL r3.1 8.1.9.1: Register Block Identifier for the component registers. */
>>> +#define CXL_REGLOC_RBI_COMPONENT     1
>>> +
>>> +/*
>>> + * Register Locator DVSEC block-1 field masks. The uapi pci_regs.h
>>> +names expand
>>> + * to __GENMASK(), which is not a macro in this userspace include
>>> +path, so use
>>> + * explicit values.
>>> + */
>>> +#define REG_LOCATOR_BIR_MASK         0x00000007
>>> +#define REG_LOCATOR_BLOCK_ID_MASK    0x0000ff00
>>> +#define REG_LOCATOR_BLOCK_OFF_LOW_MASK       0xffff0000
>>> +
>>> +/*
>>> + * vfio-pci's region-offset packing is kernel-internal
>>> +(vfio_pci_core.h), not
>>> + * UAPI. Define it locally; the guards let a future kernel hoist it to UAPI.
>>> + */
>>> +#ifndef VFIO_PCI_OFFSET_SHIFT
>>> +#define VFIO_PCI_OFFSET_SHIFT                40
>>> +#endif
>>> +#ifndef VFIO_PCI_INDEX_TO_OFFSET
>>> +#define VFIO_PCI_INDEX_TO_OFFSET(i)  ((uint64_t)(i) <<
>>> +VFIO_PCI_OFFSET_SHIFT) #endif
>>> +
>>> +static const char *device_bdf;
>>> +
>>> +/* Locate a region-info capability by id inside a GET_REGION_INFO
>>> +buffer. */ static const struct vfio_info_cap_header *
>>> +find_region_cap(const void *buf, size_t bufsz, uint16_t id) {
>>> +     const struct vfio_region_info *ri = buf;
>>> +     const struct vfio_info_cap_header *cap;
>>> +     size_t off = ri->cap_offset;
>>> +
>>> +     while (off && off + sizeof(*cap) <= bufsz) {
>>> +             cap = (const void *)((const char *)buf + off);
>>> +             if (cap->id == id)
>>> +                     return cap;
>>> +             off = cap->next;
>>> +     }
>>> +     return NULL;
>>> +}
>>> +
>>> +/*
>>> + * Find a CXL region by scanning every region's
>>> +VFIO_REGION_INFO_CAP_TYPE for
>>> + * the CXL type and the requested subtype. Returns the region index or -1.
>>> + * @buf is a caller scratch buffer left holding the matched region's
>>> +info
>>> + * (with caps).
>>> + */
>>> +static int find_cxl_region(int fd, uint32_t nregions, uint32_t subtype,
>>> +                        void *buf, size_t bufsz) {
>>> +     uint32_t i;
>>> +
>>> +     for (i = 0; i < nregions; i++) {
>>> +             struct vfio_region_info *ri = buf;
>>> +             const struct vfio_region_info_cap_type *t;
>>> +             const struct vfio_info_cap_header *hdr;
>>> +
>>> +             memset(buf, 0, bufsz);
>>> +             ri->argsz = bufsz;
>>> +             ri->index = i;
>>> +             if (ioctl(fd, VFIO_DEVICE_GET_REGION_INFO, ri))
>>> +                     continue;
>>> +             if (!(ri->flags & VFIO_REGION_INFO_FLAG_CAPS))
>>> +                     continue;
>>> +
>>> +             hdr = find_region_cap(buf, bufsz, VFIO_REGION_INFO_CAP_TYPE);
>>> +             if (!hdr)
>>> +                     continue;
>>> +             t = (const void *)hdr;
>>> +             if (t->type == VFIO_REGION_TYPE_CXL && t->subtype == subtype)
>>> +                     return i;
>>> +     }
>>> +     return -1;
>>> +}
>>> +
>>> +/* Walk the PCI extended capability list for the CXL Device DVSEC. */
>>> +static uint16_t find_cxl_dvsec(struct vfio_pci_device *dev) {
>>> +     uint16_t pos = PCI_CFG_SPACE_SIZE;
>>> +     int iter = 0;
>>> +
>>> +     while (pos && iter++ < 64) {
>>> +             uint32_t hdr = vfio_pci_config_readl(dev, pos);
>>> +             uint16_t cap_id = hdr & 0xffff;
>>> +             uint16_t next = (hdr >> 20) & 0xffc;
>>> +             uint32_t h1, h2;
>>> +
>>> +             if (cap_id == PCI_EXT_CAP_ID_DVSEC) {
>>> +                     h1 = vfio_pci_config_readl(dev, pos + 4);
>>> +                     h2 = vfio_pci_config_readl(dev, pos + 8);
>>> +                     if ((h1 & 0xffff) == PCI_DVSEC_VENDOR_ID_CXL &&
>>> +                         (h2 & 0xffff) == PCI_DVSEC_ID_CXL_DEVICE)
>>> +                             return pos;
>>> +             }
>>> +             pos = next;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +FIXTURE(vfio_cxl) {
>>> +     struct iommu *iommu;
>>> +     struct vfio_pci_device *dev;
>>> +
>>> +     int mem_idx;
>>> +     uint64_t mem_size;
>>> +     uint32_t mem_flags;
>>> +     int comp_idx;
>>> +     uint64_t comp_size;
>>> +     uint32_t comp_bar;
>>> +     uint64_t comp_offset;   /* HDM block offset within comp_bar */
>>> +     uint64_t comp_off;      /* mmap/rw base offset of the comp region */
>>> +     uint16_t dvsec;
>>> +};
>>> +
>>> +FIXTURE_SETUP(vfio_cxl)
>>> +{
>>> +     uint8_t infobuf[512] = {};
>>> +     struct vfio_device_info *info = (void *)infobuf;
>>> +     const struct vfio_region_info_cap_cxl_comp_regs *geo;
>>> +     const struct vfio_info_cap_header *hdr;
>>> +     uint8_t rbuf[1024];
>>> +
>>> +     self->iommu = iommu_init(default_iommu_mode);
>>> +     self->dev = vfio_pci_device_init(device_bdf, self->iommu);
>>> +
>>> +     info->argsz = sizeof(infobuf);
>>> +     ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_INFO, info));
>>> +
>>> +     if (!(info->flags & VFIO_DEVICE_FLAGS_CXL))
>>> +             SKIP(return, "not a CXL Type-2 device");
>>> +
>>> +     self->mem_idx = find_cxl_region(self->dev->fd, info->num_regions,
>>> +                                     VFIO_REGION_SUBTYPE_CXL_MEM,
>>> +                                     rbuf, sizeof(rbuf));
>>> +     ASSERT_GE(self->mem_idx, 0);
>>> +     self->mem_size = ((struct vfio_region_info *)rbuf)->size;
>>> +     self->mem_flags = ((struct vfio_region_info *)rbuf)->flags;
>>> +
>>> +     self->comp_idx = find_cxl_region(self->dev->fd, info->num_regions,
>>> +                                      VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
>>> +                                      rbuf, sizeof(rbuf));
>>> +     ASSERT_GE(self->comp_idx, 0);
>>> +     self->comp_size = ((struct vfio_region_info *)rbuf)->size;
>>> +
>>> +     /* The geometry cap rides on the component-register region. */
>>> +     hdr = find_region_cap(rbuf, sizeof(rbuf),
>>> +                           VFIO_REGION_INFO_CAP_CXL_COMP_REGS);
>>> +     ASSERT_NE(NULL, hdr);
>>> +     geo = (const void *)hdr;
>>> +     self->comp_bar = geo->bar;
>>> +     self->comp_offset = geo->offset;
>>> +
>>> +     self->comp_off = VFIO_PCI_INDEX_TO_OFFSET(self->comp_idx);
>>> +     self->dvsec = find_cxl_dvsec(self->dev); }
>>> +
>>> +FIXTURE_TEARDOWN(vfio_cxl)
>>> +{
>>> +     vfio_pci_device_cleanup(self->dev);
>>> +     iommu_cleanup(self->iommu);
>>> +}
>>> +
>>> +/* GET_INFO advertises the flag and both CXL regions with a sane
>>> +geometry cap. */ TEST_F(vfio_cxl, device_is_cxl) {
>>> +     ASSERT_NE(self->mem_idx, self->comp_idx);
>>> +     ASSERT_GT(self->mem_size, 0);
>>> +     ASSERT_GT(self->comp_size, 0);
>>> +     ASSERT_LT(self->comp_bar, PCI_STD_NUM_BARS);
>>> +     /* The HDM memory must advertise mmap; a VMM needs it for stage-2.
>> */
>>> +     ASSERT_NE(0, self->mem_flags & VFIO_REGION_INFO_FLAG_MMAP); }
>>> +
>>> +/*
>>> + * The component BAR carries the physical HDM decoder block, which
>>> +vfio traps
>>> + * and excludes from mmap so the guest cannot reprogram it directly.
>>> +Mapping the
>>> + * whole BAR must fail; mapping the ranges around the excluded block,
>>> +as the
>>> + * sparse-mmap capability advertises, must succeed.
>>> + */
>>> +TEST_F(vfio_cxl, comp_bar_sparse_mmap) {
>>> +     size_t page_size = getpagesize();
>>> +     uint8_t rbuf[1024] = {};
>>> +     struct vfio_region_info *ri = (void *)rbuf;
>>> +     const struct vfio_region_info_cap_sparse_mmap *sm;
>>> +     const struct vfio_info_cap_header *hdr;
>>> +     uint64_t bar_off, decoder_page;
>>> +     void *map;
>>> +     uint32_t i;
>>> +
>>> +     /* Region info for the component BAR, with capabilities. */
>>> +     ri->argsz = sizeof(rbuf);
>>> +     ri->index = self->comp_bar;
>>> +     ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, ri));
>>> +     ASSERT_NE(0, ri->flags & VFIO_REGION_INFO_FLAG_MMAP);
>>> +     bar_off = ri->offset;
>>> +
>>> +     /* The trapped decoder block splits the BAR, so it must be sparse. */
>>> +     hdr = find_region_cap(rbuf, sizeof(rbuf),
>>> +                           VFIO_REGION_INFO_CAP_SPARSE_MMAP);
>>> +     ASSERT_NE(NULL, hdr);
>>> +     sm = (const void *)hdr;
>>> +     ASSERT_GT(sm->nr_areas, 0);
>>> +
>>> +     /* Mapping the whole BAR must fail: it covers the excluded block. */
>>> +     map = mmap(NULL, ri->size, PROT_READ | PROT_WRITE, MAP_SHARED,
>>> +                self->dev->fd, bar_off);
>>> +     ASSERT_EQ(MAP_FAILED, map);
>>> +
>>> +     /* Every advertised area is page aligned and must map. */
>>> +     for (i = 0; i < sm->nr_areas; i++) {
>>> +             uint64_t ao = sm->areas[i].offset;
>>> +             uint64_t as = sm->areas[i].size;
>>> +
>>> +             if (!as)
>>> +                     continue;
>>> +             ASSERT_EQ(0, ao & (page_size - 1));
>>> +             ASSERT_EQ(0, as & (page_size - 1));
>>> +
>>> +             map = mmap(NULL, as, PROT_READ | PROT_WRITE, MAP_SHARED,
>>> +                        self->dev->fd, bar_off + ao);
>>> +             ASSERT_NE(MAP_FAILED, map);
>>> +             ASSERT_EQ(0, munmap(map, as));
>>> +     }
>>> +
>>> +     /* The page holding the decoder block must never be mmappable. */
>>> +     decoder_page = self->comp_offset & ~(uint64_t)(page_size - 1);
>>> +     map = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
>> MAP_SHARED,
>>> +                self->dev->fd, bar_off + decoder_page);
>>> +     ASSERT_EQ(MAP_FAILED, map);
>>> +}
>>> +
>>> +/* mmap one page of the HDM memory, write a pattern, read it back. */
>>> +TEST_F(vfio_cxl, hdm_mem_mmap_rw) {
>>> +     uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
>>> +     uint32_t pattern = 0xdeadbeefU, readback = 0;
>>> +     void *map;
>>> +
>>> +     if (self->mem_size < SZ_4K)
>>> +             SKIP(return, "HDM memory < 4K");
>>> +
>>> +     map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
>>> +                self->dev->fd, off);
>>> +     ASSERT_NE(MAP_FAILED, map);
>>> +
>>> +     memcpy(map, &pattern, sizeof(pattern));
>>> +     memcpy(&readback, map, sizeof(readback));
>>> +     ASSERT_EQ(pattern, readback);
>>> +
>>> +     ASSERT_EQ(0, munmap(map, SZ_4K)); }
>>> +
>>> +/*
>>> + * A 2 MB-aligned window should map as a huge (PMD) fault. The kernel
>>> +falls back
>>> + * to base pages when it cannot, so only correctness (write/read) is
>> asserted.
>>> + */
>>> +TEST_F(vfio_cxl, hdm_mem_huge_mmap)
>>> +{
>>> +     uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
>>> +     uint32_t pattern = 0x5a5a5a5aU, readback = 0;
>>> +     void *map, *last;
>>> +
>>> +     if (self->mem_size < SZ_2M)
>>> +             SKIP(return, "HDM memory < 2M");
>>> +
>>> +     map = mmap(NULL, SZ_2M, PROT_READ | PROT_WRITE, MAP_SHARED,
>>> +                self->dev->fd, off);
>>> +     ASSERT_NE(MAP_FAILED, map);
>>> +
>>> +     /* Touch the last dword so a 2 MB PMD fault covers the whole window.
>> */
>>> +     last = (char *)map + SZ_2M - sizeof(pattern);
>>> +     memcpy(last, &pattern, sizeof(pattern));
>>> +     memcpy(&readback, last, sizeof(readback));
>>> +     ASSERT_EQ(pattern, readback);
>>> +
>>> +     ASSERT_EQ(0, munmap(map, SZ_2M)); }
>>> +
>>> +/*
>>> + * A guest driver disables and re-enables PCI Memory-Space during
>>> +init and
>>> + * reset. The committed HDM decoder stays valid across that toggle,
>>> +so once
>>> + * Memory-Space is re-enabled the coherent HDM memory must be
>>> +reachable again
>>> + * without a reset. This is the regression test for the hdm_valid
>>> +access gate
>>> + * being cleared by a Memory-Space disable and never restored, which
>>> +left a
>>> + * later valid mmap fault wrongly SIGBUS-ing.
>>> + *
>>> + * The region is exercised only through the mmap path (as a VMM does)
>>> +and only
>>> + * while Memory-Space is enabled. An access with Memory-Space
>>> +disabled aborts
>>> + * on the fabric as a fatal host error, so the test never attempts
>>> +one: the
>>> + * toggle in between is pure config-space writes.
>>> + */
>>> +TEST_F(vfio_cxl, hdm_mem_survives_mem_space_toggle)
>>> +{
>>> +     uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
>>> +     uint32_t pattern = 0x12345678U, readback = 0;
>>> +     uint16_t cmd;
>>> +     void *map;
>>> +
>>> +     if (self->mem_size < SZ_4K)
>>> +             SKIP(return, "HDM memory < 4K");
>>> +
>>> +     /* Seed a known pattern through the mmap path with Memory-Space
>> on. */
>>> +     cmd = vfio_pci_config_readw(self->dev, PCI_COMMAND);
>>> +     vfio_pci_config_writew(self->dev, PCI_COMMAND,
>>> +                            cmd | PCI_COMMAND_MEMORY);
>>> +     map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
>>> +                self->dev->fd, off);
>>> +     ASSERT_NE(MAP_FAILED, map);
>>> +     memcpy(map, &pattern, sizeof(pattern));
>>> +     ASSERT_EQ(0, munmap(map, SZ_4K));
>>> +
>>> +     /*
>>> +      * Toggle Memory-Space off and back on with no HDM access in
>> between,
>>> +      * as a guest driver does during init/reset.
>>> +      */
>>> +     vfio_pci_config_writew(self->dev, PCI_COMMAND,
>>> +                            cmd & ~PCI_COMMAND_MEMORY);
>>> +     vfio_pci_config_writew(self->dev, PCI_COMMAND,
>>> +                            cmd | PCI_COMMAND_MEMORY);
>>> +
>>> +     /*
>>> +      * The committed decoder stayed valid across the toggle, so a fresh
>> mmap
>>> +      * fault succeeds and the seeded pattern reads back, without a reset.
>>> +      * Before the fix the gate was cleared by the disable and never restored,
>>> +      * so the fault wrongly SIGBUS-ed.
>>> +      */
>>> +     map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
>>> +                self->dev->fd, off);
>>> +     ASSERT_NE(MAP_FAILED, map);
>>> +     memcpy(&readback, map, sizeof(readback));
>>> +     ASSERT_EQ(pattern, readback);
>>> +     ASSERT_EQ(0, munmap(map, SZ_4K));
>>> +
>>> +     /* Restore PCI_COMMAND. */
>>> +     vfio_pci_config_writew(self->dev, PCI_COMMAND, cmd); }
>>> +
>>> +/*
>>> + * Mirror how a VMM uses the region: mmap the HDM memory and map it
>>> +into the
>>> + * IOAS (stage-2) so the device can reach it over ATS. The mmap flag
>>> +is required
>>> + * for that path, so its absence is a failure, not a skip. The host
>>> +CPU does not
>>> + * dereference the mapping; the guest reaches it through stage-2.
>>> + */
>>> +TEST_F(vfio_cxl, hdm_mem_ioas_map)
>>> +{
>>> +     uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
>>> +     struct iova_allocator *iova_alloc;
>>> +     struct dma_region region;
>>> +     void *map;
>>> +
>>> +     ASSERT_NE(0, self->mem_flags & VFIO_REGION_INFO_FLAG_MMAP);
>>> +
>>> +     /* iova_allocator_alloc() requires a power-of-2 size. */
>>> +     if (self->mem_size < SZ_2M)
>>> +             SKIP(return, "HDM memory < 2M");
>>> +
>>> +     map = mmap(NULL, SZ_2M, PROT_READ | PROT_WRITE, MAP_SHARED,
>>> +                self->dev->fd, off);
>>> +     ASSERT_NE(MAP_FAILED, map);
>>> +
>>> +     iova_alloc = iova_allocator_init(self->iommu);
>>> +     region.vaddr = map;
>>> +     region.size = SZ_2M;
>>> +     region.iova = iova_allocator_alloc(iova_alloc, SZ_2M);
>>> +
>>> +     iommu_map(self->iommu, &region);
>>
>> Hi Manish,
>>
>> We ran this series' selftests with a QEMU-emulated Type-2 device (pxb-cxl
>> host bridge, firmware-committed HDM decoder).  16 of the 17 tests pass; the
>> one failure is hdm_mem_ioas_map:
>>
>>   >      iova_alloc = iova_allocator_init(self->iommu);
>>   >      region.vaddr = map;
>>   >      region.size = SZ_2M;
>>   >      region.iova = iova_allocator_alloc(iova_alloc, SZ_2M);
>>   >
>>   >      iommu_map(self->iommu, &region);
>>
>> IOMMU_IOAS_MAP (the vaddr variant) on the mmap of the CXL_MEM region
>> fails with -EFAULT.  The path is:
>>
>>          iommufd_ioas_map()
>>            iopt_map_user_pages()
>>              pfn_reader_user_pin()
>>                pin_user_pages_fast()
>>                  check_vma_flags()               /* mm/gup.c */
>>                    if (vm_flags & (VM_IO | VM_PFNMAP))
>>                      return -EFAULT;
>>
>> The CXL_MEM region is struct-page-less device memory, so vfio_cxl_core.c
>> creates the VMA with VM_IO | VM_PFNMAP.  pin_user_pages() refuses such
>> VMAs outright and pfn_reader_user_pin() has no fallback, so with the current
>> upstream iommufd the vaddr variant of IOMMU_IOAS_MAP cannot map this
>> region at all, and the test's unconditional assertion fails.
>>
>> The test documents a real part of the contract (the mmap is what lets the
>> device reach its DPA through stage-2), so rather than have reviewers read this
>> as a series regression, maybe:
>>
>>     - tolerate the current upstream behavior: skip (or xfail) when
>>       IOMMU_IOAS_MAP fails with -EFAULT on the PFNMAP VMA, with a
>> comment
>>       that the vaddr path needs iommufd support for PFNMAP device memory;
>>       or
>>     - note the dependency in the cover letter.
>>
>> FWIW, the dmabuf variant does not offer a way around this today either:
>> VFIO_DEVICE_FEATURE_DMA_BUF only exports BARs, while the CXL_MEM
>> region is a vendor region backed by the resolved HPA window, so there is
>> currently no upstream path at all to IOAS-map the HDM memory from
>> userspace.  If the vaddr path is meant to work eventually, it might be worth
>> saying which side owns that (iommufd pin fallback vs. a dmabuf export for this
>> region).
>>
>> Everything else here works nicely, including the guest reset path and the HDM
>> shadow/commit FSM tests.
>>
>> Test setup, in case it helps reproduction:
>>
>>     - this series applied on an upstream-based tree
>>     - QEMU with pxb-cxl and an emulated Type-2 device whose decoder is
>>       firmware-committed at boot
>>     - result: 16/17 pass, hdm_mem_ioas_map fails with -EFAULT from
>>       pin_user_pages_fast()
>>
>> Thanks,
>> Shuai Xue
>>
> 
> Hello Shuai,
> 
> Thanks for applying the patch series with dependencies and running the tests.
> 
> My test tree carried an out-of-tree iommufd patch that adds a fallback to the
> exact function you point at, pfn_reader_user_pin(). When the gup pin fails on
> a VM_PFNMAP VMA, it follows the PFNs with follow_pfnmap_start()/fixup_user_fault()
> instead of pinning pages, and only for struct-page-less PFNs.
> With that in place the IOAS map succeeds; on a clean upstream tree like yours
> it correctly returns -EFAULT. I did mention this in the cover letter, but I should have
> provide more concrete details.
> 
> For v5 I will do both things you suggest:
> 
> - Make hdm_mem_ioas_map tolerant: call the non-asserting __iommu_map()
>    and SKIP/xfail on -EFAULT, with a comment that the vaddr path needs
>    iommufd support for struct-page-less device memory.
> - Note the dependency in the cover letter instead of leaving it implicit.
> - Include the dma-buf import implementation for CXL.mem and not run selftests
> With any out-of-tree patches.
> 
> I intend the final path for vfio-cxl series to be a dma-buf export of the CXL_MEM region,
> imported by iommufd, rather than an iommufd pin fallback.
> --
> 
> One request: could you please share which QEMU patches you used for the emulated
> Type-2 device? I would like to reproduce your exact setup.
> 
> Specifically:
> - which QEMU tree/branch and version
> - the device model you instantiated (for example cxl-type3 adapted, or an
> accelerator/Type-2 model, and how it advertises the CACHE + MEM DVSEC so
> vfio-cxl treats it as Type-2)
> - how the HDM decoder is firmware-committed at boot, and the full pxb-cxl /
> cxl-rp / CFMWS command line.
> 
> Thanks,
> Manish

Hi Manish,

Sorry for the late reply — this one slipped through my inbox.
Hope it's not too late.

Thanks for confirming — glad our read of the -EFAULT was right, and the
v5 plan (tolerant test + cover letter note + dma-buf import, tests run
without out-of-tree patches) sounds exactly right.  Making the CXL_MEM
region a dma-buf export and importing it through iommufd is also the
direction we'd like to see upstream, rather than growing the vaddr pin
path.

Happy to share the setup.  The device model is Zhi Wang's cxl-accel
from the zhiwang fork (QEMU 9.2, commit 3270075 "hw/cxl: introduce CXL
type-2 device emulation", with just volatile-memdev), forward-ported
onto current master keeping the original authorship and commit
message; on top of it we added the BAR enlargement and the
firmware pre-commit machinery, since the fork has no way to present a
firmware-committed decoder to the guest.  Details below.

QEMU tree
---------

   - Base: QEMU master close to v11.0.91 (aarch64-softmmu).  The branch
     lives at https://gitee.com/axiqia/qemu-kvm.git (branch
     cxl-type2-test, full history on top of upstream).
   - The commits on top of master:

       7f3a30f25 gitignore: pyvenv venv artifacts
       896d9ea7e hw/arm/smmu-common: Allow pxb-cxl as an SMMUv3 primary bus
                 (your v2 9/10, cherry-picked as-is; needed for the
                 iommufd path in the guest)
       d903ce222 hw/cxl: introduce CXL type-2 device emulation
                 (Zhi Wang's cxl-accel from the zhiwang fork, forward-
                 ported to master: component registers with HDM decoders
                 and a volatile memory backend)
       d6f8cf53c hw/mem/cxl_accel: Enlarge the component register BAR for
                 passthrough mmap (BAR 0x20000 with a device register
                 window after the component block, so a passthrough kernel
                 has an mmappable area to advertise as sparse mmap)
       b73e32964 hw/mem/cxl_accel: Pre-commit the HDM decoder as firmware
                 would (commit-hdm / hdm-base)
       8f72e34f4 hw/cxl: Give the component register .io sub-region
                 read-0 ops.  The .io sub-region of the component
                 register block was created with NULL ops, so any read of
                 the 0x0-0xFFF block returned unassigned -> bus
                 transaction failure (synchronous external abort in the
                 guest, ESR DFSC=0x10); real hardware returns 0 for
                 reserved registers, so we attach read-0/write-ignore ops.
                 This is what the selftest's comp_bar_rdwr_split test
                 tripped over.
       6e6de19bb hw/pci-bridge/pxb-cxl: Pre-commit the host bridge HDM
                 decoder (commit-hdm / hdm-base / hdm-size on pxb-cxl;
                 the host-bridge side of the machinery described below)
       afb2b75d0 hw/mem/cxl_accel: Advertise a Type-2 device with reset
                 support.  The DVSEC Type-2 advertisement (cap 0x19f:
                 cache + mem + 1 HDM + reset capable, ctrl 0x5) together
                 with the CXL reset handshake: a guest write of
                 INIT_CXL_RST to CTRL2 completes immediately and latches
                 RST_DONE in STATUS2, which the guest reset path of your
                 series needs.
       3a577f904 hw/mem/cxl_accel: Advertise a single HDM decoder
                 (DECODER_COUNT = 1, since the vfio Type-2 kernel side
                 only accepts single-decoder devices)

Device model
------------

cxl-accel, a dedicated Type-2 model (not an adapted cxl-type3):

   - PCIE_CXL_DEVICE_DVSEC with cap=0x19f (cache + mem + HDM, i.e. Type-2
     with CXL.cache), ctrl=0x5; the DVSEC block is created via
     CXL3_TYPE2_DEVICE.
   - Component register BAR of 0x20000 with the CXL component block at
     offset 0 and a device register window after it.
   - volatile-memdev supplies the DPA window (HBM stand-in).

Firmware-committed HDM decoder
------------------------------

This part is our addition (the fork cannot express it): both pxb-cxl
and cxl-accel carry a commit-hdm property; at machine init they
pre-commit HDM decoder 0 covering the CFMWS window / DPA range before
Linux boots (pxb-cxl gets hdm-base/hdm-size for the HB decoder;
cxl-accel's hdm-base must fall inside its volatile-memdev), with the
LOCK and COMMITTED bits set so Linux sees a firmware-committed decoder
right at enumeration.

The HB-side pre-commit matters: without it, pxb_cxl only hands out a
passthrough decoder with an empty HPA range under a single root port,
and region attach in the guest fails with BAR0 EBUSY (we hit this as
"all tests fail" before adding commit-hdm to the host bridge).

Reproducing from scratch
------------------------

Everything below was rebuilt from zero and re-verified end to end
(2026-08-27); the 16/17 result is stable across a full clean rebuild
of QEMU, kernel, modules and the selftest binary.

   - Kernel: the ANCK-based tree carrying your v4 27/27 backport,
     https://gitee.com/axiqia/cloud-kernel.git (branch
     cxl-type2-pr2-lore).  Build with:
         make headers && make -j$(nproc) Image.gz modules
         make -C tools/testing/selftests TARGETS=vfio
     (make headers first is required; it exports cxl/cxl_regs.h into
     usr/include, which vfio_cxl_type2_test.c includes.)
   - QEMU: the whole tree is pushed as a full-history branch, ready to
     clone:
         git clone -b cxl-type2-test https://gitee.com/axiqia/qemu-kvm.git
         cd qemu-kvm && mkdir build && cd build
         ../configure --target-list=aarch64-softmmu && make -j$(nproc)
     The branch carries complete upstream history with the 9 patches
     on top (tip 3a577f904).  If you prefer patches over a clone, the
     same 9 commits also apply cleanly with git am onto upstream
     master at 6333226c2.
   - Guest: a minimal busybox initramfs carrying the 17 modules the
     stack needs (einj, libnvdimm, cxl_*, dax_*, iommufd, vfio, and
     vfio-cxl between vfio-pci-core and vfio-pci), the selftest
     binary, and a static busybox with devmem.  The init script loads
     modules in dependency order (busybox modprobe does not resolve
     modules.dep), enables PCI_COMMAND_MEMORY through ECAM as noted
     below, binds the device to vfio-pci and runs the test binary
     directly.
   - The CFMWS base discovery dry-run and the final invocation are in
     run_v3_test_dbg.sh; the full recipe (initramfs assembly included)
     is captured in reproduce.sh / build-initramfs.sh alongside it.

Command line (aarch64)
----------------------

   -M virt,cxl=on,gic-version=3,accel=tcg,cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=256M \
   -cpu max -smp 4 -m 4G \
   -bios /usr/share/AAVMF/AAVMF_CODE.fd \
   -kernel Image.gz -initrd cxl-initramfs.cpio.gz \
   -append "console=ttyAMA0,115200 earlycon=pl011,0x9000000" \
   -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=1,commit-hdm=on,hdm-base=0x<BASE>,hdm-size=256M \
   -device arm-smmuv3,primary-bus=cxl.0 \
   -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
   -object memory-backend-ram,id=vmem0,size=256M \
   -device cxl-accel,id=accel0,bus=rp0,addr=0.0,volatile-memdev=vmem0,commit-hdm=on,hdm-base=0x<BASE>

Notes:

   - <BASE> is the auto-assigned CFMWS window base; we discover it with a
     paused dry-run ("info mtree", grep cxl-fixed-memory-region) and then
     pass the same value to both commit-hdm instances.  If you always run
     with the same guest RAM size it is stable, but reading it out keeps
     the script robust.
   - The guest runs a minimal initramfs; the test binary runs directly
     from init.  One initramfs detail for the selftest: the kernel probes
     the device before the guest driver binds, and PCI_COMMAND_MEMORY is
     off at that point, so the init script enables it through the ECAM
     window (devmem write to the command register) before running the
     test, matching what a real guest OS does when it binds a driver.
   - arm-smmuv3 on the pxb-cxl primary bus is what makes the iommufd
     IOAS path reachable inside the guest.

With this setup the series works nicely for us: 16/17 on a clean
upstream-based tree (the expected hdm_mem_ioas_map -EFAULT), and the
same tree passes everything else, including the guest reset path, the
HDM shadow/commit FSM, and the huge-fault path.

One more data point you may find useful for v5: we also ran your v2-era
SAUCE stack (NVIDIA 26.04 kernel + the zhiwang QEMU fork) on aarch64 as
a sanity baseline, where all 11 of its vfio_cxl tests pass, so the
forward-ported model above is exercising the same contract.

Thanks,
Shuai Xue


