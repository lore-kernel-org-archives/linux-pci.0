Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:13468 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbbHDUmb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 16:42:31 -0400
From: Jayachandran C <jchandra@broadcom.com>
To: Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: Jayachandran C <jchandra@broadcom.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v4 2/3] PCI: Add setup-irq.o when compiling for arm64
Date: Wed, 5 Aug 2015 02:23:39 +0530
Message-ID: <1438721620-15493-2-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ARM64 requires setup-irq.o to provide pci_fixup_irqs() implementation.
We are adding this now to support the pci-host-generic host controller,
but we enable it for ARM64 PCI so that other host controllers can use
this as well.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 73e4af4..be3f631 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
 #
 obj-$(CONFIG_ALPHA) += setup-irq.o
 obj-$(CONFIG_ARM) += setup-irq.o
+obj-$(CONFIG_ARM64) += setup-irq.o
 obj-$(CONFIG_UNICORE32) += setup-irq.o
 obj-$(CONFIG_SUPERH) += setup-irq.o
 obj-$(CONFIG_MIPS) += setup-irq.o
-- 
1.9.1

