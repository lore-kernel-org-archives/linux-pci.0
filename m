Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58D3AEB5F
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276624; cv=none; b=o+TJsweSfYq2XJ/3SB+ir8L7bcev7mHi7x1U6zFxs4sLq2N6LlS54PmUE33hjT72GUGmaOXQYSzYvjarOdQDLBvmvpnkfm4GdAmO8ukpC5g+CXJxJOF/1MQEH3y9hs6e/eJ6nnV45KDN3RHXnmq2duwIAVdEbmNcwb8FvU28bQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276624; c=relaxed/simple;
	bh=0UZNuviYLx19aO8YEdfXL7RZbmJoZicnA+RK4QIknWQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t4FdRXk8yr+DrBEuiKcWMfmdSSdAgp7t/rXAQDqYRA3kgLVR2xM5oj07s9fizBIgdt1O5o+e6vqzlTW512xvIpj6hhxewZyYyF0udIB34OxtSJ8wtb2CCCh/trFMBE2nbl8MCGX0ws3SwhYu6ZLgXged5tqn25cdDwXbnUz36v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=halpzjT7; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="halpzjT7"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so501777b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276621; x=1785881421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=APTOBAxUiPao4l9S27Y+m2/wTZqMb3MMdg2HVgF0ixE=;
        b=halpzjT7LE2pU8bbQMFrdX+TTgdhkR0/YY+CuYIlfRFsM6MkJxMS9TzkHnHGhuta+0
         gydOWdiWgFxC9lDKDJxP2YSbV8r61YgLmdu3R2JYwlwXlZNQUZtYj+uU4hW5sZ/W0xbO
         aL4rutiI1JcYlkl/8EtZqZdxbr9v0H+Ysmis823XShHTTMfSTQp73J5nj4Ba6sp1rjEv
         OhKoi2mN6Na/M8g241fxwvJxUep/11fRR6LrvdZTK9RmkWHp7inCXOuGK96o8lcHNQ53
         fAZo5Spii+tldb9JYKhmzTJrQ9sPItPjK5v/AIaheRaENowLUGiLjxA+69mXuNAPJ3Bi
         axFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276621; x=1785881421;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APTOBAxUiPao4l9S27Y+m2/wTZqMb3MMdg2HVgF0ixE=;
        b=rfn8TCDUEDbq+ky3UX39ToSloqze4SBhyll4JqH5Hig5htSqRssbI/kKP8sXekzV/m
         z2w84zWDR780FpgzDsWzoSKHSvMKAesowlZgO6yQJov1qHtLIXKQtycjO9aXNMKhXJru
         U1gh3oS2iNB025d+1B2Suscih6iqRUtDgOfDQNLb62VzIfr06YXRo4ryyAG2GAHF/zGU
         1F3akzw5YG1hZDb21uX6aSUVKRflwkLdyprKN+NU/lexMzYJM4TVukIH+sBRJmfdQGg/
         DL6Cq0d9JTYmn76bjEg08fCxgMX8EYihHMA2mWFI9C72OyQLPUFCKEPtS3maN0g/7hpO
         tRdg==
X-Forwarded-Encrypted: i=1; AHgh+RoV/HQhjgL8q0r85m2J3p/dTUUMyFUtIUYY6veCW+rUOO0Uwz1KGxzXOimZItoEXD+6J03ZEvPEcYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvxmZCLIs9tuh61GJ+2K0YVSzmvx0uOcu/uzjOtsVtQJjylCa
	5fvnYrUu3C3cbwcMscczttNOpNbO9EnwQYDRBuFyh6bIl0VMKG+pLaXtlNT+ska57DXCqdnqy6L
	QIHNv2AYFQn2+5w==
