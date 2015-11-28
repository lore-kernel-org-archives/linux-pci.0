Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57844 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbbK1UCl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 28 Nov 2015 15:02:41 -0500
Date: Sat, 28 Nov 2015 14:02:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Mathias Krause <minipli@googlemail.com>
Subject: [GIT PULL] PCI fixes for v4.4
Message-ID: <20151128200236.GA9306@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are a few fixes I'd like to have in v4.4: a generic one for sysfs and
three for HiSilicon and DesignWare host controllers.

Bjorn


The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.4-fixes-1

for you to fetch changes up to 7c7a0e945349a3d0d497d7f32db6ed33d4031110:

  ARM/PCI: Move align_resource function pointer to pci_host_bridge structure (2015-11-25 13:23:38 -0600)

----------------------------------------------------------------
PCI updates for v4.4:

  NUMA
    Prevent out of bounds access in numa_node override (Mathias Krause)

  HiSilicon host bridge driver
    Fix deferred probing (Arnd Bergmann)

  Synopsys DesignWare host bridge driver
    Remove incorrect io_base assignment (Stanimir Varbanov)
    Move align_resource function pointer to pci_host_bridge structure (Gabriele Paoloni)

----------------------------------------------------------------
Arnd Bergmann (1):
      PCI: hisi: Fix deferred probing

Gabriele Paoloni (1):
      ARM/PCI: Move align_resource function pointer to pci_host_bridge structure

Mathias Krause (1):
      PCI: Prevent out of bounds access in numa_node override

Stanimir Varbanov (1):
      PCI: designware: Remove incorrect io_base assignment

 arch/arm/kernel/bios32.c           | 19 +++++++++++--------
 drivers/pci/host/pcie-designware.c |  1 -
 drivers/pci/host/pcie-hisi.c       |  4 ++--
 drivers/pci/pci-sysfs.c            |  5 ++++-
 drivers/pci/pci.h                  |  2 --
 include/linux/pci.h                |  9 +++++++++
 6 files changed, 26 insertions(+), 14 deletions(-)
