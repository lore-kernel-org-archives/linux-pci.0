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
Subject: [PATCH V5 0/2] Add ACPI support for HiSilicon SoCs Host Controllers
Date: Fri, 18 Nov 2016 17:22:29 +0800
Message-ID: <1479460951-49281-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds ACPI support for the HiSilicon Hip05/Hip06/Hip07 SoC
PCIe controllers.
The two patches respectively:
        - provides the common function acpi_get_rc_resources() for ARM64
          platform.
        - adds the HiSilicon ACPI specific quirks.

This patchset is based on branch pci/ecam-v6
It can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git(pci/ecam-v6)

This patchset has been tested on HiSilicon D03 board.
The dmesg log, /proc/iomem, and ACPI table information can be found:
https://bugzilla.kernel.org/show_bug.cgi?id=187961

v4 -> v5:
- obtain rc base addresses from PNP0C02 at the root of the ACPI
namespace (under \_SB) instead of from sub-device under the RC.
- merge the rewrited get rc resources code by Tomasz.
- delete unused code. 
- drop the PATCH V4 1/2, will rework late as a seperate patch.

v3 -> v4:
- rebase on pci/ecam-v6.
- delete the unnecessary link_up check code. 

v2 -> v3:
- rebase against 4.9-rc1 and add Tomasz quirks V6 pathcset. 
- obtain rc base addresses from PNP0C02 as subdevice of PNP0A03 instead of
  hardcode the addresses.
- modify hisi_pcie_acpi_rd_conf/hisi_pcie_acpi_wr_conf() according to
  Arnd comments.

v1 -> v2:
- rebase against Tomasz RFC V5 quirk mechanism
- add ACPI support for the HiSilicon Hip07 SoC PCIe controllers.

Dongdong Liu (2):
  PCI/ACPI: Provide acpi_get_rc_resources() for ARM64 platform
  PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers

 MAINTAINERS                       |   1 +
 drivers/acpi/pci_mcfg.c           |  13 ++++
 drivers/pci/host/Kconfig          |   8 +++
 drivers/pci/host/Makefile         |   1 +
 drivers/pci/host/pcie-hisi-acpi.c | 124 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-acpi.c            |  71 ++++++++++++++++++++++
 drivers/pci/pci.h                 |   4 ++
 include/linux/pci-ecam.h          |   5 ++
 8 files changed, 227 insertions(+)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c

-- 
1.9.1

