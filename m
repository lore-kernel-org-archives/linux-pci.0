Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com, paulus@samba.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] PCI: hotplug: constify attribute_group structures.
Date: Tue, 11 Jul 2017 14:58:44 +0530
Message-Id: <1499765324-617-2-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1499765324-617-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1499765324-617-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    418	    160	      8	    586	    24a	drivers/pci/hotplug/rpadlpar_sysfs.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
    482	     96	      8	    586	    232	drivers/pci/hotplug/rpadlpar_sysfs.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/hotplug/rpadlpar_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index a796301..edb5d8a 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -102,7 +102,7 @@ static ssize_t remove_slot_show(struct kobject *kobj,
 	NULL,
 };
 
-static struct attribute_group dlpar_attr_group = {
+static const struct attribute_group dlpar_attr_group = {
 	.attrs = default_attrs,
 };
 
-- 
1.9.1
