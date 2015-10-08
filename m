Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Kuleshov <kuleshovmail@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] x86/pci/legacy: make pci_subsys_init static
Date: Fri,  9 Oct 2015 00:51:46 +0600
Message-Id: <1444330306-14076-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_subsys_init() is a subsys_initcall that can be declared
static.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/x86/pci/legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
index 5b662c0..ea6f380 100644
--- a/arch/x86/pci/legacy.c
+++ b/arch/x86/pci/legacy.c
@@ -54,7 +54,7 @@ void pcibios_scan_specific_bus(int busn)
 }
 EXPORT_SYMBOL_GPL(pcibios_scan_specific_bus);
 
-int __init pci_subsys_init(void)
+static int __init pci_subsys_init(void)
 {
 	/*
 	 * The init function returns an non zero value when
-- 
2.6.0

