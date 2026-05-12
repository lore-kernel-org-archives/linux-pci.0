Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A232ED32
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611735; cv=none; b=jbHZhkG9aagjLyPlRizFHi14EcC9/RyWKhnGBfK9bMiZ/db3Y8n/taVIP87Pw6cK0jcv7tH4CfCKuNLxkBw0lOMAxH09DSkkwQqOMQreK30Xb54hdY2Wcw1pL0gcYm4MaXf4+KXQtNO1rmbx+CEp5nCaZOy65pMQRAzYVS6AgGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611735; c=relaxed/simple;
	bh=Nx7DwIbKVB82Cf3C7OcpLw8Y6/mIWkE8qNDIkG9LXTY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QZWTL8zXz5vjS5nwo+qvd3lBeG3zah7JHFnB8JnnOd4+fKKUGcc2/6V1wr32Vxm68YtOXUJ2BTkKLKekXDraldDEa2jozSMKGpUZMGXxUCBzpXhKNrKhqJdXctKqeI+J/AfFZQsjNmkCp0ZhdTzFIWaeKyrAUx++V3GPTXWcDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFE8Y4XP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFE8Y4XP"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8397b14a689so3730759b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611731; x=1779216531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EyguY5SyRRz30bfysN8DgGpUMffGCDjWMOlfWBdfAYk=;
        b=uFE8Y4XPJsVkRnyvzZpeHA2LaMvwYQSdiwRGwiANAYb3M6Z53QYNCAYCv4sEhSKd6c
         Xg6TXax3ElYf/6hhi+pzOwEU4whIGtjW3egQvAdfqXVND9CrCB7Xp4hwiJbaMpNo4pGn
         A/9mJ3SATxkeXRxszA8JXp5zgVzdFDg59nbhhdvrtcUpZc8SQ4rcSipKGIgYUYMaRZxr
         eUhZuXlFcncRaO6XIdrubynDrlfg5pt6SeKmljUGTqtHvTRvbe5ypBBf77S0LGEVGri5
         f/uTUXSmjTWNRUfh9uVKlmWjW+jxANVql0Z5lX125TagkX6CH62k7icb3GVmrAN8b2Pj
         xXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611731; x=1779216531;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyguY5SyRRz30bfysN8DgGpUMffGCDjWMOlfWBdfAYk=;
        b=MQCA1ddwJ4jM+HAI/2kNufpJRe0OIFIEHDRH7LdMoy+OwCx54MQgg0lntwd1sL5GLF
         4tuetiHH9eJJgYJS/ES2dYa3OGghCOVRYfeNdlqPIkovZLxxOqpbwNYjF2VXAfdL5Kzq
         CFoVHe4d31G9ECKxxHYwidYOdDMV948rtRliBUEAHREPuJzJFzuTExOsrBoNjvtrS89R
         6K9ffZWAJeTcggdd57+fiZryJSfFHVFP0iUCmYDfklxiF6xm/PiY3Pz1s5TgxJ5ocOQW
         TM0lxYsuihVh8xCjeCQFjWpo+lfZUA0GxgCAmnKktCpjZaCzRAwZiigFbm44nnsBlVs1
         7TjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RroAUWnx0qUr8PBMM0fNf5sMMHm8HunwcIt8Hi2C8U2xwTg9/7eEv8ldJKW+DYhVE7etdcZbYRr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cFzZ75nNsSjn7VuRbVaVs3kjzoNB3KWgRGVEGHATH+K+2DBS
	xLHNKoH/8ES99p6EfTrxGtZciiA8T6bLaS4l78GbrNVh8cDJHqZEv5FGZQU4RcJTjbVPePbEqUV
	dCTqbpxUo84sgWA==
X-Received: from pfblu4.prod.google.com ([2002:a05:6a00:7484:b0:82f:7d56:a149])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1784:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-83eeb85bbafmr4618299b3a.0.1778611731139;
 Tue, 12 May 2026 11:48:51 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:35 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-1-dmatlack@google.com>
Subject: [PATCH v5 00/11] PCI: liveupdate: PCI core support for Live Update
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

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v5

This patch series introduces the initial support in the PCI core for
Live Update, enabling drivers to preserve PCI devices across a
kexec-based kernel update without interrupting the device. This
functionality is critical for minimizing downtime in environments where
PCI devices (e.g., those assigned to VMs via VFIO) must continue
operating or maintain state across a host kernel upgrade.

