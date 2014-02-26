Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/7] PCI: Add "weak" generic pcibios_enable_device()
 implementation
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2014 16:41:36 -0700
Message-ID: <20140226234136.18970.21352.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140226233541.18970.83328.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140226233541.18970.83328.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Many architectures implement pcibios_enable_device() the same way, so
provide a default implementation in the core.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dc9ce62be7aa..c3ce3d61091c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1185,6 +1185,11 @@ int pci_load_and_free_saved_state(struct pci_dev *dev,
 }
 EXPORT_SYMBOL_GPL(pci_load_and_free_saved_state);
 
+int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
+{
+	return pci_enable_resources(dev, bars);
+}
+
 static int do_pci_enable_device(struct pci_dev *dev, int bars)
 {
 	int err;

