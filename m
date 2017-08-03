Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com, scott@spiteful.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 5/5] PCI: hotplug: cpqphp: constify pci_device_id.
Date: Thu,  3 Aug 2017 22:39:16 +0530
Message-Id: <1501780156-24708-6-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/hotplug/cpqphp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index 33d300d..4d06b84 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -1417,7 +1417,7 @@ static void __exit unload_cpqphpd(void)
 		iounmap(smbios_start);
 }
 
-static struct pci_device_id hpcd_pci_tbl[] = {
+static const struct pci_device_id hpcd_pci_tbl[] = {
 	{
 	/* handle any PCI Hotplug controller */
 	.class =        ((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
-- 
2.7.4
