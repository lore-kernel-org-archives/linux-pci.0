Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33905 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbbFDVtZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 17:49:25 -0400
Received: by obew15 with SMTP id w15so42350029obe.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 14:49:24 -0700 (PDT)
Received: from localhost (172-9-203-140.lightspeed.spfdmo.sbcglobal.net. [172.9.203.140])
        by mx.google.com with ESMTPSA id w131sm2185952oie.29.2015.06.04.14.49.22
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 14:49:23 -0700 (PDT)
Subject: [PATCH 0/7] Cleanup unused code
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 04 Jun 2015 16:49:22 -0500
Message-ID: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These patches:

  - Remove some unnecessary declarations
  - Include <linux/pci.h> instead of <asm/pci.h>
  - Remove some unnecessary includes of <asm/pci.h>
  - Remove some unused code

They touch a lot of arches but are trivial, so I propose to merge them all
via my PCI tree.

---

Bjorn Helgaas (7):
      microblaze/PCI: Remove unused declarations
      microblaze/PCI: Remove unnecessary pci_bus_find_capability() declaration
      microblaze/PCI: Remove unnecessary struct pci_dev declaration
      PCI: Include <linux/pci.h>, not <asm/pci.h>
      PCI: Remove unnecessary #includes of <asm/pci.h>
      PCI: Remove unused pcibios_select_root() (again)
      PCI: Remove unused pci_dma_burst_advice()


 arch/alpha/include/asm/pci.h              |   16 ------------
 arch/alpha/kernel/core_irongate.c         |    1 -
 arch/alpha/kernel/sys_eiger.c             |    1 -
 arch/alpha/kernel/sys_nautilus.c          |    1 -
 arch/arm/include/asm/pci.h                |   10 -------
 arch/frv/include/asm/pci.h                |   10 -------
 arch/ia64/include/asm/pci.h               |   32 -----------------------
 arch/microblaze/include/asm/pci.h         |   40 -----------------------------
 arch/mips/include/asm/pci.h               |   10 -------
 arch/mips/pci/fixup-cobalt.c              |    1 -
 arch/mips/pci/ops-mace.c                  |    1 -
 arch/mips/pci/pci-lantiq.c                |    1 -
 arch/mn10300/include/asm/pci.h            |   13 ---------
 arch/parisc/include/asm/pci.h             |   19 --------------
 arch/powerpc/include/asm/pci.h            |   30 ----------------------
 arch/powerpc/kernel/prom.c                |    1 -
 arch/powerpc/kernel/prom_init.c           |    1 -
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |    2 +
 arch/s390/kernel/suspend.c                |    2 +
 arch/sh/drivers/pci/ops-sh5.c             |    1 -
 arch/sh/drivers/pci/pci-sh5.c             |    1 -
 arch/sh/include/asm/pci.h                 |   18 -------------
 arch/sparc/include/asm/pci_32.h           |   10 -------
 arch/sparc/include/asm/pci_64.h           |   19 --------------
 arch/unicore32/include/asm/pci.h          |   10 -------
 arch/x86/include/asm/pci.h                |    7 -----
 arch/x86/kernel/x86_init.c                |    1 -
 drivers/net/ethernet/sun/cassini.c        |    1 -
 include/asm-generic/pci.h                 |   13 ---------
 include/linux/pci.h                       |   11 --------
 30 files changed, 2 insertions(+), 282 deletions(-)
