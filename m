Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Daniel J Blueman <daniel@numascale.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel J Blueman <daniel@numascale.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Steffen Persvold <sp@numascale.com>
Subject: [PATCH v3 1/5] Numachip: Fix 16-bit APIC ID truncation
Date: Sun,  2 Nov 2014 16:10:09 +0800
Message-Id: <1414915813-2462-1-git-send-email-daniel@numascale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Prevent 16-bit APIC IDs being truncated by using correct mask. This fixes
booting large systems, where the wrong core would receive the startup and
init IPIs, causing hanging.

Signed-off-by: Daniel J Blueman <daniel@numascale.com>
---
 arch/x86/kernel/apic/apic_numachip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 81d70ba..bd083c0 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -40,7 +40,7 @@ static unsigned int get_apic_id(unsigned long x)
 	unsigned int id;
 
 	rdmsrl(MSR_FAM10H_NODE_ID, value);
-	id = ((x >> 24) & 0xffU) | ((value << 2) & 0x3f00U);
+	id = ((x >> 24) & 0xffU) | ((value << 2) & 0xff00U);
 
 	return id;
 }
-- 
1.9.1

