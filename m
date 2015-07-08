Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/3] x86/pci/intel-mid-pci: fix to get eMMC detected
Date: Wed,  8 Jul 2015 14:14:16 +0300
Message-Id: <1436354059-130135-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Intel Edison we have an interesting implementation of x86 platform without
legacy PIC and with specific PCI. There are devices which are not using
interrupt by some reasons, but have them as IRQ0 in the PCI configuration.
Suprisingly the first eMMC host controller is the actual user for IRQ0. Since
we have serial driver implemented that enumerates unused serial IP (one of
four) which has IRQ0 assigned we, in case it gets it first by
pci_enable_device(), lost a possibility to probe eMMC. 

So, this series provides a quirk (patch 1), small fix of error code
(patch 2), and sparse warning fix (patch 3).

Changelog v2:
 - rearrange patches 1 and 2 to provide fix first with Fixes: tag
 - append patch 3
 - rebase on top of recent linux-next

Andy Shevchenko (3):
  x86/pci/intel_mid_pci: work around for IRQ0 assignment
  x86/pci/intel_mid_pci: propagate actual return code
  x86/pci/intel_mid_pci: fix a sparse warning

 arch/x86/pci/intel_mid_pci.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

-- 
2.1.4

