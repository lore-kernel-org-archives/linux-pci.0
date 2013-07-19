Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22784 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab3GSTOb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jul 2013 15:14:31 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Donald Dutile <ddutile@redhat.com>,
	Greg Rose <gregory.v.rose@intel.com>
Subject: [PATCH] PCI: Stop sriov before remove PF
Date: Fri, 19 Jul 2013 12:14:18 -0700
Message-Id: <1374261258-23036-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
(PCI: Simplify IOV implementation and fix reference count races)
VF need to be removed via virtfn_remove to make sure ref to PF
is put back.

Some driver (like ixgbe) does not call pci_disable_sriov() if
sriov is enabled via /sys/.../sriov_numvfs setting.
ixgbe does allow driver for PF get detached, but still have VFs
around.

But how about PF get removed via /sys or pciehp?

During hot-remove, VF will still hold one ref to PF and it
prevent PF to be removed.
That make the next hot-add fails, as old PF dev struct is still around.

We need to add pci_disable_sriov() calling during pci dev removing.

Need this one for v3.11

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>
Cc: Donald Dutile <ddutile@redhat.com>
Cc: Greg Rose <gregory.v.rose@intel.com>

---
 drivers/pci/remove.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/pci/remove.c
===================================================================
--- linux-2.6.orig/drivers/pci/remove.c
+++ linux-2.6/drivers/pci/remove.c
@@ -34,6 +34,9 @@ static void pci_stop_dev(struct pci_dev
 
 static void pci_destroy_dev(struct pci_dev *dev)
 {
+	/* remove VF, if PF driver skip that */
+	pci_disable_sriov(dev);
+
 	down_write(&pci_bus_sem);
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
