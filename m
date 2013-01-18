Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 5/5] PCI: catch enable-counter underflows
To: linux-kernel@vger.kernel.org
From: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: e1000-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 18 Jan 2013 15:42:30 +0400
Message-ID: <20130118114230.6698.1881.stgit@zurg>
In-Reply-To: <20130118113019.6698.25941.stgit@zurg>
References: <20130118113019.6698.25941.stgit@zurg>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds single WARN_ONCE() check for catching 'enable_cnt' imbalances.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5cb5820..ff93f8f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1401,6 +1401,9 @@ pci_disable_device(struct pci_dev *dev)
 	if (dr)
 		dr->enabled = 0;
 
+	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
+			"enable counter underflow");
+
 	if (atomic_sub_return(1, &dev->enable_cnt) != 0)
 		return;
 

