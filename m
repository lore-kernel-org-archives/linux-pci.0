Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Takao Indoh <indou.takao@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: tokunaga.keiich@jp.fujitsu.com, kexec@lists.infradead.org,
	hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com,
	Takao Indoh <indou.takao@jp.fujitsu.com>,
	ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com,
	tglx@linutronix.de, yinghai@kernel.org, mingo@redhat.com,
	vgoyal@redhat.com, khalid@gonehiking.org
Message-Id: <20121127004233.3604.33429.sendpatchset@tindoh.g01.fujitsu.local>
In-Reply-To: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
Subject: [PATCH v7 5/5] x86, pci: Enable PCI INTx when MSI is disabled
Date: Tue, 27 Nov 2012 09:43:21 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables INTx if MSI is disabled in pcibios_enable_device().
In normal case interrupt disable bit in command register is 0b on boot
time, but in case of kdump, this bit may be 1b. It causes problems of
some drivers. At leaset I confirmed mptsas driver does not work in such
a case. This patch fix this problem.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 arch/x86/pci/common.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 720e973..2bb7ecc 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -615,8 +615,10 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	if ((err = pci_enable_resources(dev, mask)) < 0)
 		return err;
 
-	if (!pci_dev_msi_enabled(dev))
+	if (!pci_dev_msi_enabled(dev)) {
+		pci_intx(dev, true);
 		return pcibios_enable_irq(dev);
+	}
 	return 0;
 }
 
-- 
1.7.1


