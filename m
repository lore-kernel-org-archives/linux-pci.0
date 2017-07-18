Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:52712 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdGROqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 10:46:36 -0400
From: Harvey Hunt <harvey.hunt@imgtec.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: Harvey Hunt <harvey.hunt@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation/devicetree: Update links to PCI DT bindings
Date: Tue, 18 Jul 2017 15:46:07 +0100
Message-ID: <1500389167-34944-1-git-send-email-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update links to the PDFs of PCI and interrupt mapping bindings, as
the previous links are broken.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/pci.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 50f9e2c..13a73b4 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -1,12 +1,12 @@
 PCI bus bridges have standardized Device Tree bindings:
 
 PCI Bus Binding to: IEEE Std 1275-1994
-http://www.firmware.org/1275/bindings/pci/pci2_1.pdf
+https://www.openfirmware.info/data/docs/bus.pci.pdf
 
 And for the interrupt mapping part:
 
 Open Firmware Recommended Practice: Interrupt Mapping
-http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
+https://www.openfirmware.info/data/docs/rec.intmap.d09.pdf
 
 Additionally to the properties specified in the above standards a host bridge
 driver implementation may support the following properties:
-- 
2.7.4
