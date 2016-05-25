Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Peter Wu <peter@lekensteyn.nl>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI: Wait for 50ms after bridge is powered up
Date: Wed, 25 May 2016 18:04:56 +0300
Message-Id: <1464188696-25782-1-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <20160524162833.GA30762@localhost>
References: <20160524162833.GA30762@localhost>
List-ID: <linux-pci.vger.kernel.org>

The PCI PM 1.2 specification requires minimum of 50ms before function on a
bus is accessed after the bus is transitioned from B2 to B0. Now that we
actually power down bridges we should make sure the specification is
followed accordingly.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi Bjorn,

Since this is only needed when bridges are powered down, I think it makes
sense to put this to your pci/pm branch.

 drivers/pci/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e785dc260e72..e645a3d4f2e0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2361,7 +2361,12 @@ void pci_pm_init(struct pci_dev *dev)
 	}
 
 	dev->pm_cap = pm;
-	dev->d3_delay = PCI_PM_D3_WAIT;
+	/*
+	 * PCI PM 1.2 specification requires minimum of 50ms before any
+	 * function on the bus is accessed after the bus is transitioned
+	 * from B2 to B0.
+	 */
+	dev->d3_delay = pci_is_bridge(dev) ? PCI_PM_BUS_WAIT : PCI_PM_D3_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
 	dev->d3cold_allowed = true;
-- 
2.8.1
