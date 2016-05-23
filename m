Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17037 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095AbcEWIx5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 May 2016 04:53:57 -0400
From: Amir Levy <amir.jer.levy@intel.com>
To: andreas.noever@gmail.com, gregkh@linuxfoundation.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, amir.jer.levy@intel.com,
	michael.jamet@intel.com, dan.alloun@intel.com,
	mika.westerberg@intel.com, kai.svahn@intel.com,
	andriy.shevchenko@intel.com, tomas.winkler@intel.com
Subject: [PATCH 5/6] thunderbolt: Kconfig for Thunderbolt(TM) networking
Date: Mon, 23 May 2016 11:48:55 +0300
Message-Id: <1463993336-2750-6-git-send-email-amir.jer.levy@intel.com>
In-Reply-To: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Updating the Kconfig Thunderbolt(TM) description.

Signed-off-by: Amir Levy <amir.jer.levy@intel.com>
Signed-off-by: Michael Jamet <michael.jamet@intel.com>
---
 drivers/thunderbolt/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index c121acc..8ac4149 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -1,13 +1,12 @@
 menuconfig THUNDERBOLT
-	tristate "Thunderbolt support for Apple devices"
+	tristate "Thunderbolt(TM) support"
 	depends on PCI
 	select CRC32
 	help
-	  Cactus Ridge Thunderbolt Controller driver
-	  This driver is required if you want to hotplug Thunderbolt devices on
-	  Apple hardware.
+	  Thunderbolt(TM) Controller driver
+	  This driver is required if you want to hotplug Thunderbolt(TM) devices.
 
-	  Device chaining is currently not supported.
+	  Device chaining is currently not supported on Apple hardware.
 
 	  To compile this driver a module, choose M here. The module will be
 	  called thunderbolt.
-- 
1.9.1

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

