Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53741 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755053AbdBOXXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 18:23:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1FNJLFB090692
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 18:23:39 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28my2qu78d-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 18:23:39 -0500
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Thu, 16 Feb 2017 09:23:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, mpe@ellerman.id.au, bhelgaas@google.com,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        "# v4 . 8+" <stable@vger.kernel.org>
Subject: [PATCH 1/3] pci/hotplug/pnv-php: Remove WARN_ON() in pnv_php_put_slot()
Date: Thu, 16 Feb 2017 10:22:32 +1100
In-Reply-To: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1487200954-14681-2-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The WARN_ON() causes unnecessary backtrace when putting the parent
slot, which is likely to be NULL.

 WARNING: CPU: 2 PID: 1071 at drivers/pci/hotplug/pnv_php.c:85 \
                              pnv_php_release+0xcc/0x150 [pnv_php]
    :
 Call Trace:
 [c0000003bc007c10] [d00000000ad613c4] pnv_php_release+0x144/0x150 [pnv_php]
 [c0000003bc007c40] [c0000000006641d8] pci_hp_deregister+0x238/0x330
 [c0000003bc007cd0] [d00000000ad61440] pnv_php_unregister_one+0x70/0xa0 [pnv_php]
 [c0000003bc007d10] [d00000000ad614c0] pnv_php_unregister+0x50/0x80 [pnv_php]
 [c0000003bc007d40] [d00000000ad61e84] pnv_php_exit+0x50/0xcb4 [pnv_php]
 [c0000003bc007d70] [c00000000019499c] SyS_delete_module+0x1fc/0x2a0
 [c0000003bc007e30] [c00000000000b184] system_call+0x38/0xe0

Cc: <stable@vger.kernel.org> # v4.8+
Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 63cd9f3..da1bbf3 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -76,7 +76,7 @@ static void pnv_php_free_slot(struct kref *kref)
 static inline void pnv_php_put_slot(struct pnv_php_slot *php_slot)
 {
 
-	if (WARN_ON(!php_slot))
+	if (!php_slot)
 		return;
 
 	kref_put(&php_slot->kref, pnv_php_free_slot);
-- 
2.7.4
