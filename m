Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55133 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbaH2JKP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Aug 2014 05:10:15 -0400
From: David Henningsson <david.henningsson@canonical.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
Date: Fri, 29 Aug 2014 11:10:14 +0200
Message-Id: <1409303414-5196-1-git-send-email-david.henningsson@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Under a 3.16 based kernel (Ubuntu 3.16.0-031600-lowlatency),
CardBus is not working unless pci=assign-buses is added to the
kernel boot parameters.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 arch/x86/pci/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

It was working OOTB on a 3.2 based kernel (Ubuntu 3.2.0-67-generic),
and I have not thoroughly bisected what made it stop working.
Still I'm suggesting to just a quirk to make it work regardless of
kernel - it's a ~8 year old laptop, so being a bit lazy about it is
probably okay, I hope. :-)

Extract from dmidecode:

Handle 0x0100, DMI type 1, 25 bytes
System Information
	Manufacturer: Dell Inc.
	Product Name: Latitude D505    

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 059a76c..1849e39 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -262,6 +262,14 @@ static const struct dmi_system_id pciprobe_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "SX20S"),
 		},
 	},
+	{
+		.callback = assign_all_busses,
+		.ident = "Dell Latitude D505 Laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D505"),
+		},
+	},
 #endif		/* __i386__ */
 	{
 		.callback = set_bf_sort,
-- 
1.9.1

