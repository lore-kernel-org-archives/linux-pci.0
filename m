Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31A392C2C
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979404; cv=none; b=ht4U+J6e6BVu/Ys9bfnmjbresTwqgllPyg7ry1n7DR3NJZWDehWfQF3Ycz+IWWhe5oGQ1iwHYmruBTf6ANLoOxwrtjeQUXVEjShn9GzV0QvyFd+LNaZ9tuc41yt8yrFKj1BCGPqvPk0KdNVQIa/v8T7dCRhNMgZzF6DpF6UxH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979404; c=relaxed/simple;
	bh=VEr3YGdqak3FVQ9/ao+xXZ+w5i00Ao9Ssj4jC1ZGrN4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cwqq0nXnTLkOfgEZLKMncsI0JtAGcxytBFU4WJaZEd+/ElDkXL0rR7euTx26f9V8sPcpaiAnpdxs2PI6S/ohUzc8t4t5RbojicKz4wjQegWtEy6wtslRfASBMvWsZipTi4gu211MgZS61IsaUdY/0dHPZflj7tPXxMRGpFquq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRWCMvt+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRWCMvt+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f70ae35c0so3661444b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979400; x=1777584200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=;
        b=rRWCMvt+h3PuppHXtLZezVhdlbTA6Zcppj/YDQyrcfzPTnaUic3TJSS4WZEEFToKZ4
         hEgQpNpVRv8gRkBu1sDU7vCK7zVgprhCR+uKNqWD5ekIVs9NuMHykxG6bAZCuyGWqOo2
         3s4nIdJuc4+p+IbpII6D85umhWozlMypAM/g3v4o6wzAjU63wzDYHkOFUxDwMTJF49Dt
         qyHK7BFIdFPCp17JVgtXnLU9nqmtzrNFx2W2gHxNraGMrJDptUc9L/5HvoljMOYPtuP+
         nupJDKyfqQQMDfsnaYfPFEnCku6OY/dzydgbL+IznzQlYY5uNjkIfuBDr8ZIEIemZvO6
         l/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979400; x=1777584200;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=;
        b=KkdWM/HDG/el6FdZ6oN0dr7+6lc6i80HaJ3rEvSvXitfr0q3rOXLAuChQauv9yqZ7m
         UK6d/16RNV1b2RGPhcapQUVGz5eN7au6tcCCZuJPXPydD/UWOaSaCFPo8fD4y4WBem+O
         pcTKop93Q3XURI2mB9QENFfN/O81YSbZli+gwkm+ZVdKMGzJE/5pnCGobOecvxfWgjMb
         6u3PiKyvJqwp2wYTqb04NKLTw6oPTr7chdcJNW8P72beWSUn9f1IeYW//AE57DqOIY8Z
         fhJNIkkUpZpsly4GS8+tLW4LsEnWKq8I7dPzKr5H7G7Gb+F2GTDPTXLspDgzs1Cce+Oo
         fuVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8F1ASydJEYSNPbem14K04iaYcn4hRCHcz+rfWueH0nMn5e3Haa8oAetl0qd1uVO9m3f1gwc1bcEXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsqccy1W8T5Fgv5r6UyRX9v0s2bFhtTzRljAyhNqANYJZN55I
	GUvfjmmQBDlhvZcZUZwY8YuCjrsLlvpnOsRDfS1wqoEIKLdER6kGi2UFoBq7y3oJ+2IhameLB97
	OZFXMqXFbr4pzIw==
X-Received: from pfhx15.prod.google.com ([2002:a05:6a00:188f:b0:82f:3c29:a283])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd0a:b0:82f:74b2:7fba with SMTP id d2e1a72fcca58-82f8c7dd0d9mr31341067b3a.4.1776979399901;
 Thu, 23 Apr 2026 14:23:19 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:04 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-1-dmatlack@google.com>
Subject: [PATCH v4 00/11] PCI: liveupdate: PCI core support for Live Update
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
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

