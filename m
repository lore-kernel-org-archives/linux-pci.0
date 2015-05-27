Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57239 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbbE0VKE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:10:04 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 03/13] PCI: Add Kconfig option PCI_STATIC_ENUMERATION
Date: Wed, 27 May 2015 20:58:54 +0000
Message-ID: <a59b2055cd9946d5a95b0e547944d12a@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a new Kconfig option that enables PCI static enumeration.
Changes to existing files will key off of this option.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/Kconfig |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 7a8f1c5..81ead93 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -114,4 +114,16 @@ config PCI_LABEL
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
+	  When in doubt, say N.
+
 source "drivers/pci/host/Kconfig"
-- 
1.7.9.5