X-Received: from pgbfm24.prod.google.com ([2002:a05:6a02:4998:b0:c8b:2706:11a7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2192:b0:848:2f84:f433 with SMTP id d2e1a72fcca58-84e93367cf5mr4264411b3a.76.1785276620540;
 Tue, 28 Jul 2026 15:10:20 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:09:54 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-1-dmatlack@google.com>
Subject: [PATCH v8 00/12] PCI: liveupdate: PCI core support for Live Update
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
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

NOTE: I am sending v8 out a little earlier than I normally would since I
will be AFK from July 29th (tomorrow) through August 6th and would like
to post the changes made in response to v7 feedback before then. I will
respond to any review feedback on v8 on August 7th or shortly after.

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v8

This series introduces initial support in the PCI core for Live Update,
enabling drivers to preserve PCI devices across a kexec-based kernel
update without interrupting the device. This functionality is critical
for minimizing downtime in environments where PCI devices (e.g., those
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

I propose we merge this series through liveupdate.git for 2 reasons:

 1. There are some LUO core changes around how FLBs are refcounted in
    the next branch of liveupdate.git that this series depends on.

 2. We had previously agreed that the files covered by the PCI LIVE
    UPDATE maintainer entry would be merged through the liveupdate.git
    tree (which is the majority of this series), so this would be
    following that process.

This plan still needs to be Acked by Bjorn Helgaas as there are some PCI
core changes in this series.

Dependencies
------------

This series is built on top of the next branch of the liveupdate.git
tree for the incoming and outgoing FLB reference counting patches.

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=next

Testing
-------

This series was tested in conjunction with v5 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub.

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v8-with-vfio

Testing was performed using the new VFIO selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

Both tests were run in a QEMU-based VM environment (using a single
virtio-net PCIe device connected to a root port to exercise bridge
support) and on bare metal using an Intel EMR server with 8x Intel DSA
PCIe devices and 1x NVMe device.

Future Work
-----------

Following this series, we expect to make further improvements to the PCI
core support for Live Update:

  - Allow P2P across Live Update by avoiding resizing or moving
    preserved device BARs and preserving all upstream bridge windows.

  - Support preserving Virtual Functions by preserving SR-IOV
    configuration on PFs and enumerating VFs after Live Update.

Changelog
---------

v8:
 - Use __free() and no_free_ptr() in pci_flb_preserve (Pasha)
 - Sort linux/kho_block.h include alphabetically (Pasha)
 - Fix reverse-fir-tree variable ordering (Pasha)
 - Eliminate unnecessary loops to allocate a new pci_dev_ser (me)
 - put() the outgoing FLB refcount now that get() takes a reference (me)
 - Document -ENODEV handling in pci_liveupdate_flb_get_incoming() (Alex)
 - Detect and panic on PCI FLB version mismatches instead of silently
   ignoring (Alex)
 - Panic if drivers violate contract to call pci_liveupdate_finish()
   before LUO drops its reference to the preserved device file (Sami,
   Pasha)
 - Use pci_upstream_bridge() instead of raw dev->bus->self (me)
 - Add a comment about ari_enabled bitfield safety (Sashiko, Pasha)
 - Add drivers/pci/liveupdate.c :internal: kernel-doc to
   Documentation/PCI/liveupdate.rst (Pasha)
 - Collected Reviewed-by tags (Pasha, Bjorn)
 - Remove use of KBUILD_BASENAME (Bjorn)
 - Make pr_debug()s more useful (Bjorn)
 - Refactor bus number preservation logic, variables, and function names
   (Bjorn)
 - Move for_each_pci_dev_in_path() to include/linux/pci.h and drop _end
   parameter (Bjorn) and _start parameter (me)
 - Rename and add kernel-doc comments to functions that adopt ARI
   enablement and ACS flags established by the previous kernel during
   enumeration to make the code more readable (Bjorn)

v7: https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/
v6: https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/
v5: https://lore.kernel.org/linux-pci/20260512184846.119396-1-dmatlack@google.com/
v4: https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/
v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/
v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (12):
  PCI: liveupdate: Set up FLB handler for the PCI core
  PCI: liveupdate: Track outgoing preserved PCI devices
  PCI: liveupdate: Track incoming preserved PCI devices
  PCI: liveupdate: Document driver binding responsibilities
  PCI: liveupdate: Preserve bus numbers during Live Update
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
  PCI: Refactor matching logic for pci_dev_acs_ops
  PCI: liveupdate: Adopt ACS controls in incoming preserved devices
  PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
  PCI: liveupdate: Freeze preservation status during shutdown
  PCI: liveupdate: Do not disable bus mastering on preserved devices
    during kexec
  Documentation: PCI: Add documentation for Live Update

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/liveupdate.rst              |  35 +
 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/liveupdate.rst         |   5 +
 MAINTAINERS                                   |  15 +
 drivers/pci/Kconfig                           |  15 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 939 ++++++++++++++++++
 drivers/pci/liveupdate.h                      |  66 ++
 drivers/pci/pci-driver.c                      |   9 +-
 drivers/pci/pci.c                             |  14 +-
 drivers/pci/pci.h                             |   5 +
 drivers/pci/probe.c                           |  23 +-
 drivers/pci/quirks.c                          |  58 +-
 include/linux/kho/abi/pci.h                   |  64 ++
 include/linux/pci.h                           |   7 +
 include/linux/pci_liveupdate.h                |  77 ++
 17 files changed, 1302 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: cecfb90c5f2cc0622b363c2291b69d6cad272897
-- 
2.55.0.487.gaf234c4eb3-goog

