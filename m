Return-Path: <SRS0=sMT+=FB=codeaurora.org=tbaicar@kernel.org>
Return-Path: <SRS0=sMT+=FB=codeaurora.org=tbaicar@kernel.org>
From: Tyler Baicar <tbaicar@codeaurora.org>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH v2] PCI/AER: update AER status string print to match other AER logs
Date: Wed,  7 Feb 2018 15:11:25 -0500
Message-Id: <1518034285-3543-1-git-send-email-tbaicar@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

Currently the AER driver uses cper_print_bits() to print the AER status
string. This causes the status string to not include the proper PCI device
name prefix that the other AER prints include. Also, it has a different
print level than all the other AER prints, and there is a potential to
have multiple status prints based on string lengths.

Update the AER driver to print the AER status string with the proper string
prefix and proper print level, and abreviate the status strings similar to
lspci -vv prints so they can be printed on the same line.

Previous log example:

e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
Receiver Error, Bad TLP
e1000e 0003:01:00.1: aer_layer=Physical Layer, aer_agent=Receiver ID
pcieport 0003:00:00.0: aer_status: 0x00001000, aer_mask: 0x0000e000
Replay Timer Timeout
pcieport 0003:00:00.0: aer_layer=Data Link Layer, aer_agent=Transmitter ID

New log:

e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
e1000e 0003:01:00.1: RxErr, BadTLP
e1000e 0003:01:00.1: aer_layer=Physical Layer, aer_agent=Receiver ID
pcieport 0003:00:00.0: aer_status: 0x00001000, aer_mask: 0x0000e000
pcieport 0003:00:00.0: Timeout
pcieport 0003:00:00.0: aer_layer=Data Link Layer, aer_agent=Transmitter ID

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/pci/pcie/aer/aerdrv_errprint.c | 71 ++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 6a352e6..bb68dd4 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -72,22 +72,22 @@
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
@@ -95,28 +95,28 @@
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
@@ -203,6 +203,29 @@ void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
+
+#define MAX_PRINT_LENGTH		120
+
+void dev_print_bits(struct pci_dev *dev, unsigned int bits,
+		    const char * const strs[], unsigned int strs_size)
+{
+	unsigned int i;
+	char errs[MAX_PRINT_LENGTH];
+
+	errs[0] = '\0';
+
+	for (i = 0; i < strs_size; i++) {
+		if (!(bits & (1U << i)))
+			continue;
+		if (strs[i]) {
+			if (strlen(errs))
+				strlcat(errs, ", ", MAX_PRINT_LENGTH);
+			strlcat(errs, strs[i], MAX_PRINT_LENGTH);
+		}
+	}
+	dev_err(&dev->dev, "%s\n", errs);
+}
+
 int cper_severity_to_aer(int cper_severity)
 {
 	switch (cper_severity) {
@@ -240,7 +263,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	agent = AER_GET_AGENT(aer_severity, status);
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	cper_print_bits("", status, status_strs, status_strs_size);
+	dev_print_bits(dev, status, status_strs, status_strs_size);
 	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
 		aer_error_layer[layer], aer_agent_string[agent]);
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
