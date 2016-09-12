Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 2/8] PCI: pciehp: Return IRQ_NONE when we can't read
 interrupt status
To: Mayurkumar Patel <mayurkumar.patel@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, MikaWesterberg@linux.intel.com,
        linux-pci@vger.kernel.org,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Luis Antonio Tarazona-Duarte
        <luis.antonio.tarazona-duarte@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mika.westerberg@linux.intel.com
Date: Mon, 12 Sep 2016 16:09:04 -0500
Message-ID: <20160912210904.22258.59775.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After 1469d17dd341 ("PCI: pciehp: Handle invalid data when reading from
non-existent devices"), we returned IRQ_HANDLED when we failed to read
interrupt status from the bridge.  I think it's better to return IRQ_NONE,
as we do in other cases where there's no interrupt pending.  This will
facilitate refactoring the loop in pcie_isr(): we'll be able to call the
ISR in a loop as long as it returns IRQ_HANDLED.

Return IRQ_NONE if we couldn't read interrupt status.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 264df36..b8efe1b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -561,7 +561,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 		if (status == (u16) ~0) {
 			ctrl_info(ctrl, "%s: no response from device\n",
 				  __func__);
-			return IRQ_HANDLED;
+			return IRQ_NONE;
 		}
 
 		/*
