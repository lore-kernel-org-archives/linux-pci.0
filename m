Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851580;
	b=WorYUM4t8XD48q0BLj39hucge86j1yIC7a4/OxggfCQmUGRaFyZJrdVhGk23fYFQ136M
	 HONrnunc9FnG/4Fv/2Qprj1l4SAgu8FEWSymxZXc8XUVF6n5OiHt54qbAzWoVBTkicraf
	 1qgwbYSEiJ3+inPtEN9dybJxTQ6ID/06sowSI0B1n+yiPGwAY2289jc4wdEZXtNjd7FUR
	 iOFJqB4+9UimTfSx6o2HmRNgHkzwoeK2AhE0ueyDjDyYqfB4O3PYsdP0SPmVAUEYHT72/
	 vPEWsGHBuHzKqzMpI941YPVATOUhR0FgwroFAtNFTVKLAUT/KDeMgsjwtZE+oH8z/uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=ZVha1LQJ+ZYa0pasaO7rOjBg6mtWgNhixYpeavUGJvw=;
	b=eLWL1WNEtmsrAS58pTkJujX7O35PSNFzF2Dh7FWhv7kJuUWwnCM5GCUNzujZxWH1I/D8
	 wPLQndAn3ibvpWYM/vZOSN/rxnODdBSXO4gveT++UXOE3axn7uP3lOq0n/Y/hK7lBgZrU
	 bL1MoTtNEM/3pFpynWH74k5TBy0qdZ4DVtrQXLGMF9CCTaQpPB7jJyxpVI9GlBBftOop4
	 A05ypD/j4BCx1+4LRsBd8T+iPfA/L0FCqjYDY0vmm2QtQoP07N38jJS3jXb2tz03Ynkqn
	 PYagON1pbH4IMlrQ/q1APUKkVnF2NWqOTqmQtFP9yrkeSea+hx0Nn2bIzI4Lud6LSvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mr0MWBAM;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04874606A33D
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 17:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04874606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mr0MWBAM
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cddee4abc57so411702a12.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 09:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794851577; x=1795456377; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZVha1LQJ+ZYa0pasaO7rOjBg6mtWgNhixYpeavUGJvw=;
        b=Mr0MWBAM4MLlHJMOKb/4Z6+dOhVz5cE+GMuRUduu9EHxuwhijBh3tXy8WJrkhaD0vh
         PYAoy9x9sShYaRayE53yartClLeXdWk62a//vvYlSd2zLiJvKMc9TXh7Mof3XZRTu0rx
         GxoGIFqRYzrwZ+dbFPfJk7TnrE7kr2+1NPV9kZnPO9acPHImQGPyrlGzUI/V+O9rL+lS
         rW57l05EwtNh4ZKXuPgI4wU7DkeDNQM3yk0RZSB8ysyrRk6y/+Fsb3SJKn/X/NOmQar9
         V386QxKbhvhnCZ98vZnrwlnUF9YPDTCdsBALgZVykIgXLyQJuXY30X/5rtUP6x7EcqzI
         KKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851577; x=1795456377;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVha1LQJ+ZYa0pasaO7rOjBg6mtWgNhixYpeavUGJvw=;
        b=2HLAFtmGwZ+spyU5rQpeOfNIM+BUK019NC4uQslDwRLob0iYMq+hqPawGQpwq+2ihu
         UhZP7GE5X0F9d+C/MhUHbZoGBQ/EokTNxEilKDpw2CMCXrIpSVFSP+HemFFnfdguer4r
         OFBE5AOWTc6FvETCfxaCdDJfgLJZVmKLXTwzGDB7iiVmIPFa0IhVnjPA/pS6cjO9Y8Sx
         xzlSJDE2OUPWfrB1RQ26lxAK/IJxr5BKs8TbeYlcLsWSsHv0GS7Lv5TZzVJGrQZL1DBQ
         RD18z/E5q9u/pW8+QF9tXxHhHhtmlOKjvgc+Pm5iIZiDCRGRlNKV0SwuuC7o0LByKtTY
         DOPA==
X-Forwarded-Encrypted: i=1; AL+hErEv6HPbFQny1HXcYorYRAWNbKy2LQsWecFHh/O8VNMrDqLQpuTjNzZfnDAfAh8P5i62qkVUAQ2/5d0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XogubERRpQFtvtUeUyvkkwuH0UbICd/vN0fYa/Ajzx5HtmlSr
	LGwBrCdIoOpqdLo4LLzaxw+tM66LmuxKbrU3DGnpFWJbliA84gVeiSgtMzaAmbZMqw==
