Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041429;
	b=miaMhbrCka0i0AsyS7BXD9KnF22FFmccRnabp+9g3De1EeN5z71W6wDGa/SgdLVX63xT
	 M0KzUevCxHbPlPOao6x0bg/r3Swa2yuKCaoEhk1nYg1ZhfHoylnO/EKPsorDkUwhAxaUH
	 NRUZJX0xxpjvuNA4qles3oQ6KklxusoLpsJ8XO65YNJGPH3mv7E2yOqUn8MLCBTY+TFmx
	 kavCZYGcZ9o9mJYaiAPJaStOpIWKNYXSDPzieBOvm2U1YeeJH0Vhok759m3YDjIsfhxTs
	 suZ1fWNIk77xucHQlRyrz++omaDJMyTFvQmX4cyqh7vA7bDSxXv4GyL+gtalEVYdzTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pk/I3wSfbne6vIr6Mw8kkpXlHwTn38hslTEt3tHnxeE=;
	b=N6XELPFbwnjsAkrYkbeMbCJUBJkzMIkSxpnMkSDfz1rin/zV2S8xRz9HWBxzR18FE/Xt
	 NxuOjOpFqTlPRkbFrxVz/ltwKN4Y1NEy774waJpJCf4HSaikW5E+cyX2rvjFi7Eslp/zn
	 I8sovOB+nUV2BBSxszcCCRy0FGWKWJT1IA/pg5HYcgp3uTrOGpGRvGlKoV/qmNEGQoxwK
	 oK8gE5HW4Np37TntC8IDlzzPgGTmV1GnrFueb15q9GLDl/2skapcvEA+fMobz74XEU2YM
	 47Zu7hcaWCtgiC/LD+wRZ21iUH99Cf4MgsGgljky9i9TyV5gX2Uj2nblpHEKg6wQY1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="gOOeLJ8/";
	arc=none smtp.remote-ip=209.85.160.71
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8A606A330
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2A8A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gOOeLJ8/
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4adc1aca8c2so1403170fac.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 14:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041428; x=1795646228; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pk/I3wSfbne6vIr6Mw8kkpXlHwTn38hslTEt3tHnxeE=;
        b=gOOeLJ8/GvA1MwlGnJTs4kYvCxQiILRmm99X61mFTVbGcDJvAcKu+cmafYqyaecY4G
         y/4FnMdD0yzOJ3HJRWbiV7LPTDyzBGtBLoCBYIDBGfc0pV1MUMJNF948yrhVVfCyawox
         xOlLa1P0fbVkw+XRp5vfgGgawpxl49mAqDEyca90adfKZkaQw6urHD/9gSvUJNX/q/x5
         LTfPYV+DpbATV+Ou6ZQtyPRvn8FoIkkJoMCMAHz4nii9s+/8iRFHLufqIGHxQoW0T9ud
         /0A8PVsBjGq8eIRrsUOYWSEzfh3Wz6iaGPcIb3/F2SOHtVDVAuZrqBnYwY8A+le4pJap
         CJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041428; x=1795646228;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pk/I3wSfbne6vIr6Mw8kkpXlHwTn38hslTEt3tHnxeE=;
        b=WeFOLvFhkJkLyQ0TVXAnW9MrJzkIJr7zJfhNitxGID1gp7915x48YFEqEM9oWe2H6Q
         p3Yb2rZxpM9J0aBOsgoO2spIDV6UGDp2hFEHHd8jZjlLZHTZnbarrxX9C92aCVd9xA7O
         lnM9CvwVkgZqWIxyr5EH+M0efMGB1s/wvl6VJSo/uB7H9N2wqOc8bjVqmkQEHSeKD3g7
         DKle1uJ/1AEbRTJ1LmF4EPx1BKa0UphCkFzmuW+JCzZ6qBeskgoohzahRUJfcoi/tdzc
         01c37O7Q6rawFIytvmXbQHxetlcn9SM/eTgUC8YTRQ2OoZ946ZIzSRzeI5YDSZNmRQfp
         k48g==
