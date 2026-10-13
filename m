Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AD51A14C
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908738; cv=none; b=HIbK7TxVdpWD0SJljW4A9dAUvt3B240/ndRdIEAu2NqcNBZyh4CCplymSoz5LCj0cGUvLnSNnnCXSB14NSz/M4rSn4YT063uAxqb+5N/KNOU2Y3cvGkwaEZeB8uJADf8CYf/5f5ei8PKHgZfoA6nDdzv/zN2yHzwVbUC7irE8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908738; c=relaxed/simple;
	bh=0xNJOb/H9UtwUf5zYgBgR5vpK0hLcAELc8eV5cybtEk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rvnIv3w/BPPmlHM2zfc/yN0jX4utRs5FYB+lDtOfRhUYZFIL/4d61Fc35HnDjJgXNdnur4pvoFqtfp0gknrwwuztkJi/SbuUzoLL7YkhHXD6DutmkG9ynnOlUIrFLLC5T8tWOFnolXHmYPvVV3j7RYwrRef6Oyx5qm24Ug15niQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebVyHi2q; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebVyHi2q"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so4528894a91.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791908735; x=1792513535; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jeAXIyFq6wDt1DrhCTJh2CZ3Qk782HPpYdtAi65KBOg=;
        b=ebVyHi2qO1fTjV+ChvhTcruJufu4aFJjN+GMJ2vUbEMmBk74lrNd33hUWy1tnxYFog
         aNFj+fYpL1Exc0K2rCJVP3NDv1XSvjWncGYDFKQfijKmCfFcX7Zyx5JEd9vsmlh7CFJS
         G7q7VBNUDBVJwQzsrYJu2lCkM3sTLWmharBnECiaqaRNLFRRoyIR3E2Nk5MBc2QPxY6k
         MnUi/WcxUNdB0klVwyeNaj528b0F3op9JroPpimsuWlMbLY6EA2g04hIzkMYe5NWABP1
         11veryQKTxDiAY+JM+vh4eHXh4n5BvyoVEFnwOsZUA/lqRtrP+U4N0ylElEmboGYUG/R
         y2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908735; x=1792513535;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jeAXIyFq6wDt1DrhCTJh2CZ3Qk782HPpYdtAi65KBOg=;
        b=neKjByYmLMAuooGbCHCVH/4erfxEo17rwOMMpwArHb5cZoDvFbfTE6UfguF0i+yJkF
         16PiBSSo+wB6MbHW0d4sjnxSFVfn5tyas7GfnXZUtzQopmMiLKnbRUr6fYZGLqL7KSIV
         RjOlGSy22n1fyt+VFFysKcVPX8aocL+5vSBvS6zRxKxRTrEIPgpFoUBDWFFpGjTbqlNV
         B6bOzy5xi0pxcR1/i1PjJ1PXpdsLbVDItc3yKAv8tBhJ8CLpkchHCxL+deiSn/GKV7LR
         IZ1Y49x7MKBVSSnkfOutr8srNCfo5Fv+hyd3fy4HlU8znz0sSAsQL2KUDtXiLX2CB9aX
         0XcA==
X-Forwarded-Encrypted: i=1; AKwUvBwQKjRO6DC2Szp2g+atAI0wxO28iKoOQedb+omZQn27dCfeYYtfB2VzhR3qWauE+0rPR97FW9jmKJA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL58WCM5WnpFLqP/nHhClg2HXLHNViAENpjnPnNmoRBOcc6JnYz
	GLSNg/H2jgvxoa2Swy8io/X0pUL3wm33IJnkLj8NlH03DXxYvSsfeo8kAb0+de5OCsG4AzCbfsC
	q69Y/5jxzb2sodg==
