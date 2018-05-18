Return-Path: <SRS0=CtTX=IF=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=CtTX=IF=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>,
	Dave Fugate <david.fugate@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/5] Enable an additional VMD device id
Date: Fri, 18 May 2018 13:27:57 -0600
Message-Id: <20180518192802.20371-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

This patchset enables an additional VMD device ID to the VMD driver
supporting assignment of the membar addresses from shadow registers and
allows more flexibility in assigning bus numbers to a VMD PCIe domain.
Additional VMD root port device ids have been added to the VMD AER
quirk.

Changes from rfc include comments, code structure, and using
pci_add_resource_offset to correctly assign addresses while virtualized.

Applies to Bjorn's next branch

Jon Derrick (5):
  PCI: Add Intel VMD devices to pci ids
  PCI/VMD: Assign membar addresses from shadow registers
  PCI/VMD: Add offset to bus numbers if necessary
  x86/PCI: Add additional VMD device root ports to VMD AER quirk
  PCI/VMD: Add an additional VMD device id to driver device id table

 arch/x86/pci/fixup.c    |  4 +++
 drivers/pci/host/vmd.c  | 91 +++++++++++++++++++++++++++++++++++++++++++------
 include/linux/pci_ids.h |  2 ++
 3 files changed, 87 insertions(+), 10 deletions(-)

-- 
2.14.3
