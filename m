Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53737 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbaHFJEo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Aug 2014 05:04:44 -0400
From: "Chen, Gong" <gong.chen@linux.intel.com>
To: bhelgaas@google.com, rdunlap@infradead.org, bp@alien8.de,
	tony.luck@intel.com
Cc: linux-pci@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 4/5] PCI-e, AER: Make AER UC status naming clearer
Date: Wed,  6 Aug 2014 04:32:43 -0400
Message-Id: <1407313964-20794-4-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1407313964-20794-1-git-send-email-gong.chen@linux.intel.com>
References: <1407313964-20794-1-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In PCI-e SPEC r3.0, BIT 0 of Uncorrectable Error Status Register
has been redefined for a different purpose.

BIT 0:
    Undefined – The value read from this bit is undefined. In
		previous versions of this specification, this
		bit was used to mask a Link Training Error. 
		System software must ignore the value read from 
		this bit. System software must only write a value
		of 1b to this bit.

Update related MACRO definition to reflect this change.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 2 +-
 include/ras/ras_event.h            | 2 +-
 include/uapi/linux/pci_regs.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index e50790e..1de3f94 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -727,7 +727,7 @@ static int __init init_pci_ext_cap_err_perm(struct perm_bits *perm)
 	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
 
 	/* Writable bits mask */
-	mask =	PCI_ERR_UNC_TRAIN |		/* Training */
+	mask =	PCI_ERR_UNC_UND |		/* Undefined */
 		PCI_ERR_UNC_DLP |		/* Data Link Protocol */
 		PCI_ERR_UNC_SURPDN |		/* Surprise Down */
 		PCI_ERR_UNC_POISON_TLP |	/* Poisoned TLP */
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 0f04a97..79abb9c 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -185,7 +185,7 @@ TRACE_EVENT(mc_event,
 	{PCI_ERR_COR_LOG_OVER,	"Header Log Overflow"}
 
 #define aer_uncorrectable_errors				\
-	{PCI_ERR_UNC_TRAIN,	"Undefined"},			\
+	{PCI_ERR_UNC_UND,	"Undefined"},			\
 	{PCI_ERR_UNC_DLP,	"Data Link Protocol Error"},	\
 	{PCI_ERR_UNC_SURPDN,	"Surprise Down Error"},		\
 	{PCI_ERR_UNC_POISON_TLP,"Poisoned TLP"},		\
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 30db069..99e3182 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -630,7 +630,7 @@
 
 /* Advanced Error Reporting */
 #define PCI_ERR_UNCOR_STATUS	4	/* Uncorrectable Error Status */
-#define  PCI_ERR_UNC_TRAIN	0x00000001	/* Training */
+#define  PCI_ERR_UNC_UND	0x00000001	/* Undefined */
 #define  PCI_ERR_UNC_DLP	0x00000010	/* Data Link Protocol */
 #define  PCI_ERR_UNC_SURPDN	0x00000020	/* Surprise Down */
 #define  PCI_ERR_UNC_POISON_TLP	0x00001000	/* Poisoned TLP */
-- 
2.0.0.rc2

