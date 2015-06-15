Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org, pebolle@tiscali.nl,
	haiyangz@microsoft.com, mebersol@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 5/6] drivers:hv: Define the channel type for Hyper-V PCI Express pass-through
Date: Mon, 15 Jun 2015 17:06:38 +0000
Message-Id: <1434387999-1885-6-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
References: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch updates the list of VMBus channel GUIDs, defining the one
for PCI Express pass-through.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 include/linux/hyperv.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6fec42d..1903238 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1144,6 +1144,17 @@ int vmbus_procnum_to_vpnum(int procnum);
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

