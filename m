Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:43285 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbbF3BSH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 21:18:07 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 30 Jun 2015 11:18:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2838C3578048
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 11:18:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5U1HqQx58196154
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 11:18:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5U1HTPv024636
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 11:17:29 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V2 4/4] PCI: consolidate return value check for pci_find_(ext_)capability
Date: Tue, 30 Jun 2015 09:16:44 +0800
Message-Id: <1435627004-6029-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The return value of the pci_find_(ext_)capability is the position of this
Cap.  After previous two patches clean up, the position returned is an
unsigned value. Only 0 indicates the Cap is not presented.

This patch consolidates the form of check from (pos <= 0)to (!pos).

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4bd3a0c..e1282aa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -971,7 +971,7 @@ static int pci_save_pcix_state(struct pci_dev *dev)
 	struct pci_cap_saved_state *save_state;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (pos <= 0)
+	if (!pos)
 		return 0;
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
@@ -995,7 +995,7 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (!save_state || pos <= 0)
+	if (!save_state || !pos)
 		return;
 	cap = (u16 *)&save_state->cap.data[0];
 
@@ -2159,7 +2159,7 @@ static int _pci_add_cap_save_buffer(struct pci_dev *dev, u16 cap,
 	else
 		pos = pci_find_capability(dev, cap);
 
-	if (pos <= 0)
+	if (!pos)
 		return 0;
 
 	save_state = kzalloc(sizeof(*save_state) + size, GFP_KERNEL);
-- 
1.7.9.5

