Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8143BD648
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979367; cv=none; b=Uc1YzhIBzqHDk+WoXks99rZyYPuq3LNPw6rn26fcvsY0kC6U6Gs8gpHXp9l7gVrFB+sk8E5/Efm2OZJlb0klxLCb91kg46XijHzleEQOTCnC1Syhc5Y116g8cxSTuA+jejkl8Hw7Oop3j8kVeUByH3QI3j8yF4Qbvm9j44D6KxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979367; c=relaxed/simple;
	bh=VEr3YGdqak3FVQ9/ao+xXZ+w5i00Ao9Ssj4jC1ZGrN4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=SNdHImCloQ3NAJ2814WAaPljjyrgV0B/vC+sXVJl5rWRurmoCl6LCkLnYdygAOhl1hiVGTjIAPNA+Z0R4diX33IeSI6ye7d5OXLxlweb2hvZ+tBTn1KC23crdlhxPN7mKedSN5N0mEoN+z2s3cT6fRMpdfeg/LupTAbkkkfRV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbdpiwSs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbdpiwSs"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b461b36990so76308595ad.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979364; x=1777584164; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=;
        b=mbdpiwSsOjUrW5IGSArA8vhCsSEPPwz2w+bbEWubZTO96PjGKHHS5tMk5qhx652vy6
         +awzGC6QYXoiKEy35HALvsrTZ/vVlQiEzQHSBIl3IWjUMJ1JieM9EC/kNtUZ8XDtbD/h
         aqbTKe7/kqhyarZfTJTVM7vO+SD1uwLNLfTH8Sr50+aMHJtTvW3EAtOrmNEE9IZuetBh
         /oZIXW7tuOe//zpx2YeccBk1FwckkFk37JYnTgTWdFcvVZYNx5oBphjWv44q6rSfN3uZ
         28jC2Fc4/nupjzq5lk9ZL4gzkKCqY9IgCUfqgh31qC2rvAoe2jpoKWs4lzzy68DJ2Qs5
         hfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979364; x=1777584164;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=;
        b=cXV3WuDbYsV4T/GbtkAWzh0ULHlcf1RYqwxlhjackN+nBF55QgBs205z8wqPcyf3RK
         8v9FGHDBhWVRoOknLC17nf3Lrto58/XhlesRiaduzTAFzeLXR6A5Qku8gSGHOBixQbGC
         r9Jk/jMqwS8RGKZhBO5GFQ4++3PEuOolPoVJ40RkS9xFnWfsxaTqWzgwdq+9uTf/tlFa
         EB9nvuCNmT/qtPZMENF7+Q2SdxliglqwOvGaFRPDTo8Ha1oUdLVeJ6Rdk52FCazOUnRK
         YyaTmLzXTMmGz6e+M4JJMKF0vOW14B7RvDaRZAJeF4EZ0AkVPZKOLxzN9isptVyJEIs9
         oCBw==
X-Forwarded-Encrypted: i=1; AFNElJ9lG/HC+t/ctM+SJxLus9cvfNWKnNz4ArML+cOD970jDYmYf4R3wgsv+BaITY+B+mflSVTyKfO3ACM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySlI7gnnWldkcWNvakKGOt7YP8hgi4tATA5xNNTe5FVgfRbTLV
	zsKiDxm6/9UcqFfHHQEICUk8YoiCmw6AdJH+c2xnbgVrGNRFgGKJEGavZY4bP6uvRO5a855HFsK
	bAqh72v6lanZwMQ==
X-Received: from plnx22.prod.google.com ([2002:a17:902:8216:b0:2ae:ce70:7c80])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:7d8c:b0:2b4:604c:ec6f with SMTP id d9443c01a7336-2b5f9f86840mr213628685ad.32.1776979363647;
 Thu, 23 Apr 2026 14:22:43 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:22:31 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212242.3431136-1-dmatlack@google.com>
Subject: [PATCH v4 00/11] PCI: liveupdate: PCI core support for Live Update
From: David Matlack <dmatlack@google.com>
To: dmatlack@google.com, iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v4

This patch series introduces support in the PCI core for Live Update,
enabling drivers to preserve PCI devices across a kexec-based kernel
update without interrupting the device. This functionality is critical
for minimizing downtime in environments where PCI devices (e.g., those
assigned to VMs via VFIO) must continue operating or maintain state
across a host kernel upgrade.

This series was split off from the the VFIO driver series [1] to enable
more rapid iteration on the PCI core changes, add breathing room to
split changes into smaller patches, and add some more functionality.

Series Overview
---------------

This series implements the following to support PCI device preservation
across Live Update:

  1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
     PCI-specific state (struct pci_ser) across Live Update using Kexec
     Handover (KHO).

  2. Add APIs for drivers to register "outgoing" devices for
     preservation and for the PCI core to identify "incoming" preserved
     devices during enumeration.

  3. Automatically preserve all upstream bridges for any preserved
     endpoint. Use reference counting to ensure bridges remain preserved
     as long as any downstream device is preserved.

  4. Inherit secondary/subordinate bus numbers, ARI Forwarding Enable,
     and Access Control Services (ACS) flags from the previous kernel to
     ensure a stable routing fabric and consistent IOMMU group
     assignments during Live Update.

  5. Restrict preservation to devices in immutable singleton IOMMU
     groups. Require that all upstream bridges have the necessary ACS
     features enabled to prevent IOMMU group changes across the update.

  6. Modify the PCI shutdown path to avoid disabling bus mastering on
     preserved devices and their upstream bridges, allowing memory
     transactions to continue uninterrupted.

  7. Provide comprehensive documentation for the FLB API, device
     tracking mechanisms, and the division of responsibilities between
     the PCI core, drivers, and userspace.

