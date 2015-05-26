Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34027 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbbEZMxD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 08:53:03 -0400
Received: by pdbki1 with SMTP id ki1so48622485pdb.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 05:50:48 -0700 (PDT)
From: Hanjun Guo <hanjun.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 09/11] pci, acpi, mcfg: Share ACPI PCI config space accessors.
Date: Tue, 26 May 2015 20:49:22 +0800
Message-Id: <1432644564-24746-10-git-send-email-hanjun.guo@linaro.org>
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

MCFG can be used perfectly for all architectures which support ACPI.
ACPI mandates MCFG to describe PCI config space ranges which means
we should use MMCONFIG accessors by default.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/acpi/mcfg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 745b83e..90c81fa 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -12,6 +12,26 @@
 
 #define	PREFIX	"MCFG: "
 
+/*
+ * raw_pci_read/write - ACPI PCI config space accessors.
+ *
+ * ACPI spec defines MCFG table as the way we can describe access to PCI config
+ * space, so let MCFG be default (__weak).
+ *
+ * If platform needs more fancy stuff, should provides its own implementation.
+ */
+int __weak raw_pci_read(unsigned int domain, unsigned int bus,
+			unsigned int devfn, int reg, int len, u32 *val)
+{
+	return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
+}
+
+int __weak raw_pci_write(unsigned int domain, unsigned int bus,
+			 unsigned int devfn, int reg, int len, u32 val)
+{
+	return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
+}
+
 int __init acpi_parse_mcfg(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
-- 
1.9.1

