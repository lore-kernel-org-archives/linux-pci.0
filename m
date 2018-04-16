Return-Path: <SRS0=NmO7=HF=gmail.com=hkallweit1@kernel.org>
Return-Path: <SRS0=NmO7=HF=gmail.com=hkallweit1@kernel.org>
Subject: [PATCH net-next 1/2] PCI: Add two more values for PCIe
 Max_Read_Request_Size
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <00f1255f-acf0-4760-c20f-0b78bda44645@gmail.com>
Message-ID: <ab8696d7-59e0-1f24-0ead-757057eb50cf@gmail.com>
Date: Mon, 16 Apr 2018 21:37:13 +0200
MIME-Version: 1.0
In-Reply-To: <00f1255f-acf0-4760-c20f-0b78bda44645@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

This patch adds missing values for the max read request size.
E.g. network driver r8169 uses a value of 4K.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/uapi/linux/pci_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 0c79eac5..699257fb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -506,6 +506,8 @@
 #define  PCI_EXP_DEVCTL_READRQ_256B  0x1000 /* 256 Bytes */
 #define  PCI_EXP_DEVCTL_READRQ_512B  0x2000 /* 512 Bytes */
 #define  PCI_EXP_DEVCTL_READRQ_1024B 0x3000 /* 1024 Bytes */
+#define  PCI_EXP_DEVCTL_READRQ_2048B 0x4000 /* 2048 Bytes */
+#define  PCI_EXP_DEVCTL_READRQ_4096B 0x5000 /* 4096 Bytes */
 #define  PCI_EXP_DEVCTL_BCR_FLR 0x8000  /* Bridge Configuration Retry / FLR */
 #define PCI_EXP_DEVSTA		10	/* Device Status */
 #define  PCI_EXP_DEVSTA_CED	0x0001	/* Correctable Error Detected */
-- 
2.17.0
