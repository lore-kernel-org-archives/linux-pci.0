Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7811 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeISFeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:34:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 01/12] PCI: Set PCI bus accessors to noinline
Date: Tue, 18 Sep 2018 17:58:37 -0600
Message-Id: <20180918235848.26694-2-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci bus config accessors could compile inlined with other accessor
functions, which makes it so they can't be traced. This patch forces
these to never be inlined so that ftrace can hook into these functions.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/access.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index a3ad2fe185b9..544922f097c0 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -33,7 +33,7 @@ DEFINE_RAW_SPINLOCK(pci_lock);
 #endif
 
 #define PCI_OP_READ(size, type, len) \
-int pci_bus_read_config_##size \
+int noinline pci_bus_read_config_##size \
 	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
 {									\
 	int res;							\
@@ -48,7 +48,7 @@ int pci_bus_read_config_##size \
 }
 
 #define PCI_OP_WRITE(size, type, len) \
-int pci_bus_write_config_##size \
+int noinline pci_bus_write_config_##size \
 	(struct pci_bus *bus, unsigned int devfn, int pos, type value)	\
 {									\
 	int res;							\
-- 
2.14.4
