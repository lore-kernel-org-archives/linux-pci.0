Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39722 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538AbcHAMZG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Aug 2016 08:25:06 -0400
From: Amir Levy <amir.jer.levy@intel.com>
To: andreas.noever@gmail.com, gregkh@linuxfoundation.org,
	bhelgaas@google.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	thunderbolt-linux@intel.com, mika.westerberg@intel.com,
	tomas.winkler@intel.com, Amir Levy <amir.jer.levy@intel.com>
Subject: [PATCH v6 1/8] thunderbolt: Macro rename
Date: Mon,  1 Aug 2016 15:23:46 +0300
Message-Id: <1470054233-4309-2-git-send-email-amir.jer.levy@intel.com>
In-Reply-To: <1470054233-4309-1-git-send-email-amir.jer.levy@intel.com>
References: <1470054233-4309-1-git-send-email-amir.jer.levy@intel.com>
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

