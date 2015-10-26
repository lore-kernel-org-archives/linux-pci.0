Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:51411 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbJZDUb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2015 23:20:31 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 26 Oct 2015 13:20:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4C18A357804F
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 14:20:27 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9Q3KJBJ23134428
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 14:20:27 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9Q3JsdR030684
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 14:19:54 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH V10 11/12] powerpc/eeh: Don't block PCI config on resetting VF PE
Date: Mon, 26 Oct 2015 11:16:01 +0800
Message-Id: <1445829362-2738-12-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

When passing through SRIOV VF from host to guest via VFIO PCI
infrastructure, the VF is resetted by EEH specific backend
(pcibios_set_pcie_reset_state()). We can't block the PCI config,
otherwise, the reset (FLR or AF FLR), to be completed by PCI
config access to the VF, can't be done. Then the VF can't be
put into initial state when passing it to the guest and returning
back to the host.

The patch just doesn't block the VF's PCI config space when doing
the reset. It fixes EEH error caused by DMA traffic to bogus DMA
address on restarting guest after killing the QEMU process, which
includes Mellanox VF passed through from host.

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/eeh.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 28e4d73..e1846f5 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -745,7 +745,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 	case pcie_deassert_reset:
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
 		eeh_unfreeze_pe(pe, false);
-		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
+		if (!(pe->type & EEH_PE_VF))
+			eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		eeh_pe_dev_traverse(pe, eeh_restore_dev_state, dev);
 		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 		break;
@@ -753,14 +754,16 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
-		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
+		if (!(pe->type & EEH_PE_VF))
+			eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
 		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
-		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
+		if (!(pe->type & EEH_PE_VF))
+			eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 		break;
 	default:
-- 
2.5.0

