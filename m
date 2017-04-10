Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36165 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdDJWZn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2017 18:25:43 -0400
Received: by mail-pf0-f182.google.com with SMTP id o126so39498341pfb.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2017 15:25:43 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Michael Davidson <md@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] PCI: Add cast when assigning PCI_ROM_ADDRESS_MASK to a 32-bit variable
Date: Mon, 10 Apr 2017 15:24:57 -0700
Message-Id: <20170410222457.113155-1-mka@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes a clang warning about "implicit conversion from 'unsigned
long' to 'u32'"

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dfc9a2794141..148e80d5caf1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -180,7 +180,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	u16 orig_cmd;
 	struct pci_bus_region region, inverted_region;
 
-	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
+	mask = type ? (u32)PCI_ROM_ADDRESS_MASK : ~0;
 
 	/* No printks while decoding is disabled! */
 	if (!dev->mmio_always_on) {
-- 
2.12.2.715.g7642488e1d-goog
