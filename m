Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <rafael@kernel.org>,
        <Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jcm@redhat.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH 0/3] Add ACPI support for Hisilicon PCIe Host Controller
Date: Tue, 12 Jul 2016 10:42:21 +0800
Message-ID: <1468291344-122909-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

This patchset adds ACPI support for the HiSilicon Hip05/Hip06 SoC PCIe
controllers.
The three patches respectively:
        - re-architect the current HiSilicon driver to make it scalable to
          the new ACPI quirks.
        - rework the current HiSilicon driver to add support for ECAM
          platforms(not RC).
        - adds the HiSilicon ACPI specific quirks.

This patchset is base on Tomasz RFC V4 quirk mechanism:
https://lkml.org/lkml/2016/6/28/165

Dongdong Liu (3):
  PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for
    ACPI
  PCI: hisi: Add ECAM support for devices that are not RC
  PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  15 +-
 MAINTAINERS                                        |   3 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   3 +-
 drivers/pci/host/mcfg-quirks.c                     |   8 ++
 drivers/pci/host/mcfg-quirks.h                     |   8 ++
 drivers/pci/host/pcie-designware.c                 |   3 +-
 drivers/pci/host/pcie-designware.h                 |   2 +
 drivers/pci/host/pcie-hisi-acpi.c                  | 151 +++++++++++++++++++++
 drivers/pci/host/pcie-hisi-common.c                |  66 +++++++++
 drivers/pci/host/pcie-hisi.c                       | 143 ++++++++++---------
 drivers/pci/host/pcie-hisi.h                       |  25 ++++
 12 files changed, 351 insertions(+), 83 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
 create mode 100644 drivers/pci/host/pcie-hisi-common.c
 create mode 100644 drivers/pci/host/pcie-hisi.h

-- 
1.9.1
