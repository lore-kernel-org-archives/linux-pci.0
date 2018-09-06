Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 04/10] PCI: pciehp: Do not handle events if interrupts are masked
Date: Thu,  6 Sep 2018 18:50:14 +0300
Message-Id: <20180906155020.51700-5-mika.westerberg@linux.intel.com>
In-Reply-To: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe native hotplug shares MSI vector with native PME so the interrupt
handler might get called even the hotplug interrupt is masked. In that
case we should not handle any events because the interrupt was not meant
for us. Modify the PCIe hotplug interrupt handler to check this
accordingly and bail out if it finds out that the interrupt was not
about hotplug.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 2249c4d06efd..19ed13d44b8f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -533,9 +533,11 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	u16 status, events;
 
 	/*
-	 * Interrupts only occur in D3hot or shallower (PCIe r4.0, sec 6.7.3.4).
+	 * Interrupts only occur in D3hot or shallower and only if enabled
+	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
 	 */
-	if (pdev->current_state == PCI_D3cold)
+	if (pdev->current_state == PCI_D3cold ||
+	    !(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE))
 		return IRQ_NONE;
 
 	/*
-- 
2.18.0
