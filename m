Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <rafael@kernel.org>,
        <Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jcm@redhat.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V3 0/2] Add ACPI support for HiSilicon SoCs Host Controllers
Date: Thu, 20 Oct 2016 11:10:32 +0800
Message-ID: <1476933034-46044-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

This patchset adds ACPI support for the HiSilicon Hip05/Hip06/Hip07 SoC
PCIe controllers.
The two patches respectively:
        - rework the current HiSilicon driver to add support for ECAM
          platforms(not RC).
        - adds the HiSilicon ACPI specific quirks.

This patchset is based on 4.9-rc1 and add Tomasz quirks V6 pathcset.
Tomasz quirks V6 patchset can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git(pci/ecam-v6)

v2 -> v3:
- rebase against 4.9-rc1 and add Tomasz quirks V6 pathcset. 
- obtain rc base addresses from PNP0C02 as subdevice of PNP0A03 instead of
  hardcode the addresses.
- modify hisi_pcie_acpi_rd_conf/hisi_pcie_acpi_wr_conf() according to
  Arnd comments.

v1 -> v2:
- rebase against Tomasz RFC V5 quirk mechanism
- add ACPI support for the HiSilicon Hip07 SoC PCIe controllers

Dongdong Liu (2):
  PCI: hisi: Add ECAM support for devices that are not RC
  PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers

 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  15 +-
 MAINTAINERS                                        |   1 +
 drivers/acpi/pci_mcfg.c                            |  15 ++
 drivers/pci/host/Kconfig                           |  12 +-
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-designware.c                 |   4 +-
 drivers/pci/host/pcie-designware.h                 |   2 +
 drivers/pci/host/pcie-hisi-acpi.c                  | 170 +++++++++++++++++++++
 drivers/pci/host/pcie-hisi.c                       |  45 ++++++
 include/linux/pci-ecam.h                           |   4 +
 10 files changed, 259 insertions(+), 10 deletions(-)
 create mode 100755 drivers/pci/host/pcie-hisi-acpi.c

-- 
1.9.1
