Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633821;
	b=whaHzfIC4Wx7d6aqTjkeq9Ow/egnnG5oJsfgQ0rbViRRJsONBILeG1DY9g/jhFcn9qKx
	 F2u9YEATyCvJaqmpDzRY3LzROSGyBBXE9nQ3sJ4GwJb5UThaegbkvmOPHn5wkY2LPm+od
	 bMYazyuQbpkbLy1BqMSB8re9qaKnONw1peQkk7U30sjtx57nVJ8XdDyv6z99cR59s4ASw
	 UMIzUFL9iyCTjLSJJrGtL3GnvaO5x3tUuxd5w82uu367phd30Oj6QYlUPKl+pNXYCyFkx
	 pexPgnoC+i0Ml3CvT2cSnfs+w+raS0cM2bj9W2JcuH/5SOccxm9ksW6w1bt9Aro1ySQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=iSMn9Luik8JQySxKW5TZdiPLSp0bOJ1EGPPjD/yQ8D8=;
	b=vzSQHNRAQ2hdtqZgdKL9moqLhgLqvw7KZZ78T195xr3U1kyQGIqmpGqzX9z4HOURfflD
	 B9owldZYC7O1F27CMn9k+KnxzjALaNAJXv/DoAcuQvggW0w3+QqU7xjfgQkjx28rpgTJ0
	 m4r+xmxk8ng1F90oex+c9+02mfPxzoxnERNZO/IFWewVuc1lkL9+SLFTh4Rm+/zKCURUU
	 4vWmhLdnkq4QDtlOBoMZzhpz9Kitd0sWlS116TofLMcAUqYusslpjenfXhh3s7aEXq37g
	 ZRo2gMz7kVz1F2mjopesCBWyoMFsQuTwAb25PTgFp+MpDWUmUwJwADL5Iy1rkvy4TsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=APDovMQt;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E860A6D08
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D64E860A6D08
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=APDovMQt
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so4606073a91.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633820; x=1794238620; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iSMn9Luik8JQySxKW5TZdiPLSp0bOJ1EGPPjD/yQ8D8=;
        b=APDovMQtDTFspt258gusLfxerbUG0yqLICh8jArI4BsEqWwa+NX4s7llovPfAYNWxC
         +Yxi8Sk6XQa7T3hHvCaXKZsg3G49PZ8PvLqbeDGLOSgnLfWT2Rw2XccMZ1RIkVHlSBwo
         ZYuwQhpTmXzcMb/BoiVx4ubdEzAFxRFuY5VnDB3llhJ6RmGCFLZ7X2LxKChXyZLqJZYA
         +7VSSz1bhxNA/2Br8rUm8HBDo1LTh8RgjufxG3GZYF82X/FXlybk3GLFFIcJDtlcrIId
         vegT7QXM0mF8oE2kh2F0pXGfcb8oXLl5gXzmQk4RTCEo1Z4Zw50XTUIBM2bslaixHlsq
         A9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633820; x=1794238620;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iSMn9Luik8JQySxKW5TZdiPLSp0bOJ1EGPPjD/yQ8D8=;
        b=1e7uDwiYw62ezOFKOt0LC1AT4c3kPp3mHrhiBPXCqLEG6OEIolK5r2tkBKCJeZQ79G
         X8MZHSkZnGrjbpxp1nTXxlvO558zsBsI8E9ZZoHBI3ri6iwHo/nFd6nMgeBoIGTVCssv
         dQNLIs7388sJ5nDeIkqgkfMRvjzhLV4Mp6tDVDsTbRmjVFCHORPzc36Q+fLKEuucoXhQ
         nqhlzrp9FrKXeQ+Dg0t4VxTV2OvH/mgqQiyRd90PzJprhXKpwQuMqLLHKERBHJEfddsp
         hVrxxlxUWh0YwaODijyjr9AXZ0lUP8ImjRq3qyxSdBtq+B9ni+aIh5bXG94Z4GcHTVo2
         oZrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlL+N3mP4RWrqTTkULzuaW7eWoaUAXtsoPoA91QJSbXMKJMvKoDcvZ6sQKHlGVg7Edxf4svYcffyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z93V3k80auRhIOQiwDmjlnNQkmNbnmh1H1i2W1Z0cc/jBj0xeka
	KwrZIX0nY0iEblCI9jpMp34bU+aNhucVW7Xqw0vcrTWggehRjBBJCNnBDwVKkdVzZ5g05UoYJIf
	m8a04n1HevA==
X-Received: from pjbir10.prod.google.com ([2002:a17:90b:468a:b0:3aa:ee30:1a77])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8b:b0:3ab:884b:65b7
 with SMTP id 98e67ed59e1d1-3ae89814e34mr8631702a91.25.1793633819867; Mon, 02
 Nov 2026 07:36:59 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:29 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-1-vipinsh@google.com>
Subject: [PATCH v6 00/27] VFIO PCI Live Update (noiommu mode)
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

