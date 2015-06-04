Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFT v2 01/48] genirq: Clean up outdated comments related to include/linux/irqdesc.h
Date: Thu,  4 Jun 2015 12:13:11 +0800
Message-Id: <1433391238-19471-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Seems we have little chance to move irqdesc.h from include/linux/ into
kernel/irq/, so kill the outdated comments.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h     |    1 -
 include/linux/irqdesc.h |    3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index a38610520b33..2de650d61a4e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -409,7 +409,6 @@ enum {
 	IRQCHIP_EOI_THREADED		= (1 <<  6),
 };
 
-/* This include will go away once we isolated irq_desc usage to core code */
 #include <linux/irqdesc.h>
 
 /*
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 749755bffbc1..8c84a2513665 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -3,9 +3,6 @@
 
 /*
  * Core internal functions to deal with irq descriptors
- *
- * This include will move to kernel/irq once we cleaned up the tree.
- * For now it's included from <linux/irq.h>
  */
 
 struct irq_affinity_notify;
-- 
1.7.10.4

