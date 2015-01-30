Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from p02c12o142.mxlogic.net ([208.65.145.75]:58327 "EHLO
	p02c12o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbbA3Txz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jan 2015 14:53:55 -0500
From: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
To: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
CC: "'stable@vger.kernel.org'" <stable@vger.kernel.org>,
	"Lawrence, Joe" <Joe.Lawrence@stratus.com>,
	"'myron.stowe@redhat.com'" <myron.stowe@redhat.com>
Subject: [PATCH] PCI: Add NEC ftServer variants to PCIe DMI check
Date: Fri, 30 Jan 2015 19:45:02 +0000
Message-ID: <48F2A65D5838B34AA5C81AB195ED2D5F932489A2@EXHQ1.corp.stratus.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Myron -

commit 1278998f8ff6 missed the NEC variants of the ftServers.
We'll need this in RHEL7/6, but can you shepherd this patch upstream first?
Thanks!

/Charlotte

-->8--

>From 64a19253432e87b2293d3b8ee323e8b8ac63395d Mon Sep 17 00:00:00 2001
From: Charlotte Richardson <charlotte.richardson@stratus.com>
Date: Fri, 30 Jan 2015 12:58:31 -0500
Subject: [PATCH] PCI: Add NEC ftServer variants to PCIe DMI check.

NEC OEMs the same platforms as Stratus does, which have multiple
devices on some PCIe buses under downstream ports.

Signed-off-by: Charlotte Richardson <charlotte.richardson@stratus.com>
Fixes: 1278998f8ff6 ("PCI: Work around Stratus ftServer broken PCIe hierarchy (fix DMI check)")
Cc: <stable@vger.kernel.org>
Cc: Myron Stowe <myron.stowe@redhat.com>
---
 arch/x86/pci/common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 7b20bcc..2fb3847 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -448,6 +448,22 @@ static const struct dmi_system_id pciprobe_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ftServer"),
 		},
 	},
+        {
+                .callback = set_scan_all,
+                .ident = "Stratus/NEC ftServer",
+                .matches = {
+                        DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "Express5800/R32"),
+                },
+        },
+        {
+                .callback = set_scan_all,
+                .ident = "Stratus/NEC ftServer",
+                .matches = {
+                        DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "Express5800/R31"),
+                },
+        },
 	{}
 };
 
-- 
1.8.3.1


