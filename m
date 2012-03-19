Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v11 20/30] PCI: Probe safe range that we can use for unassigned bridge.
Date: Sun, 18 Mar 2012 22:42:51 -0700
Message-Id: <1332135781-13695-21-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Try to allocate from parent bus busn_res. If we can not find any big enough,
will try to extend parent bus top. even the extending is through allocating,
after allocating will pad the range to parent buses top.

When extending happens, We will record the parent_res, so could use it as
stopper for really extend/shrink top later.

-v4: Use generic probe_resource()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3e32b34..67cd0a7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -690,6 +690,31 @@ static void __devinit pci_bus_shrink_top(struct pci_bus *parent,
 	pci_bus_update_top(parent, -size, parent_res);
 }
 
+static int __devinit pci_bridge_probe_busn_res(struct pci_bus *bus,
+			 struct pci_dev *dev, struct resource *busn_res,
+			 resource_size_t needed_size, struct resource **p)
+{
+	int ret;
+	int old_size = resource_size(&bus->busn_res);
+
+	ret = probe_resource(&bus->busn_res, &dev->dev, busn_res, needed_size,
+			p, 1, 0xff, "busn");
+
+	if (ret)
+		return ret;
+
+	busn_res->flags = IORESOURCE_BUS;
+
+	if (*p) {
+		/* extend parent bus top*/
+		int new_size = resource_size(&bus->busn_res);
+
+		pci_bus_extend_top(bus, new_size - old_size, *p);
+	}
+
+	return ret;
+}
+
 /*
  * If it's a bridge, configure it and scan the bus behind it.
  * For CardBus bridges, we don't scan behind as the devices will
-- 
1.7.7

