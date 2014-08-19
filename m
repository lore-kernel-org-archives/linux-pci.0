Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50394 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbaHSPKh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Aug 2014 11:10:37 -0400
Message-ID: <53F368F7.1070707@ti.com>
Date: Tue, 19 Aug 2014 11:10:47 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Fwd: [GIT PULL] PCI changes for v3.17 (part 3)
References: <20140819044050.GA15551@google.com>
In-Reply-To: <20140819044050.GA15551@google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

I see you have pulled in my designware related patches for Keystone PCI 
in this request. When do you think you can pull in Keystone PCI driver 
(v8) on the list?

Thanks and regards,

Murali

-------- Original Message --------
Subject: [GIT PULL] PCI changes for v3.17 (part 3)
Date: Mon, 18 Aug 2014 22:40:50 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Murali 
Karicheri" <m-karicheri2@ti.com>, Kishon Vijay Abraham I 
<kishon@ti.com>, Thierry Reding <treding@nvidia.com>, Andrew Lunn 
<andrew@lunn.ch>

Hi Linus,

I screwed up.  I intended these changes for v3.17, and I put them in my
'next' branch just before leaving on vacation, but I forgot to include them
in my merge window pull request when I returned.  They're low-risk, so I'm
sending them to you now (late), but the world won't end if they wait until
v3.18.

The main reason to include them would be to support the TI DRA7xx.

Bjorn


The following changes since commit 792688fde431b4fdb2cf10a6f7589a8176b6b14a:

   Merge branches 'pci/host-generic', 'pci/host-mvebu', 'pci/host-rcar', 
'pci/host-tegra', 'pci/msi', 'pci/misc', 'pci/resource' and 
'pci/virtualization' into next (2014-07-16 17:09:47 -0600)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git 
tags/pci-v3.17-changes-3

for you to fetch changes up to 981c191778a4f92bc82456205a444d522843a630:

   Merge branches 'pci/host-designware', 'pci/host-mvebu' and 
'pci/host-tegra' into next (2014-07-22 17:55:50 -0600)

----------------------------------------------------------------
PCI changes for v3.17 (part 3):

   Marvell MVEBU
     - Remove ARCH_KIRKWOOD dependency (Andrew Lunn)

   NVIDIA Tegra
     - Add debugfs support (Thierry Reding)

   Synopsys DesignWare
     - Look for configuration space in 'reg', not 'ranges' (Kishon Vijay 
Abraham I)
     - Program ATU with untranslated address (Kishon Vijay Abraham I)
     - Add config access-related pcie_host_ops for v3.65 hardware 
(Murali Karicheri)
     - Add MSI-related pcie_host_ops for v3.65 hardware (Murali Karicheri)

   TI DRA7xx
     - Add TI DR7xx PCIe driver (Kishon Vijay Abraham I)

----------------------------------------------------------------
Andrew Lunn (1):
       PCI: mvebu: Remove ARCH_KIRKWOOD dependency

Bjorn Helgaas (1):
       Merge branches 'pci/host-designware', 'pci/host-mvebu' and 
'pci/host-tegra' into next

Kishon Vijay Abraham I (3):
       PCI: designware: Look for configuration space in 'reg', not 'ranges'
       PCI: designware: Program ATU with untranslated address
       PCI: dra7xx: Add TI DRA7xx PCIe driver

Murali Karicheri (2):
       PCI: designware: Add config access-related pcie_host_ops for 
v3.65 hardware
       PCI: designware: Add MSI-related pcie_host_ops for v3.65 hardware

Thierry Reding (1):
       PCI: tegra: Add debugfs support

  .../devicetree/bindings/pci/designware-pcie.txt    |   4 +
  Documentation/devicetree/bindings/pci/ti-pci.txt   |  59 +++
  MAINTAINERS                                        |   8 +
  drivers/pci/host/Kconfig                           |  11 +-
  drivers/pci/host/Makefile                          |   1 +
  drivers/pci/host/pci-dra7xx.c                      | 458 
+++++++++++++++++++++
  drivers/pci/host/pci-tegra.c                       | 118 ++++++
  drivers/pci/host/pcie-designware.c                 | 134 ++++--
  drivers/pci/host/pcie-designware.h                 |  11 +
  9 files changed, 771 insertions(+), 33 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/pci/ti-pci.txt
  create mode 100644 drivers/pci/host/pci-dra7xx.c