This series adds a fully working Live Update support for vfio-pci
devices in noiommu mode, using the Live Update Orchestrator (LUO) and
Kexec HandOver (KHO).

This series can also be found on GitHub:
  https://github.com/shvipin/linux/tree/vfio/liveupdate/v6

Unlike v5, which reset the device in freeze() and required userspace to
re-initialize it after kexec, v6 keeps a preserved device running across
the kexec: it is not reset, bus mastering and memory decode stay enabled,
it stays in D0, and in-flight DMA continues into preserved memory (e.g. a
LUO-preserved shmem memfd). In the new kernel, userspace retrieves the
device FD from its LUO session and takes over the running device without
resetting it on the first VFIO_DEVICE_BIND_IOMMUFD.

Preserving IOMMU-backed devices is refused with -EOPNOTSUPP until LUO can
preserve IOMMU state; group/container FDs and unbound cdev FDs are refused
with -ENOENT.

This series is built on top of PCI Live Update series version v10:
  https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/

Design
======

- Preserve: only a bound noiommu vfio-pci cdev FD can be preserved (no
  VFs, Intel display devices, or zdev). The device is registered with PCI
  Live Update and its pre-open struct pci_saved_state is serialized into
  a versioned KHO buffer ("vfio-pci-v1").

- Freeze/unfreeze: freeze() requires interrupts to be disabled, the
  device to be in D0, and SR-IOV to be disabled (VFs are not preserved).
  It snapshots vconfig and pci_config_map, and masks physical INTx while
  leaving bus mastering enabled. If the kexec is aborted, unfreeze()
  restores INTx and the existing FD keeps working.

- Early protection in the new kernel: an incoming device is kept out of
  runtime D3, sibling dev_set resets are blocked, and opening it via its
  cdev or VFIO_GROUP_GET_DEVICE_FD fails with -EBUSY until the session is
  finished. If the new kernel is not in noiommu mode, bus mastering is
  cleared at registration.

- Retrieve and take-over: LIVEUPDATE_SESSION_RETRIEVE_FD validates the
  serialized state against the hardware and returns an unbound cdev FD.
  The first VFIO_DEVICE_BIND_IOMMUFD takes over the device without
  clearing bus mastering, resetting, or re-saving its state, restores the
  preserved vconfig, and keeps the original saved state so that normal
  reset/restore applies when the FD is closed.

- Unclaimed devices: if the session is finished or closed without taking
  over the device (not retrieved, retrieved but not bound, unbound, or
  driverless), the kernel logs one pci_warn(), resets the device, and
  restores its pre-Live-Update state.

- DMA memory ordering: a running device keeps DMAing until it is taken
  over or reset, so its DMA memory must stay pinned until then. LUO
  finishes files in LIFO order, so userspace must preserve the DMA memory
  (e.g. a memfd) in the same session and before the device. This is
  documented in Documentation/driver-api/vfio_pci_liveupdate.rst.

Testing
=======

- QEMU with an emulated igb device in noiommu mode, across real
  kexec reboots: vfio_pci_liveupdate_uapi_test and
  vfio_pci_liveupdate_kexec_test (opens fail with -EBUSY, memfd stays at
  the same physical addresses, pre-kexec DMA completes after take-over,
  and new DMA works without re-init).
- Physical Intel hosts with DSA (8086:0b25), across real kexec
  reboots: vfio_pci_liveupdate_kexec_test with DMA started just before
  the kexec (opens fail with -EBUSY, memfd stays at the same physical
  addresses, pre-kexec DMA completes correctly after take-over, and new
  DMA works without re-init).


  $ ./setup.sh 0000:6a:01.0
  $ ./vfio_pci_liveupdate_kexec_test -s 1 0000:6a:01.0
  $ kexec --reuse-cmdline -l -s /boot/vmlinuz
  $ kexec -e
  $ ./setup.sh 0000:6a:01.0
  $ ./vfio_pci_liveupdate_kexec_test -s 2 0000:6a:01.0

AI disclosure
=============

New and reworked patches were developed with LLM assistance. Assisted-by
is not needed now in linux kernel but I thought I should at least
disclose this in cover letter.

v6:

- Keep noiommu devices running across kexec and take them over without
  reset, instead of resetting them in freeze().
- Restrict preservation to bound noiommu cdev FDs.
- Add PCI helpers to serialize and restore struct pci_saved_state.
- Add unfreeze() and close races between freeze() and ioctl/config
  access. Refuse freeze() while SR-IOV is enabled, and refuse enabling
  SR-IOV on a frozen device.
- Protect incoming devices in the new kernel until they finish Live
  Update; reset unclaimed devices in finish() with a single pci_warn().
  retrieve() and finish() look the device up under the device lock, so
  they never act on a device that vfio-pci is still probing.
- Fix vfio_pci_liveupdate_init() error handling to avoid a double
  unregister at module exit (reported by Sashiko on v5).
