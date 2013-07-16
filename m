Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	driverdev-devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 2/4] serial: 8250_pci: replace PCI_VENDOR_ID_ADDIDATA_OLD
Date: Tue, 16 Jul 2013 16:14:39 +0100
Message-Id: <1373987681-18245-3-git-send-email-abbotti@mev.co.uk>
In-Reply-To: <1373987681-18245-1-git-send-email-abbotti@mev.co.uk>
References: <1373987681-18245-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_VENDOR_ID_ADDIDATA_OLD has the same value (0x10e8) as
PCI_VENDOR_ID_AMCC in <linux/pci_ids.h>.  The vender ID is actually
assigned to Applied Micro Circuits Corporation.  The 8250_pci driver
uses PCI_VENDOR_ID_ADDIDATA_OLD in the lists of quirks and PCI IDs for
the ADDI-DATA APCI-7800 card.  Change it to use the more accurate
PCI_VENDOR_ID_AMCC.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/tty/serial/8250/8250_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c52948b..3e3d59b 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1587,7 +1587,7 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
 	*/
 	{
-		.vendor         = PCI_VENDOR_ID_ADDIDATA_OLD,
+		.vendor         = PCI_VENDOR_ID_AMCC,
 		.device         = PCI_DEVICE_ID_ADDIDATA_APCI7800,
 		.subvendor      = PCI_ANY_ID,
 		.subdevice      = PCI_ANY_ID,
@@ -4697,7 +4697,7 @@ static struct pci_device_id serial_pci_tbl[] = {
 		0,
 		pbn_b0_1_115200 },
 
-	{	PCI_VENDOR_ID_ADDIDATA_OLD,
+	{	PCI_VENDOR_ID_AMCC,
 		PCI_DEVICE_ID_ADDIDATA_APCI7800,
 		PCI_ANY_ID,
 		PCI_ANY_ID,
-- 
1.8.2.1

