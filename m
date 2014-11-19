Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, bhelgaas@google.com,
	lorenzo.pieralisi@arm.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH 0/6] PCI: MMCONFIG clean up
Date: Wed, 19 Nov 2014 17:04:45 +0100
Message-Id: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MMCFG ACPI table has no arch dependencies so it can be used across all
architectures. Currently MMCONFIG related code resides in arch/x86 directories.
This patch set is goint to isolate non-architecure specific code and make
it accessible from drivers/pci/ directory.

Tomasz Nowicki (6):
  x86, acpi, pci: Reorder logic of pci_mmconfig_insert() function
  x86, acpi, pci: Move arch-agnostic MMCFG code out of arch/x86/
    directory
  x86, acpi, pci: Move PCI config space accessors.
  x86, acpi, pci: mmconfig_{32,64}.c code refactoring - remove code
    duplication.
  x86, acpi, pci: mmconfig_64.c becomes default implementation for arch
    agnostic low-level direct PCI config space accessors via MMCONFIG.
  pci, acpi: Share ACPI PCI config space accessors.

 arch/x86/include/asm/pci.h     |  42 +++++
 arch/x86/include/asm/pci_x86.h |  72 --------
 arch/x86/pci/Makefile          |   5 +-
 arch/x86/pci/acpi.c            |   1 +
 arch/x86/pci/init.c            |   1 +
 arch/x86/pci/mmconfig-shared.c | 242 ++++---------------------
 arch/x86/pci/mmconfig_32.c     |  11 +-
 arch/x86/pci/mmconfig_64.c     | 153 ----------------
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/bus.c             |   1 +
 drivers/acpi/mmconfig.c        | 396 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mmconfig.h       |  62 +++++++
 include/linux/pci.h            |   8 -
 13 files changed, 541 insertions(+), 454 deletions(-)
 delete mode 100644 arch/x86/pci/mmconfig_64.c
 create mode 100644 drivers/acpi/mmconfig.c
 create mode 100644 include/linux/mmconfig.h

-- 
1.9.1

