Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v2 16/26] PCI: Use for_each_res pci release release
Date: Sun, 18 Mar 2012 22:48:39 -0700
Message-Id: <1332136129-14010-17-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
References: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace those open code, and make code more readable.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/remove.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 18efb31..7dfe507 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -6,15 +6,14 @@
 static void pci_free_resources(struct pci_dev *dev)
 {
 	int i;
+	struct resource *res;
 
  	msi_remove_pci_irq_vectors(dev);
 
 	pci_cleanup_rom(dev);
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = dev->resource + i;
+	for_each_pci_dev_all_resource(dev, res, i)
 		if (res->parent)
 			release_resource(res);
-	}
 }
 
 static void pci_stop_dev(struct pci_dev *dev)
-- 
1.7.7

