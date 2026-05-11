Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325A363098
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543311; cv=none; b=ov+FRVDyjF8yeG0jFMIIaaNp9+bbvPWsI70Yzw6Ldax1/PMuaz4TVxbNOYO4TYaoOZzAil+h7sjemQQKRRnEE89OJa/Re8hlld0jer7Pl4KxNu51nXafV2TariCZ3UaN9sMkh3GJEoPawofAZ8yaEXc4Cis55oNrPIxTnYb2J0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543311; c=relaxed/simple;
	bh=W9gY1oZGi2jL87aNtG+4iM5dzO0jzsNm8dS3YDV++m0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=acumbdP0PnrfmVUmQDojNmQo4Ya3P1Yz1ZfaKm/16REZAX3h0mySZM37DbEU1lR1FKFoXG+MiD+zs1q/2hCGQI1Kae/0rT/EXpkjy8SLW3nyF9nhI0PDlvWbfY1thKHP1tw1W6lRHGwZwp7sE31b3kFIX1XWMopiJDDUx+1mWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPSmZnKB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPSmZnKB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2baf7378ad0so34190865ad.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 16:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543309; x=1779148109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VfwqHN43xnPfZz9FoZhoTr3j3r/6GeXBkPQenl4wh+g=;
        b=qPSmZnKB/P7w+HvkG9Anyk9j9hdK/HuiCC4rHJy1javwinC80YZS8xvhyCeI2tQa/t
         k8PZGuB4V6XSWBBmXJsqOY+/4GoE8P0eRcH1AmUbTqYflKtV4QH6+OQLPPvXJbwv60ov
         rvf9N3Jt5ZEtc9DMjswjA9mBtazUcQsCat61mkZG7u5VysixzF0MSdN9ua380qKNl28C
         Ndg0Zn4LyQcH8PbvxVmXCPPDyEGJuZYPqO+990ccYZGN1p/WGpNG1M9ttblVDaOL/gkQ
         pR+GK3WeUqN3Aq7x1QVr9GwpfsWFy3ID7Qi2fHCPMSYlCOXRDJLyzCudstKX0ue+bX+l
         Em+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543309; x=1779148109;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfwqHN43xnPfZz9FoZhoTr3j3r/6GeXBkPQenl4wh+g=;
        b=Eu8Jm4J1lEz3KTg/darZibYxm/YY8WPWBLrfzHbBAS5nizocWz0nyTpEt9t2x2D1zZ
         Oyj9h6QOiCXDBuYym71yf6C1bpQCWCMC2Wx+VwhZ2X3cC5wegOzNYJn4R7UizlbG6M+r
         2xNK0HR9K3Ljs90amoZaN0hA6YY5FUWre1mpTydVg3FKvoEhB9UBgplC5adxxiv2QKC1
         bLH6nOx54pBjlr/szJ7f8V2o4DBEOg4kyX2VEykFHtlYOF0f3BgTqkhIXpLrpp8RsLPR
         KSNBEnGS8GXMUvZ7mHqNrqRmn0SNRW7d5iV4ae4kxGKaXNfLw/KIyEVeGWLMS05tA16k
         FcBA==
X-Forwarded-Encrypted: i=1; AFNElJ/bbj8DPLndkot2ytSJXvZDuyJq+Ifva9vLpFH6uitjHVQlgccYAOwhD6j6zvg4PPqFQJzI58KCliU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgo86+mb1eAg8CNkVKKihYbx+yGjpE9qt6vXfGVCiXpj6Syyz
	jzfbvCIMAitWETpsbkiMP/UpyrmwKwB6D3eImQkcC0rYSOgBflsiG5mXSsoOcJUwNFVc55vJma8
	vcl+zkNDt/w==
X-Received: from plup11.prod.google.com ([2002:a17:903:4b2b:b0:2ba:67f8:6257])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b46:b0:2b2:eb9d:1648
 with SMTP id d9443c01a7336-2ba79c25ad9mr285828335ad.37.1778543309191; Mon, 11
 May 2026 16:48:29 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:46 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-1-vipinsh@google.com>
Subject: [PATCH v4 00/16] vfio/pci: Base Live Update support for VFIO
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

This series can be found on Github:

  https://github.com/shvipin/linux vfio/liveupdate/v4

It adds the base support to enable Live Update feature for VFIO devices.

In v3 of this series, both core PCI subsystem and VFIO changes were
together. Based on the feedbacks on the patches, increasing
complexities and the overall number of patches, we have split the effort
in two parts, PCI and VFIO.

v4 version of PCI work is here:
  https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/

This series is the VFIO part, built on top of PCI v4. Going forward,
work on both subsystem will be independent and we may not be making same
version releases in sync. However, VFIO changes will always be on the top of
some version of PCI changes.

Overview
--------

This series made following changes to support VFIO live update:

  1. VFIO Live Update feature is put behind VFIO_PCI_LIVEUPDATE config
     option. It also requires that VFIO_DEVICE_CDEV config is enabled.
  1. To keep things simple in this series, enabling this option will
     disable VFIO_PCI_DMABUF. This is temporary.
  1. A VFIO cdev FD can be preserved via Live Update session and
     retrieved after kexec via the same session.
  2. Getting the preserved device FD after kexec via legacy VFIO group
     APIs or by directly opening /dev/vfio/devices/vfioX will error out.
     User has to get the FD from Live Update subsystem.
  3. For now, only FD is preserved, underlying device and its states are
     not.
  4. To keep the next kernel safe, just before the kexec, VFIO resets
     the device, disables BME and restores the original state of the
     device. This is temporary and will be removed when we have added
     full support of the Live Update.
  5. New VFIO selftests have been added which interacts with VFIO
     - vfio_pci_liveupdate_uapi_test
     - vfio_pci_liveupdate_kexec_test
     liveupdate.
  6. Documentations have been added for kernel docs.