X-Received: from pgbe27.prod.google.com ([2002:a63:501b:0:b0:cc7:dec6:f87d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f91:b0:3ac:53e0:4ed5 with SMTP id 98e67ed59e1d1-3ac53e0532fmr683953a91.39.1791908734381;
 Tue, 13 Oct 2026 09:25:34 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:25:16 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013162529.1928093-1-dmatlack@google.com>
Subject: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
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

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10

This series introduces support in the PCI core for Live Update, enabling
drivers to preserve PCI devices across a kexec-based kernel update
without interrupting the device. This functionality is critical for
minimizing downtime in environments where PCI devices (e.g., those
assigned to VMs via VFIO) must continue operating or maintain state
across a host kernel upgrade.

Specifically, this series allows preserved PCI devices to perform
uninterrupted memory transactions (DMA) targeting system memory
(specifically, preserved memfds) across a Live Update. These devices can
be behind a bridge but must not be VFs. Support for P2P and VF
preservation will be addressed in future series.

Series Overview
---------------

This series implements the following to support PCI device preservation
across Live Update:

  1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
     PCI-specific state (struct pci_ser) across Live Update using Kexec
     Handover (KHO).

  2. Add APIs for drivers to register devices for preservation
     (outgoing) and for the PCI core to identify preserved devices
     during enumeration (incoming)

  3. Automatically preserve all upstream bridges for any preserved
     endpoint. Use reference counting to ensure bridges remain preserved
     as long as any downstream device is preserved.

  4. Guarantee that preserved devices retain the same RequesterID (bus,
     device, function) for the duration of their preservation by
     inheriting secondary bus numbers, subordinate bus numbers, and ARI
     Forwarding Enable on preserved bridges.

  5. Guarantee that memory transactions to/from preserved devices are
     routed consistently by inheriting Access Control Services (ACS)
     flags across a Live Update, from the endpoint up to the root port.

  6. Modify the PCI shutdown path to avoid disabling bus mastering on
     preserved devices, thereby allowing preserved devices to perform
     uninterrupted during kexec for Live Update.

  7. Provide comprehensive documentation for the FLB API, device
     tracking mechanisms, and the division of responsibilities between
     the PCI core, drivers, and userspace.

Merge Plan
----------

This series will be merged through liveupdate.git, matching the
agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.

Testing
-------

This series was tested in conjunction with v5 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub.

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v10-with-vfio

Testing was performed using the new VFIO selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

Both tests were run in a QEMU-based VM environment (using a single
virtio-net PCIe device connected to a root port to exercise bridge
support) and on bare metal using an Intel EMR server with 8x Intel DSA
PCIe devices and 1x NVMe device.

Future Work
-----------

Please see the PCI core Live Update Roadmap:

  https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/

Changelog
---------

v10:
 - Save and restore the ACS Egress Control Vector along with the ACS
   Control register, sizing the save buffer from the HwInit Egress
   Control Vector Size field (Alex) and drop Bjorn's R-b tag
 - Make CONFIG_PCI_LIVEUPDATE depend on 64BIT from the first patch
   rather than adding the dependency later in the series (Pratyush,
   Mike)
 - Reword kernel-doc comments to read better in the HTML docs and
   spell out "reference count" (Mike)
 - Replace the version number at the start of struct pci_ser with
   required_flags and optional_flags, and record the size of struct
   pci_dev_ser, so that the PCI FLB ABI can be extended (LPC BoF)

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
 .../admin-guide/kernel-parameters.txt         |    7 +-
 Documentation/core-api/liveupdate.rst         |    5 +
 MAINTAINERS                                   |   15 +
 drivers/pci/Kconfig                           |   15 +
 drivers/pci/Makefile                          |    1 +
 drivers/pci/liveupdate.c                      | 1038 +++++++++++++++++
 drivers/pci/liveupdate.h                      |   62 +
 drivers/pci/pci-driver.c                      |    9 +-
 drivers/pci/pci.c                             |  159 ++-
 drivers/pci/pci.h                             |    5 +
 drivers/pci/probe.c                           |   16 +-
 drivers/pci/quirks.c                          |   58 +-
 include/linux/kho/abi/pci.h                   |   96 ++
 include/linux/pci.h                           |    7 +
 include/linux/pci_liveupdate.h                |   72 ++
 17 files changed, 1562 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: 945d61765894dda2f0344de50cb1ade2e51b66fd
-- 
2.56.0.385.gd3acb90ef8-goog

