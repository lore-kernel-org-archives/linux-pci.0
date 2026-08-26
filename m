Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93883603EF;
	Wed, 26 Aug 2026 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729350; cv=none; b=LiXS9BB+7TDJxp5jxy7D4kuYgvQTeEV5cKluvQrRQJbh5qmUs2ehEStDHhAYxPY4keCMHf/6seYTvBS55+XWaFrWPz7eenfJBI1wcMKxNFcLRtnpMyIOmr+YH68e/vSlPrr+IZmGQZ/+QGUegkcG23YLvPOJVqyMYKpGypqo1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729350; c=relaxed/simple;
	bh=BTS7cCx4O4uC0vcXYnOZ04ZyijMCsrCoiK4dOxVeFoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WG55LdGfn4zSWYglMy00u1DClt6cdjl4UDIbHoRo5fpYbv/DONx7kQjEmjMq85vzu4KqTUXoan0ACYU657K3Ps6b/BtCXN2gzsAxqnWAQ37nrjTJd5rLdJ2eFWDaoId10RU+KH/W4Im5ESbon5Tw54kFQ8Q30NyzIDfbJ5hIh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qOcMuhG+; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qOcMuhG+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787729342; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qJJFpSNIIr6zjViebMv+RLyJbu4NfLTUdMxdk3Rub7Q=;
	b=qOcMuhG+r+9e3dXKYR1/2G55RAiWctIZpwPVeqEbkOmk7DyLIzFLKNPdeI5aTvw9U2IoC0d1Q37kpdt/u0N1Hk6py6HpZ5WY9t0PZQQ8SdNrKOlLpUKVg65tu3lYBxuVS7kjjuUI+wPqD/OXwS5vqFfNGuPduyWX4z93Qg6BpIk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0X9gBsuz_1787729338;
Received: from 30.246.160.219(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X9gBsuz_1787729338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Aug 2026 15:29:00 +0800
Message-ID: <8b6a3086-c491-4eff-938f-aecaac53b813@linux.alibaba.com>
Date: Wed, 26 Aug 2026 15:28:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/27] selftests/vfio: Add CXL Type-2 passthrough
 corner-case tests
To: mhonap@nvidia.com, alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com,
 jic23@kernel.org, dave.jiang@intel.com, alejandro.lucero-palau@amd.com,
 smadhavan@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org,
 dave@stgolabs.net, alison.schofield@intel.com, vishal.l.verma@intel.com,
 iweiny@kernel.org, ming.li@zohomail.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, bhelgaas@google.com,
 dmatlack@google.com, kees@kernel.org, gustavoars@kernel.org
Cc: cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260813093631.2288172-1-mhonap@nvidia.com>
 <20260813093631.2288172-28-mhonap@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260813093631.2288172-28-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 5:36 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Exercise the vfio-cxl contract on a bound CXL Type-2 device: the two VFIO
