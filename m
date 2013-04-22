Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:51504 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab3DVXK2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:10:28 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so12591ieb.26
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:10:28 -0700 (PDT)
Subject: [PATCH v4 02/22] PCI: Use u8, not int, for PM capability offset
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:10:26 -0600
Message-ID: <20130422231026.32621.14207.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Power Management Capability (PCI_CAP_ID_PM == 0x01) is defined by PCI
and must appear in the 256-byte PCI Configuration Space from 0-0xff.  It
cannot be in the PCIe Extended Configuration space from 0x100-0xfff, so
we only need a u8 to hold its offset.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>
---
 include/linux/pci.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2461033a..9587d4d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -249,8 +249,7 @@ struct pci_dev {
 	pci_power_t     current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
 					   and D3 being off. */
-	int		pm_cap;		/* PM capability offset in the
-					   configuration space */
+	u8		pm_cap;		/* PM capability offset */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
 	unsigned int	pme_interrupt:1;

