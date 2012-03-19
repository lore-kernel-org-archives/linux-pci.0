Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v2 14/26] PCI: Use for_each_res with noassign_bars
Date: Sun, 18 Mar 2012 22:48:37 -0700
Message-Id: <1332136129-14010-15-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
References: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace those open code, and make code more readable.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/common.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 0ec860f..7ea09f8 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -136,8 +136,7 @@ static void __devinit pcibios_fixup_device_resources(struct pci_dev *dev)
 		* resource so the kernel doesn't attmept to assign
 		* it later on in pci_assign_unassigned_resources
 		*/
-		for (bar = 0; bar <= PCI_STD_RESOURCE_END; bar++) {
-			bar_r = &dev->resource[bar];
+		for_each_pci_dev_base_norom_resource(dev, bar_r, bar) {
 			if (bar_r->start == 0 && bar_r->end != 0) {
 				bar_r->flags = 0;
 				bar_r->end = 0;
-- 
1.7.7

