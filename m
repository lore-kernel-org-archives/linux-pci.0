Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:39767 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab2IJMDF convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:1:1>);
	Mon, 10 Sep 2012 08:03:05 -0400
Message-Id: <504DF314020000780009A2E2@nat28.tlf.novell.com>
Date: Mon, 10 Sep 2012 13:03:00 +0100
From: "Jan Beulich" <JBeulich@suse.com>
To: "Jesse Barnes" <jbarnes@virtuousgeek.org>
Cc: <linux-pci@vger.kernel.org>
Subject: [PATCH] drop bogus default from ARCH_SUPPORTS_MSI
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Options without prompts and without dependencies don't usefully have a
default value - they're intended to be selected from other options
only.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

---
 drivers/pci/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- 3.6-rc5/drivers/pci/Kconfig
+++ 3.6-rc5-kconfig-cleanup-pci/drivers/pci/Kconfig
@@ -3,7 +3,6 @@
 #
 config ARCH_SUPPORTS_MSI
 	bool
-	default n
 
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"



