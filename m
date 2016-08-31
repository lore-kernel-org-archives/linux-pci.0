Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <rafael@kernel.org>,
        <Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jcm@redhat.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH V2 0/3] Add ACPI support for Hisilicon PCIe Host Controller
Date: Wed, 31 Aug 2016 19:48:11 +0800
Message-ID: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds ACPI support for the HiSilicon Hip05/Hip06/Hip07 SoC PCIe
controllers.
The three patches respectively:
        - re-architect the current HiSilicon driver to make it scalable to
          the new ACPI quirks.
        - rework the current HiSilicon driver to add support for ECAM
          platforms(not RC).
        - adds the HiSilicon ACPI specific quirks.

This patchset is base on Tomasz RFC V5 quirk mechanism:
https://lkml.org/lkml/2016/8/8/273

v1 -> v2
- rebase against Tomasz RFC V5 quirk mechanism
- add ACPI support for the HiSilicon Hip07 SoC PCIe controllers 

Dongdong Liu (3):
  PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for
    ACPI
  PCI: hisi: Add ECAM support for devices that are not RC
  PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  15 +-
 MAINTAINERS                                        |   2 +
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   3 +-
 drivers/pci/host/mcfg-quirks.c                     |   8 +
 drivers/pci/host/mcfg-quirks.h                     |  11 ++
 drivers/pci/host/pcie-designware.c                 |   3 +-
 drivers/pci/host/pcie-designware.h                 |   2 +
 drivers/pci/host/pcie-hisi-acpi.c                  | 189 +++++++++++++++++++++
 drivers/pci/host/pcie-hisi-common.c                |  66 +++++++
 drivers/pci/host/pcie-hisi.c                       | 143 ++++++++--------
 drivers/pci/host/pcie-hisi.h                       |  25 +++
 12 files changed, 392 insertions(+), 83 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
 create mode 100644 drivers/pci/host/pcie-hisi-common.c
 create mode 100644 drivers/pci/host/pcie-hisi.h

-- 
1.9.1