X-Forwarded-Encrypted: i=1; AL+hErFEru86OxfuEERPdYD5oYZlxFRMmBcarZmgKrFm8XudWEcqo3iWG0mMWJb/aMz7VKU1U1ZMMvzP/YA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qV3BYIwXvc67D7LdEYbvL1qgjB5yi/U3Uys0UWho8RtisVspZ
	9SQ1NotK+AUfmkKgyCqR471GD0IhrxOstdwXcqY/pUJbOxAOss6A9VgKHtPSYGz3C+13FUslDM6
	g+k/9kw7HJw5DvQ==
X-Received: from ilbdx7-n2.prod.google.com ([2002:a05:6e02:4207:20b0:549:b431:8d75])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:16a8:b0:567:e971:200c with SMTP id 5614622812f47-57741228693mr4525440b6e.41.1795041427354;
 Wed, 18 Nov 2026 14:37:07 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-1-dmatlack@google.com>
Subject: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v11

This series introduces support in the PCI core for Live Update, enabling
drivers to preserve PCI devices across a kexec-based kernel update
without interrupting the device. This lets devices, such as ones
assigned to VMs through VFIO, keep running across a host kernel upgrade.

Preserved devices can keep doing DMA to system memory throughout the
Live Update. Devices may be behind bridges, but VFs, devices that need
device-specific ACS quirks, and CardBus are not supported. Support for
P2P and VF preservation will be addressed in future series.

Series Overview
---------------

This series implements the following to support PCI device preservation
across Live Update:

  1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
     PCI-specific state (struct pci_ser) across Live Update using Kexec
     Handover (KHO).

  2. Add APIs for drivers to register devices for preservation
     (outgoing) and for the PCI core to identify preserved devices
     during enumeration (incoming).

  3. Automatically preserve all upstream bridges for any preserved
     endpoint. Use reference counting to ensure bridges remain preserved
     as long as any downstream device is preserved.

  4. Keep the Requester ID (bus, device, function) of preserved devices
     stable for the duration of their preservation by adopting the
     secondary bus numbers, subordinate bus numbers, and ARI Forwarding
     Enable of preserved bridges. After a Live Update, pci=assign-busses
     and pci=noari do not override this adopted state.

  5. Save and restore the ACS Control register and Egress Control Vector
     across resets for all devices (patch 8), so that adopted ACS
     controls survive a reset.

  6. Keep memory transactions to/from preserved devices routed
     consistently by adopting Access Control Services (ACS) controls
     across a Live Update, from the endpoint up to the root port.

  7. Freeze each device's preservation status when it is shut down, and
     avoid disabling bus mastering on preserved devices in the PCI
     shutdown path, so preserved devices can keep doing DMA during
     kexec.

  8. Add Documentation/PCI/liveupdate.rst, built from the kernel-doc in
     drivers/pci/liveupdate.c and include/linux/kho/abi/pci.h, describing
     the FLB API, device tracking, and the division of responsibilities
     between the PCI core, drivers, and userspace.

Merge Plan
----------

This series is intended to go through liveupdate.git, the tree listed in
the new PCI LIVE UPDATE MAINTAINERS entry.

v10 and a follow-up patch were applied to the lu-pci-preservation branch
of liveupdate.git. This version is meant to replace them, and applies on
v7.4-rc1, the base of that branch.

Testing
-------

VFIO
~~~~

This series was tested with v5 of the vfio-pci Live Update series,
rebased onto this series and the luo-internal-api branch of
liveupdate.git (which the VFIO series depends on):

  https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub.

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v11-with-vfio

Testing was performed using the VFIO selftests, including the new Live
Update selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

The tests were run in a QEMU-based VM environment (using an emulated
Intel IGB device connected to a PCIe Root Port to exercise bridge
support) and on bare metal using an Intel Emerald Rapids server with 8x
Intel DSA PCIe devices and 1x NVMe device, all of which were preserved
across a Live Update by vfio_pci_liveupdate_kexec_test.

PCI Selftests
~~~~~~~~~~~~~

This series was also tested with a new set of PCI Live Update
selftests:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v11-with-selftests