Specifically, this patch series allows preserved PCI devices to perform
memory transactions to/from system memory (DMA) uninterrupted across a
Live Update. The devices can be behind a bridge, but must not be a VF.
Support for P2P and preserving VFs will come in future series.

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

  4. Guarantee that preserved devices can be identified by the same
     RequesterID (bus, device, function) for as long as they are
     preserved by always inheriting secondary and subordinate bus
     numbers and ARI Forwarding Enable on bridges with preserved
     downstream endpoints.

  5. Guarantee the memory transactions to/from preserved devices are
     routed the same way by inheriting Access Control Services (ACS)
     flags across a Live Update.

  6. Modify the PCI shutdown path to avoid disabling bus mastering on
     preserved devices and their upstream bridges, allowing memory
     transactions to continue uninterrupted.

  7. Provide comprehensive documentation for the FLB API, device
     tracking mechanisms, and the division of responsibilities between
     the PCI core, drivers, and userspace.

Dependencies
------------

This series is built on top of the next branch of liveupdate.git tree
which has 2 commits to enable refcounting the incoming FLB:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=next

Testing
-------

This series was tested in conjunction with v4 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/

The full set of patches that I used for testing can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v5-with-vfio

The full set of patches was tested using the new VFIO selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

Both tests were ran in ran in a QEMU-based VM environment, using a
single virtio-net PCIe device connected to a root port (to exercise the
bridge support in this series), and in a baremetal environment on an
Intel EMR server, using 8x Intel DSA PCIe devices (each on a host
bridge) and 1x NVMe device connected to a root port.

Future Work
-----------

After this series we expect to make further improvements to the PCI core
support for Live Update.

  - Allow P2P across Live Update by avoiding sizing or moving preserved
    device BARs and preserving all upstream bridge windows.

  - Support preserving Virtual Functions, by preserving SR-IOV
    configuration on PFs and enumerating VFs after Live Update.

Changelog
---------

v5:
 - Update PCI LIVE UPDATE entry in MAINTAINERS to use liveupdate.git,
   add kexec@ mailing list, and drop Bjorn (Pasha, Bjorn, Pratyush)
 - Create separate headers for Live Update definitions to avoid future
   patch conflicts (me)
 - Add kernel doc for public (Driver) API (me)
 - Rename reserved field to padding (Vipin)
 - Reorder checks outside of mutex where possible (Jacob)
 - Clarify refcount in struct pci_dev_ser in kernel-doc (Sami)
 - Require CONFIG_64BIT to avoid overflowing xarray key (Sashiko)
 - Various spelling and grammar fixes (Bjorn)
 - Ensure incoming and outgoing devices do not have their bus numbers
   changed during manual rescans via sysfs (Jacob)
 - Fix refcount dropping for upstream bridges during finish (Sashiko)
 - Disallow devices with PCI_DEV_FLAGS_ACS_ENABLED_QUIRK to simplify
   ACS inheritence across Live Update (Sashiko)
 - Fix ACS re-enablement via pci_restore_state() (Sashiko)
 - Drop commit that requires singleton iommu groups (me, Sami)
 - Add per-device lock to protect Live Update fields (Sami, Sashiko)

v4: https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/
v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/
v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (11):
  PCI: liveupdate: Set up FLB handler for the PCI core
  PCI: liveupdate: Track outgoing preserved PCI devices
  PCI: liveupdate: Track incoming preserved PCI devices
  PCI: liveupdate: Document driver binding responsibilities
  PCI: liveupdate: Keep bus numbers constant during Live Update
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
  PCI: liveupdate: Inherit ACS flags in incoming preserved devices
  PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges
  PCI: liveupdate: Freeze preservation status during shutdown
  PCI: liveupdate: Do not disable bus mastering on preserved devices
    during kexec
  Documentation: PCI: Add documentation for Live Update

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/liveupdate.rst              |  29 +
 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/liveupdate.rst         |   1 +
 MAINTAINERS                                   |  12 +
 drivers/pci/Kconfig                           |  14 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 807 ++++++++++++++++++
 drivers/pci/liveupdate.h                      |  66 ++
 drivers/pci/pci-driver.c                      |  33 +-
 drivers/pci/pci.c                             |  13 +-
 drivers/pci/probe.c                           |  29 +-
 include/linux/kho/abi/pci.h                   |  64 ++
 include/linux/pci.h                           |   4 +
 include/linux/pci_liveupdate.h                |  75 ++
 15 files changed, 1140 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: 34e8f02817e31826e76bb2ded48bf28fe921f20b
-- 
2.54.0.563.g4f69b47b94-goog

