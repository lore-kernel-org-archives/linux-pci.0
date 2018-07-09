Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46099 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754576AbeGIIhJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2018 04:37:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id r17-v6so13261950edo.13
        for <linux-pci@vger.kernel.org>; Mon, 09 Jul 2018 01:37:09 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 10/12] pci: use for_each_if
Date: Mon,  9 Jul 2018 10:36:48 +0200
Message-Id: <20180709083650.23549-10-daniel.vetter@ffwll.ch>
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Avoids the inverted condition compared to the open-coded version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..1484471ed048 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -601,7 +601,7 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
 
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
-		if (!pci_is_bridge(dev)) {} else
+		for_each_if (pci_is_bridge(dev))
 
 static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 {
-- 
2.18.0
