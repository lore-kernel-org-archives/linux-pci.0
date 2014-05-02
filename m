Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:45508 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752976AbaEBQmE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 May 2014 12:42:04 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH 3/3] MAINTAINERS: add entry for generic PCI host controller driver
Date: Fri,  2 May 2014 17:41:16 +0100
Message-Id: <1399048876-11862-4-git-send-email-will.deacon@arm.com>
In-Reply-To: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add myself as the maintainer for the generic PCI host controller driver.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e67ea2442041..d5db11484062 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6740,6 +6740,14 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*designware*
 
+PCI DRIVER FOR GENERIC OF HOSTS
+M:	Will Deacon <will.deacon@arm.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
+F:	drivers/pci/host/pci-host-generic.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
-- 
1.9.2

