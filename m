Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751279AbeCNVLJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 17:11:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EL6BQx054434
        for <linux-pci@vger.kernel.org>; Wed, 14 Mar 2018 17:11:08 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gq88pqayh-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 14 Mar 2018 17:11:08 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <desnesn@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 15:11:07 -0600
From: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, brking@linux.vnet.ibm.com
Subject: [PATCH, pci, v2] pci: Delete PCI disabling informational messages
Date: Wed, 14 Mar 2018 18:10:53 -0300
Message-Id: <20180314211053.26605-1-desnesn@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The disabling informational messages on the PCI subsystem should be deleted
since they do not represent any real value for the system logs.

These messages are either not presented, or presented for all PCI devices
(e.g., powerpc now realigns all PCI devices to its page size). Thus, they
are flooding system logs and can be interpreted as a false positive for
total PCI failure on the system.

[root@system user]# dmesg | grep -i disabling
[    0.692270] pci 0000:00:00.0: Disabling memory decoding and releasing memory resources
[    0.692324] pci 0000:00:00.0: disabling bridge mem windows
[    0.729134] pci 0001:00:00.0: Disabling memory decoding and releasing memory resources
[    0.737352] pci 0001:00:00.0: disabling bridge mem windows
[    0.776295] pci 0002:00:00.0: Disabling memory decoding and releasing memory resources
[    0.784509] pci 0002:00:00.0: disabling bridge mem windows
... and goes on for all PCI devices on the system ...

Fixes: 38274637699 ("powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
---
 drivers/pci/pci.c       | 1 -
 drivers/pci/setup-res.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8c71d1a66cdd..1563ce1ee091 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5505,7 +5505,6 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 	}
 
-	pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 369d48d6c6f1..6bd35e8e7cde 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -172,8 +172,6 @@ EXPORT_SYMBOL(pci_claim_resource);
 
 void pci_disable_bridge_window(struct pci_dev *dev)
 {
-	pci_info(dev, "disabling bridge mem windows\n");
-
 	/* MMIO Base/Limit */
 	pci_write_config_dword(dev, PCI_MEMORY_BASE, 0x0000fff0);
 
-- 
2.14.3
