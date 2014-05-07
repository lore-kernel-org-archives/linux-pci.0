Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:47586 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933942AbaEGQIq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 May 2014 12:08:46 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, sthokal@xilinx.com,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH v6 3/3] MAINTAINERS: add entry for generic PCI host controller driver
Date: Wed,  7 May 2014 17:07:19 +0100
Message-Id: <1399478839-3564-4-git-send-email-will.deacon@arm.com>
In-Reply-To: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add myself as the maintainer for the generic PCI host controller driver.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 106626442124..424874c9a692 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6751,6 +6751,14 @@ L:	linux-pci@vger.kernel.org
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

