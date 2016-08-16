Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51360 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436AbcHPBmZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2016 21:42:25 -0400
From: Helen Koike <helen.koike@collabora.co.uk>
To: hch@infradead.org, mlin@kernel.org, fes@google.com,
	keith.busch@intel.com, rlnelson@google.com, axboe@fb.com,
	digitaleric@google.com, tytso@mit.edu, mikew@google.com,
	monish@google.com
Cc: Helen Koike <helen.koike@collabora.co.uk>,
	Helen Koike <helen.koike@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 RFC 1/2] PCI: Add Google device ID
Date: Mon, 15 Aug 2016 22:41:19 -0300
Message-Id: <69910419c3745269604fcb052ad9b08d1b601590.1471308889.git.helen.koike@collabora.co.uk>
In-Reply-To: <cover.1471308889.git.helen.koike@collabora.co.uk>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
 <cover.1471308889.git.helen.koike@collabora.co.uk>
In-Reply-To: <cover.1471308889.git.helen.koike@collabora.co.uk>
References: <cover.1471308889.git.helen.koike@collabora.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device ID for the local SSDs (NVMe) in Google Clound Engine

Signed-off-by: Helen Koike <helen.koike@collabora.com>
---

Changes since v2:
- This is a new patch in the serie

 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c58752f..d422afc 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -948,6 +948,8 @@
 #define PCI_DEVICE_ID_APPLE_IPID2_GMAC	0x006b
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
 
+#define PCI_VENDOR_ID_GOOGLE		0x1AE0
+
 #define PCI_VENDOR_ID_YAMAHA		0x1073
 #define PCI_DEVICE_ID_YAMAHA_724	0x0004
 #define PCI_DEVICE_ID_YAMAHA_724F	0x000d
-- 
1.9.1

