Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Wed, 31 Aug 2016 10:30:02 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>, rjw@rjwysocki.net
Cc: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
	rjw@rjwysocki.net, helgaas@kernel.org, will.deacon@arm.com,
	catalin.marinas@arm.com, hanjun.guo@linaro.org,
	shijie.huang@arm.com, robert.richter@caviumnetworks.com,
	mw@semihalf.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	andrea.gallo@linaro.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, al.stone@linaro.org,
	graeme.gregory@linaro.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org
Subject: Re: [PATCH V8 1/8] ACPI: I/O Remapping Table (IORT) initial support
Message-ID: <20160831093002.GA2021@red-moon>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
 <1470909998-16710-2-git-send-email-tn@semihalf.com>
 <20160812163332.GA17734@red-moon>
 <ecf44af7-598c-bfe4-a144-8e26168d4ad8@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ecf44af7-598c-bfe4-a144-8e26168d4ad8@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On Thu, Aug 18, 2016 at 08:25:20AM +0200, Tomasz Nowicki wrote:
> On 12.08.2016 18:33, Lorenzo Pieralisi wrote:
> >Hi Tomasz,
> >
> >On Thu, Aug 11, 2016 at 12:06:31PM +0200, Tomasz Nowicki wrote:
> >>IORT shows representation of IO topology for ARM based systems.
> >>It describes how various components are connected together on
> >>parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
> >>http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
> >>
> >>Initial support allows to detect IORT table presence and save its
> >>root pointer obtained through acpi_get_table(). The pointer validity
> >>depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
> >>is not set while using IORT nodes we would dereference unmapped pointers.
> >>
> >>For the aforementioned reason call iort_table_detect() from acpi_init()
> >>which guarantees acpi_gbl_permanent_mmap to be set at that point.
> >
> >We still need to get Rafael ACK on this, keeping in mind that the
> >eg code parsing DMAR table relies on the same assumption.
> 
> Exactly.
> 
> Rafael, can you please have a look ?

A gentle reminder, this patch is gating this series and requires
your review, please let us know what you think.

Thank you,
Lorenzo

> 
> >
> >[...]
> >
> >>diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> >>index 445ce28..6cef2d1 100644
> >>--- a/drivers/acpi/Kconfig
> >>+++ b/drivers/acpi/Kconfig
> >>@@ -521,4 +521,9 @@ config ACPI_CONFIGFS
> >> 	  userspace. The configurable ACPI groups will be visible under
> >> 	  /config/acpi, assuming configfs is mounted under /config.
> >>
> >>+if ARM64
> >>+source "drivers/acpi/arm64/Kconfig"
> >>+
> >
> >Just curious: Why do you need a space ?
> 
> No good reason, it will disappear for next version.
> 
> >
> >>+endif
> >>+
> >> endif	# ACPI
> >>diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> >>index 5ae9d85..e5ada78 100644
> >>--- a/drivers/acpi/Makefile
> >>+++ b/drivers/acpi/Makefile
> >>@@ -105,3 +105,5 @@ obj-$(CONFIG_ACPI_CONFIGFS)	+= acpi_configfs.o
> >>
> >> video-objs			+= acpi_video.o video_detect.o
> >> obj-y				+= dptf/
> >>+
> >>+obj-$(CONFIG_ARM64)		+= arm64/
> >>diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> >>new file mode 100644
> >>index 0000000..fc818dc
> >>--- /dev/null
> >>+++ b/drivers/acpi/arm64/Kconfig
> >>@@ -0,0 +1,6 @@
> >>+#
> >>+# ACPI Configuration for ARM64
> >>+#
> >>+
> >>+config IORT_TABLE
> >>+	bool
> >>diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> >>new file mode 100644
> >>index 0000000..d01be6f
> >>--- /dev/null
> >>+++ b/drivers/acpi/arm64/Makefile
> >>@@ -0,0 +1 @@
> >>+obj-$(CONFIG_IORT_TABLE) 	+= iort.o
> >>diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>new file mode 100644
> >>index 0000000..f89056e
> >>--- /dev/null
> >>+++ b/drivers/acpi/arm64/iort.c
> >>@@ -0,0 +1,218 @@
> >>+/*
> >>+ * Copyright (C) 2016, Semihalf
> >>+ *	Author: Tomasz Nowicki <tn@semihalf.com>
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or modify it
> >>+ * under the terms and conditions of the GNU General Public License,
> >>+ * version 2, as published by the Free Software Foundation.
> >>+ *
> >>+ * This program is distributed in the hope it will be useful, but WITHOUT
> >>+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> >>+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> >>+ * more details.
> >>+ *
> >>+ * This file implements early detection/parsing of I/O mapping
> >>+ * reported to OS through firmware via I/O Remapping Table (IORT)
> >>+ * IORT document number: ARM DEN 0049A
> >>+ */
> >>+
> >>+#define pr_fmt(fmt)	"ACPI: IORT: " fmt
> >>+
> >>+#include <linux/iort.h>
> >>+#include <linux/kernel.h>
> >>+#include <linux/pci.h>
> >>+
> >>+typedef acpi_status (*iort_find_node_callback)
> >>+	(struct acpi_iort_node *node, void *context);
> >>+
> >>+/* Root pointer to the mapped IORT table */
> >>+static struct acpi_table_header *iort_table;
> >
> >See above.
> >
> >[...]
> >
> >>+void __init iort_table_detect(void)
> >>+{
> >>+	acpi_status status;
> >>+
> >>+	status = acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
> >>+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> >>+		const char *msg = acpi_format_exception(status);
> >>+		pr_err("Failed to get table, %s\n", msg);
> >>+	}
> >>+}
> >>diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >>index 85b7d07..55a84da 100644
> >>--- a/drivers/acpi/bus.c
> >>+++ b/drivers/acpi/bus.c
> >>@@ -36,6 +36,7 @@
> >> #ifdef CONFIG_X86
> >> #include <asm/mpspec.h>
> >> #endif
> >>+#include <linux/iort.h>
> >> #include <linux/pci.h>
> >> #include <acpi/apei.h>
> >> #include <linux/dmi.h>
> >>@@ -1186,6 +1187,7 @@ static int __init acpi_init(void)
> >> 	}
> >>
> >> 	pci_mmcfg_late_init();
> >>+	iort_table_detect();
> >
> >That's another bit we have to make sure Rafael is ok with, given
> >that IORT is ARM64 specific (but we stub it out if it is not
> >configured).
> >
> >Having said that:
> >
> >Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Thanks for your time.
> 
> Tomasz
> 
