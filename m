Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:13423 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbbIQVXj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 17:23:39 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v1 4/7] PCI: Add Kconfig option for static enumeration
Date: Thu, 17 Sep 2015 21:11:12 +0000
Message-ID: <eea7fd1592244403b5e8cbeba6a6e4f5@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a new Kconfig option, PCI_STATIC_ENUMERATION, that will be
used by upcoming commits.  Changes to existing files will key off of
this option.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 73de4ef..efebf81 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -118,4 +118,16 @@ config PCI_LABEL
 	def_bool y if (DMI || ACPI)
 	select NLS
 
+config PCI_STATIC_ENUMERATION
+	bool "PCI static enumeration support"
+	depends on PCI
+	help
+	  Say Y here to allow PCI devices to be specifically enumerated
+	  instead of relying upon BIOS to enumerate the devices. This is
+	  useful when hotplugging non-CardBus devices. A static enumeration
+	  option string can be given on the command line to override BIOS
+	  settings.
+
+	  If unsure, say N.
+
 source "drivers/pci/host/Kconfig"
-- 
1.8.3.1

