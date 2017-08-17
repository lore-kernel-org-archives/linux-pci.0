Return-Path: <SRS0=NXC0=7T=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=NXC0=7T=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Keith Busch <keith.busch@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	David Fugate <david.fugate@intel.com>,
	<linux-kernel@vger.kernel.org>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 0/4] VMD fixups
Date: Thu, 17 Aug 2017 12:10:10 -0600
Message-Id: <20170817181014.1257-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Mostly just cleanup in this revision, eg, trying to limit scope of vmd code to
x86

Previous:
https://patchwork.kernel.org/patch/9886095/
https://patchwork.kernel.org/patch/9886097/
https://patchwork.kernel.org/patch/9886101/


Jon Derrick (4):
  MAINTAINERS: Add Jonathan Derrick as VMD maintainer
  pci/x86: Move VMD quirks to x86 fixups
  x86/PCI: Use is_vmd rather than relying on the domain number
  iommu: Prevent VMD child devices from being remapping targets

 MAINTAINERS                 |  1 +
 arch/x86/pci/fixup.c        | 18 ++++++++++++++++++
 drivers/iommu/intel-iommu.c |  5 +++++
 drivers/pci/quirks.c        | 17 -----------------
 4 files changed, 24 insertions(+), 17 deletions(-)

-- 
2.9.4