X-Gm-Gg: AZFdTZchszlWl5XcH/sj7xyqu1rLy1EoRTvX5dhQwvCPc8d/WT/60ez9DfPNq4wK6DG
	5Zo6i7nZuixIxjJN3iyXm3ic/9L7bL5fdOPQ3Bje9OBbnBtUx72hgqXR5AqNNdDc/L8KoFab43R
	eEqPy0ENQgLvaOEJeFNJ/k/TPFWREoTCIUCbo7d90MDPW8/NG0Agn+uunGMLR0ysJJ8eCmmFQ29
	56sK9hw5J2IVqAGQHvInz7kJodV+w+kqQIWNOBmHz6mx8plnsTAHCG+oGaMErS64hmXFfc61xBe
	wu8qDiFIzu1pw9/O254nNr7+8M+mTTWd8Wuf4TA0F2Ut+YD5SJkVMFoDW4AseJHpoCcNmw60BjS
	iXPbj1HHUqhdTI7s8nxlK5sPr2yJTHMl5T20Kz8eLzZDEXBPBgF4222RAULuZMM8YxR0ySgeYEg
	ZPTPcBI1FH6h7GHMlo3NUT6IZC1p9/DijQfMaFErBmPyvc8vaofhpyhHVbfg16jFyA/aPMnTp//
	eECu8Oi5um47MMWkpHXya5MwX4ba3QOn1rcMioHYfa+r34QOujSU6Ug0wEElVsAbxlJvarlWq47
	UKUOuJEW7E4c5Jf5HWe/ud2hQpKW8JnUzJKpLptsxpNH+bb3q1eEttWIIEwDw5yT
X-Received: by 2002:a17:90b:4c0c:b0:3a0:516d:9f87 with SMTP id 98e67ed59e1d1-3b1b0a1f01cmr12343648a91.13.1794851576505;
        Mon, 16 Nov 2026 09:52:56 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac296b5fsm224574a91.8.2026.11.16.09.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 09:52:55 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 09:52:54 -0800
Message-Id: <DMWTS6IPSI2R.3EJQC130JYVW3@google.com>
Cc: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
 <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v6 31/31] selftests/vfio: Add CXL Type-2 passthrough
 tests
From: "David Matlack" <dmatlack@google.com>
To: <mhonap@nvidia.com>, <alex@shazbot.org>, <jgg@ziepe.ca>,
 <ankita@nvidia.com>, <jic23@kernel.org>, <dave.jiang@intel.com>,
 <alejandro.lucero-palau@amd.com>, <smadhavan@nvidia.com>, <corbet@lwn.net>,
 <skhan@linuxfoundation.org>, <dave@stgolabs.net>,
 <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
 <iweiny@kernel.org>, <ming.li@zohomail.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <bhelgaas@google.com>,
 <dmatlack@google.com>, <kees@kernel.org>, <gustavoars@kernel.org>
X-Mailer: aerc 0.21.0
References: <20261016161839.2765592-1-mhonap@nvidia.com>
 <20261016161839.2765592-32-mhonap@nvidia.com>
In-Reply-To: <20261016161839.2765592-32-mhonap@nvidia.com>

On Fri Oct 16, 2026 at 9:18 AM PDT, mhonap wrote:
> Exercise the vfio-cxl contract on a bound Type-2 device: the CXL
> device-info flag and the two vendor-type regions, the HDM memory mmap
> (including a 2 MB huge fault), the read-only trapped decoder region
> against the live host-committed decoder, and the guest's DVSEC reset
> doorbell and manual HDM discovery.

I tried running this test in a VM with the emulated cxl-type2 device
from your QEMU RFC [1], on an x86 q35 machine with intel-iommu. Out of
the box the device binds as plain vfio-pci and the fixture skips
everything. v6 now requires that the host can do CPU cache invalidation
for CXL Reset, and cpu_cache_has_invalidate_memregion() returns false in
a VM (x86 refuses it under a hypervisor, and arm64 has no cache
maintenance provider in a guest).

The QEMU RFC reports 19/19 passing in an Arm guest, but that was against
v5, which didn't have this requirement. How did you run the v6 version
of this test without hardware? Did you use something like
CONFIG_CXL_REGION_INVALIDATION_TEST? That option only covers region
management in drivers/cxl/core/region.c, and depends on CXL_REGION, so
it doesn't help here.

I added a local test-only bypass (a CONFIG_CXL_RESET_INVALIDATION_TEST
that skips the invalidation in cxl_reset_check() and
cxl_hdm_quiesce_prepare()/cxl_hdm_ranges_invalidate()), I get 26 passes
and 1 skip (pm_d3hot_restores_decoder, since cxl-type2 has no PM
capability in QEMU). I think something like that belongs in the
cxl_reset series. Otherwise this test can only be run by people with
real Type-2 hardware.