Dependencies
------------

This series has following dependencies as shown in the diagram

    |---------------------------|
    |         VFIO v4           |
    |---------------------------|
    |  Liveupdate Selftests[1]  |
    |---------------------------|
    |        PCI v4 [2]         |
    |---------------------------|
    |  Liveupdate Refcount [3]  |
    |---------------------------|

[1] https://lore.kernel.org/all/20260511201155.1488670-1-vipinsh@google.com/
  These selftests changes are needed by other selftests also (iommu, kvm),
  so, I have sent them separately.

[2] https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
  This is the PCI v4, which adds the live update support in PCI core.

[3] https://lore.kernel.org/lkml/20260423174032.3140399-1-dmatlack@google.com/
  PCI v4 is dependent on this.

Github branch I have mentioned at the top has all of these dependencies.

Testing
-------

Series has been tested using new VFIO live update selftests in both qemu and
bare-metal environment. In bare-metal environment, it was ran using the
Intel DSA PCIe device.

vfio_pci_liveupdate_kexec_test test is executed as following

  $ ./setup.sh 0000:00:04.0
  $ ./vfio_pci_liveupdate_kexec_test --stage 1 0000:6a:01.0
  $ kexec --reuse-cmdline -l -s /boot/vmlinuz
  $ kexec -e
  $ ./setup.sh 0000:00:04.0
  $ ./vfio_pci_liveupdate_kexec_test --stage 2 0000:6a:01.0

Kernel commandline used for booting the VM and testing had following
options passed
  - liveupdate=on
  - kho=on
  - vfio_iommu_type1.allow_unsafe_interrupts=Y
  - vfio_pci.enable_sriov=Y
  - vfio_pci.disable_denylist=Y
  - vfio.enable_unsafe_noiommu_mode=Y

Changelog
---------
v4:
 - Addressed sashiko feedback regarding issues in resetting the devize
   in freeze
 - Dropped the patch which was skipping reset of preserved VFIO device
   after kexec when user opens the device. This will be added back in
   future but for now not needed as freeze() is also resetting the
   device before kexec.
 - Kernel doc and comment updates based on feedbacks.

v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/

v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/

v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/

rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (10):
  vfio/pci: Notify PCI subsystem about devices preserved across Live
    Update
  vfio: Enforce preserved devices are retrieved via
    LIVEUPDATE_SESSION_RETRIEVE_FD
  vfio/pci: Store incoming Live Update state in struct
    vfio_pci_core_device
  docs: liveupdate: Add documentation for VFIO PCI
  vfio: selftests: Add vfio_pci_liveupdate_uapi_test
  vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
  vfio: selftests: Expose iommu_modes to tests
  vfio: selftests: Expose low-level helper routines for setting up
    struct vfio_pci_device
  vfio: selftests: Verify that opening VFIO device fails during Live
    Update
  vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

Vipin Sharma (6):
  vfio/pci: Register a file handler with Live Update Orchestrator
  vfio/pci: Preserve vfio-pci device files across Live Update
  vfio/pci: Retrieve preserved device files after Live Update
  vfio: selftests: Build liveupdate library in VFIO selftests
  vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
  vfio: selftests: Add vfio_pci_liveupdate_kexec_test

 Documentation/core-api/liveupdate.rst         |   1 +
 .../driver-api/vfio_pci_liveupdate.rst        |  23 ++
 MAINTAINERS                                   |   2 +
 drivers/vfio/device_cdev.c                    |  67 +++-
 drivers/vfio/group.c                          |   9 +
 drivers/vfio/pci/Kconfig                      |  16 +-
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/vfio_pci.c                   |  13 +-
 drivers/vfio/pci/vfio_pci_core.c              |  62 ++--
 drivers/vfio/pci/vfio_pci_liveupdate.c        | 349 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h              |  19 +
 drivers/vfio/vfio.h                           |  18 +
 drivers/vfio/vfio_main.c                      |  16 +-
 include/linux/kho/abi/vfio_pci.h              |  43 +++
 include/linux/vfio.h                          |  13 +
 include/linux/vfio_pci_core.h                 |   2 +
 tools/testing/selftests/vfio/Makefile         |  23 +-
 .../vfio/lib/include/libvfio/iommu.h          |   2 +
 .../lib/include/libvfio/vfio_pci_device.h     |   8 +
 tools/testing/selftests/vfio/lib/iommu.c      |   4 +-
 .../selftests/vfio/lib/vfio_pci_device.c      |  60 ++-
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 256 +++++++++++++
 .../vfio/vfio_pci_liveupdate_uapi_test.c      |  93 +++++
 23 files changed, 1041 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/vfio_pci.h
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c


base-commit: 2a4c0c11c0193889446cdb6f1540cc2b9aff97dd
-- 
2.54.0.563.g4f69b47b94-goog

