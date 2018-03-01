Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55661 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163389AbeCAXhg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 18:37:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id q83so28748wme.5
        for <linux-pci@vger.kernel.org>; Thu, 01 Mar 2018 15:37:35 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 5/5] PCI: tegra: use seq_open_data
Date: Fri,  2 Mar 2018 00:37:24 +0100
Message-Id: <20180301233724.20440-5-linux@rasmusvillemoes.dk>
In-Reply-To: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simplify the code slightly by having seq_open_data do the ->private
assignment.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pci/host/pci-tegra.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index dd9b3bcc41c3..7921428786aa 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2188,17 +2188,8 @@ static const struct seq_operations tegra_pcie_ports_seq_ops = {
 static int tegra_pcie_ports_open(struct inode *inode, struct file *file)
 {
 	struct tegra_pcie *pcie = inode->i_private;
-	struct seq_file *s;
-	int err;
-
-	err = seq_open(file, &tegra_pcie_ports_seq_ops);
-	if (err)
-		return err;
-
-	s = file->private_data;
-	s->private = pcie;
 
-	return 0;
+	return seq_open_data(file, &tegra_pcie_ports_seq_ops, pcie);
 }
 
 static const struct file_operations tegra_pcie_ports_ops = {
-- 
2.15.1
