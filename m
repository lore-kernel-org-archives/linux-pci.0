Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:36636 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbbHBBGc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2015 21:06:32 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 2/4] drivers:hv: Define the channel type for Hyper-V PCI Express pass-through
Date: Sun,  2 Aug 2015 00:54:47 +0000
Message-Id: <1438476889-19220-3-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1438476889-19220-1-git-send-email-jakeo@microsoft.com>
References: <1438476889-19220-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch defines the channel type for a paravirtual PCI front-end within
a Hyper-V VM.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 include/linux/hyperv.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 02393b6..ab17332 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1139,6 +1139,17 @@ int vmbus_cpu_number_to_vp_number(int cpu_number);
 		}
 
 /*
+ * PCI Express Pass Through
+ * {44C4F61D-4444-4400-9D52-802E27EDE19F}
+ */
+
+#define HV_PCIE_GUID \
+	.guid = { \
+			0x1D, 0xF6, 0xC4, 0x44, 0x44, 0x44, 0x00, 0x44, \
+			0x9D, 0x52, 0x80, 0x2E, 0x27, 0xED, 0xE1, 0x9F \
+		}
+
+/*
  * Common header for Hyper-V ICs
  */
 
-- 
1.9.1

