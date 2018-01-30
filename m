Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932070AbeA3SLR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:11:17 -0500
Date: Tue, 30 Jan 2018 12:11:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: okaya@codeaurora.org
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 6/8] PCI/DPC: Consolidate RP PIO get/print functions
Message-ID: <20180130181112.GF232763@bhelgaas-glaptop.roam.corp.google.com>
References: <20180126225043.58614.99920.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180126225622.58614.24127.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <51b6a3709f193727d85e08cee97c4133@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51b6a3709f193727d85e08cee97c4133@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 29, 2018 at 07:42:54PM -0500, okaya@codeaurora.org wrote:
> On 2018-01-26 17:56, Bjorn Helgaas wrote:
> >From: Bjorn Helgaas <bhelgaas@google.com>
> >
> >Previously we defined a structure for RP PIO log information,
> >allocated it
> >on the stack, called one function to fill it in from DPC registers, and
> >called another to print it out.
> >
> >Simplify this by dropping the structure and printing the error
> >information
> >as soon as we read it from the DPC capability.  This way we don't
> >need a
> >structure, there's one function instead of four, and everything we
> >do with
> >the register information is in one place instead of being split between
> >functions.
> >
> >No functional change intended.
> >
> >Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >---
> > drivers/pci/pcie/pcie-dpc.c |  132
> >+++++++++++++------------------------------
> > 1 file changed, 39 insertions(+), 93 deletions(-)
> >
> >diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> >index a6b8d1496322..06d3af112580 100644
> >--- a/drivers/pci/pcie/pcie-dpc.c
> >+++ b/drivers/pci/pcie/pcie-dpc.c
> >@@ -17,26 +17,6 @@
> > #include "../pci.h"
> > #include "aer/aerdrv.h"
> >
> >-struct rp_pio_header_log_regs {
> >-	u32 dw0;
> >-	u32 dw1;
> >-	u32 dw2;
> >-	u32 dw3;
> >-};
> >-
> >-struct dpc_rp_pio_regs {
> >-	u32 status;
> >-	u32 mask;
> >-	u32 severity;
> >-	u32 syserror;
> >-	u32 exception;
> >-
> >-	struct rp_pio_header_log_regs header_log;
> >-	u32 impspec_log;
> >-	u32 tlp_prefix_log[4];
> >-	u16 first_error;
> >-};
> >-
> > struct dpc_dev {
> > 	struct pcie_device	*dev;
> > 	struct work_struct	work;
> >@@ -142,100 +122,66 @@ static void dpc_work(struct work_struct *work)
> > 			      ctl | PCI_EXP_DPC_CTL_INT_EN);
> > }
> >
> >-static void dpc_rp_pio_print_tlp_header(struct device *dev,
> >-					struct rp_pio_header_log_regs *t)
> >-{
> >-	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
> >-		t->dw0, t->dw1, t->dw2, t->dw3);
> >-}
> >-
> >-static void dpc_rp_pio_print_error(struct dpc_dev *dpc,
> >-				   struct dpc_rp_pio_regs *rp_pio)
> >+static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
> > {
> > 	struct device *dev = &dpc->dev->device;
> >+	struct pci_dev *pdev = dpc->dev->port;
> >+	u16 cap = dpc->cap_pos;
> >+	u32 status, mask;
> >+	u32 sev, syserr, exc;
> >+	u16 dpc_status, first_error;
> > 	int i;
> >-	u32 status;
> >+	u32 dw0, dw1, dw2, dw3;
> >+	u32 log;
> >+	u32 prefix;
> >
> >+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
> >&status);
> >+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK, &mask);
> > 	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
> >-		rp_pio->status, rp_pio->mask);
> >+		status, mask);
> >
> >+	dpc->rp_pio_status = status;
> >+
> >+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY, &sev);
> >+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR,
> >&syserr);
> >+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION,
> >&exc);
> > 	dev_err(dev, "RP PIO severity=%#010x, syserror=%#010x,
> >exception=%#010x\n",
> >-		rp_pio->severity, rp_pio->syserror, rp_pio->exception);
> >+		sev, syserr, exc);
> >
> >-	status = (rp_pio->status & ~rp_pio->mask);
> >+	/* Get First Error Pointer */
> >+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
> >+	first_error = (dpc_status & 0x1f00) >> 8;
> 
> This didn't look like a simple change here.

The diff is ugly, for sure.   I'll split it up and you can see what
you think.
