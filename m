Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org
Subject: [RFC PATCH 0/2] Driver for new PCI-e device
Date: Thu, 27 Aug 2015 16:39:04 -0600
Message-Id: <1440715146-16578-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Intel Volume Management Device (VMD) is an integrated endpoint on the
platform's PCIe root complex that acts as a host bridge to a secondary
PCIe domain. BIOS can reassign one or more root ports to appear within
VMD domains instead of the primary domain. This driver enables and
enumerates the VMD domain using the root bus configuration interface
provided by the PCI subsystem.

CC: Bryan Veal <bryan.e.veal@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-pci@vger.kernel.org

Keith Busch (2):
  x86: PCI bus specific MSI operations
  x86/pci: Initial commit for new VMD device driver

 arch/x86/Kconfig           |   11 ++
 arch/x86/include/asm/pci.h |    3 +
 arch/x86/kernel/x86_init.c |   19 ++
 arch/x86/pci/Makefile      |    2 +
 arch/x86/pci/vmd.c         |  412 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 447 insertions(+)
 create mode 100644 arch/x86/pci/vmd.c

-- 
1.7.10.4

