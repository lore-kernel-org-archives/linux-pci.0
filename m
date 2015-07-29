Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13661 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbbG2JQx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Jul 2015 05:16:53 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/3] x86/pci/intel-mid-pci: fix to get eMMC detected
Date: Wed, 29 Jul 2015 12:16:46 +0300
Message-Id: <1438161409-4671-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Intel Edison we have an interesting implementation of x86 platform without
legacy PIC and with specific PCI. There are devices which are not using
interrupt line 0, but have it assigned in the PCI configuration. By default
first come gets it, though the first eMMC host controller is the actual user
for IRQ0. 

So, this series provides a quirk (patch 1) to resolve the issue, a small fix of
error code (patch 2), and a sparse warning fix (patch 3).

Changelog v3:
- address Thomas' comments
- massage changelog (what Thomas proposed)

Changelog v2:
- rearrange patches 1 and 2 to provide fix first with Fixes: tag
- append patch 3
- rebase on top of recent linux-next

Andy Shevchenko (3):
  x86/pci/intel_mid_pci: work around for IRQ0 assignment
  x86/pci/intel_mid_pci: propagate actual return code
  x86/pci/intel_mid_pci: fix a sparse warning

 arch/x86/pci/intel_mid_pci.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

-- 
2.4.6