[1] https://lore.kernel.org/linux-cxl/20261106035911.1280066-1-mhonap@nvidi=
a.com/

> Check that the decoder register region reads fail with EIO while Memory
> Space is disabled, and that the decoder reads back committed and HDM
> access works after low power entry and exit.

The series says a Type-2 device loses its committed HDM decoder in D3hot
and D3cold (patches 17 and 30), but the emulated cxl-type2 device in
your QEMU RFC has no PM capability, so on it these tests never take the
decoder restore path in vfio_cxl_power_up(). Please make the emulated
device behave the same way as the real hardware across D3hot (PM
capability, No_Soft_Reset, and whether the decoder is lost), so that the
selftest exercises the same vfio-cxl code paths in a VM as it does on
hardware.

To help get that right: what does lspci -vv show for the PM capability
of the device you tested with (NoSoftRst+ or NoSoftRst-), and did you
observe the decoder actually being lost?

> Add a partial-mmap path to the vfio selftest library so the trapped
> component BAR maps its sparse ranges, and an __iommu_map_file() helper fo=
r
> the dma-buf mapping.

Please split the library changes into separate commits ahead of the
test: __iommu_map_file(), the sparse mmap support in vfio_pci_bar_map(),
and each of the new libvfio helpers suggested below. That way each one
can be reviewed on its own, and the final commit only adds the test, its
Makefile entry, and the MAINTAINERS line.

This series is already quite long (31 patches), and with the library
changes split out the selftest changes will grow to several patches.
Consider sending all the VFIO selftests patches as a separate series
that depends on this one.

> +/* Return the sparse-mmap capability in @info, or NULL if the region has=
 none. */
> +static struct vfio_region_info_cap_sparse_mmap *
> +vfio_pci_sparse_mmap_cap(struct vfio_region_info *info)
> +{
> +	struct vfio_info_cap_header *hdr;
> +	u32 offset;
> +
> +	if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS))
> +		return NULL;
> +
> +	for (offset =3D info->cap_offset; offset; offset =3D hdr->next) {
> +		hdr =3D (void *)info + offset;
> +		if (hdr->id =3D=3D VFIO_REGION_INFO_CAP_SPARSE_MMAP)
> +			return (struct vfio_region_info_cap_sparse_mmap *)hdr;
> +	}
> +
> +	return NULL;
> +}

This walks the region info capability chain looking for one ID, which is
the same thing find_region_cap() does in the test. Please add one
generic libvfio helper that looks up a region info capability by ID, and
use it in both places.

> + * Usage: ./vfio_cxl_type2_test <BDF>  (or export VFIO_SELFTESTS_BDF=3D<=
BDF>).
> + * The device must be bound to vfio-pci with the vfio-cxl module availab=
le.

Please document how to run this test in more detail: the hardware
requirements, how to set up the emulated QEMU device, and the kernel
config needed (VFIO_CXL, IOMMUFD, any test-only bypass), so others can
reproduce your results.

> +/* vfio-pci region-offset packing is kernel-internal, not UAPI; define l=
ocally. */
> +#ifndef VFIO_PCI_OFFSET_SHIFT
> +#define VFIO_PCI_OFFSET_SHIFT		40
> +#endif
> +#ifndef VFIO_PCI_INDEX_TO_OFFSET
> +#define VFIO_PCI_INDEX_TO_OFFSET(i)	((uint64_t)(i) << VFIO_PCI_OFFSET_SH=
IFT)
> +#endif

As the comment says, this is kernel-internal and not uAPI, so the test
shouldn't depend on it. Please use vfio_region_info.offset from
VFIO_DEVICE_GET_REGION_INFO instead, as comp_bar_sparse_mmap already
does for the BAR. Better yet, use region access helpers in libvfio that
take a region index and apply the offset internally (see below), so the
test never computes region offsets itself.

