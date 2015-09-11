Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 10/11] drivers:hv: Define the channel type for Hyper-V PCI Express pass-through
Date: Fri, 11 Sep 2015 00:01:09 +0000
Message-Id: <1441929670-10058-11-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This defines the channel type for PCI front-ends in Hyper-V VMs.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 include/linux/hyperv.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 033fe59..af0f2e7 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1140,6 +1140,17 @@ u64 do_hypercall(u64 control, void *input, void *output);
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

