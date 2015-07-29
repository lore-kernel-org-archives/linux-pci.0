Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/3] x86/pci/intel_mid_pci: fix a sparse warning
Date: Wed, 29 Jul 2015 12:16:49 +0300
Message-Id: <1438161409-4671-4-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1438161409-4671-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1438161409-4671-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes the following sparse warning.
arch/x86/pci/intel_mid_pci.c:265:16: warning: symbol 'intel_mid_pci_ops' was not declared. Should it be static?

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 3361f0a..b096da5 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -263,7 +263,7 @@ static void intel_mid_pci_irq_disable(struct pci_dev *dev)
 	}
 }
 
-struct pci_ops intel_mid_pci_ops = {
+static struct pci_ops intel_mid_pci_ops = {
 	.read = pci_read,
 	.write = pci_write,
 };
-- 
2.4.6

