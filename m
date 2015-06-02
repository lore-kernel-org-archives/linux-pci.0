Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22289 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755651AbbFBGLm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Jun 2015 02:11:42 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Cc: Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v4 5/8] ARM64/PCI/ACPI: Introduce struct pci_controller for ACPI
Date: Tue,  2 Jun 2015 14:12:53 +0800
Message-Id: <1433225576-8215-6-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

ARM64 ACPI based PCI host bridge init needs a arch dependent
struct pci_controller to accommodate common PCI host bridge
code which is introduced later, or it will lead to compile
errors on ARM64.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/arm64/include/asm/pci.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b008a72f8bc0..70884957f253 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -10,6 +10,16 @@
 #include <asm-generic/pci-bridge.h>
 #include <asm-generic/pci-dma-compat.h>
 
+struct acpi_device;
+
+struct pci_controller {
+#ifdef CONFIG_ACPI
+	struct acpi_device *companion;	/* ACPI companion device */
+#endif
+	int		segment;	/* PCI domain */
+	int		node;		/* NUMA node */
+};
+
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0
 
-- 
1.7.10.4

