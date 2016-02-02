Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:41440 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbcBBRjX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2016 12:39:23 -0500
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] Synopsys driver updated in Maintainers
Date: Tue,  2 Feb 2016 17:39:16 +0000
Message-Id: <eb5a3237d868dba88c0bdbe3862e14890b4adf05.1454434674.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Driver name changed but not updated in MAINTAINERS.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2e4506..caba688 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8234,8 +8234,8 @@ PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
 M:	Joao Pinto <jpinto@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
-F:	drivers/pci/host/pcie-snpsdev.c
+F:	Documentation/devicetree/bindings/pci/pcie-synopsys.txt
+F:	drivers/pci/host/pcie-synopsys.c
 
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
-- 
1.8.1.5

