Return-Path: <linux-arch-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>,
	<lftan.linux@gmail.com>
Subject: [PATCH v2 0/4] Add PCI support on nios2 architecture
Date: Wed, 14 Oct 2015 14:31:40 +0800
Message-ID: <1444804304-5213-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is 2nd version of patch to add pci support for nios2 architecture.
This patchset also update asm-generic/pci.h to include PCI generic define/function
as suggested by Arnd.
It requires pci_fixup_irqs() from setup-irq.c.

v1->v2 changes:
- nios2: remove PCI_SYSCALL from Kconfig
- nios2: set IO_SPACE_LIMIT to 0xffff
- nios2: remove arch/nios2/include/asm/pci.h and use asm-generic pci.h
- pci: add include <linux/dma-mapping.h> to pci.c
- asm-generic: add pci generic functions/defines to pci.h

History
-------
[v1]: https://lkml.org/lkml/2015/9/22/44

Ley Foon Tan (4):
  asm-generic: add pci required defines and functions
  pci: add include <linux/dma-mapping.h>
  PCI: Build setup-irq.o for nios2
  nios2: Add architectural support for PCIe

 arch/nios2/Kconfig            | 21 +++++++++++++++++++++
 arch/nios2/include/asm/Kbuild |  1 +
 arch/nios2/include/asm/io.h   | 12 ++++++++++--
 arch/nios2/kernel/Makefile    |  1 +
 arch/nios2/kernel/pci.c       | 33 +++++++++++++++++++++++++++++++++
 drivers/pci/Makefile          |  1 +
 drivers/pci/pci.c             |  1 +
 include/asm-generic/pci.h     | 34 ++++++++++++++++++++++++++++++++++
 8 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100644 arch/nios2/kernel/pci.c

-- 
1.8.2.1

