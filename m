Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59220 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbbLDXow (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 18:44:52 -0500
Date: Fri, 4 Dec 2015 17:44:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladis Dronov <vdronov@redhat.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: fix missing ROM content warning in
 pci_get_rom_size()
Message-ID: <20151204234447.GM20125@localhost>
References: <20151124170331.GB24819@localhost>
 <1448644806-6506-1-git-send-email-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448644806-6506-1-git-send-email-vdronov@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 27, 2015 at 06:20:06PM +0100, Vladis Dronov wrote:
> Make pci_get_rom_size() to emit a warning if any byte in a PCI ROM
> header or data signature is not following the standard ("PCI Local
> Bus Specification" or "PCI Firmware Specification Revision 3.x"),
> not only the first one.
> 
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>

Applied as follows to pci/misc for v4.5, thanks!


commit f3744cad60c3ecae125c4be566867517d4bac848
Author: Vladis Dronov <vdronov@redhat.com>
Date:   Fri Nov 27 18:20:06 2015 +0100

    PCI: Print warnings for all invalid expansion ROM headers
    
    We've always validated that both bytes of the Expansion ROM signature and
    all four bytes of the PCI Data Structure signature (see PCI Firmware spec
    r3.0, sec 5.1.1), but we only printed a warning if the first byte of the
    ROM signature was invalid.
    
    Print warnings if *any* of those bytes are invalid.  Note that we only look
    at these headers if we map or read the ROM.
    
    [bhelgaas: changelog, tweak printk format]
    Signed-off-by: Vladis Dronov <vdronov@redhat.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index eb0ad53..5a1a39d 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -77,22 +77,18 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
 	do {
 		void __iomem *pds;
 		/* Standard PCI ROMs start out with these bytes 55 AA */
-		if (readb(image) != 0x55) {
-			dev_err(&pdev->dev, "Invalid ROM contents\n");
+		if (readw(image) != 0xAA55) {
+			dev_err(&pdev->dev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
+				readw(image));
 			break;
 		}
-		if (readb(image + 1) != 0xAA)
-			break;
-		/* get the PCI data structure and check its signature */
+		/* get the PCI data structure and check its "PCIR" signature */
 		pds = image + readw(image + 24);
-		if (readb(pds) != 'P')
-			break;
-		if (readb(pds + 1) != 'C')
-			break;
-		if (readb(pds + 2) != 'I')
-			break;
-		if (readb(pds + 3) != 'R')
+		if (readl(pds) != 0x52494350) {
+			dev_err(&pdev->dev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
+				readl(pds));
 			break;
+		}
 		last_image = readb(pds + 21) & 0x80;
 		length = readw(pds + 16);
 		image += length * 512;
