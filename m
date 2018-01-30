Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbeA3TLE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 14:11:04 -0500
Date: Tue, 30 Jan 2018 13:11:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v2 11/14] PCI/DPC: Remove unnecessary RP PIO register
 structs
Message-ID: <20180130191100.GH232763@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180130182648.106875.32803.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180130185758.GC27205@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180130185758.GC27205@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 30, 2018 at 11:57:58AM -0700, Keith Busch wrote:
> On Tue, Jan 30, 2018 at 12:26:48PM -0600, Bjorn Helgaas wrote:
> > +	u16 cap = dpc->cap_pos;
> > +	u32 status, mask;
> > +	u32 sev, syserr, exc;
> > +	u16 dpc_status, first_error;
> > +	u32 dw0, dw1, dw2, dw3;
> > +	u32 log;
> > +	u32 prefix;
> 
> Minor nit, could you squash the declarations of the same type?

I did it that way so it matches the order of the chunks of code where
they're used.  But I guess we don't really do that elsewhere in the
file, so I did.  Here's the result:


commit ea512cad7f7e293eca002039517c4469383c5bcf
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Jan 30 12:12:48 2018 -0600

    PCI/DPC: Remove unnecessary RP PIO register structs
    
    We read and immediately print the RP PIO log registers.  We don't save
    them, so there's no need to define structs for them.  Remove the structs
    and read the registers into local variables instead.  No functional change
    intended.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 7b96169a808c..468440e8fb6f 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -17,26 +17,6 @@
 #include "../pci.h"
 #include "aer/aerdrv.h"
 
-struct rp_pio_header_log_regs {
-	u32 dw0;
-	u32 dw1;
-	u32 dw2;
-	u32 dw3;
-};
-
-struct dpc_rp_pio_regs {
-	u32 status;
-	u32 mask;
-	u32 severity;
-	u32 syserror;
-	u32 exception;
-
-	struct rp_pio_header_log_regs header_log;
-	u32 impspec_log;
-	u32 tlp_prefix_log[4];
-	u16 first_error;
-};
-
 struct dpc_dev {
 	struct pcie_device	*dev;
 	struct work_struct	work;
@@ -142,78 +122,66 @@ static void dpc_work(struct work_struct *work)
 			      ctl | PCI_EXP_DPC_CTL_INT_EN);
 }
 
-static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
-				struct dpc_rp_pio_regs *rp_pio)
+static void dpc_rp_pio_get_info(struct dpc_dev *dpc)
 {
 	struct device *dev = &dpc->dev->device;
 	struct pci_dev *pdev = dpc->dev->port;
+	u16 cap = dpc->cap_pos, dpc_status, first_error;
+	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
 	int i;
-	u16 cap = dpc->cap_pos, dpc_status;
-	u32 status;
 
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
-			      &rp_pio->status);
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK,
-			      &rp_pio->mask);
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, &status);
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK, &mask);
 	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
-		rp_pio->status, rp_pio->mask);
+		status, mask);
 
-	dpc->rp_pio_status = rp_pio->status;
+	dpc->rp_pio_status = status;
 
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY,
-			      &rp_pio->severity);
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR,
-			      &rp_pio->syserror);
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION,
-			      &rp_pio->exception);
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY, &sev);
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR, &syserr);
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION, &exc);
 	dev_err(dev, "RP PIO severity=%#010x, syserror=%#010x, exception=%#010x\n",
-		rp_pio->severity, rp_pio->syserror, rp_pio->exception);
+		sev, syserr, exc);
 
 	/* Get First Error Pointer */
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
-	rp_pio->first_error = (dpc_status & 0x1f00) >> 8;
+	first_error = (dpc_status & 0x1f00) >> 8;
 
-	status = (rp_pio->status & ~rp_pio->mask);
+	status &= ~mask;
 	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
 		if (status & (1 << i))
 			dev_err(dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
-				rp_pio->first_error == i ? " (First)" : "");
+				first_error == i ? " (First)" : "");
 	}
 
 	if (dpc->rp_log_size < 4)
 		return;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
-			      &rp_pio->header_log.dw0);
+			      &dw0);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
-			      &rp_pio->header_log.dw1);
+			      &dw1);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 8,
-			      &rp_pio->header_log.dw2);
+			      &dw2);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
-			      &rp_pio->header_log.dw3);
+			      &dw3);
 	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
-		rp_pio->header_log.dw0, rp_pio->header_log.dw1,
-		rp_pio->header_log.dw2, rp_pio->header_log.dw3);
+		dw0, dw1, dw2, dw3);
 
 	if (dpc->rp_log_size < 5)
 		return;
-	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG,
-			      &rp_pio->impspec_log);
-	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", rp_pio->impspec_log);
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
+	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", log);
 
 	for (i = 0; i < dpc->rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
-			&rp_pio->tlp_prefix_log[i]);
-		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i,
-			rp_pio->tlp_prefix_log[i]);
+			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
+		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
 }
 
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
-	struct dpc_rp_pio_regs rp_pio_regs;
-
-	dpc_rp_pio_get_info(dpc, &rp_pio_regs);
+	dpc_rp_pio_get_info(dpc);
 
 }
 
