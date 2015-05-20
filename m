Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38777 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629AbbETKEU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 May 2015 06:04:20 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Joshua Thompson <funaho@jurai.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: [RFC v1 18/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Wed, 20 May 2015 18:00:06 +0800
Message-Id: <1432116013-25902-19-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now most IRQ flow handlers make no use of the first parameter 'irq'.
And for those who do make use of 'irq', we could easily get the irq
number through irq_desc->irq_data->irq. So kill the first parameter
'irq' of irq_flow_handler_t.

To ease review, I have split the changes into several parts, though
they should be merge as one to support bisecting.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/m68k/amiga/amiints.c       |    8 ++++----
 arch/m68k/coldfire/intc-5272.c  |    4 ++--
 arch/m68k/include/asm/mac_via.h |    2 +-
 arch/m68k/mac/baboon.c          |    2 +-
 arch/m68k/mac/oss.c             |    4 ++--
 arch/m68k/mac/psc.c             |    3 ++-
 arch/m68k/mac/via.c             |    6 +++---
 7 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/m68k/amiga/amiints.c b/arch/m68k/amiga/amiints.c
index 47b5f90002ab..7ff739e94896 100644
--- a/arch/m68k/amiga/amiints.c
+++ b/arch/m68k/amiga/amiints.c
@@ -46,7 +46,7 @@ static struct irq_chip amiga_irq_chip = {
  * The builtin Amiga hardware interrupt handlers.
  */
 
-static void ami_int1(unsigned int irq, struct irq_desc *desc)
+static void ami_int1(struct irq_desc *desc)
 {
 	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
@@ -69,7 +69,7 @@ static void ami_int1(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static void ami_int3(unsigned int irq, struct irq_desc *desc)
+static void ami_int3(struct irq_desc *desc)
 {
 	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
@@ -92,7 +92,7 @@ static void ami_int3(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static void ami_int4(unsigned int irq, struct irq_desc *desc)
+static void ami_int4(struct irq_desc *desc)
 {
 	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
@@ -121,7 +121,7 @@ static void ami_int4(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static void ami_int5(unsigned int irq, struct irq_desc *desc)
+static void ami_int5(struct irq_desc *desc)
 {
 	unsigned short ints = amiga_custom.intreqr & amiga_custom.intenar;
 
diff --git a/arch/m68k/coldfire/intc-5272.c b/arch/m68k/coldfire/intc-5272.c
index d1e2fbad327c..b0a19e207a63 100644
--- a/arch/m68k/coldfire/intc-5272.c
+++ b/arch/m68k/coldfire/intc-5272.c
@@ -143,10 +143,10 @@ static int intc_irq_set_type(struct irq_data *d, unsigned int type)
  * We need to be careful with the masking/acking due to the side effects
  * of masking an interrupt.
  */
-static void intc_external_irq(unsigned int irq, struct irq_desc *desc)
+static void intc_external_irq(struct irq_desc *desc)
 {
 	irq_desc_get_chip(desc)->irq_ack(&desc->irq_data);
-	handle_simple_irq(irq, desc);
+	handle_simple_irq(desc);
 }
 
 static struct irq_chip intc_irq_chip = {
diff --git a/arch/m68k/include/asm/mac_via.h b/arch/m68k/include/asm/mac_via.h
index fe3fc9ae1b69..53c632c85b03 100644
--- a/arch/m68k/include/asm/mac_via.h
+++ b/arch/m68k/include/asm/mac_via.h
@@ -261,7 +261,7 @@ extern void via_irq_enable(int);
 extern void via_irq_disable(int);
 extern void via_nubus_irq_startup(int irq);
 extern void via_nubus_irq_shutdown(int irq);
-extern void via1_irq(unsigned int irq, struct irq_desc *desc);
+extern void via1_irq(struct irq_desc *desc);
 extern void via1_set_head(int);
 extern int via2_scsi_drq_pending(void);
 
diff --git a/arch/m68k/mac/baboon.c b/arch/m68k/mac/baboon.c
index 3fe0e43d44f6..f6f7d42713ec 100644
--- a/arch/m68k/mac/baboon.c
+++ b/arch/m68k/mac/baboon.c
@@ -45,7 +45,7 @@ void __init baboon_init(void)
  * Baboon interrupt handler. This works a lot like a VIA.
  */
 
-static void baboon_irq(unsigned int irq, struct irq_desc *desc)
+static void baboon_irq(struct irq_desc *desc)
 {
 	int irq_bit, irq_num;
 	unsigned char events;
diff --git a/arch/m68k/mac/oss.c b/arch/m68k/mac/oss.c
index bb11dceed7ed..1fe868166a9c 100644
--- a/arch/m68k/mac/oss.c
+++ b/arch/m68k/mac/oss.c
@@ -63,7 +63,7 @@ void __init oss_nubus_init(void)
  * Handle miscellaneous OSS interrupts.
  */
 
-static void oss_irq(unsigned int irq, struct irq_desc *desc)
+static void oss_irq(struct irq_desc *desc)
 {
 	int events = oss->irq_pending &
 	             (OSS_IP_IOPSCC | OSS_IP_SCSI | OSS_IP_IOPISM);
@@ -97,7 +97,7 @@ static void oss_irq(unsigned int irq, struct irq_desc *desc)
  * Unlike the VIA/RBV this is on its own autovector interrupt level.
  */
 
-static void oss_nubus_irq(unsigned int irq, struct irq_desc *desc)
+static void oss_nubus_irq(struct irq_desc *desc)
 {
 	int events, irq_bit, i;
 
diff --git a/arch/m68k/mac/psc.c b/arch/m68k/mac/psc.c
index 835fa04511c8..23ddaa07fa0e 100644
--- a/arch/m68k/mac/psc.c
+++ b/arch/m68k/mac/psc.c
@@ -113,8 +113,9 @@ void __init psc_init(void)
  * PSC interrupt handler. It's a lot like the VIA interrupt handler.
  */
 
-static void psc_irq(unsigned int irq, struct irq_desc *desc)
+static void psc_irq(struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	unsigned int offset = (unsigned int)irq_desc_get_handler_data(desc);
 	int pIFR	= pIFRbase + offset;
 	int pIER	= pIERbase + offset;
diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index e198dec868e4..979ea8312db8 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -446,7 +446,7 @@ void via_nubus_irq_shutdown(int irq)
  * via6522.c :-), disable/pending masks added.
  */
 
-void via1_irq(unsigned int irq, struct irq_desc *desc)
+void via1_irq(struct irq_desc *desc)
 {
 	int irq_num;
 	unsigned char irq_bit, events;
@@ -467,7 +467,7 @@ void via1_irq(unsigned int irq, struct irq_desc *desc)
 	} while (events >= irq_bit);
 }
 
-static void via2_irq(unsigned int irq, struct irq_desc *desc)
+static void via2_irq(struct irq_desc *desc)
 {
 	int irq_num;
 	unsigned char irq_bit, events;
@@ -493,7 +493,7 @@ static void via2_irq(unsigned int irq, struct irq_desc *desc)
  * VIA2 dispatcher as a fast interrupt handler.
  */
 
-void via_nubus_irq(unsigned int irq, struct irq_desc *desc)
+void via_nubus_irq(struct irq_desc *desc)
 {
 	int slot_irq;
 	unsigned char slot_bit, events;
-- 
1.7.10.4

