Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:7465 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab3IBGfS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2013 02:35:18 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rob Landley <rob@landley.net>, <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] PCI: clean up pci_find_slot() in pci.txt
Date: Mon, 2 Sep 2013 14:34:40 +0800
Message-ID: <1378103680-42500-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pci_find_slot() has been removed from the kernel,
clean up its description in pci.txt

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 Documentation/PCI/pci.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/pci.txt b/Documentation/PCI/pci.txt
index bccf602..ac39338 100644
--- a/Documentation/PCI/pci.txt
+++ b/Documentation/PCI/pci.txt
@@ -525,8 +525,10 @@ corresponding register block for you.
 6. Other interesting functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-pci_find_slot()			Find pci_dev corresponding to given bus and
-				slot numbers.
+pci_get_domain_bus_and_slot()	Find pci_dev corresponding to given domain,
+                        bus and slot and number. If the device is
+                        found, its reference count is increased and
+                        return the pci_dev pointer.
 pci_set_power_state()		Set PCI Power Management state (0=D0 ... 3=D3)
 pci_find_capability()		Find specified capability in device's capability
 				list.
@@ -582,7 +584,6 @@ having sane locking.
 
 pci_find_device()	Superseded by pci_get_device()
 pci_find_subsys()	Superseded by pci_get_subsys()
-pci_find_slot()		Superseded by pci_get_slot()
 
 
 The alternative is the traditional PCI device driver that walks PCI
-- 
1.7.1


