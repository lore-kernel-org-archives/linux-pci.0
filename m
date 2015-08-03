Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35636 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbHCEdg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 00:33:36 -0400
Received: by pasy3 with SMTP id y3so4616244pas.2
        for <linux-pci@vger.kernel.org>; Sun, 02 Aug 2015 21:33:36 -0700 (PDT)
From: Adam Lee <adam.lee@canonical.com>
To: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] serial: 8250_pci: Add support for Pericom PI7C9X795[1248]
Date: Mon,  3 Aug 2015 12:33:21 +0800
Message-Id: <1438576401-24921-2-git-send-email-adam.lee@canonical.com>
In-Reply-To: <1438576401-24921-1-git-send-email-adam.lee@canonical.com>
References: <1438576401-24921-1-git-send-email-adam.lee@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pericom PI7C9X795[1248] are Uno/Dual/Quad/Octal UART devices, this
patch enables them.

Signed-off-by: Adam Lee <adam.lee@canonical.com>
---
 drivers/tty/serial/8250/8250_pci.c | 76 +++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e55f18b..353112c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2331,27 +2331,12 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 	 * Pericom
 	 */
 	{
-		.vendor		= 0x12d8,
-		.device		= 0x7952,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_pericom_setup,
-	},
-	{
-		.vendor		= 0x12d8,
-		.device		= 0x7954,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_pericom_setup,
-	},
-	{
-		.vendor		= 0x12d8,
-		.device		= 0x7958,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_pericom_setup,
+		.vendor         = PCI_VENDOR_ID_PERICOM,
+		.device         = PCI_ANY_ID,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.setup          = pci_pericom_setup,
 	},
-
 	/*
 	 * PLX
 	 */
@@ -3056,6 +3041,10 @@ enum pci_board_num_t {
 	pbn_fintek_8,
 	pbn_fintek_12,
 	pbn_wch384_4,
+	pbn_pericom_PI7C9X7951,
+	pbn_pericom_PI7C9X7952,
+	pbn_pericom_PI7C9X7954,
+	pbn_pericom_PI7C9X7958,
 };
 
 /*
@@ -3881,7 +3870,6 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud	= 115200,
 		.first_offset	= 0x40,
 	},
-
 	[pbn_wch384_4] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 4,
@@ -3889,6 +3877,33 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset    = 8,
 		.first_offset   = 0xC0,
 	},
+	/*
+	 * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
+	 */
+	[pbn_pericom_PI7C9X7951] = {
+		.flags          = FL_BASE0,
+		.num_ports      = 1,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
+	[pbn_pericom_PI7C9X7952] = {
+		.flags          = FL_BASE0,
+		.num_ports      = 2,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
+	[pbn_pericom_PI7C9X7954] = {
+		.flags          = FL_BASE0,
+		.num_ports      = 4,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
+	[pbn_pericom_PI7C9X7958] = {
+		.flags          = FL_BASE0,
+		.num_ports      = 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
 };
 
 static const struct pci_device_id blacklist[] = {
@@ -5154,6 +5169,25 @@ static struct pci_device_id serial_pci_tbl[] = {
 		0,
 		0, pbn_exar_XR17V8358 },
 	/*
+	 * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
+	 */
+	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7951,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_pericom_PI7C9X7951 },
+	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7952,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_pericom_PI7C9X7952 },
+	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7954,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_pericom_PI7C9X7954 },
+	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7958,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_pericom_PI7C9X7958 },
+	/*
 	 * Topic TP560 Data/Fax/Voice 56k modem (reported by Evan Clarke)
 	 */
 	{	PCI_VENDOR_ID_TOPIC, PCI_DEVICE_ID_TOPIC_TP560,
-- 
2.5.0

