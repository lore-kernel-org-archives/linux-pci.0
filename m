Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: pci-label: constify attribute_group structures.
Date: Tue, 11 Jul 2017 14:57:08 +0530
Message-Id: <1499765228-543-3-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1499765228-543-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1499765228-543-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    930	    320	      0	   1250	    4e2	drivers/pci/pci-label.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   1058	    192	      0	   1250	    4ca	drivers/pci/pci-label.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/pci-label.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index a7a41d9..7e9e795 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -123,7 +123,7 @@ static ssize_t smbiosinstance_show(struct device *dev,
 	NULL,
 };
 
-static struct attribute_group smbios_attr_group = {
+static const struct attribute_group smbios_attr_group = {
 	.attrs = smbios_attributes,
 	.is_visible = smbios_instance_string_exist,
 };
@@ -260,7 +260,7 @@ static ssize_t acpiindex_show(struct device *dev,
 	NULL,
 };
 
-static struct attribute_group acpi_attr_group = {
+static const struct attribute_group acpi_attr_group = {
 	.attrs = acpi_attributes,
 	.is_visible = acpi_index_string_exist,
 };
-- 
1.9.1
