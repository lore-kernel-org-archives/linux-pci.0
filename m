Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35489 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbbKSQI1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 Nov 2015 11:08:27 -0500
From: Andy Lutomirski <luto@kernel.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/2] acpi: Show _OSC UUID when _OSC fails
Date: Thu, 19 Nov 2015 08:08:20 -0800
Message-Id: <a89313359d813d955da7235d9193aab01a1c05f9.1447949171.git.luto@kernel.org>
In-Reply-To: <cover.1447949171.git.luto@kernel.org>
References: <cover.1447949171.git.luto@kernel.org>
In-Reply-To: <cover.1447949171.git.luto@kernel.org>
References: <cover.1447949171.git.luto@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When _OSC fails and especially when it fails due to an invalid UUID,
it's helpful to show the UUID that we tried.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/acpi/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2177ef0b16e4..be2b164f8f2d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -180,9 +180,9 @@ static void acpi_print_osc_error(acpi_handle handle,
 	int i;
 
 	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer)))
-		printk(KERN_DEBUG "%s\n", error);
+		printk(KERN_DEBUG "%s: %s\n", context->uuid_str, error);
 	else {
-		printk(KERN_DEBUG "%s: %s\n", (char *)buffer.pointer, error);
+		printk(KERN_DEBUG "%s (%s): %s\n", (char *)buffer.pointer, context->uuid_str, error);
 		kfree(buffer.pointer);
 	}
 	printk(KERN_DEBUG "_OSC request data:");
-- 
2.5.0

