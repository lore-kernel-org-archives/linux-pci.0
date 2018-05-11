Return-Path: <SRS0=T3Dv=H6=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=T3Dv=H6=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>,
	Dave Fugate <david.fugate@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC PATCH 0/4] Enable new VMD device
Date: Thu, 10 May 2018 18:48:59 -0600
Message-Id: <20180511004903.19892-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

This patchset enables a new VMD device with the existing VMD driver. The
new device offers a few additional features such as direct-assign
capabilities.

Jon Derrick (4):
  PCI/VMD: Assign membar addresses from shadow registers
  PCI/VMD: Add offset to bus numbers if necessary
  x86/PCI: Add new VMD device root ports to VMD AER quirk
  PCI/VMD: Add new VMD device id to driver device id table

 arch/x86/pci/fixup.c   |  4 +++
 drivers/pci/host/vmd.c | 79 +++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 70 insertions(+), 13 deletions(-)

-- 
2.14.3
