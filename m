Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33298 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758982AbcAMNVd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2016 08:21:33 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so295437124wmf.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2016 05:21:32 -0800 (PST)
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V3 07/21] pci, acpi, mcfg: Provide default RAW ACPI PCI config space accessors.
Date: Wed, 13 Jan 2016 14:20:53 +0100
Message-Id: <1452691267-32240-8-git-send-email-tn@semihalf.com>
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lets keep RAW ACPI PCI config space accessors empty by default,
since we are note sure if they are necessary accross all archs.
Once we sort this out, we can provide generic version or let
architectures to overwrite, like now x86.

Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/mcfg.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 745b83e..3e1e7be 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -9,9 +9,30 @@
 
 #include <linux/acpi.h>
 #include <linux/ecam.h>
+#include <linux/pci.h>
 
 #define	PREFIX	"MCFG: "
 
+/*
+ * raw_pci_read/write - raw ACPI PCI config space accessors.
+ *
+ * By defauly (__weak) these accessors are empty and should be overwritten
+ * by architectures which support operations on ACPI PCI_Config regions,
+ * see osl.c file.
+ */
+
+int __weak raw_pci_read(unsigned int domain, unsigned int bus,
+			unsigned int devfn, int reg, int len, u32 *val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+int __weak raw_pci_write(unsigned int domain, unsigned int bus,
+			 unsigned int devfn, int reg, int len, u32 val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
 int __init acpi_parse_mcfg(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
-- 
1.9.1

