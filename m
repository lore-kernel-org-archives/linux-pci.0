Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"Kumar Gala" <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v12 2/6] pci: add Altera PCI vendor ID
Date: Fri, 23 Oct 2015 18:27:11 +0800
Message-ID: <1445596035-27733-3-git-send-email-lftan@altera.com>
In-Reply-To: <1445596035-27733-1-git-send-email-lftan@altera.com>
References: <1445596035-27733-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d9ba49c..08e4462 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1550,6 +1550,8 @@
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_HT1100LD 0x0408
 
+#define PCI_VENDOR_ID_ALTERA		0x1172
+
 #define PCI_VENDOR_ID_SBE		0x1176
 #define PCI_DEVICE_ID_SBE_WANXL100	0x0301
 #define PCI_DEVICE_ID_SBE_WANXL200	0x0302
-- 
1.8.2.1

