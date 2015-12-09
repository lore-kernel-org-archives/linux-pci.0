Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:18826 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbbLITtP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2015 14:49:15 -0500
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v8 6/7] drivers:hv: Define the channel type of Hyper-V PCI Express pass-through
Date: Wed,  9 Dec 2015 19:48:44 +0000
Message-Id: <1449690525-5240-7-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1449690525-5240-1-git-send-email-jakeo@microsoft.com>
References: <1449690525-5240-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This defines the channel type for PCI front-ends in Hyper-V VMs.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 include/linux/hyperv.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 24d0b65..c9a9eed 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1141,6 +1141,17 @@ u64 hv_do_hypercall(u64 control, void *input, void *output);
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