> +/* Find a CXL region by subtype; returns the region index or -1, @buf le=
ft holding its info. */
> +static int find_cxl_region(int fd, uint32_t nregions, uint32_t subtype,
> +			   void *buf, size_t bufsz)
> +{
> +	uint32_t i;
> +
> +	for (i =3D 0; i < nregions; i++) {
> +		struct vfio_region_info *ri =3D buf;
> +		const struct vfio_region_info_cap_type *t;
> +		const struct vfio_info_cap_header *hdr;
> +
> +		memset(buf, 0, bufsz);
> +		ri->argsz =3D bufsz;
> +		ri->index =3D i;
> +		if (ioctl(fd, VFIO_DEVICE_GET_REGION_INFO, ri))
> +			continue;

This is a generic lookup of a region by type and subtype. Only the CXL
vendor ID is specific. Please make it a libvfio helper (e.g.
vfio_pci_find_region(device, type, subtype)) built on the existing
region info code in libvfio.

More generally, please replace the raw ioctl() calls throughout the test
with libvfio helpers: VFIO_DEVICE_GET_INFO, VFIO_DEVICE_GET_REGION_INFO,
and VFIO_DEVICE_FEATURE for DMA_BUF and LOW_POWER_ENTRY/EXIT. Please
follow the existing convention, e.g. __vfio_pci_device_reset() and
vfio_pci_device_reset(): a double-underscore variant that returns -errno
for the tests that expect failures or skip when something isn't
supported, and a plain variant that asserts success.

> +/* Walk the PCI extended capability list for the CXL Device DVSEC. */
> +static uint16_t find_cxl_dvsec(struct vfio_pci_device *dev)
> +{

Same here, the extended capability walk and the DVSEC match aren't
CXL-specific. Please consider vfio_pci_find_ext_capability() and
vfio_pci_find_dvsec(device, vendor, id) helpers in libvfio, with the
test passing in the CXL IDs.

> +/* Read config space from sysfs, which is the hardware, not the vfio vie=
w. */
> +static int sysfs_config_read(uint32_t off, void *buf, size_t len)
> +{
> +	char path[128];
> +	ssize_t n;
> +	int fd;
> +
> +	snprintf(path, sizeof(path), "/sys/bus/pci/devices/%s/config",
> +		 device_bdf);
> +	fd =3D open(path, O_RDONLY);
> +	if (fd < 0)
> +		return -errno;
> +	n =3D pread(fd, buf, len, off);
> +	close(fd);
> +	return n =3D=3D (ssize_t)len ? 0 : -EIO;
> +}

This and sysfs_config() further down do the same thing. Please replace
both with one sysfs config access helper in lib/sysfs.c, modeled after
the existing vfio config helpers: a sysfs_config_access(bdf, write,
offset, size, data) core with sysfs_config_read{b,w,l}() and
sysfs_config_write{b,w,l}() wrappers that assert on failure, like
vfio_pci_config_access() and vfio_pci_config_read{b,w,l}().

Taking the BDF as a parameter also gets helpers off the device_bdf
global. Please only use device_bdf where the device is opened
(FIXTURE_SETUP() and close_restores_open_time_command). Everywhere else
can use self->dev->bdf.

> +/* The trapped block starts at the HDM decoder registers; CTRL 0 reads b=
ack. */
> +TEST_F(vfio_cxl, comp_regs_hdm_read)
> +{
> +	uint64_t ctrl =3D self->comp_off + CXL_HDM_DECODER0_CTRL_OFFSET(0);
> +	uint32_t val =3D 0;
> +
> +	ASSERT_GE(self->comp_size, CXL_HDM_DECODER0_CTRL_OFFSET(0) + 4);
> +	ASSERT_EQ((ssize_t)sizeof(val),
> +		  pread(self->dev->fd, &val, sizeof(val), ctrl));
> +}

Please add region access helpers to libvfio instead of open-coding
pread()/pwrite()/mmap() on the device fd, which this test does in about
50 places. Something modeled on the config space helpers:
__vfio_pci_region_access(device, index, write, offset, size, data)
returning the number of bytes or -errno, vfio_pci_region_access()
asserting success, and typed vfio_pci_region_read{b,w,l,q}() and
vfio_pci_region_write{b,w,l,q}() wrappers. Then this becomes:

	val =3D vfio_pci_region_readl(self->dev, self->comp_idx,
				    CXL_HDM_DECODER0_CTRL_OFFSET(0));

The double-underscore variant covers the expected failures, like
comp_regs_read_needs_memory and the unaligned and out of range tests.
vfio_pci_config_access() could become a wrapper around the same code
using VFIO_PCI_CONFIG_REGION_INDEX. libvfio would need to cache the
region info for all regions, not just config space and the BARs, so it
can apply the offset reported by VFIO_DEVICE_GET_REGION_INFO.

Similarly, __vfio_pci_region_mmap() and vfio_pci_region_mmap() could
cover the HDM region mappings and the expected mmap failures over the
decoder block, and vfio_pci_bar_map() could be built on them.

> +/* Find a standard capability through the vfio config view. */
> +static uint8_t find_std_cap(struct vfio_pci_device *dev, uint8_t id)

Please make this a libvfio helper too, e.g.
vfio_pci_find_capability(device, cap_id).
