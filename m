Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yijing Wang <wangyijing@huawei.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>
CC: Gavin Shan <shangw@linux.vnet.ibm.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 5/6] PCI: use pci_is_pcie() to simplify code
Date: Thu, 5 Sep 2013 15:55:29 +0800
Message-ID: <1378367730-25996-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1378367730-25996-1-git-send-email-wangyijing@huawei.com>
References: <1378367730-25996-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use pci_is_pcie() instead of pci_find_capability
to simplify code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index eeb50bd..0fa9075 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -641,8 +641,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 		return;
 	}
 
-	pos = pci_find_capability(bridge, PCI_CAP_ID_EXP);
-	if (pos) {
+	if (pci_is_pcie(bridge)) {
 		u32 linkcap;
 		u16 linksta;
 
-- 
1.7.1


