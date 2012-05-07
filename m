Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 11/21] PCI: Add default busn_resource
Date: Mon,  7 May 2012 13:29:56 -0700
Message-Id: <1336422606-4244-12-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to put into the resources list for legacy system.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    7 +++++++
 include/linux/pci.h |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6258f6f..68e75cb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -16,6 +16,13 @@
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
 
+struct resource busn_resource = {
+	.name	= "PCI busn",
+	.start	= 0,
+	.end	= 255,
+	.flags	= IORESOURCE_BUS,
+};
+
 /* Ugh.  Need to stop exporting this to modules. */
 LIST_HEAD(pci_root_buses);
 EXPORT_SYMBOL(pci_root_buses);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b5f2cc7..84ce6da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -368,6 +368,8 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
+extern struct resource busn_resource;
+
 struct pci_host_bridge_window {
 	struct list_head list;
 	struct resource *res;		/* host bridge aperture (CPU address) */
-- 
1.7.7

