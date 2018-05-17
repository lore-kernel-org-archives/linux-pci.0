Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v7 11/12] PCI: Improve "partially hidden behind bridge" log message
Date: Thu, 17 May 2018 12:29:02 +0300
Message-Id: <20180517092903.43701-12-mika.westerberg@linux.intel.com>
In-Reply-To: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
References: <20180517092903.43701-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is a sanity checker in the end of pci_scan_child_bus_extend() that
tries to detect badly configured bridges. For example given the below
topology:

  +-1b.0-[01-39]----00.0-[02-3a]--+-00.0-[03]----00.0
                                  +-01.0-[04-39]--
                                  \-02.0-[3a]----00.0

The sanity checker notices this and logs following messages:

  pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:02 [bus 02-39]
  pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:01 [bus 01-39]

This is not really helpful to users and the information above is not
even correct (0000:02 is a bus not bridge). Make this a bit more
understandable by changing the sanity checker to log following message
in place of the above two messages:

  pci 0000:02:02.0: devices behind bridge are unusable, because [bus 3a] cannot be assigned for them

While there update the comment on top of the sanity checker block to
make it clear that it is not only restricted to CardBus.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/probe.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a0c48aa1c42f..10084990fbc3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1191,20 +1191,16 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		(is_cardbus ? "PCI CardBus %04x:%02x" : "PCI Bus %04x:%02x"),
 		pci_domain_nr(bus), child->number);
 
-	/* Has only triggered on CardBus, fixup is in yenta_socket */
+	/* Check that all devices are accessible */
 	while (bus->parent) {
 		if ((child->busn_res.end > bus->busn_res.end) ||
 		    (child->number > bus->busn_res.end) ||
 		    (child->number < bus->number) ||
 		    (child->busn_res.end < bus->number)) {
-			dev_info(&child->dev, "%pR %s hidden behind%s bridge %s %pR\n",
-				&child->busn_res,
-				(bus->number > child->busn_res.end &&
-				 bus->busn_res.end < child->number) ?
-					"wholly" : "partially",
-				bus->self->transparent ? " transparent" : "",
-				dev_name(&bus->dev),
-				&bus->busn_res);
+			dev_info(&dev->dev,
+				 "devices behind bridge are unusable, because %pR cannot be assigned for them\n",
+				 &child->busn_res);
+			break;
 		}
 		bus = bus->parent;
 	}
-- 
2.17.0