> regions and the geometry capability, the HDM memory mmap (including a 2 MB
> huge fault), the dword-aligned trapped decoder block, and the
> lock-on-commit FSM. The decoder writes land in the per-open shadow and
> each test reopens the device, so the FSM tests repeat cleanly.
> 
> Cover the HDM memory two ways: a host-CPU load/store of the mmap, and the
> path a VMM actually uses, mmap plus a stage-2 IOAS map for the device's
> ATS access. The mmap flag is required for the IOAS path, so assert it is
> advertised rather than skipping when it is absent.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>   MAINTAINERS                                   |   1 +
>   tools/testing/selftests/vfio/Makefile         |   1 +
>   .../selftests/vfio/lib/vfio_pci_device.c      |  57 +-
>   .../selftests/vfio/vfio_cxl_type2_test.c      | 799 ++++++++++++++++++
>   4 files changed, 855 insertions(+), 3 deletions(-)
>   create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b9361a8d618e..192b1681b3bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28319,6 +28319,7 @@ L:	linux-cxl@vger.kernel.org
>   S:	Supported
>   F:	Documentation/driver-api/vfio-pci-cxl.rst
>   F:	drivers/vfio/pci/cxl/
> +F:	tools/testing/selftests/vfio/vfio_cxl_type2_test.c
>   
>   VFIO DRIVER
>   M:	Alex Williamson <alex@shazbot.org>
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 2c32c48db509..08f88e88cb4d 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -13,6 +13,7 @@ TEST_GEN_PROGS += vfio_pci_device_test
>   TEST_GEN_PROGS += vfio_pci_device_init_perf_test
>   TEST_GEN_PROGS += vfio_pci_driver_test
>   TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
> +TEST_GEN_PROGS += vfio_cxl_type2_test
>   
>   TEST_FILES += scripts/cleanup.sh
>   TEST_FILES += scripts/lib.sh
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 94dc5fcecbeb..ab49b41653c4 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -160,9 +160,31 @@ static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
>   	ioctl_assert(device->fd, VFIO_DEVICE_GET_REGION_INFO, info);
>   }
>   
> +/* Return the sparse-mmap capability in @info, or NULL if the region has none. */
> +static struct vfio_region_info_cap_sparse_mmap *
> +vfio_pci_sparse_mmap_cap(struct vfio_region_info *info)
> +{
> +	struct vfio_info_cap_header *hdr;
> +	u32 offset;
> +
> +	if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS))
> +		return NULL;
> +
> +	for (offset = info->cap_offset; offset; offset = hdr->next) {
> +		hdr = (void *)info + offset;
> +		if (hdr->id == VFIO_REGION_INFO_CAP_SPARSE_MMAP)
> +			return (struct vfio_region_info_cap_sparse_mmap *)hdr;
> +	}
> +
> +	return NULL;
> +}
> +
>   static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
>   {
>   	struct vfio_pci_bar *bar = &device->bars[index];
> +	struct vfio_region_info_cap_sparse_mmap *sparse;
> +	u8 infobuf[1024] = {};
> +	struct vfio_region_info *info = (void *)infobuf;
>   	size_t align, size;
>   	int prot = 0;
>   	void *vaddr;
> @@ -190,9 +212,38 @@ static void vfio_pci_bar_map(struct vfio_pci_device *device, int index)
>   	align = min_t(size_t, size, SZ_1G);
>   
>   	vaddr = mmap_reserve(size, align, 0);
> -	bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
> -			  device->fd, bar->info.offset);
> -	VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
> +
> +	/*
> +	 * A BAR that is only partially mmappable, such as a CXL Type-2 component
> +	 * BAR with the HDM decoder block trapped, advertises the mmappable
> +	 * ranges through a sparse-mmap capability. Map each area within the
> +	 * reservation and leave the excluded ranges unmapped; mapping the whole
> +	 * BAR would be rejected.
> +	 */
> +	info->argsz = sizeof(infobuf);
> +	info->index = index;
> +	ioctl_assert(device->fd, VFIO_DEVICE_GET_REGION_INFO, info);
> +	sparse = vfio_pci_sparse_mmap_cap(info);
> +	if (sparse) {
> +		u32 i;
> +
> +		bar->vaddr = vaddr;
> +		for (i = 0; i < sparse->nr_areas; i++) {
> +			void *p;
> +
> +			if (!sparse->areas[i].size)
> +				continue;
> +			p = mmap(vaddr + sparse->areas[i].offset,
> +				 sparse->areas[i].size, prot,
> +				 MAP_SHARED | MAP_FIXED, device->fd,
> +				 bar->info.offset + sparse->areas[i].offset);
> +			VFIO_ASSERT_NE(p, MAP_FAILED);
> +		}
> +	} else {
> +		bar->vaddr = mmap(vaddr, size, prot, MAP_SHARED | MAP_FIXED,
> +				  device->fd, bar->info.offset);
> +		VFIO_ASSERT_NE(bar->vaddr, MAP_FAILED);
> +	}
>   
>   	madvise(bar->vaddr, size, MADV_HUGEPAGE);
>   }
> diff --git a/tools/testing/selftests/vfio/vfio_cxl_type2_test.c b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
> new file mode 100644
> index 000000000000..8c23ddd014ca
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_cxl_type2_test.c
> @@ -0,0 +1,799 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vfio_cxl_type2_test - corner-case tests for the vfio-cxl kernel contract.
> + *
> + * Exercises the user-visible surface the vfio-cxl module adds to a CXL Type-2
> + * device: the two VFIO regions (HDM memory and the trapped HDM decoder block),
> + * the component-register geometry capability, and the lock-on-commit decoder
> + * FSM the kernel runs on the trapped block.
> + *
> + * Unlike a plain vfio-pci device the guest programs its own endpoint decoder,
> + * so the trapped block enforces the commit handshake and freezes a locked
> + * decoder. These tests drive that FSM directly. Writes to the decoder block
> + * land in the per-open kernel shadow only, never on the physical decoder, and
> + * each test reopens the device (fresh shadow), so the FSM tests are safe to
> + * repeat and do not leak state between tests.
> + *
> + * Usage: ./vfio_cxl_type2_test <BDF>  (or export VFIO_SELFTESTS_BDF=<BDF>).
> + * The device must be bound to vfio-pci with the vfio-cxl module available.
> + *
> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.
> + */
> +
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +
> +#include <linux/pci_regs.h>
> +#include <linux/sizes.h>
> +#include <linux/vfio.h>
> +
> +#include <cxl/cxl_regs.h>
> +
> +#include <libvfio.h>
> +
> +#include "kselftest_harness.h"
> +
> +#define PCI_DVSEC_VENDOR_ID_CXL		0x1e98
> +#define PCI_DVSEC_ID_CXL_DEVICE		0x0000
> +
> +/* CXL r3.1 8.1.9.1: Register Block Identifier for the component registers. */
> +#define CXL_REGLOC_RBI_COMPONENT	1
> +
> +/*
> + * Register Locator DVSEC block-1 field masks. The uapi pci_regs.h names expand
> + * to __GENMASK(), which is not a macro in this userspace include path, so use
> + * explicit values.
> + */
> +#define REG_LOCATOR_BIR_MASK		0x00000007
> +#define REG_LOCATOR_BLOCK_ID_MASK	0x0000ff00
> +#define REG_LOCATOR_BLOCK_OFF_LOW_MASK	0xffff0000
> +
> +/*
> + * vfio-pci's region-offset packing is kernel-internal (vfio_pci_core.h), not
> + * UAPI. Define it locally; the guards let a future kernel hoist it to UAPI.
> + */
> +#ifndef VFIO_PCI_OFFSET_SHIFT
> +#define VFIO_PCI_OFFSET_SHIFT		40
> +#endif
> +#ifndef VFIO_PCI_INDEX_TO_OFFSET
> +#define VFIO_PCI_INDEX_TO_OFFSET(i)	((uint64_t)(i) << VFIO_PCI_OFFSET_SHIFT)
> +#endif
> +
> +static const char *device_bdf;
> +
> +/* Locate a region-info capability by id inside a GET_REGION_INFO buffer. */
> +static const struct vfio_info_cap_header *
> +find_region_cap(const void *buf, size_t bufsz, uint16_t id)
> +{
> +	const struct vfio_region_info *ri = buf;
> +	const struct vfio_info_cap_header *cap;
> +	size_t off = ri->cap_offset;
> +
> +	while (off && off + sizeof(*cap) <= bufsz) {
> +		cap = (const void *)((const char *)buf + off);
> +		if (cap->id == id)
> +			return cap;
> +		off = cap->next;
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * Find a CXL region by scanning every region's VFIO_REGION_INFO_CAP_TYPE for
> + * the CXL type and the requested subtype. Returns the region index or -1.
> + * @buf is a caller scratch buffer left holding the matched region's info
> + * (with caps).
> + */
> +static int find_cxl_region(int fd, uint32_t nregions, uint32_t subtype,
> +			   void *buf, size_t bufsz)
> +{
> +	uint32_t i;
> +
> +	for (i = 0; i < nregions; i++) {
> +		struct vfio_region_info *ri = buf;
> +		const struct vfio_region_info_cap_type *t;
> +		const struct vfio_info_cap_header *hdr;
> +
> +		memset(buf, 0, bufsz);
> +		ri->argsz = bufsz;
> +		ri->index = i;
> +		if (ioctl(fd, VFIO_DEVICE_GET_REGION_INFO, ri))
> +			continue;
> +		if (!(ri->flags & VFIO_REGION_INFO_FLAG_CAPS))
> +			continue;
> +
> +		hdr = find_region_cap(buf, bufsz, VFIO_REGION_INFO_CAP_TYPE);
> +		if (!hdr)
> +			continue;
> +		t = (const void *)hdr;
> +		if (t->type == VFIO_REGION_TYPE_CXL && t->subtype == subtype)
> +			return i;
> +	}
> +	return -1;
> +}
> +
> +/* Walk the PCI extended capability list for the CXL Device DVSEC. */
> +static uint16_t find_cxl_dvsec(struct vfio_pci_device *dev)
> +{
> +	uint16_t pos = PCI_CFG_SPACE_SIZE;
> +	int iter = 0;
> +
> +	while (pos && iter++ < 64) {
> +		uint32_t hdr = vfio_pci_config_readl(dev, pos);
> +		uint16_t cap_id = hdr & 0xffff;
> +		uint16_t next = (hdr >> 20) & 0xffc;
> +		uint32_t h1, h2;
> +
> +		if (cap_id == PCI_EXT_CAP_ID_DVSEC) {
> +			h1 = vfio_pci_config_readl(dev, pos + 4);
> +			h2 = vfio_pci_config_readl(dev, pos + 8);
> +			if ((h1 & 0xffff) == PCI_DVSEC_VENDOR_ID_CXL &&
> +			    (h2 & 0xffff) == PCI_DVSEC_ID_CXL_DEVICE)
> +				return pos;
> +		}
> +		pos = next;
> +	}
> +	return 0;
> +}
> +
> +FIXTURE(vfio_cxl) {
> +	struct iommu *iommu;
> +	struct vfio_pci_device *dev;
> +
> +	int mem_idx;
> +	uint64_t mem_size;
> +	uint32_t mem_flags;
> +	int comp_idx;
> +	uint64_t comp_size;
> +	uint32_t comp_bar;
> +	uint64_t comp_offset;	/* HDM block offset within comp_bar */
> +	uint64_t comp_off;	/* mmap/rw base offset of the comp region */
> +	uint16_t dvsec;
> +};
> +
> +FIXTURE_SETUP(vfio_cxl)
> +{
> +	uint8_t infobuf[512] = {};
> +	struct vfio_device_info *info = (void *)infobuf;
> +	const struct vfio_region_info_cap_cxl_comp_regs *geo;
> +	const struct vfio_info_cap_header *hdr;
> +	uint8_t rbuf[1024];
> +
> +	self->iommu = iommu_init(default_iommu_mode);
> +	self->dev = vfio_pci_device_init(device_bdf, self->iommu);
> +
> +	info->argsz = sizeof(infobuf);
> +	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_INFO, info));
> +
> +	if (!(info->flags & VFIO_DEVICE_FLAGS_CXL))
> +		SKIP(return, "not a CXL Type-2 device");
> +
> +	self->mem_idx = find_cxl_region(self->dev->fd, info->num_regions,
> +					VFIO_REGION_SUBTYPE_CXL_MEM,
> +					rbuf, sizeof(rbuf));
> +	ASSERT_GE(self->mem_idx, 0);
> +	self->mem_size = ((struct vfio_region_info *)rbuf)->size;
> +	self->mem_flags = ((struct vfio_region_info *)rbuf)->flags;
> +
> +	self->comp_idx = find_cxl_region(self->dev->fd, info->num_regions,
> +					 VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
> +					 rbuf, sizeof(rbuf));
> +	ASSERT_GE(self->comp_idx, 0);
> +	self->comp_size = ((struct vfio_region_info *)rbuf)->size;
> +
> +	/* The geometry cap rides on the component-register region. */
> +	hdr = find_region_cap(rbuf, sizeof(rbuf),
> +			      VFIO_REGION_INFO_CAP_CXL_COMP_REGS);
> +	ASSERT_NE(NULL, hdr);
> +	geo = (const void *)hdr;
> +	self->comp_bar = geo->bar;
> +	self->comp_offset = geo->offset;
> +
> +	self->comp_off = VFIO_PCI_INDEX_TO_OFFSET(self->comp_idx);
> +	self->dvsec = find_cxl_dvsec(self->dev);
> +}
> +
> +FIXTURE_TEARDOWN(vfio_cxl)
> +{
> +	vfio_pci_device_cleanup(self->dev);
> +	iommu_cleanup(self->iommu);
> +}
> +
> +/* GET_INFO advertises the flag and both CXL regions with a sane geometry cap. */
> +TEST_F(vfio_cxl, device_is_cxl)
> +{
> +	ASSERT_NE(self->mem_idx, self->comp_idx);
> +	ASSERT_GT(self->mem_size, 0);
> +	ASSERT_GT(self->comp_size, 0);
> +	ASSERT_LT(self->comp_bar, PCI_STD_NUM_BARS);
> +	/* The HDM memory must advertise mmap; a VMM needs it for stage-2. */
> +	ASSERT_NE(0, self->mem_flags & VFIO_REGION_INFO_FLAG_MMAP);
> +}
> +
> +/*
> + * The component BAR carries the physical HDM decoder block, which vfio traps
> + * and excludes from mmap so the guest cannot reprogram it directly. Mapping the
> + * whole BAR must fail; mapping the ranges around the excluded block, as the
> + * sparse-mmap capability advertises, must succeed.
> + */
> +TEST_F(vfio_cxl, comp_bar_sparse_mmap)
> +{
> +	size_t page_size = getpagesize();
> +	uint8_t rbuf[1024] = {};
> +	struct vfio_region_info *ri = (void *)rbuf;
> +	const struct vfio_region_info_cap_sparse_mmap *sm;
> +	const struct vfio_info_cap_header *hdr;
> +	uint64_t bar_off, decoder_page;
> +	void *map;
> +	uint32_t i;
> +
> +	/* Region info for the component BAR, with capabilities. */
> +	ri->argsz = sizeof(rbuf);
> +	ri->index = self->comp_bar;
> +	ASSERT_EQ(0, ioctl(self->dev->fd, VFIO_DEVICE_GET_REGION_INFO, ri));
> +	ASSERT_NE(0, ri->flags & VFIO_REGION_INFO_FLAG_MMAP);
> +	bar_off = ri->offset;
> +
> +	/* The trapped decoder block splits the BAR, so it must be sparse. */
> +	hdr = find_region_cap(rbuf, sizeof(rbuf),
> +			      VFIO_REGION_INFO_CAP_SPARSE_MMAP);
> +	ASSERT_NE(NULL, hdr);
> +	sm = (const void *)hdr;
> +	ASSERT_GT(sm->nr_areas, 0);
> +
> +	/* Mapping the whole BAR must fail: it covers the excluded block. */
> +	map = mmap(NULL, ri->size, PROT_READ | PROT_WRITE, MAP_SHARED,
> +		   self->dev->fd, bar_off);
> +	ASSERT_EQ(MAP_FAILED, map);
> +
> +	/* Every advertised area is page aligned and must map. */
> +	for (i = 0; i < sm->nr_areas; i++) {
> +		uint64_t ao = sm->areas[i].offset;
> +		uint64_t as = sm->areas[i].size;
> +
> +		if (!as)
> +			continue;
> +		ASSERT_EQ(0, ao & (page_size - 1));
> +		ASSERT_EQ(0, as & (page_size - 1));
> +
> +		map = mmap(NULL, as, PROT_READ | PROT_WRITE, MAP_SHARED,
> +			   self->dev->fd, bar_off + ao);
> +		ASSERT_NE(MAP_FAILED, map);
> +		ASSERT_EQ(0, munmap(map, as));
> +	}
> +
> +	/* The page holding the decoder block must never be mmappable. */
> +	decoder_page = self->comp_offset & ~(uint64_t)(page_size - 1);
> +	map = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> +		   self->dev->fd, bar_off + decoder_page);
> +	ASSERT_EQ(MAP_FAILED, map);
> +}
> +
> +/* mmap one page of the HDM memory, write a pattern, read it back. */
> +TEST_F(vfio_cxl, hdm_mem_mmap_rw)
> +{
> +	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
> +	uint32_t pattern = 0xdeadbeefU, readback = 0;
> +	void *map;
> +
> +	if (self->mem_size < SZ_4K)
> +		SKIP(return, "HDM memory < 4K");
> +
> +	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
> +		   self->dev->fd, off);
> +	ASSERT_NE(MAP_FAILED, map);
> +
> +	memcpy(map, &pattern, sizeof(pattern));
> +	memcpy(&readback, map, sizeof(readback));
> +	ASSERT_EQ(pattern, readback);
> +
> +	ASSERT_EQ(0, munmap(map, SZ_4K));
> +}
> +
> +/*
> + * A 2 MB-aligned window should map as a huge (PMD) fault. The kernel falls back
> + * to base pages when it cannot, so only correctness (write/read) is asserted.
> + */
> +TEST_F(vfio_cxl, hdm_mem_huge_mmap)
> +{
> +	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
> +	uint32_t pattern = 0x5a5a5a5aU, readback = 0;
> +	void *map, *last;
> +
> +	if (self->mem_size < SZ_2M)
> +		SKIP(return, "HDM memory < 2M");
> +
> +	map = mmap(NULL, SZ_2M, PROT_READ | PROT_WRITE, MAP_SHARED,
> +		   self->dev->fd, off);
> +	ASSERT_NE(MAP_FAILED, map);
> +
> +	/* Touch the last dword so a 2 MB PMD fault covers the whole window. */
> +	last = (char *)map + SZ_2M - sizeof(pattern);
> +	memcpy(last, &pattern, sizeof(pattern));
> +	memcpy(&readback, last, sizeof(readback));
> +	ASSERT_EQ(pattern, readback);
> +
> +	ASSERT_EQ(0, munmap(map, SZ_2M));
> +}
> +
> +/*
> + * A guest driver disables and re-enables PCI Memory-Space during init and
> + * reset. The committed HDM decoder stays valid across that toggle, so once
> + * Memory-Space is re-enabled the coherent HDM memory must be reachable again
> + * without a reset. This is the regression test for the hdm_valid access gate
> + * being cleared by a Memory-Space disable and never restored, which left a
> + * later valid mmap fault wrongly SIGBUS-ing.
> + *
> + * The region is exercised only through the mmap path (as a VMM does) and only
> + * while Memory-Space is enabled. An access with Memory-Space disabled aborts
> + * on the fabric as a fatal host error, so the test never attempts one: the
> + * toggle in between is pure config-space writes.
> + */
> +TEST_F(vfio_cxl, hdm_mem_survives_mem_space_toggle)
> +{
> +	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
> +	uint32_t pattern = 0x12345678U, readback = 0;
> +	uint16_t cmd;
> +	void *map;
> +
> +	if (self->mem_size < SZ_4K)
> +		SKIP(return, "HDM memory < 4K");
> +
> +	/* Seed a known pattern through the mmap path with Memory-Space on. */
> +	cmd = vfio_pci_config_readw(self->dev, PCI_COMMAND);
> +	vfio_pci_config_writew(self->dev, PCI_COMMAND,
> +			       cmd | PCI_COMMAND_MEMORY);
> +	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
> +		   self->dev->fd, off);
> +	ASSERT_NE(MAP_FAILED, map);
> +	memcpy(map, &pattern, sizeof(pattern));
> +	ASSERT_EQ(0, munmap(map, SZ_4K));
> +
> +	/*
> +	 * Toggle Memory-Space off and back on with no HDM access in between,
> +	 * as a guest driver does during init/reset.
> +	 */
> +	vfio_pci_config_writew(self->dev, PCI_COMMAND,
> +			       cmd & ~PCI_COMMAND_MEMORY);
> +	vfio_pci_config_writew(self->dev, PCI_COMMAND,
> +			       cmd | PCI_COMMAND_MEMORY);
> +
> +	/*
> +	 * The committed decoder stayed valid across the toggle, so a fresh mmap
> +	 * fault succeeds and the seeded pattern reads back, without a reset.
> +	 * Before the fix the gate was cleared by the disable and never restored,
> +	 * so the fault wrongly SIGBUS-ed.
> +	 */
> +	map = mmap(NULL, SZ_4K, PROT_READ | PROT_WRITE, MAP_SHARED,
> +		   self->dev->fd, off);
> +	ASSERT_NE(MAP_FAILED, map);
> +	memcpy(&readback, map, sizeof(readback));
> +	ASSERT_EQ(pattern, readback);
> +	ASSERT_EQ(0, munmap(map, SZ_4K));
> +
> +	/* Restore PCI_COMMAND. */
> +	vfio_pci_config_writew(self->dev, PCI_COMMAND, cmd);
> +}
> +
> +/*
> + * Mirror how a VMM uses the region: mmap the HDM memory and map it into the
> + * IOAS (stage-2) so the device can reach it over ATS. The mmap flag is required
> + * for that path, so its absence is a failure, not a skip. The host CPU does not
> + * dereference the mapping; the guest reaches it through stage-2.
> + */
> +TEST_F(vfio_cxl, hdm_mem_ioas_map)
> +{
> +	uint64_t off = VFIO_PCI_INDEX_TO_OFFSET(self->mem_idx);
> +	struct iova_allocator *iova_alloc;
> +	struct dma_region region;
> +	void *map;
> +
> +	ASSERT_NE(0, self->mem_flags & VFIO_REGION_INFO_FLAG_MMAP);
> +
> +	/* iova_allocator_alloc() requires a power-of-2 size. */
> +	if (self->mem_size < SZ_2M)
> +		SKIP(return, "HDM memory < 2M");
> +
> +	map = mmap(NULL, SZ_2M, PROT_READ | PROT_WRITE, MAP_SHARED,
> +		   self->dev->fd, off);
> +	ASSERT_NE(MAP_FAILED, map);
> +
> +	iova_alloc = iova_allocator_init(self->iommu);
> +	region.vaddr = map;
> +	region.size = SZ_2M;
> +	region.iova = iova_allocator_alloc(iova_alloc, SZ_2M);
> +
> +	iommu_map(self->iommu, &region);

Hi Manish,

We ran this series' selftests with a QEMU-emulated Type-2 device
(pxb-cxl host bridge, firmware-committed HDM decoder).  16 of the 17
tests pass; the one failure is hdm_mem_ioas_map:

 > 	iova_alloc = iova_allocator_init(self->iommu);
 > 	region.vaddr = map;
 > 	region.size = SZ_2M;
 > 	region.iova = iova_allocator_alloc(iova_alloc, SZ_2M);
 >
 > 	iommu_map(self->iommu, &region);

IOMMU_IOAS_MAP (the vaddr variant) on the mmap of the CXL_MEM region
fails with -EFAULT.  The path is:

	iommufd_ioas_map()
	  iopt_map_user_pages()
	    pfn_reader_user_pin()
	      pin_user_pages_fast()
	        check_vma_flags()		/* mm/gup.c */
	          if (vm_flags & (VM_IO | VM_PFNMAP))
	            return -EFAULT;

The CXL_MEM region is struct-page-less device memory, so vfio_cxl_core.c
creates the VMA with VM_IO | VM_PFNMAP.  pin_user_pages() refuses such
VMAs outright and pfn_reader_user_pin() has no fallback, so with the
current upstream iommufd the vaddr variant of IOMMU_IOAS_MAP cannot map
this region at all, and the test's unconditional assertion fails.

The test documents a real part of the contract (the mmap is what lets
the device reach its DPA through stage-2), so rather than have reviewers
read this as a series regression, maybe:

   - tolerate the current upstream behavior: skip (or xfail) when
     IOMMU_IOAS_MAP fails with -EFAULT on the PFNMAP VMA, with a comment
     that the vaddr path needs iommufd support for PFNMAP device memory;
     or
   - note the dependency in the cover letter.

FWIW, the dmabuf variant does not offer a way around this today either:
VFIO_DEVICE_FEATURE_DMA_BUF only exports BARs, while the CXL_MEM region
is a vendor region backed by the resolved HPA window, so there is
currently no upstream path at all to IOAS-map the HDM memory from
userspace.  If the vaddr path is meant to work eventually, it might be
worth saying which side owns that (iommufd pin fallback vs. a dmabuf
export for this region).

Everything else here works nicely, including the guest reset path and
the HDM shadow/commit FSM tests.

Test setup, in case it helps reproduction:

   - this series applied on an upstream-based tree
   - QEMU with pxb-cxl and an emulated Type-2 device whose decoder is
     firmware-committed at boot
   - result: 16/17 pass, hdm_mem_ioas_map fails with -EFAULT from
     pin_user_pages_fast()

Thanks,
Shuai Xue


