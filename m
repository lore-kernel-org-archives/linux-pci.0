Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13821 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbdKYTcs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Nov 2017 14:32:48 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 5/9] PCI: Export pci_flags
Date: Sun, 26 Nov 2017 01:02:09 +0530
Message-ID: <1511638333-22951-6-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_flags variable is used in inline functions in 'pci.h', Tegra PCIe
driver use one of these functions pci_add_flags() and includes 'pci.h'.
Export pci_flags to allow Tegra PCIe host controller driver to be
compiled as loadable kernel module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* commit message update

 drivers/pci/setup-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b1ad466199ad..3567e1c4e340 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -29,6 +29,7 @@
 #include "pci.h"
 
 unsigned int pci_flags;
+EXPORT_SYMBOL(pci_flags);
 
 struct pci_dev_resource {
 	struct list_head list;
-- 
2.1.4
