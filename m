Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36955 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdHBP1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2017 11:27:36 -0400
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] PCI: Add const to bin_attribute structures
Date: Wed,  2 Aug 2017 20:57:27 +0530
Message-Id: <1501687647-4462-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add const to bin_attribute structures as they are only passed to the
functions sysfs_{remove/create}_bin_file. The corresponding arguments
are of type const, so declare the structures to be const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2f3780b..2fc358c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1431,7 +1431,7 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute pci_config_attr = {
+static const struct bin_attribute pci_config_attr = {
 	.attr =	{
 		.name = "config",
 		.mode = S_IRUGO | S_IWUSR,
@@ -1441,7 +1441,7 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
 	.write = pci_write_config,
 };
 
-static struct bin_attribute pcie_config_attr = {
+static const struct bin_attribute pcie_config_attr = {
 	.attr =	{
 		.name = "config",
 		.mode = S_IRUGO | S_IWUSR,
-- 
1.9.1
