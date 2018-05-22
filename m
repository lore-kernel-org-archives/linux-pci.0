Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 3/3] xtensa/PCI: Use dev_printk() when possible
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Date: Tue, 22 May 2018 08:10:27 -0500
Message-ID: <152699462765.162480.7860807553501499399.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152699456050.162480.13521209483758803324.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152699456050.162480.13521209483758803324.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use the pci_info() and pci_err() wrappers for dev_printk() when possible.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/xtensa/kernel/pci.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index e121b555fdb4..21f13e9aabe1 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -179,8 +179,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	for (idx=0; idx<6; idx++) {
 		r = &dev->resource[idx];
 		if (!r->start && r->end) {
-			pr_err("PCI: Device %s not available because "
-			       "of resource collisions\n", pci_name(dev));
+			pci_err(dev, "can't enable device: resource collisions\n");
 			return -EINVAL;
 		}
 		if (r->flags & IORESOURCE_IO)
@@ -189,8 +188,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 	if (cmd != old_cmd) {
-		pr_info("PCI: Enabling device %s (%04x -> %04x)\n",
-			pci_name(dev), old_cmd, cmd);
+		pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 
