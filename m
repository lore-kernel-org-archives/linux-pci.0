Return-Path: <SRS0=WKef=GA=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=WKef=GA=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>
CC: <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<charles.chenxin@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [RFC PATCH] ARM64/PCI: Set dev->irq=0 before calling acpi_pci_irq_enable()
Date: Sat, 10 Mar 2018 10:58:12 +0800
Message-ID: <1520650692-62705-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

The init value of dev->irq is from PCI_INTERRUPT_LINE register.The default
value of dev->irq usually is 255 before calling acpi_pci_irq_enable().
This will cause a problem When the platform does not support INTx well.
For example, we do not config _PRT on our HIP07 platform, we met irq 255
confilict.

The error message is as below.
snd_hda_intel 000d:33:00.1: PCI INT B: no GSI
snd_hda_intel 000d:33:00.1: enabling device (0000 -> 0002)
snd_hda_intel 000d:33:00.1: Force to snoop mode by module option
snd_hda_intel 000d:33:00.1: Device has broken 64-bit MSI but arch tried to
assign one above 4G
genirq: Flags mismatch irq 255. 00000001 (enahisic2i0-tx1) vs. 00000081
(snd_hda_intel:card0)
hns-nic HISI00C2:00 enahisic2i0: request irq(255) fail

enahisic2i0-tx1: this device is a platform device.
snd_hda_intel:card0: this device is a PCI device.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 arch/arm64/kernel/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 0e2ea1c..6a77bef 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -28,8 +28,11 @@
  */
 int pcibios_alloc_irq(struct pci_dev *dev)
 {
-	if (!acpi_disabled)
+	if (!acpi_disabled) {
+		dev->irq = 0;
 		acpi_pci_irq_enable(dev);
+	}
+
 
 	return 0;
 }
-- 
1.9.1
