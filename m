Return-Path: <SRS0=nXoD=KD=intel.com=lkp@kernel.org>
Return-Path: <SRS0=nXoD=KD=intel.com=lkp@kernel.org>
Date: Fri, 20 Jul 2018 07:54:17 +0800
From: kbuild test robot <lkp@intel.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:pci/aer 7/14] drivers/pci/pcie/aer.c:349:9-10: WARNING: return
 of 0/1 in function 'aer_acpi_firmware_first' with return type bool
Message-ID: <201807200714.M8pIgh8M%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/aer
head:   8138a743c2b056d86d0643670765da11fa9bed17
commit: 69c7f453d545930c8cc60478c27be5e06581ba4b [7/14] PCI/AER: Honor "pcie_ports=native" even if HEST sets FIRMWARE_FIRST


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/pcie/aer.c:349:9-10: WARNING: return of 0/1 in function 'aer_acpi_firmware_first' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