This series could be simplified down to fewer patches by limiting
preservation support to only devices on a root bus. Supporting devices
downstream of bridges could be split off into a follow-up series.
However since I got bridge preservation working and the series was less
than 15 patches I opted to include it for now.

Dependencies
------------

This series depends on 2 LUO patches to enable refcounting of the
incoming FLB so that it is safe for the PCI core to use
liveupdate_flb_get_incoming() during enumeration.

  https://lore.kernel.org/lkml/20260423174032.3140399-1-dmatlack@google.com/

VFIO support for PCI device preservation is built on top of this series.
The following branch on GitHub contains all the patches together to
enable testing (the LUO FLB changes, this series, and the VFIO patches):

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v4-with-vfio

Testing
-------

This series was tested in combination with the VFIO patches mentioned in
the previous section using the the new VFIO selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

Both tests were ran in ran in a QEMU-based VM environment, using a
single virtio-net PCIe device behind a PCI-to-PCI bridge as the test
device, and in a baremetal environment on an Intel EMR server, using 8x
Intel DSA PCIe devices (each on a host bridge).

Future Work
-----------

After this series we expect to make further improvements to the PCI core
support for Live Update. Once these are done we plan to drop the
"experimental" verbiage from PCI_LIVEUPDATE Kconfig help message and
documentation.

  - Ensure bridges with downstream preserved devices stay in D0 across
    Live Update in case preserved endpoints are doing memory
    transactions.
  - Preserve BARs of all preserved devices to avoid disrupting P2P

Beyond that we also plan to add support for preserving Virtual Functions
since that is a major use-case for Cloud environments. This will require
keeping SR-IOV enabled on the partent PF across a Live Update.

Changelog
---------

v4:

 Enhancements on top of previous series:

 - Split "PCI: Add API to track PCI devices preserved across Live
   Update" from v3 into 4 separate commits to make reviewing easier (FLB
   setup, outgoing device tracking, incoming device tracking, and
   documentation for driver binding)
 - Use new incoming FLB refcounting to avoid use-after-free bugs during
   enumeration
 - Use an xarray to speed up looking up of incoming preserved devices
   during enumeration
 - Use a per-device bit to indicate when secondary and subordinate bus
   numbers should be inherited on bridges instead of global data to
   avoid races between the 2 passes
 - Inherit ARI enablement across Live Update
 - Automatically preserve bridges upstream of preserved endpoints so
   so that ACS flags, ARI enablement, and bus mastering can be kept
   constant on bridges across Live Update
 - Avoid clearing bus mastering during shutdown on outgoing preserved
   device to avoid disrupting memory transcations being performed by
   preserved devices
 - Add a MAINTAINERS entry for the new files to support Live Update in
   the PCI core
 - Add info and debug level logging for various events throughout device
   preservation

 Changes based on review feedback on v3:

 - Fix up typos, wording, documentation gaps, and code style (Bjorn)
 - Use pci_WARN_ONCE() where possible (Bjorn)
 - Require ACS flags to preserve devices behind bridges so that
   singleton IOMMU group topology is guaranteed to remain across Live
   Update (Yi)
 - Preserve ACS flags (Jason, Alex)

v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/

v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/

v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/

rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


[1] https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/

David Matlack (11):
  PCI: liveupdate: Set up FLB handler for the PCI core
  PCI: liveupdate: Track outgoing preserved PCI devices
  PCI: liveupdate: Track incoming preserved PCI devices
  PCI: liveupdate: Document driver binding responsibilities
  PCI: liveupdate: Inherit bus numbers during Live Update
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
  PCI: liveupdate: Inherit ACS flags in incoming preserved devices
  PCI: liveupdate: Require preserved devices are in immutable singleton
    IOMMU groups
  PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges
  PCI: liveupdate: Do not disable bus mastering on preserved devices
    during kexec
  Documentation: PCI: Add documentation for Live Update

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/liveupdate.rst              |  23 +
 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/liveupdate.rst         |   1 +
 MAINTAINERS                                   |  13 +
 drivers/iommu/iommu.c                         |  35 ++
 drivers/pci/Kconfig                           |  14 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 562 ++++++++++++++++++
 drivers/pci/pci-driver.c                      |  31 +-
 drivers/pci/pci.c                             |  22 +-
 drivers/pci/pci.h                             |  13 +
 drivers/pci/probe.c                           |  25 +-
 include/linux/iommu.h                         |   7 +
 include/linux/kho/abi/pci.h                   |  62 ++
 include/linux/pci.h                           |  58 ++
 16 files changed, 858 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 include/linux/kho/abi/pci.h


base-commit: a13f7eb5b2d5bef886659768680093bec1c0470d
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

