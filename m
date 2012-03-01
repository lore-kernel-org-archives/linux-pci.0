Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 21/36] PCI: add default res for pci_scan_bus
Date: Wed, 29 Feb 2012 19:00:22 -0800
Message-Id: <1330570837-26638-22-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
References: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1149109..1c07aba 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1784,6 +1784,7 @@ struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 
 	pci_add_resource(&resources, &ioport_resource);
 	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_resource);
 	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
 	if (b)
 		b->subordinate = pci_scan_child_bus(b);
@@ -1801,6 +1802,7 @@ struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
 
 	pci_add_resource(&resources, &ioport_resource);
 	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_resource);
 	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
 	if (b) {
 		b->subordinate = pci_scan_child_bus(b);
-- 
1.7.7

