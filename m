Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:38272 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753152AbcFQPFT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2016 11:05:19 -0400
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 9/9] [RFC] pci: include <asm/dma.h> for isa_dma_bridge_buggy
Date: Fri, 17 Jun 2016 16:05:13 +0100
Message-Id: <1466175913-19067-10-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

At least on arm, <asm/dma.h> does not get included when building
drivers/pci/pci.o. This causes the following build warning which
can be fixed by including <asm/dma.h>:

drivers/pci/pci.c:37:5: warning: symbol 'isa_dma_bridge_buggy' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9add285..86b538d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
 #include <asm/setup.h>
+#include <asm/dma.h>
 #include <linux/aer.h>
 #include "pci.h"
 
-- 
2.8.1

