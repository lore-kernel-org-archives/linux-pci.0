Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52108 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbcGNL27 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Jul 2016 07:28:59 -0400
From: Amir Levy <amir.jer.levy@intel.com>
To: andreas.noever@gmail.com, gregkh@linuxfoundation.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, thunderbolt-linux@intel.com,
	mika.westerberg@intel.com, tomas.winkler@intel.com,
	Amir Levy <amir.jer.levy@intel.com>
Subject: [PATCH v3 1/8] thunderbolt: Macro rename
Date: Thu, 14 Jul 2016 14:28:15 +0300
Message-Id: <1468495702-7467-2-git-send-email-amir.jer.levy@intel.com>
In-Reply-To: <1468495702-7467-1-git-send-email-amir.jer.levy@intel.com>
References: <1468495702-7467-1-git-send-email-amir.jer.levy@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This first patch updates the registers file to
reflect that it isn't only for Cactus Ridge.
No functional change intended.

Signed-off-by: Amir Levy <amir.jer.levy@intel.com>
---
 drivers/thunderbolt/nhi_regs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
index 86b996c..75cf069 100644
--- a/drivers/thunderbolt/nhi_regs.h
+++ b/drivers/thunderbolt/nhi_regs.h
@@ -1,11 +1,11 @@
 /*
- * Thunderbolt Cactus Ridge driver - NHI registers
+ * Thunderbolt driver - NHI registers
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
  */
 
-#ifndef DSL3510_REGS_H_
-#define DSL3510_REGS_H_
+#ifndef NHI_REGS_H_
+#define NHI_REGS_H_
 
 #include <linux/types.h>
 
-- 
2.7.4