Each test preserves a PCI device across a Live Update in a QEMU VM and
checks that the PCI core keeps the device, and every bridge above it,
running: same BDF and bus numbers, Bus Master Enable left set, ARI
Forwarding Enable and ACS controls adopted from the previous kernel, and
no PCI config writes that disrupt the device during the Live Update. The
tests cover endpoints on the root bus, below a Root Port, below a
switch, and below two levels of switches, as well as booting the next
kernel with command lines that would otherwise renumber buses or change
ARI and ACS. All tests pass on x86_64 (q35) and arm64 (virt), except
for the pci=assign-busses test, which is skipped on arm64 (the option is
x86-only).

Future Work
-----------

Please see the PCI core Live Update Roadmap:

  https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/

Changelog
---------

v11:
 - Rebase onto v7.4-rc1, the base of lu-pci-preservation in
   liveupdate.git
 - Fold in "PCI: liveupdate: Factor out pci_dev_ser allocation and
   release", which was posted and applied as a follow-up to v10 [1]:
   introduce the struct pci_dev_ser allocation and release helpers in
   "Track outgoing preserved PCI devices", and split
   pci_liveupdate_preserve_device() into separate paths for new and
   already-preserved devices in "Auto-preserve upstream bridges across
   Live Update" (suggested by Bjorn; the follow-up was reviewed and
   tested by Chris Down)
 - Don't allocate an ACS save buffer for devices that rely on
   device-specific ACS quirks (Alex)
 - Adopt the ACS controls of preserved devices even if they match a
   device-specific ACS quirk, logging a warning instead of programming
   ACS from scratch, and panic if a preserved device has no ACS save
   buffer (Alex)
 - Clean up commit messages, comments and documentation: fix
   inaccuracies, remove filler and duplicated text, document that
   pci=noari does not override adopted ARI Forwarding Enable, and note
   in the documentation that devices cannot be preserved or unpreserved
   once they are shut down
 - Panic if any outgoing device was never unpreserved when the outgoing
   FLB is freed, instead of leaving dangling dev->liveupdate.outgoing
   pointers, and share the check with the incoming side (Sashiko)

[1] https://lore.kernel.org/linux-pci/20261109174009.735309-1-dmatlack@google.com/

v10: https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
v9: https://lore.kernel.org/linux-pci/20260918200640.887030-1-dmatlack@google.com/
v8: https://lore.kernel.org/linux-pci/20260728221007.2098560-1-dmatlack@google.com/
v7: https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/
v6: https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/
v5: https://lore.kernel.org/linux-pci/20260512184846.119396-1-dmatlack@google.com/
v4: https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/
v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/
v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (13):
  PCI: liveupdate: Set up FLB handler for the PCI core
  PCI: liveupdate: Track outgoing preserved PCI devices
  PCI: liveupdate: Track incoming preserved PCI devices
  PCI: liveupdate: Document driver binding responsibilities
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
  PCI: liveupdate: Preserve bus numbers during Live Update
  PCI: Refactor matching logic for pci_dev_acs_ops
  PCI: Save and restore the ACS Control register and Egress Control
    Vector
  PCI: liveupdate: Adopt ACS controls in incoming preserved devices
  PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
  PCI: liveupdate: Freeze preservation status during shutdown
  PCI: liveupdate: Do not disable bus mastering on preserved devices
    during kexec
  Documentation: PCI: Add documentation for Live Update

 Documentation/PCI/index.rst                   |    1 +
 Documentation/PCI/liveupdate.rst              |   35 +
 .../admin-guide/kernel-parameters.txt         |   11 +-
 Documentation/core-api/liveupdate.rst         |    5 +
 MAINTAINERS                                   |   15 +
 drivers/pci/Kconfig                           |   14 +
 drivers/pci/Makefile                          |    1 +
 drivers/pci/liveupdate.c                      | 1011 +++++++++++++++++
 drivers/pci/liveupdate.h                      |   72 ++
 drivers/pci/pci-driver.c                      |    8 +-
 drivers/pci/pci.c                             |  169 ++-
 drivers/pci/pci.h                             |    5 +
 drivers/pci/probe.c                           |   16 +-
 drivers/pci/quirks.c                          |   58 +-
 include/linux/kho/abi/pci.h                   |   96 ++
 include/linux/pci.h                           |    7 +
 include/linux/pci_liveupdate.h                |   72 ++
 17 files changed, 1556 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.1.703.gf848ed807c-goog

