Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425139AbdDUTci (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Apr 2017 15:32:38 -0400
Subject: [PATCH 8/9] lspci: Use #defines for greppability
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org,
        Jayachandran C <jnair@caviumnetworks.com>
Date: Fri, 21 Apr 2017 14:32:34 -0500
Message-ID: <20170421193234.6562.18157.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170421192844.6562.30976.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170421192844.6562.30976.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use existing #defines when possible so grep/cscope/etc are more useful.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index 2111918..0ca46fb 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -25,7 +25,7 @@ cap_pm(struct device *d, int where, int cap)
 	 FLAG(cap, PCI_PM_CAP_DSI),
 	 FLAG(cap, PCI_PM_CAP_D1),
 	 FLAG(cap, PCI_PM_CAP_D2),
-	 pm_aux_current[(cap >> 6) & 7],
+	 pm_aux_current[(cap & PCI_PM_CAP_AUX_C_MASK) >> 6],
 	 FLAG(cap, PCI_PM_CAP_PME_D0),
 	 FLAG(cap, PCI_PM_CAP_PME_D1),
 	 FLAG(cap, PCI_PM_CAP_PME_D2),
@@ -136,17 +136,17 @@ cap_pcix_nobridge(struct device *d, int where)
 	 1 << (9 + ((command & PCI_PCIX_COMMAND_MAX_MEM_READ_BYTE_COUNT) >> 2U)),
 	 max_outstanding[(command & PCI_PCIX_COMMAND_MAX_OUTSTANDING_SPLIT_TRANS) >> 4U]);
   printf("\t\tStatus: Dev=%02x:%02x.%d 64bit%c 133MHz%c SCD%c USC%c DC=%s DMMRBC=%u DMOST=%u DMCRS=%u RSCEM%c 266MHz%c 533MHz%c\n",
-	 ((status >> 8) & 0xff),
-	 ((status >> 3) & 0x1f),
+	 (status & PCI_PCIX_STATUS_BUS) >> 8,
+	 (status & PCI_PCIX_STATUS_DEVICE) >> 3,
 	 (status & PCI_PCIX_STATUS_FUNCTION),
 	 FLAG(status, PCI_PCIX_STATUS_64BIT),
 	 FLAG(status, PCI_PCIX_STATUS_133MHZ),
 	 FLAG(status, PCI_PCIX_STATUS_SC_DISCARDED),
 	 FLAG(status, PCI_PCIX_STATUS_UNEXPECTED_SC),
 	 ((status & PCI_PCIX_STATUS_DEVICE_COMPLEXITY) ? "bridge" : "simple"),
-	 1 << (9 + ((status >> 21) & 3U)),
-	 max_outstanding[(status >> 23) & 7U],
-	 1 << (3 + ((status >> 26) & 7U)),
+	 1 << (9 + ((status & PCI_PCIX_STATUS_DESIGNED_MAX_MEM_READ_BYTE_COUNT) >> 21)),
+	 max_outstanding[(status & PCI_PCIX_STATUS_DESIGNED_MAX_OUTSTANDING_SPLIT_TRANS) >> 23],
+	 1 << (3 + ((status & PCI_PCIX_STATUS_DESIGNED_MAX_CUMULATIVE_READ_SIZE) >> 26)),
 	 FLAG(status, PCI_PCIX_STATUS_RCVD_SC_ERR_MESS),
 	 FLAG(status, PCI_PCIX_STATUS_266MHZ),
 	 FLAG(status, PCI_PCIX_STATUS_533MHZ));
@@ -175,11 +175,11 @@ cap_pcix_bridge(struct device *d, int where)
 	 FLAG(secstatus, PCI_PCIX_BRIDGE_SEC_STATUS_UNEXPECTED_SC),
 	 FLAG(secstatus, PCI_PCIX_BRIDGE_SEC_STATUS_SC_OVERRUN),
 	 FLAG(secstatus, PCI_PCIX_BRIDGE_SEC_STATUS_SPLIT_REQUEST_DELAYED),
-	 sec_clock_freq[(secstatus >> 6) & 7]);
+	 sec_clock_freq[(secstatus & PCI_PCIX_BRIDGE_SEC_STATUS_CLOCK_FREQ) >> 6]);
   status = get_conf_long(d, where + PCI_PCIX_BRIDGE_STATUS);
   printf("\t\tStatus: Dev=%02x:%02x.%d 64bit%c 133MHz%c SCD%c USC%c SCO%c SRD%c\n",
-	 ((status >> 8) & 0xff),
-	 ((status >> 3) & 0x1f),
+	 (status & PCI_PCIX_BRIDGE_STATUS_BUS) >> 8,
+	 (status & PCI_PCIX_BRIDGE_STATUS_DEVICE) >> 3,
 	 (status & PCI_PCIX_BRIDGE_STATUS_FUNCTION),
 	 FLAG(status, PCI_PCIX_BRIDGE_STATUS_64BIT),
 	 FLAG(status, PCI_PCIX_BRIDGE_STATUS_133MHZ),
@@ -831,7 +831,7 @@ static void cap_express_slot(struct device *d, int where)
 	FLAG(t, PCI_EXP_SLTCAP_HPC),
 	FLAG(t, PCI_EXP_SLTCAP_HPS));
   printf("\t\t\tSlot #%d, PowerLimit %.3fW; Interlock%c NoCompl%c\n",
-	t >> 19,
+	(t & PCI_EXP_SLTCAP_PSN) >> 19,
 	power_limit((t & PCI_EXP_SLTCAP_PWR_VAL) >> 7, (t & PCI_EXP_SLTCAP_PWR_SCL) >> 15),
 	FLAG(t, PCI_EXP_SLTCAP_INTERLOCK),
 	FLAG(t, PCI_EXP_SLTCAP_NOCMDCOMP));
