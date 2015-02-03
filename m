Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:42054 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbbBCBhi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 20:37:38 -0500
Received: by mail-yh0-f41.google.com with SMTP id f73so17375609yha.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2015 17:37:37 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 01/15] PCI: Add pci_device_to_OF_node() stub for !CONFIG_OF
Date: Tue,  3 Feb 2015 09:37:24 +0800
Message-Id: <1422927444-31292-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422923108.4625.2.camel@ellerman.id.au>
References: <1422923108.4625.2.camel@ellerman.id.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a stub for pci_device_to_OF_node() so drivers don't need to
use #ifdef CONFIG_OF around calls to it.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Hi Bjorn,

Here is the revised version with the update of the subject and commit log
in case that you want to take it for 3.20. Otherwise we will merge this
version to powerpc tree during the 3.21 cycle.

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

