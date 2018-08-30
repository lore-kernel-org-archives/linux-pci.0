Return-Path: <SRS0=V20j=LN=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=V20j=LN=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<Lorenzo.Pieralisi@arm.com>
CC: <helgaas@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] arm64: defconfig: Enable PCIEPORTBUS
Date: Thu, 30 Aug 2018 20:29:32 +0800
Message-ID: <1535632172-127690-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

PCIe features like AER, Hotplug, PME, DPC depend on PCIEPORTBUS,
so enable PCIEPORTBUS as default.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5..e5652e9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -67,6 +67,7 @@ CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZX=y
 CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_IOV=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_ACPI=y
-- 
1.9.1
