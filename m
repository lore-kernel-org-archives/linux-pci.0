Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v2 08/26] PCI, acpiphp: Use for_each_pci_dev_resource helper
Date: Sun, 18 Mar 2012 22:48:31 -0700
Message-Id: <1332136129-14010-9-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
References: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/acpiphp_glue.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 9d781a7..90e68670d 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -1025,10 +1025,10 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus)
 	struct pci_dev *dev;
 	int i;
 	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
+	struct resource *res;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		for (i=0; i<PCI_BRIDGE_RESOURCES; i++) {
-			struct resource *res = &dev->resource[i];
+		for_each_pci_dev_nobridge_resource(dev, res, i) {
 			if ((res->flags & type_mask) && !res->start &&
 					res->end) {
 				/* Could not assign a required resources
-- 
1.7.7

