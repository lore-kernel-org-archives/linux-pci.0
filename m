Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/2] PCI/MSI: Remove arch_msi_check_device()
Date: Sat, 12 Jul 2014 13:21:06 +0200
Message-Id: <cover.1405160163.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This is a cleanup effort to get rid of useless arch_msi_check_device().
I am not sure what were the reasons for its existence in the first place,
but at the moment it appears totally unnecessary.

Thanks!

Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org

Alexander Gordeev (2):
  PCI/MSI/PPC: Remove arch_msi_check_device()
  PCI/MSI: Remove arch_msi_check_device()

 arch/powerpc/include/asm/machdep.h     |    2 -
 arch/powerpc/kernel/msi.c              |   12 +-------
 arch/powerpc/platforms/cell/axon_msi.c |    9 ------
 arch/powerpc/platforms/powernv/pci.c   |   19 +++---------
 arch/powerpc/platforms/pseries/msi.c   |   42 ++++++++++-----------------
 arch/powerpc/sysdev/fsl_msi.c          |   12 ++------
 arch/powerpc/sysdev/mpic_pasemi_msi.c  |   11 +------
 arch/powerpc/sysdev/mpic_u3msi.c       |   28 +++++++-----------
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c  |   18 ++++--------
 arch/powerpc/sysdev/ppc4xx_msi.c       |   19 ++++--------
 drivers/pci/msi.c                      |   49 ++++++++-----------------------
 include/linux/msi.h                    |    3 --
 12 files changed, 63 insertions(+), 161 deletions(-)

-- 
1.7.7.6

