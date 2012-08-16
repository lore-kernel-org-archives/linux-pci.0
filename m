Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f74.google.com ([209.85.214.74]:48292 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527Ab2HPX0s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 19:26:48 -0400
Received: by bkcjc3 with SMTP id jc3so154819bkc.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 16:26:47 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id D3404200057
	for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 16:26:46 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 3CA84180640
	for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 16:26:46 -0700 (PDT)
Subject: [PATCH 6/6] PCI: Remove unused pci_dev_b()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Aug 2012 17:26:46 -0600
Message-ID: <20120816232646.3662.46203.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
References: <20120816232620.3662.90438.stgit@bhelgaas.mtv.corp.google.com>
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
index 5faa831..12053de 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -369,7 +369,6 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 
 extern struct pci_dev *alloc_pci_dev(void);
 
-#define pci_dev_b(n) list_entry(n, struct pci_dev, bus_list)
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 

