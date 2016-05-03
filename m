Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([125.16.236.4]:33118 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933297AbcECNds (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 09:33:48 -0400
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 3 May 2016 18:53:31 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
	alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 21/22] drivers/of: Export of_detach_node()
Date: Tue,  3 May 2016 23:22:52 +1000
Message-Id: <1462281773-26438-22-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This exports of_detach_node() for PowerPC PowerNV PCI hotplug
driver. No functional changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/of/dynamic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index c647bd1..75ce30d 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -311,6 +311,7 @@ int of_detach_node(struct device_node *np)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(of_detach_node);
 
 /**
  * of_node_release() - release a dynamically allocated node
-- 
2.1.0

