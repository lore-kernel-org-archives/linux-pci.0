Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36543 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965752AbbLPPRy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2015 10:17:54 -0500
Received: by mail-wm0-f49.google.com with SMTP id p187so5660251wmp.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Dec 2015 07:17:53 -0800 (PST)
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
Subject: [PATCH V2 07/23] pci, acpi, mcfg: Provide default RAW ACPI PCI config space accessors.
Date: Wed, 16 Dec 2015 16:16:17 +0100
Message-Id: <1450278993-12664-8-git-send-email-tn@semihalf.com>
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lets keep RAW ACPI PCI config space accessors empty by default,
since we are note sure if they are necessary accross all archs.
Once we sort this out, we can provide generic version or let
architectures to overwrite, like now x86.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
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

