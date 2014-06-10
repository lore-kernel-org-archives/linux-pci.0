Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:50040 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932895AbaFJB47 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jun 2014 21:56:59 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Jun 2014 07:26:57 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id A0D48125804D
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:26:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5A1vkmE57344208
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:46 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5A1usVq012948
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:26:54 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [RFC PATCH V3 02/17] pci/of: Match PCI VFs to dev-tree nodes dynamically
Date: Tue, 10 Jun 2014 09:56:24 +0800
Message-Id: <1402365399-5121-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As introduced by commit 98d9f30c82 ("pci/of: Match PCI devices to dev-tree nodes
dynamically"), we need to match PCI devices to their corresponding dev-tree
nodes. While for VFs, this step was missed.

This patch matches VFs' PCI devices to dev-tree nodes dynamically.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 589ef7d..1d21f43 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -67,6 +67,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 
 	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
+	pci_set_of_node(virtfn);
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
 	pci_setup_device(virtfn);
 	virtfn->dev.parent = dev->dev.parent;
-- 
1.7.9.5

