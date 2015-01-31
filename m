Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:48559 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbAaNsN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 31 Jan 2015 08:48:13 -0500
Received: by mail-yh0-f48.google.com with SMTP id a41so12970031yho.7
        for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2015 05:48:13 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 01/15] PCI: introduce pci_device_to_OF_node() for !CONFIG_OF
Date: Sat, 31 Jan 2015 21:47:31 +0800
Message-Id: <1422712065-9403-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So we can avoid the ugly #ifdef in some drivers.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8323cbf93913..421eb6a9e600 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1863,6 +1863,8 @@ static inline void pci_set_of_node(struct pci_dev *dev) { }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
+static inline struct device_node *
+pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
 #endif  /* CONFIG_OF */
 
 #ifdef CONFIG_EEH
-- 
1.9.3

