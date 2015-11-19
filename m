Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35475 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbbKSQIZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 Nov 2015 11:08:25 -0500
From: Andy Lutomirski <luto@kernel.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/2] acpi: Tidy up _OSC error spacing
Date: Thu, 19 Nov 2015 08:08:19 -0800
Message-Id: <cd180d52de6dc9e217bd0a0aed32efa68d0c73f8.1447949171.git.luto@kernel.org>
In-Reply-To: <cover.1447949171.git.luto@kernel.org>
References: <cover.1447949171.git.luto@kernel.org>
In-Reply-To: <cover.1447949171.git.luto@kernel.org>
References: <cover.1447949171.git.luto@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The whitespace in _OSC error reports is weird.  Improve it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/acpi/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a212cefae524..2177ef0b16e4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -182,12 +182,12 @@ static void acpi_print_osc_error(acpi_handle handle,
 	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer)))
 		printk(KERN_DEBUG "%s\n", error);
 	else {
-		printk(KERN_DEBUG "%s:%s\n", (char *)buffer.pointer, error);
+		printk(KERN_DEBUG "%s: %s\n", (char *)buffer.pointer, error);
 		kfree(buffer.pointer);
 	}
-	printk(KERN_DEBUG"_OSC request data:");
+	printk(KERN_DEBUG "_OSC request data:");
 	for (i = 0; i < context->cap.length; i += sizeof(u32))
-		printk("%x ", *((u32 *)(context->cap.pointer + i)));
+		printk(" %x", *((u32 *)(context->cap.pointer + i)));
 	printk("\n");
 }
 
-- 
2.5.0

