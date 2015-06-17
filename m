Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42690 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758076AbbFQTFS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Jun 2015 15:05:18 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/2] x86: intel-mid-pci: fix to get eMMC detected
Date: Wed, 17 Jun 2015 22:03:48 +0300
Message-Id: <1434567830-237840-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Intel Edison we have a nice implementation of x86 platform without legacy
PIC and with specific PCI. There are devices which are not using interrupt by
some reasons, but have them as IRQ0 in the PCI configuration. Suprisingly the
first eMMC host controller is the actual user for IRQ0. Since we have serial
driver implemented that enumerates unused serial IP (one of four) which has
IRQ0 assigned we, in case it gets it first by pci_enable_device(), lost a
possibility to probe eMMC. 

So, this series provides a workaround (patch 2) and small fix of error code
(patch 1).

I wonder if this can go to v4.2. What do you think?

Andy Shevchenko (2):
  x86: intel_mid_pci: propagate actual return code
  x86: intel_mid_pci: work around for IRQ0 assignment

 arch/x86/pci/intel_mid_pci.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

-- 
2.1.4

