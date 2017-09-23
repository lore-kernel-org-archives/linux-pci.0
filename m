Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:6555 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdIWHZV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Sep 2017 03:25:21 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <yinghai@kernel.org>
CC: <linux-pci@vger.kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [RFC PATCH] PCI: Fix prefetchable range broken in pci_bridge_check_ranges
Date: Sat, 23 Sep 2017 15:24:42 +0800
Message-ID: <1506151482-113560-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When double checking 64bit prefetch range, we will change the prefetch range
in a time slot by writing 0xffffffff to PCI_PREF_BASE_UPPER32. This may break
transfers through related bridge at that time.

E.g. if we have below PCIe topology:

-[0000:00]-+-00.0-[01-02]--+-00.0  Device 8086:10fb
           |               \-00.1  Device 8086:10fb
           \-08.0-[03]----00.0  Device 8086:0953

When rescan 00:08.0, it will call:

        pci_rescan_bus
                -> pci_assign_unassigned_bus_resources
                        -> __pci_bus_size_bridges
                                -> pci_bridge_check_ranges
                                        -> pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0xffffffff)

This will change the prefetch range of 00:00.0 in a time slot, so traffic of
01:00.0 or 01:00.1 may be broken.

In fact, we can get if one bridge supports 64bit range by the bottom 4bits of
prefetchable memory base/limit. Honestly speaking, I don't know why 1f82de10d6b1
("PCI/86: don't assume prefetchable ranges are 64bit") has added the double
check code.

So Can we remove the double checking of prefetchable range to avoid this problem?

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/setup-bus.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 958da7d..23010a9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -778,20 +778,6 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 			b_res[2].flags |= PCI_PREF_RANGE_TYPE_64;
 		}
 	}
-
-	/* double check if bridge does support 64 bit pref */
-	if (b_res[2].flags & IORESOURCE_MEM_64) {
-		u32 mem_base_hi, tmp;
-		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32,
-					 &mem_base_hi);
-		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
-					       0xffffffff);
-		pci_read_config_dword(bridge, PCI_PREF_BASE_UPPER32, &tmp);
-		if (!tmp)
-			b_res[2].flags &= ~IORESOURCE_MEM_64;
-		pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32,
-				       mem_base_hi);
-	}
 }
 
 /* Helper function for sizing routines: find first available
-- 
1.9.1
