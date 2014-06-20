Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] thunderbolt: include linux/slab.h for kmalloc
Date: Fri, 20 Jun 2014 15:52:10 +0200
Message-Id: <1403272331-3790755-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1403272331-3790755-1-git-send-email-arnd@arndb.de>
References: <1403272331-3790755-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The kmalloc/kzalloc/kfree functions are declared in linux/slab.h,
so we have to explicitly include that header to avoid build failures
on ARM and other architectures that don't include these implicitly
through another header.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thunderbolt/eeprom.c | 1 +
 drivers/thunderbolt/switch.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 0d5a80b..bc0449f 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/crc32.h>
+#include <linux/slab.h>
 #include "tb.h"
 
 /**
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 0d50e7e..26e76e4 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/slab.h>
 
 #include "tb.h"
 
-- 
1.8.3.2

