Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:64756 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbaHLHC6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 03:02:58 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>,
	Wuyun <wuyun.wu@huawei.com>, <linux-pci@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>,
	<arnab.basu@freescale.com>, <x86@kernel.org>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<xen-devel@lists.xenproject.org>, Joerg Roedel <joro@8bytes.org>,
	<iommu@lists.linux-foundation.org>, <linux-mips@linux-mips.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	"Tony Luck" <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	<sparclinux@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [RFC PATCH 04/20] MSI: Remove the redundant irq_set_chip_data()
Date: Tue, 12 Aug 2014 15:25:57 +0800
Message-ID: <1407828373-24322-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, pcie-designware, pcie-rcar, pci-tegra drivers
use irq chip_data to the msi_chip pointer. They already call
irq_set_chip_data() in their own MSI irq map functions.
So irq_set_chip_data() in arch_setup_msi_irq() is useless.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 782b242..242d775 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -41,8 +41,6 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 	if (err < 0)
 		return err;
 
-	irq_set_chip_data(desc->irq, chip);
-
 	return 0;
 }
 
-- 
1.7.1

