Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:35679 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbJZDTB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2015 23:19:01 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 26 Oct 2015 13:19:00 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id D8F032BB0051
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 14:18:57 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9Q3IhrX32112860
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 14:18:52 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9Q3INMm002029
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 14:18:24 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V10 06/12] powerpc/powernv: EEH device for VF
Date: Mon, 26 Oct 2015 11:15:56 +0800
Message-Id: <1445829362-2738-7-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VFs and their corresponding pci_dn instances are created and released
dynamically as their PF's SRIOV capability is enabled and disabled.
The patch creates and releases EEH devices for VFs when creating and
releasing their pci_dn instances, which means EEH devices and pci_dn
instances have same life cycle. Also, VF's EEH device is identified
by (struct eeh_dev::physfn).

[gwshan: changelog and removed CONFIG_PCI_IOV]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  1 +
 arch/powerpc/kernel/pci_dn.c   | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index c5eb86f..6c383ad 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -140,6 +140,7 @@ struct eeh_dev {
 	struct pci_controller *phb;	/* Associated PHB		*/
 	struct pci_dn *pdn;		/* Associated PCI device node	*/
 	struct pci_dev *pdev;		/* Associated PCI device	*/
+	struct pci_dev *physfn;		/* Associated PF PORT		*/
 	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
 };
 
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index f771130..f0ddde7 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -180,7 +180,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PCI_IOV
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pci_dn *parent, *pdn;
+	struct eeh_dev *edev;
 	int i;
 
 	/* Only support IOV for now */
@@ -206,6 +208,9 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 				 __func__, i);
 			return NULL;
 		}
+		eeh_dev_init(pdn, hose);
+		edev = pdn_to_eeh_dev(pdn);
+		edev->physfn = pdev;
 	}
 #endif /* CONFIG_PCI_IOV */
 
@@ -254,10 +259,17 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
 		list_for_each_entry_safe(pdn, tmp,
 			&parent->child_list, list) {
+			struct eeh_dev *edev;
 			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
 			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
 				continue;
 
+			edev = pdn_to_eeh_dev(pdn);
+			if (edev) {
+				pdn->edev = NULL;
+				kfree(edev);
+			}
+
 			if (!list_empty(&pdn->list))
 				list_del(&pdn->list);
 
-- 
2.5.0

