Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751612AbdHAXE3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Aug 2017 19:04:29 -0400
Date: Tue, 1 Aug 2017 17:55:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Add WARN_ON() for some pci= kernel parameters
Message-ID: <20170801225556.GD26498@bhelgaas-glaptop.roam.corp.google.com>
References: <1489513617-9833-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489513617-9833-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 14, 2017 at 01:46:57PM -0400, Prarit Bhargava wrote:
> Bjorn, sorry for not getting back to this.  I forgot about it and was
> reminded of it in a bug where someone had disabled ACPI and was wondering
> why their system wouldn't boot.

As you can see, I didn't exactly deal with this promptly myself.  I
was hoping for something that made the whitelist most explicit and
easier to understand.  What do you think of the following?


commit 8b3dd031d5622d3dbe369c9d054392e8a52f933e
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Aug 1 17:00:27 2017 -0500

    PCI: Taint and warn for pci= kernel parameters
    
    Many pci= kernel parameters are used to work around BIOS and platform
    issues.  Using the parameter may result in a system which boots, but the
    problem is never reported back and future users will have to rediscover the
    parameter.
    
    Print a warning and taint the kernel when these parameters are used.
    
    Some parameters are for things Linux is not smart enough to figure out
    automatically.  Whitelist those so we don't warn about them.
    
    Based-on-patch-by: Prarit Bhargava <prarit@redhat.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc3456dc1..88204b251a08 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5396,12 +5396,51 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_fixup_cardbus);
 
+static __initdata const char * const pci_opt_whitelist[] = {
+	"earlydump",
+	"rom",
+	"norom",
+	"irqmask=",
+	"pcie_bus_tune_off",
+	"pcie_bus_safe",
+	"pcie_bus_perf",
+	"pcie_bus_peer2peer",
+	"cbiosize=",
+	"cbmemsize=",
+	"hpiosize=",
+	"hpmemsize=",
+	"hpbussize=",
+	"resource_alignment=",
+	"realloc",
+	"realloc=",
+};
+
+static int __init pci_opt_whitelisted(char *str)
+{
+	int i;
+	const char *opt;
+
+	for (i = 0; i < ARRAY_SIZE(pci_opt_whitelist); i++) {
+		opt = pci_opt_whitelist[i];
+		if (!strncmp(str, opt, strlen(opt)))
+			return 1;
+	}
+
+	return 0;
+}
+
 static int __init pci_setup(char *str)
 {
 	while (str) {
 		char *k = strchr(str, ',');
 		if (k)
 			*k++ = 0;
+		if (*str && !pci_opt_whitelisted(str)) {
+			add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+			pr_warning("PCI: Tainting kernel because pci=%s option used\n",
+				    str);
+			pr_warning("PCI: If your system requires this option, please report it so future kernels can handle this automatically\n");
+		}
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
