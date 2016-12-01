Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbcLAIjG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 03:39:06 -0500
Subject: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Thu, 01 Dec 2016 02:29:22 -0600
Message-ID: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is what I've collected on my pci/ecam branch so far.  This is
preliminary and probably doesn't even build since I made several
changes, but at least it's a strawman.  I called it v10 to keep it
separate from the previous postings of the various pieces.

  ACPI: Add acpi_resource_consumer() to find device that claims a resource
  PCI: Search ACPI namespace to ensure ECAM space is reserved
  x86/PCI: Use acpi_resource_consumer() to search ACPI namespace for MMCFG

    acpi_resource_consumer() takes a resource and returns an
    acpi_device that has _CRS that contains the resource.  The idea is
    that we call this on a resource from MCFG.  We *should* find a
    PNP0C02 or other device that reserves that resource.  On x86 we
    already do this in a more hand-coded way.  I probably wouldn't
    merge the x86 patch for v4.10 but I included it here as an
    example.

    I don't think it's worth trying to fabricate ACPI devices or _CRS
    resources to compensate for firmware that doesn't describe
    everything.  This check will emit a warning if the MCFG region is
    not reserved, and that's probably enough to motivate firmware
    fixes for the next round of hardware.  The ECAM code itself does
    reserve the region, so that part will be safe from other users.
    Unreported non-ECAM register space is still a landmine and there's
    no real way to look for it.

  arm64: PCI: Manage controller-specific data on per-controller basis

    Tomasz's fix for pci_acpi_scan_root(), unchanged.

  PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM config accessors
  PCI/ACPI: Check for platform-specific MCFG quirks

    Tomasz's quirk infrastructure.  I put this under
    CONFIG_PCI_QUIRKS.

  PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform

    Dongdong's interface to look up a _HID with a _UID matching the
    segment.  I don't have an opinion on using _UID yet.  It's
    encapsulated so it could be changed easily.  I put this under
    CONFIG_PCI_QUIRKS && CONFIG_ARM64.

  PCI: Add MCFG quirks for Qualcomm QDF2432 host controller

    Christopher's Qualcomm quirks.  Basically unchanged except to put
    the quirk ops under CONFIG_ACPI and CONFIG_PCI_QUIRKS.

  PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers

    Dongdong's HiSilicon quirks.  Here's where it gets interesting.  I
    moved this to the existing pcie-hisi.c instead of adding
    pcie-hisi-acpi.c.  I changed the Makefile so we always build
    pcie-hisi.c on ARM64.  I added ifdefs so we get the quirk code if
    CONFIG_ACPI and CONFIG_PCI_QUIRKS and we get the original platform
    driver if CONFIG_PCI_HISI.  It's possible to have both, and if we
    process the MCFG quirk we get the quirk code.

    I'm confused about why the quirk accessors are so much different
    than the original accessors.  hisi_pcie_acpi_rd_conf() looks much
    different than hisi_pcie_cfg_read().  The original driver claims
    Hipxx only supports 32-bit config accesses, but the quirk
    accessors don't enforce that.

  PCI: thunder-pem: Factor out resource lookup
  PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller
  PCI: Add MCFG quirks for Cavium ThunderX pass1.x host controller

    Tomasz's ThunderX quirks.  I restructured the PEM init I could do
    the same ifdef tricks as in hisi.  The quirks make a lot more
    sense here -- they use the same accessors as the original platform
    driver.  Only the initialization is different.

The Makefile looks a little strange:

  obj-$(CONFIG_ARM64) += pcie-hisi.o
  obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
  obj-$(CONFIG_ARM64) += pci-thunder-pem.o

and the ifdefs inside those files are a little unwieldy.  But I think
they do accomplish the goals of:

  - Adding no new files,

  - Including the MCFG quirks whenever CONFIG_ACPI and
    CONFIG_PCI_QUIRKS are enabled, regardless of the driver-specific
    config,

  - Including the original platform drivers when they are specifically
    enabled, and

  - Sharing the same code for the platform driver and the quirks
    (except for HiSi, which I don't understand)

I started looking at the Duc's X-Gene quirks, but I haven't wrapped my
head around those yet.  I'm going to push this branch to get build
testing and so you can comment on it.

If by some miracle it builds and you test it, please collect the dmesg
log and /proc/iomem contents.

---

Bjorn Helgaas (5):
      ACPI: Add acpi_resource_consumer() to find device that claims a resource
      PCI: Search ACPI namespace to ensure ECAM space is reserved
      x86/PCI: Use acpi_resource_consumer() to search ACPI namespace for MMCFG
      PCI: Add MCFG quirks for HiSilicon Hip05/06/07 host controllers
      PCI: thunder-pem: Factor out resource lookup

Christopher Covington (1):
      PCI: Add MCFG quirks for Qualcomm QDF2432 host controller

Dongdong Liu (1):
      PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform

Tomasz Nowicki (5):
      arm64: PCI: Manage controller-specific data on per-controller basis
      PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM config accessors
      PCI/ACPI: Check for platform-specific MCFG quirks
      PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller
      PCI: Add MCFG quirks for Cavium ThunderX pass1.x host controller


 arch/arm64/kernel/pci.c             |   34 +++----
 arch/x86/pci/mmconfig-shared.c      |   69 ++-------------
 drivers/acpi/pci_mcfg.c             |  165 ++++++++++++++++++++++++++++++++++-
 drivers/acpi/resource.c             |   57 ++++++++++++
 drivers/pci/ecam.c                  |   31 +++++++
 drivers/pci/host/Makefile           |    6 +
 drivers/pci/host/pci-thunder-ecam.c |    9 ++
 drivers/pci/host/pci-thunder-pem.c  |   88 ++++++++++++++-----
 drivers/pci/host/pcie-hisi.c        |   95 ++++++++++++++++++++
 drivers/pci/pci-acpi.c              |   71 +++++++++++++++
 drivers/pci/pci.h                   |    4 +
 include/linux/acpi.h                |    7 +
 include/linux/pci-acpi.h            |    4 +
 include/linux/pci-ecam.h            |    7 +
 14 files changed, 537 insertions(+), 110 deletions(-)
