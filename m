Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 4/7] sh/PCI: Use default pcibios_enable_device()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org
Date: Wed, 26 Feb 2014 16:41:55 -0700
Message-ID: <20140226234155.18970.93520.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140226233541.18970.83328.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140226233541.18970.83328.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We don't need anything arch-specific in pcibios_enable_device(), so drop
the arch implementation and use the default generic one.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Paul Mundt <lethal@linux-sh.org>
CC: linux-sh@vger.kernel.org
---
 arch/sh/drivers/pci/pci.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 60ed3e1c4b75..1bc09ee7948f 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -186,11 +186,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	return pci_enable_resources(dev, mask);
-}
-
 static void __init
 pcibios_bus_report_status_early(struct pci_channel *hose,
 				int top_bus, int current_bus,

