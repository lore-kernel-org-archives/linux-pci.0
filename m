Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:50180 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab3HBSRp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 14:17:45 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so944497vbg.39
        for <linux-pci@vger.kernel.org>; Fri, 02 Aug 2013 11:17:44 -0700 (PDT)
Date: Fri, 2 Aug 2013 12:17:40 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [GIT PULL] PCI updates for v3.11 
Message-ID: <20130802181740.GA27100@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are some fixes for v3.11.  Yinghai fixed a couple regressions:
one resource assignment problem introduced in v3.10 that showed up with
SR-IOV on powerpc, and another SR-IOV hot-remove issue related to
refcounting changes we merged for v3.11.

Yinghai is still working on another SR-IOV-related fix or two, which
will be simpler if pciehp is non-modular, so I included the Kconfig
changes now to get them in earlier.

Finally, a minor fix for the ARM Marvell EBU host bridge driver that
was merged for v3.11.

Bjorn


The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v3.11-fixes-1

for you to fetch changes up to 36dd1f3e02a4aed850a7b7318d7abd4f4d50528c:

  PCI: mvebu: Disable prefetchable memory support in PCI-to-PCI bridge (2013-08-01 14:47:54 -0600)

----------------------------------------------------------------
PCI updates for v3.11:

  Hotplug
      PCI: pciehp: Fix null pointer deref when hot-removing SR-IOV device
      PCI: hotplug: Convert to be builtin only, not modular
      PCI: pciehp: Convert pciehp to be builtin only, not modular
  Resource allocation
      PCI: Retry allocation of only the resource type that failed
  ARM
      PCI: mvebu: Disable prefetchable memory support in PCI-to-PCI bridge

----------------------------------------------------------------
Bjorn Helgaas (2):
      PCI: hotplug: Convert to be builtin only, not modular
      PCI: pciehp: Convert pciehp to be builtin only, not modular

Thomas Petazzoni (1):
      PCI: mvebu: Disable prefetchable memory support in PCI-to-PCI bridge

Yinghai Lu (2):
      PCI: pciehp: Fix null pointer deref when hot-removing SR-IOV device
      PCI: Retry allocation of only the resource type that failed

 arch/ia64/configs/generic_defconfig    |  2 +-
 arch/ia64/configs/gensparse_defconfig  |  2 +-
 arch/ia64/configs/tiger_defconfig      |  2 +-
 arch/ia64/configs/xen_domu_defconfig   |  2 +-
 arch/powerpc/configs/ppc64_defconfig   |  2 +-
 arch/powerpc/configs/ppc64e_defconfig  |  2 +-
 arch/powerpc/configs/pseries_defconfig |  2 +-
 arch/sh/configs/sh03_defconfig         |  2 +-
 drivers/pci/host/pci-mvebu.c           | 27 +------------
 drivers/pci/hotplug/Kconfig            |  5 +--
 drivers/pci/hotplug/pciehp_pci.c       |  9 ++++-
 drivers/pci/pcie/Kconfig               |  5 +--
 drivers/pci/setup-bus.c                | 69 +++++++++++++++++++++++++++++++++-
 13 files changed, 87 insertions(+), 44 deletions(-)