- Drop "vfio/pci: Export vfio_pci_dma_buf_move for vfio-pci module",
  "vfio: selftests: Expose iommu_modes to tests", and exports that were
  only needed by the v5 reset path.
- Update the VFIO PCI and PCI Live Update documentation.
- Selftests: add an iommufd noiommu mode, IOVA == PA mapping helpers,
  2MB THP memfd helpers, an attach() driver op (igb, DSA), and a kexec
  test with DMA running across the Live Update.

v5: https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
v4: https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/
v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/
v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/
v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/

David Matlack (4):
  vfio: Enforce preserved devices are retrieved via
    LIVEUPDATE_SESSION_RETRIEVE_FD
  docs: liveupdate: Add documentation for VFIO PCI
  vfio: selftests: Add vfio_pci_liveupdate_uapi_test
  vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED

Vipin Sharma (23):
  vfio/pci: Factor out the reset logic in VFIO PCI device close path
  vfio: Export various helpers from VFIO
  liveupdate: Export symbols needed by modules
  vfio/pci: Register a file handler with Live Update Orchestrator
  PCI: liveupdate: Add helpers to preserve struct pci_saved_state
  vfio: Add helpers to identify device files that can be preserved
  vfio/pci: Preserve vfio-pci device files across Live Update
  vfio: Introduce vfio_find_device() helper
  vfio: Refactor vfio_device_fops_cdev_open()
  vfio: Add API to open cdev device for Live Update restore
  vfio/pci: Retrieve preserved device files after Live Update
  vfio/pci: Protect incoming preserved devices until they finish Live
    Update
  vfio/pci: Take over preserved devices without resetting them
  vfio: selftests: Build liveupdate library in VFIO selftests
  vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
  vfio: selftests: Add iommufd noiommu mode
  vfio: selftests: Add helpers to map DMA memory at IOVA == PA in
    noiommu mode
  vfio: selftests: Add helpers for Live Update DMA memory and sysfs
    state
  vfio: selftests: Add an attach() driver op
  vfio: selftests: Test preserving noiommu devices in
    vfio_pci_liveupdate_uapi_test
  vfio: selftests: Add vfio_pci_liveupdate_kexec_test
  vfio: selftests: Verify that opening VFIO device fails during Live
    Update
  vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

 Documentation/PCI/liveupdate.rst              |   3 +
 Documentation/core-api/liveupdate.rst         |   1 +
 .../driver-api/vfio_pci_liveupdate.rst        |  25 +
 MAINTAINERS                                   |   2 +
 drivers/pci/liveupdate.c                      | 223 ++++++
 drivers/pci/pci.c                             |   5 -
 drivers/pci/pci.h                             |   6 +
 drivers/vfio/device_cdev.c                    |  87 +-
 drivers/vfio/group.c                          |   9 +
 drivers/vfio/pci/Kconfig                      |  11 +
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/vfio_pci.c                   |  14 +-
 drivers/vfio/pci/vfio_pci_config.c            |  19 +-
 drivers/vfio/pci/vfio_pci_core.c              | 348 ++++++--
 drivers/vfio/pci/vfio_pci_intrs.c             |   4 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c        | 745 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h              | 177 +++++
 drivers/vfio/vfio.h                           |  28 +-
 drivers/vfio/vfio_main.c                      |  85 +-
 include/linux/kho/abi/pci.h                   |  47 ++
 include/linux/kho/abi/vfio_pci.h              |  76 ++
 include/linux/pci_liveupdate.h                |   7 +
 include/linux/vfio.h                          |  19 +
 include/linux/vfio_pci_core.h                 |  11 +
 kernel/liveupdate/luo_file.c                  |   2 +
 tools/testing/selftests/vfio/Makefile         |  23 +-
 .../selftests/vfio/lib/drivers/dsa/dsa.c      |  35 +-
 .../selftests/vfio/lib/drivers/igb/igb.c      |  39 +-
 .../selftests/vfio/lib/include/libvfio.h      |   3 +
 .../vfio/lib/include/libvfio/iommu.h          |  43 +
 .../vfio/lib/include/libvfio/sysfs.h          |   1 +
 .../lib/include/libvfio/vfio_pci_device.h     |  10 +
 .../lib/include/libvfio/vfio_pci_driver.h     |  17 +
 tools/testing/selftests/vfio/lib/iommu.c      |  70 +-
 tools/testing/selftests/vfio/lib/libvfio.c    |  54 ++
 tools/testing/selftests/vfio/lib/sysfs.c      |  22 +-
 .../selftests/vfio/lib/vfio_pci_device.c      |  56 +-
 .../selftests/vfio/lib/vfio_pci_driver.c      |  22 +-
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 388 +++++++++
 .../vfio/vfio_pci_liveupdate_uapi_test.c      | 227 ++++++
 40 files changed, 2826 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/vfio_pci.h
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c


base-commit: 312200e9211ede3f9a03cc17d094805e06e4674e
-- 
2.56.0.317.g454f8302e1-goog

