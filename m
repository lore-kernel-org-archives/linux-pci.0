Return-Path: <SRS0=96pX=A7=huawei.com=zhengqiang10@kernel.org>
Return-Path: <SRS0=96pX=A7=huawei.com=zhengqiang10@kernel.org>
From: Qiang Zheng <zhengqiang10@huawei.com>
To: <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <gabriele.paoloni@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH V2] Bug fix for PME interrupt handler, add Root Status check
Date: Sat, 30 Sep 2017 10:12:06 +0800
Message-ID: <1506737526-94266-1-git-send-email-zhengqiang10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

PCIe PME and hot plug share same interrupt number. In some special case,
Link down event cause hot plug interrupt, devices is not disconnected,
But read config will return 0xff.

In that case, PME work function will run and not return Because
Root Status PME bit always 1 and can not be cleared.

This patch add Root Status check in PME interrupt handler,
Just do same as pciehp isr Slot status check.

Signed-off-by: Qiang Zheng <zhengqiang10@huawei.com>
---
 drivers/pci/pcie/pme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index fafdb16..2ff2e57 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -273,7 +273,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
 	spin_lock_irqsave(&data->lock, flags);
 	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
 
-	if (!(rtsta & PCI_EXP_RTSTA_PME)) {
+	if (rtsta == U32_MAX || !(rtsta & PCI_EXP_RTSTA_PME)) {
 		spin_unlock_irqrestore(&data->lock, flags);
 		return IRQ_NONE;
 	}
-- 
1.9.1
