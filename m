Return-Path: <SRS0=mh2v=JM=codeaurora.org=tbaicar@kernel.org>
Return-Path: <SRS0=mh2v=JM=codeaurora.org=tbaicar@kernel.org>
From: Tyler Baicar <tbaicar@codeaurora.org>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	poza@codeaurora.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH] PCI/AER: Adopt lspci naming convention for AER prints
Date: Tue, 26 Jun 2018 11:44:15 -0400
Message-Id: <1530027855-19709-1-git-send-email-tbaicar@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

lspci uses abbreviated naming for AER error strings. Adopt the
same naming convention for the AER printing so they match.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..08a5219 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -459,22 +459,22 @@ int pci_aer_init(struct pci_dev *dev)
 };
 
 static const char *aer_correctable_error_string[] = {
-	"Receiver Error",		/* Bit Position 0	*/
+	"RxErr",			/* Bit Position 0	*/
 	NULL,
 	NULL,
 	NULL,
 	NULL,
 	NULL,
-	"Bad TLP",			/* Bit Position 6	*/
-	"Bad DLLP",			/* Bit Position 7	*/
-	"RELAY_NUM Rollover",		/* Bit Position 8	*/
+	"BadTLP",			/* Bit Position 6	*/
+	"BadDLLP",			/* Bit Position 7	*/
+	"Rollover",			/* Bit Position 8	*/
 	NULL,
 	NULL,
 	NULL,
-	"Replay Timer Timeout",		/* Bit Position 12	*/
-	"Advisory Non-Fatal",		/* Bit Position 13	*/
-	"Corrected Internal Error",	/* Bit Position 14	*/
-	"Header Log Overflow",		/* Bit Position 15	*/
+	"Timeout",			/* Bit Position 12	*/
+	"NonFatalErr",			/* Bit Position 13	*/
+	"CorrIntErr",			/* Bit Position 14	*/
+	"HeaderOF",			/* Bit Position 15	*/
 };
 
 static const char *aer_uncorrectable_error_string[] = {
@@ -482,28 +482,28 @@ int pci_aer_init(struct pci_dev *dev)
 	NULL,
 	NULL,
 	NULL,
-	"Data Link Protocol",		/* Bit Position 4	*/
-	"Surprise Down Error",		/* Bit Position 5	*/
+	"DLP",				/* Bit Position 4	*/
+	"SDES",				/* Bit Position 5	*/
 	NULL,
 	NULL,
 	NULL,
 	NULL,
 	NULL,
 	NULL,
-	"Poisoned TLP",			/* Bit Position 12	*/
-	"Flow Control Protocol",	/* Bit Position 13	*/
-	"Completion Timeout",		/* Bit Position 14	*/
-	"Completer Abort",		/* Bit Position 15	*/
-	"Unexpected Completion",	/* Bit Position 16	*/
-	"Receiver Overflow",		/* Bit Position 17	*/
-	"Malformed TLP",		/* Bit Position 18	*/
+	"TLP",				/* Bit Position 12	*/
+	"FCP",				/* Bit Position 13	*/
+	"CmpltTO",			/* Bit Position 14	*/
+	"CmpltAbrt",			/* Bit Position 15	*/
+	"UnxCmplt",			/* Bit Position 16	*/
+	"RxOF",				/* Bit Position 17	*/
+	"MalfTLP",			/* Bit Position 18	*/
 	"ECRC",				/* Bit Position 19	*/
-	"Unsupported Request",		/* Bit Position 20	*/
-	"ACS Violation",		/* Bit Position 21	*/
-	"Uncorrectable Internal Error",	/* Bit Position 22	*/
-	"MC Blocked TLP",		/* Bit Position 23	*/
-	"AtomicOp Egress Blocked",	/* Bit Position 24	*/
-	"TLP Prefix Blocked Error",	/* Bit Position 25	*/
+	"UnsupReq",			/* Bit Position 20	*/
+	"ACSViol",			/* Bit Position 21	*/
+	"UncorrIntErr",			/* Bit Position 22	*/
+	"BlockedTLP",			/* Bit Position 23	*/
+	"AtomicOpBlocked",		/* Bit Position 24	*/
+	"TLPBlockedErr",		/* Bit Position 25	*/
 };
 
 static const char *aer_agent_string[] = {
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
