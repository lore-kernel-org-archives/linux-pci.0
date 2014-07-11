Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:55208 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaGKHAa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 03:00:30 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: tegra: Add debugfs support
Date: Fri, 11 Jul 2014 09:00:24 +0200
Message-Id: <1405062024-2364-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Provide a debugfs file that shows the current link status for each root
port.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 118 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 14ec5b2c69e0..49b3bd5f5926 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -275,6 +276,7 @@ struct tegra_pcie {
 	unsigned int num_supplies;
 
 	const struct tegra_pcie_soc_data *soc_data;
+	struct dentry *debugfs;
 };
 
 struct tegra_pcie_port {
@@ -1664,6 +1666,115 @@ static const struct of_device_id tegra_pcie_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_pcie_of_match);
 
+static void *tegra_pcie_ports_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct tegra_pcie *pcie = s->private;
+
+	if (list_empty(&pcie->ports))
+		return NULL;
+
+	seq_printf(s, "Index  Status\n");
+
+	return seq_list_start(&pcie->ports, *pos);
+}
+
+static void *tegra_pcie_ports_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct tegra_pcie *pcie = s->private;
+
+	return seq_list_next(v, &pcie->ports, pos);
+}
+
+static void tegra_pcie_ports_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static int tegra_pcie_ports_seq_show(struct seq_file *s, void *v)
+{
+	bool up = false, active = false;
+	struct tegra_pcie_port *port;
+	unsigned int value;
+
+	port = list_entry(v, struct tegra_pcie_port, list);
+
+	value = readl(port->base + RP_VEND_XP);
+
+	if (value & RP_VEND_XP_DL_UP)
+		up = true;
+
+	value = readl(port->base + RP_LINK_CONTROL_STATUS);
+
+	if (value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE)
+		active = true;
+
+	seq_printf(s, "%2u     ", port->index);
+
+	if (up)
+		seq_printf(s, "up");
+
+	if (active) {
+		if (up)
+			seq_printf(s, ", ");
+
+		seq_printf(s, "active");
+	}
+
+	seq_printf(s, "\n");
+	return 0;
+}
+
+static const struct seq_operations tegra_pcie_ports_seq_ops = {
+	.start = tegra_pcie_ports_seq_start,
+	.next = tegra_pcie_ports_seq_next,
+	.stop = tegra_pcie_ports_seq_stop,
+	.show = tegra_pcie_ports_seq_show,
+};
+
+static int tegra_pcie_ports_open(struct inode *inode, struct file *file)
+{
+	struct tegra_pcie *pcie = inode->i_private;
+	struct seq_file *s;
+	int err;
+
+	err = seq_open(file, &tegra_pcie_ports_seq_ops);
+	if (err)
+		return err;
+
+	s = file->private_data;
+	s->private = pcie;
+
+	return 0;
+}
+
+static const struct file_operations tegra_pcie_ports_ops = {
+	.owner = THIS_MODULE,
+	.open = tegra_pcie_ports_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
+{
+	struct dentry *file;
+
+	pcie->debugfs = debugfs_create_dir("pcie", NULL);
+	if (!pcie->debugfs)
+		return -ENOMEM;
+
+	file = debugfs_create_file("ports", S_IFREG | S_IRUGO, pcie->debugfs,
+				   pcie, &tegra_pcie_ports_ops);
+	if (!file)
+		goto remove;
+
+	return 0;
+
+remove:
+	debugfs_remove_recursive(pcie->debugfs);
+	pcie->debugfs = NULL;
+	return -ENOMEM;
+}
+
 static int tegra_pcie_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -1718,6 +1829,13 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		goto disable_msi;
 	}
 
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		err = tegra_pcie_debugfs_init(pcie);
+		if (err < 0)
+			dev_err(&pdev->dev, "failed to setup debugfs: %d\n",
+				err);
+	}
+
 	platform_set_drvdata(pdev, pcie);
 	return 0;
 
-- 
2.0.1

