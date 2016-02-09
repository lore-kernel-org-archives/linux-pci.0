Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:53835 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756661AbcBIRip (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 12:38:45 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <guohanjun@huawei.com>, <wangzhou1@hisilicon.com>,
	<liudongdong3@huawei.com>, <linuxarm@huawei.com>,
	<qiujiang@huawei.com>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>
CC: <gabriele.paoloni@huawei.com>, <zhangjukuo@huawei.com>,
	<xuwei5@hisilicon.com>, <liguozhu@hisilicon.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jcm@redhat.com>
Subject: [RFC PATCH v3 0/3] Add ACPI support for HiSilicon PCIe Host Controllers
Date: Tue, 9 Feb 2016 17:34:17 +0000
Message-ID: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patchset adds ACPI support for the HiSilicon Hip05/Hip06 SoC PCIe controllers
The four patches respectively:
        - re-architect the current HiSilicon driver to make it scalable to the
          new ACPI quirks
        - rework the current HiSilicon driver to add support for ECAM platforms
        - adds the HiSilicon ACPI specific quirks.

   This patchset  is based on
   https://github.com/semihalf-nowicki-tomasz/linux.git
   branch pci-acpi-v4

Changes v1 -> v2: removed the ACPI quirks dependency on Designware framework

Changes v2 -> v3: kept backward compatibility for non-ECAM platforms

gabriele paoloni (3):
  PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for
    ACPI
  PCI: hisi: Add ECAM support to HiSilicon PCIe host controller
  PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  15 +-
 MAINTAINERS                                        |   3 +
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   3 +-
 drivers/pci/host/pcie-designware.c                 |   4 +-
 drivers/pci/host/pcie-designware.h                 |   2 +
 drivers/pci/host/pcie-hisi-acpi.c                  | 188 +++++++++++++++++++++
 drivers/pci/host/pcie-hisi-common.c                |  73 ++++++++
 drivers/pci/host/pcie-hisi.c                       | 149 ++++++++--------
 drivers/pci/host/pcie-hisi.h                       |  25 +++
 10 files changed, 382 insertions(+), 88 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
 create mode 100644 drivers/pci/host/pcie-hisi-common.c
 create mode 100644 drivers/pci/host/pcie-hisi.h

-- 
1.9.1


