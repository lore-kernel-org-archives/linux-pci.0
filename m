Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 07/59] PCI: Ignore BAR for ALi M1533 PCI-ISA bridge
Date: Wed, 24 Feb 2016 18:11:58 -0800
Message-Id: <1456366370-28995-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Meelis reported strange conflicts on sparc v210:
pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with 0001:00:07.0 [mem 0x7ff00000000-0x7ff000fffff]
pci 0001:00:06.0: can't claim BAR 0 [io 0x7fe01000000-0x7fe0100000f]: address conflict with 0001:00:07.0 [io 0x7fe01000000-0x7fe0100ffff]
pci 0001:00:0d.0: can't claim BAR 0 [io 0x7fe01000900-0x7fe01000907]: address conflict with 0001:00:07.0 [io 0x7fe01000000-0x7fe0100ffff]
pci 0001:00:0d.0: can't claim BAR 1 [io 0x7fe01000918-0x7fe0100091f]: address conflict with 0001:00:07.0 [io 0x7fe01000000-0x7fe0100ffff]
pci 0001:00:0d.0: can't claim BAR 2 [io 0x7fe01000910-0x7fe01000917]: address conflict with 0001:00:07.0 [io 0x7fe01000000-0x7fe0100ffff]
pci 0001:00:0d.0: can't claim BAR 3 [io 0x7fe01000908-0x7fe0100090f]: address conflict with 0001:00:07.0 [io 0x7fe01000000-0x7fe0100ffff]
pci 0001:00:0d.0: can't claim BAR 4 [io 0x7fe01000920-0x7fe0100092f]: address conflict with 0001:00:07.0 [io 0x7fe01000000-0x7fe0100ffff]
PCI: /pci@1e,600000 can't claim Video RAM area [mem 0x7ff000a0000-0x7ff000bffff]: address conflict with 0001:00:07.0 [mem 0x7ff00000000-0x7ff000fffff]
PCI: /pci@1e,600000 can't claim System ROM [mem 0x7ff000f0000-0x7ff000fffff]: address conflict with 0001:00:07.0 [mem 0x7ff00000000-0x7ff000fffff]
PCI: /pci@1e,600000 can't claim Video ROM [mem 0x7ff000c0000-0x7ff000c7fff]: address conflict with 0001:00:07.0 [mem 0x7ff00000000-0x7ff000fffff]

we have
pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
pci_bus 0001:00: root bus resource [mem 0x7ff00000000-0x7ffffffffff] (bus address [0x00000000-0xffffffff])

so pci bus address in the bars for 0001:00:07.0 has all 0s.

0001:00:07.0 ISA bridge: ULi Electronics Inc. M1533/M1535/M1543 PCI to ISA Bridge [Aladdin IV/V/V+]
        Region 0: [virtual] I/O ports at 0000 [size=64K]
        Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [size=1M]
        Region 2: Memory at <unassigned> (32-bit, non-prefetchable) [size=1M]
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

According to http://www.versalogic.com/Support/Downloads/pdf/ali1543.pdf
page 28: The indices before 40h are read-only.
and we have all 0 from 0x10-0x2f, according to lspci.
So those BAR do not work as regular BAR, just clean flags, and ignore them all
the way include claim and sizing and alloc etc.

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 051999e..2361a62 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -445,6 +445,21 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_nl_class);
 
+
+/*
+ * ALi m1533 pci to isa bridge does not have BAR according to datasheet,
+ * clear the flags, so we will try to claim them or reallocate res.
+ */
+static void quirk_ali1533(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < PCI_ROM_RESOURCE; i++)
+		dev->resource[i].flags = 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+			 quirk_ali1533);
+
 static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
 {
 	u32 devres;
-- 
1.8.4.5
