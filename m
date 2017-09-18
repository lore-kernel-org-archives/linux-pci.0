Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, bhelgaas@google.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] x86/pci/intel_mid_pci: make intel_mid_pci_ops const and __initconst
Date: Mon, 18 Sep 2017 21:54:55 +0530
Message-Id: <1505751895-9799-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make this const as it is only used during a copy operation. This usage
is inside init function and the structure is not referenced after
initialisation, so make it __initconst too.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/x86/pci/intel_mid_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index b901ece..63fbe8f 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -279,7 +279,7 @@ static void intel_mid_pci_irq_disable(struct pci_dev *dev)
 	}
 }
 
-static struct pci_ops intel_mid_pci_ops = {
+static const struct pci_ops intel_mid_pci_ops __initconst = {
 	.read = pci_read,
 	.write = pci_write,
 };
-- 
1.9.1
