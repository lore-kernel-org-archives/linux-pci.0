Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv8] Driver for new "VMD" device 
Date: Tue, 12 Jan 2016 09:28:38 -0700
Message-Id: <1452616119-11450-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is just the commit for the VMD driver. The other patches are the
same from previous series here:

  https://lkml.org/lkml/2015/12/21/353

Patch 2/6 is no longer applicable since someone already beat me to
exporting those functions to API in commit a4289dc2ec3a5. Otherwise the
others are still needed and cleanly apply. I wasn't sure if I should
repost the entire series or just the one file that changed.

Changes since v7 are all checkpatch fixes:

  Fixing 80 character lines.

  Spacing, tabbing and new line fixes.

  A macro semicolon fix.

  An entry in the MAINTAINERS file.

The only checkpatch issue reported is warning on a normally "const"
struct, but the warning is not applicable for the usage.

Keith Busch (1):
  x86/PCI: Initial commit for new VMD device driver

 MAINTAINERS                   |   6 +
 arch/x86/Kconfig              |  13 +
 arch/x86/include/asm/hw_irq.h |   5 +
 arch/x86/pci/Makefile         |   2 +
 arch/x86/pci/vmd.c            | 699 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 725 insertions(+)
 create mode 100644 arch/x86/pci/vmd.c

-- 
2.6.2.307.g37023ba
