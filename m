Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 19/30] ACPI / hotplug / PCI: Drop redundant checks from check_hotplug_bridge()
Date: Thu, 18 Jul 2013 01:27:57 +0200
Message-ID: <2330807.Y9rEtlRl92@vostro.rjw.lan>
In-Reply-To: <2366394.4EoP1MXmG2@vostro.rjw.lan>
References: <26431283.HJCKsss0rt@vostro.rjw.lan> <3718119.FLASu5DBx8@vostro.rjw.lan> <2366394.4EoP1MXmG2@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Two checks in check_hotplug_bridge() are redundant (they have been
done by the caller already), so drop them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    6 ------
 1 file changed, 6 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -586,16 +586,10 @@ static void check_hotplug_bridge(struct
 {
 	struct acpiphp_func *func;
 
-	if (!dev->subordinate)
-		return;
-
 	/* quirk, or pcie could set it already */
 	if (dev->is_hotplug_bridge)
 		return;
 
-	if (PCI_SLOT(dev->devfn) != slot->device)
-		return;
-
 	list_for_each_entry(func, &slot->funcs, sibling) {
 		if (PCI_FUNC(dev->devfn) == func->function) {
 			dev->is_hotplug_bridge = 1;

