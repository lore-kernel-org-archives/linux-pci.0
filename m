Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4667344021
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762016; cv=none; b=VvHkBOLawYWzUXsXkQBoeasT6wIufFF1vO34EJ4UmZ3E8BRn7MWpKUPoBnTMWUgcg2Rv6/sHtF6RyHn+ZcEbK4hYVtqdobEiUYV/zP9UQeiiv24I32z9Ikn4Szghv9YRrkUEAQGgvWBYV3JTl00s+dv2XnwKzKR8bb1+Sn54kww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762016; c=relaxed/simple;
	bh=Zsz2XBty4DrUzkYE28zuU0zxv8Tp8KjlGL3dp3Cgt/M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UbNOc6qq1g5XC7v040AAJ23edRAVShYCF0LWcaNnToTDxfi0fxAqxiUzvmsejWXccV8cO1FnbztIcHVu2OBYow1CIMl1n6TzolKfN0Dj8wxA0w/k2OZunGeTuTm8Zbgh3LZwDWhg21fo5eoNew7m3+REefuykAsJ3lH6qMinnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gz89pMwJ; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gz89pMwJ"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc73f47bdcso18947415ad.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789762014; x=1790366814; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9dgEgtpibtgILH/mmPgortIM28q3qh0q2cfvPFa8qo=;
        b=gz89pMwJ9olKhepHykTJoh07aQ4pPzDCATWpBD2l6YbEU9unwCZn0eKLemuuSFhmPy
         bbEFMwZqpGaiofnAAbna/r7Kj/+pC5aEX2Om7tVbvQbzw6mb8i6DVcO0VwR6rmIVfbNa
         BYQg0z/LQNktfb0M7G7zqGNovjf+JHFNLO56YGD7ynz+P3zO3A1JYAx7yXsy1KdA7o87
         5Jg1FHPx0yKqLY5Vne1khJTIF4j+at6OzzOd0bW+MhTrGkNiS8ZQpkvGwGbWV7o5L5cq
         sKS0qXHn5D0S9QOwsvmWTdpJ8X9abhasjQCB8nDVvSTy+cxDLAaXm+Pi8vCv9t+5LhqX
         yjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762014; x=1790366814;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9dgEgtpibtgILH/mmPgortIM28q3qh0q2cfvPFa8qo=;
        b=mtcIAvsBC9vaqURqV8LX4PMUIH15MiZrHPrdfzFVlhWL+rIuom/vZwCl2ABzepSLXB
         0MdAxTtBKhQdnh/v35hAdwZer6nERfDoNQ7A+b2Vp5XE+WQP4TpZ/2/YoHeuBS0PvEqm
         sWv0NhijqydimBAvetSXfqKLzDpnf4pH7IvspNtWzIcmexC01Q+ti7MsLh+ynXCY5K/T
         ap77JGKPFR7seFU2+Fc82Z+86a6BFYuGez3BKIdNF1f5M7R4vL4HJ97b8p5I/n0jdiTm
         eHF8rO7C2N3zkZP+diGg8ptPlvz/jE3Kf/AnwFuwvg++6Z6luMLJ2DEvPLMnRzROPiPl
         JQ3g==
X-Forwarded-Encrypted: i=1; AKwUvByE286NkWpgfIX1zd//rP4RBVOfl34wh87u4WOYDE//MO3weT1CPpiaF/MXzhBZKbXOCBPL46kY3Dg=@vger.kernel.org
X-Gm-Message-State: AFuF++lA81G83QNvUok95izxq+zaxiSVxn+1DC7I0OQ1Rff2TztqjRYY
	9chMIuMd9MreV5khAGfMhdMqSeGM3FWSmLKrEfkWBo/Gto/XqVYg4p9uj2prp3cWWKaig7pOqE5
	GdHuGkJG+MqToFA==
X-Received: from plrp17.prod.google.com ([2002:a17:902:b091:b0:2db:1a39:c145])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:fa5:b0:2dd:c053:82f1 with SMTP id d9443c01a7336-2ddc053841bmr11711945ad.40.1789762013609;
 Fri, 18 Sep 2026 13:06:53 -0700 (PDT)
Date: Fri, 18 Sep 2026 20:06:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918200640.887030-1-dmatlack@google.com>
Subject: [PATCH v9 00/13] PCI: liveupdate: PCI core support for Live Update
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

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v9

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

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v9-with-vfio

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

v9:
 - Simplify pci_liveupdate_preserve_bus_numbers() to always return true
   if a device was preserved and drop pci_liveupdate_scan_bridge_end()
   (Bjorn)
 - Add pci_liveupdate_refuse_bus_numbers() to determine when it is safe
   for the PCI core to assign bus numbers to unconfigured bridges. This
   required moving "Auto-preserve upstream bridges across Live Update"
   before "Preserve bus numbers during Live Update" (Bjorn)
 - Add "PCI: Save and restore the ACS Control register" so that the ACS
   Control register is handled by the normal save/restore path (Bjorn)
 - Rename struct pci_liveupdate::was_preserved to was_incoming, to
   disambiguate incoming from outgoing preservation (me)
 - Log unfinished preserved devices from the incoming FLB rather than
   by walking struct pci_dev (Sashiko)
 - Document that state handed over by the previous kernel is trusted,
   and panic in pci_flb_retrieve() where failures are detected rather
   than unwinding into a caller that panics anyway (Sashiko)
 - Fall back to programming ACS from scratch when a preserved device has
   no ACS save buffer, since there is nowhere to record the adopted
   controls and they would be lost by the first reset (Sashiko)
 - Drop Reviewed-by tags from "Preserve bus numbers during Live Update"
   and "Adopt ACS controls in incoming preserved devices", both of which
   changed materially since v8
 - Extend commit messages and kernel-doc comments to make the FLB code
   flow more clear (Bjorn)
 - Address various spelling, formatting, and stylistic issues (Bjorn)

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
  PCI: Save and restore the ACS Control register
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
 drivers/pci/liveupdate.c                      | 1015 +++++++++++++++++
 drivers/pci/liveupdate.h                      |   62 +
 drivers/pci/pci-driver.c                      |    9 +-
 drivers/pci/pci.c                             |   79 +-
 drivers/pci/pci.h                             |    5 +
 drivers/pci/probe.c                           |   16 +-
 drivers/pci/quirks.c                          |   58 +-
 include/linux/kho/abi/pci.h                   |   66 ++
 include/linux/pci.h                           |    7 +
 include/linux/pci_liveupdate.h                |   72 ++
 17 files changed, 1429 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: 945d61765894dda2f0344de50cb1ade2e51b66fd
-- 
2.55.0.1082.g2b9226bbc0-goog

