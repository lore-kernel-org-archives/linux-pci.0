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
	"Kumar Gala" <galak@codeaurora.org>
Subject: [PATCH v4 5/5] MAINTAINERS: Add Altera PCIe and MSI drivers maintainer
Date: Mon, 17 Aug 2015 17:09:39 +0800
Message-ID: <1439802579-22651-6-git-send-email-lftan@altera.com>
In-Reply-To: <1439802579-22651-1-git-send-email-lftan@altera.com>
References: <1439802579-22651-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd60784..32f5287 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7759,6 +7759,14 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI DRIVER FOR ALTERA PCIE IP
+M:	Ley Foon Tan <lftan@altera.com>
+L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/altera-pcie.txt
+F:	drivers/pci/host/pcie-altera.c
+
 PCI DRIVER FOR ARM VERSATILE PLATFORM
 M:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
@@ -7860,6 +7868,14 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/host/*spear*
 
+PCI MSI DRIVER FOR ALTERA MSI IP
+M:	Ley Foon Tan <lftan@altera.com>
+L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
+F:	drivers/pci/host/pcie-altera-msi.c
+
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
 M:	Duc Dang <dhdang@apm.com>
 L:	linux-pci@vger.kernel.org
-- 
1.8.2.1

