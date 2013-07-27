Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24666 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab3G0PLd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Jul 2013 11:11:33 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Donald Dutile <ddutile@redhat.com>,
	Greg Rose <gregory.v.rose@intel.com>
Subject: [PATCH v2 3/3] PCI: Stop sriov after stop PF if PF's driver skip that
Date: Sat, 27 Jul 2013 08:11:07 -0700
Message-Id: <1374937868-24437-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
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

But how about PF get removed via /sys or pciehp finally?

During hot-remove, VF will still hold one ref to PF and it
prevent PF to be removed.
That make the next hot-add fails, as old PF dev struct is still around.

We need to add pci_disable_sriov() calling during stop PF .

Need this one for v3.11

-v2: Accoring to Bjorn, move that calling to pci_stop_dev.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>
Cc: Donald Dutile <ddutile@redhat.com>
Cc: Greg Rose <gregory.v.rose@intel.com>

---
 drivers/pci/remove.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/pci/remove.c
===================================================================
--- linux-2.6.orig/drivers/pci/remove.c
+++ linux-2.6/drivers/pci/remove.c
@@ -25,6 +25,8 @@ static void pci_stop_dev(struct pci_dev
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
 		device_del(&dev->dev);
+		/* remove VF, if PF driver skip that */
+		pci_disable_sriov(dev);
 		dev->is_added = 0;
 	}
 
