Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Woodhouse, David" <david.woodhouse@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Davidlohr Bueso <davidlohr@hp.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	linux-kernel@vger.kernel.org, "bhe@redhat.com" <bhe@redhat.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	James.Bottomley@hansenpartnership.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, scameron@beardog.cce.hp.com,
	Linda Knippers <linda.knippers@hp.com>, aswin@hp.com
Subject: [PATCH] iommu/vt-d: fix bug in matching PCI devices with DRHD/RMRR descriptors
Date: Tue, 15 Apr 2014 10:35:35 +0800
Message-Id: <1397529335-4834-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit "59ce0515cdaf iommu/vt-d: Update DRHD/RMRR/ATSR device scope
caches when PCI hotplug happens" introduces a bug, which fails to
match PCI devices with DMAR device scope entries if PCI path array
in the entry has more than one level.

For example, it fails to handle
[1D2h 0466   1]      Device Scope Entry Type : 01
[1D3h 0467   1]                 Entry Length : 0A
[1D4h 0468   2]                     Reserved : 0000
[1D6h 0470   1]               Enumeration ID : 00
[1D7h 0471   1]               PCI Bus Number : 00
[1D8h 0472   2]                     PCI Path : 1C,04
[1DAh 0474   2]                     PCI Path : 00,02

And cause DMA failure on HP DL980 as:
DMAR:[fault reason 02] Present bit in context entry is clear
dmar: DRHD: handling fault status reg 602
dmar: DMAR:[DMA Read] Request device [02:00.2] fault addr 7f61e000

Reported-and-tested-by: Davidlohr Bueso <davidlohr@hp.com>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
Hi David and Davidlohr,
	I have made minor syntax change to the patch, but there should be no
functional change.
Thanks!
Gerry
---
 drivers/iommu/dmar.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index f445c10df8df..39f8b717fe84 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -152,7 +152,8 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 	info->seg = pci_domain_nr(dev->bus);
 	info->level = level;
 	if (event == BUS_NOTIFY_ADD_DEVICE) {
-		for (tmp = dev, level--; tmp; tmp = tmp->bus->self) {
+		for (tmp = dev; tmp; tmp = tmp->bus->self) {
+			level--;
 			info->path[level].device = PCI_SLOT(tmp->devfn);
 			info->path[level].function = PCI_FUNC(tmp->devfn);
 			if (pci_is_root_bus(tmp->bus))
-- 
1.7.10.4

