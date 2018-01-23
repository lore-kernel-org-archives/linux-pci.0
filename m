Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:4680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751606AbeAWPpY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jan 2018 10:45:24 -0500
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
        <mark.rutland@arm.com>, <olof@lixom.net>, <hanjun.guo@linaro.org>,
        <dann.frazier@canonical.com>
CC: <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <minyard@acm.org>,
        <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <rdunlap@infradead.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: [PATCH v12 2/9] PCI: Remove unused __weak attribute in pci_register_io_range()
Date: Wed, 24 Jan 2018 00:36:18 +0800
Message-ID: <1516725385-24535-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Currently pci_register_io_range() has only one definition;
therefore there is no use of the __weak attribute.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 764ca7b..d8357ff 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3383,7 +3383,7 @@ struct io_range {
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(phys_addr_t addr, resource_size_t size)
 {
 	int err = 0;
 
-- 
1.9.1
