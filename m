Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbdK0RAI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 12:00:08 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 29/29] PCI: remove pci_get_bus_and_slot() function
Date: Mon, 27 Nov 2017 11:58:06 -0500
Message-Id: <1511801886-6753-30-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Now that all users of pci_get_bus_and_slot() switched to
pci_get_domain_bus_and_slot(), it is now safe to remove this function.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/linux/pci.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d16a7c0..8c1b650 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -957,11 +957,6 @@ struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int device,
 struct pci_dev *pci_get_slot(struct pci_bus *bus, unsigned int devfn);
 struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
 					    unsigned int devfn);
-static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
-						   unsigned int devfn)
-{
-	return pci_get_domain_bus_and_slot(0, bus, devfn);
-}
 struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
 
@@ -1676,9 +1671,6 @@ static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
 static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
 						unsigned int devfn)
 { return NULL; }
-static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
-						unsigned int devfn)
-{ return NULL; }
 
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
-- 
1.9.1
