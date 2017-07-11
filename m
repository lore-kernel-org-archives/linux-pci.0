Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34145 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755715AbdGKJ1i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2017 05:27:38 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: pci-sysfs: constify attribute_group structures.
Date: Tue, 11 Jul 2017 14:57:07 +0530
Message-Id: <1499765228-543-2-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1499765228-543-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1499765228-543-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   8480	   2024	      4	  10508	   290c	drivers/pci/pci-sysfs.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   8736	   1768	      4	  10508	   290c	drivers/pci/pci-sysfs.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/pci-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2f3780b..2eed0dc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1735,7 +1735,7 @@ static umode_t pcie_dev_attrs_are_visible(struct kobject *kobj,
 	NULL,
 };
 
-static struct attribute_group pci_dev_hp_attr_group = {
+static const struct attribute_group pci_dev_hp_attr_group = {
 	.attrs = pci_dev_hp_attrs,
 	.is_visible = pci_dev_hp_attrs_are_visible,
 };
@@ -1759,23 +1759,23 @@ static umode_t sriov_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static struct attribute_group sriov_dev_attr_group = {
+static const struct attribute_group sriov_dev_attr_group = {
 	.attrs = sriov_dev_attrs,
 	.is_visible = sriov_attrs_are_visible,
 };
 #endif /* CONFIG_PCI_IOV */
 
-static struct attribute_group pci_dev_attr_group = {
+static const struct attribute_group pci_dev_attr_group = {
 	.attrs = pci_dev_dev_attrs,
 	.is_visible = pci_dev_attrs_are_visible,
 };
 
-static struct attribute_group pci_bridge_attr_group = {
+static const struct attribute_group pci_bridge_attr_group = {
 	.attrs = pci_bridge_attrs,
 	.is_visible = pci_bridge_attrs_are_visible,
 };
 
-static struct attribute_group pcie_dev_attr_group = {
+static const struct attribute_group pcie_dev_attr_group = {
 	.attrs = pcie_dev_attrs,
 	.is_visible = pcie_dev_attrs_are_visible,
 };
-- 
1.9.1
