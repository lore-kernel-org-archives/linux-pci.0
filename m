Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jisheng Zhang <jszhang@marvell.com>
To: <thomas.petazzoni@free-electrons.com>, <jason@lakedaemon.net>,
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 1/2] PCI: mvebu: constify mvebu_pcie_pm_ops structure
Date: Wed, 16 Mar 2016 17:59:40 +0800
Message-ID: <1458122381-2280-2-git-send-email-jszhang@marvell.com>
In-Reply-To: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
References: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The mvebu_pcie_pm_ops structure is never modified, so declare it as
const.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 53b79c5..6c43cb8 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1298,7 +1298,7 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
 
-static struct dev_pm_ops mvebu_pcie_pm_ops = {
+static const struct dev_pm_ops mvebu_pcie_pm_ops = {
 	.suspend_noirq = mvebu_pcie_suspend,
 	.resume_noirq = mvebu_pcie_resume,
 };
-- 
2.7.0
