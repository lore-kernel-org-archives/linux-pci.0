Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbcLEXZX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Dec 2016 18:25:23 -0500
Subject: [PATCH v11 00/15] PCI: ARM64 ECAM quirks
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Mon, 05 Dec 2016 17:25:19 -0600
Message-ID: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's another try.  The biggest change is to add the APM X-Gene quirks.

These are on my pci/ecam branch.  Please test and report any issues.
Please also collect dmesg and /proc/iomem contents and I'll try to
summarize the current ACPI firmware situation on ARM64 and update the
writeup with recommendations for future platforms.

Changes from v10 to v11:

- Discard "consumer" resources from PNP0A03 host bridge windows (arm64
  only).  This allows using consumer PNP0A03 descriptors (rather than the
  PNP0C02 workaround used on x86) for bridge register space.

- Add APM X-Gene MCFG quirks.

- If ACPI and quirks are enabled, always build ThunderX, X-Gene, and
  HiSilicon drivers on ARM64.  Add internal ifdefs so we only compile the
  parts necessary for ACPI (the ECAM init and accessors).

- s/node/seg/ in ThunderX MCFG quirk macros.

- Move ECAM check for ACPI device reservation from pci_ecam_create() to
  that arm64-specific pci_acpi_setup_ecam_mapping().

- Add local "struct device *dev" pointers for brevity.

- Miscellaneous build fixes.

---

Bjorn Helgaas (6):
      ACPI: Add acpi_resource_consumer() to find device that claims a resource
      x86/PCI: Use acpi_resource_consumer() to search ACPI namespace for MMCFG
      arm64: PCI: Add local struct device pointers
      arm64: PCI: Search ACPI namespace to ensure ECAM space is reserved
      arm64: PCI: Exclude ACPI "consumer" resources from host bridge windows
      PCI: thunder-pem: Factor out resource lookup

Christopher Covington (1):
      PCI: Add MCFG quirks for Qualcomm QDF2432 host controller

Dongdong Liu (2):
      PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform
      PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers

Duc Dang (1):
      PCI: Add MCFG quirks for X-Gene host controller

Tomasz Nowicki (5):
      arm64: PCI: Manage controller-specific data on per-controller basis
      PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM config accessors
      PCI/ACPI: Check for platform-specific MCFG quirks
      PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller
      PCI: Add MCFG quirks for Cavium ThunderX pass1.x host controller


 arch/arm64/kernel/pci.c             |   68 ++++++++-----
 arch/x86/pci/mmconfig-shared.c      |   69 ++-----------
 drivers/acpi/pci_mcfg.c             |  190 ++++++++++++++++++++++++++++++++++-
 drivers/acpi/resource.c             |   57 +++++++++++
 drivers/pci/ecam.c                  |   12 ++
 drivers/pci/host/Kconfig            |   10 +-
 drivers/pci/host/Makefile           |    8 +
 drivers/pci/host/pci-thunder-ecam.c |    9 +-
 drivers/pci/host/pci-thunder-pem.c  |   94 +++++++++++++----
 drivers/pci/host/pci-xgene.c        |  126 ++++++++++++++++++++++-
 drivers/pci/host/pcie-hisi.c        |  101 +++++++++++++++++++
 drivers/pci/pci-acpi.c              |   76 ++++++++++++++
 drivers/pci/pci.h                   |    5 +
 include/linux/acpi.h                |    7 +
 include/linux/pci-acpi.h            |    4 +
 include/linux/pci-ecam.h            |    9 ++
 16 files changed, 718 insertions(+), 127 deletions(-)
