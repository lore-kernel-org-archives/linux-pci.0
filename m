Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
To: <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
	<lenb@kernel.org>, <izumi.taku@jp.fujitsu.com>,
	<wency@cn.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
	<ddaney.cavm@gmail.com>, <chen.fan.fnst@cn.fujitsu.com>,
	<helgaas@kernel.org>, <okaya@codeaurora.org>,
	<bhelgaas@google.com>, <jiang.liu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <tglx@linutronix.de>,
	<linux@roeck-us.net>
Subject: [PATCH v3 2/2] i801_smbus: fix unavailable irq number 255 reported by BIOS
Date: Wed, 27 Jan 2016 14:08:44 +0800
Message-ID: <736ccbb04de44a75e8d1389bb7b2746c0a9a8937.1453862105.git.chen.fan.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1453862105.git.chen.fan.fnst@cn.fujitsu.com>
References: <cover.1453862105.git.chen.fan.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In our environment, when enable Secure boot, we found an abnormal
phenomenon as following call trace shows. after investigation, we
found the firmware assigned an irq number 255 which means unknown
or no connection in PCI local spec for i801_smbus, meanwhile the
ACPI didn't configure the pci irq routing. and the 255 irq number
was assigned for megasa msix without IRQF_SHARED. then in this case
during i801_smbus probe, the i801_smbus driver would request irq with
bad irq number 255. but the 255 irq number was assigned for memgasa
with MSIX enable. which will cause request_irq fails and result in
the call trace below, here we add check the irq_invalid flag to identify
the smbus whether support IRQ-driven.

i801_smbus 0000:00:1f.3: enabling device (0140 -> 0143)
i801_smbus 0000:00:1f.3: can't derive routing for PCI INT C
i801_smbus 0000:00:1f.3: PCI INT C: no GSI
genirq: Flags mismatch irq 255. 00000080 (i801_smbus) vs. 00000000 (megasa)
CPU: 0 PID: 2487 Comm: kworker/0:1 Not tainted 3.10.0-229.el7.x86_64 #1
Hardware name: FUJITSU PRIMEQUEST 2800E2/D3736, BIOS PRIMEQUEST 2000 Serie5

Call Trace:
  dump_stack+0x19/0x1b
  __setup_irq+0x54a/0x570
  request_threaded_irq+0xcc/0x170
  i801_probe+0x32f/0x508 [i2c_i801]
  local_pci_probe+0x45/0xa0
i801_smbus 0000:00:1f.3: Failed to allocate irq 255: -16
i801_smbus: probe of 0000:00:1f.3 failed with error -16

Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
---
 drivers/i2c/busses/i2c-i801.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index f62d697..22f9aea 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1380,6 +1380,11 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		}
 	}
 
+	if ((priv->features & FEATURE_IRQ) && dev->irq_invalid) {
+		dev_warn(&dev->dev, "Interrupt line is invalid!\n");
+		priv->features &= ~FEATURE_IRQ;
+	}
+
 	if (priv->features & FEATURE_IRQ) {
 		init_waitqueue_head(&priv->waitq);
 
-- 
1.9.3



