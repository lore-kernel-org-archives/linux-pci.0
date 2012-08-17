Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:34062 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211Ab2HQXhI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:37:08 -0400
Received: by mail-ob0-f202.google.com with SMTP id wc20so3010724obb.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:37:08 -0700 (PDT)
Subject: [PATCH v2 16/16] PCI: Remove unused pci_dev_b()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:37:07 -0600
Message-ID: <20120817233707.10973.16684.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All uses of pci_dev_b() have been replaced by list_for_each_entry(), so
remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1dce47c..ed47147 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -369,7 +369,6 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 
 extern struct pci_dev *alloc_pci_dev(void);
 
-#define pci_dev_b(n) list_entry(n, struct pci_dev, bus_list)
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 

