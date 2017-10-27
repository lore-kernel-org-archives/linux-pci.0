Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>, <lorenzo.pieralisi@arm.com>
CC: <gabriele.paoloni@huawei.com>, <mark.rutland@arm.com>,
        <brian.starkey@arm.com>, <olof@lixom.net>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <minyard@acm.org>,
        <john.garry@huawei.com>, <xuwei5@hisilicon.com>
Subject: [PATCH v10 2/9] PCI: remove unused __weak attribute in pci_register_io_range()
Date: Fri, 27 Oct 2017 17:11:20 +0100
Message-ID: <1509120687-7352-3-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

Currently pci_register_io_range() has only one definition;
therefore there is no use of the __weak attribute.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Acked-by: Bjorn Helgaas <helgaas@kernel.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..eee967c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3270,7 +3270,7 @@ static DEFINE_SPINLOCK(io_range_lock);
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(phys_addr_t addr, resource_size_t size)
 {
 	int err = 0;
 
-- 
2.7.4


