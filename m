Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 23/27] PCI: Update pci_resource_bar() to support addon_resource
Date: Wed, 13 Mar 2013 16:28:18 -0700
Message-Id: <1363217302-14383-24-git-send-email-yinghai@kernel.org>
In-Reply-To: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
References: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Need to loop addon resource list to retrieve reg_addr in it.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dca6c1a1..7dca4f1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3613,6 +3613,13 @@ int pci_resource_bar(struct pci_dev *dev, int resno, enum pci_bar_type *type)
 		reg = pci_iov_resource_bar(dev, resno, type);
 		if (reg)
 			return reg;
+	} else if (resno >= PCI_NUM_RESOURCES) {
+		struct resource *res = pci_dev_resource_n(dev, resno);
+
+		if (res) {
+			*type = pci_bar_unknown;
+			return to_pci_dev_addon_resource(res)->reg_addr;
+		}
 	}
 
 	dev_err(&dev->dev, "BAR %d: invalid resource\n", resno);
-- 
1.7.10.4

