Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46614 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbbJTVDJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 20 Oct 2015 17:03:09 -0400
Subject: [PATCH] Documentation/devicetree: Update PCI Device Tree bindings
To: Rob Herring <robh+dt@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Date: Tue, 20 Oct 2015 16:03:03 -0500
Message-ID: <20151020210303.3671.52391.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update broken links to PCI bus and interrupt mapping bindings.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/devicetree/bindings/pci/pci.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index f8fbe9a..08dcfad 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -1,12 +1,12 @@
 PCI bus bridges have standardized Device Tree bindings:
 
 PCI Bus Binding to: IEEE Std 1275-1994
-http://www.openfirmware.org/ofwg/bindings/pci/pci2_1.pdf
+http://www.firmware.org/1275/bindings/pci/pci2_1.pdf
 
 And for the interrupt mapping part:
 
 Open Firmware Recommended Practice: Interrupt Mapping
-http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf
+http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
 
 Additionally to the properties specified in the above standards a host bridge
 driver implementation may support the following properties:

