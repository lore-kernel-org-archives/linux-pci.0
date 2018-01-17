Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752791AbeAQX2o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 18:28:44 -0500
Date: Wed, 17 Jan 2018 17:28:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 2/5] PCI/ERR: Rename error reporting to generic pci
 naming
Message-ID: <20180117232840.GA53542@bhelgaas-glaptop.roam.corp.google.com>
References: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
 <1516096723-8013-3-git-send-email-poza@codeaurora.org>
 <20180117011624.GG10860@bhelgaas-glaptop.roam.corp.google.com>
 <553ef73a25bbbd6e0211c9bc6867a4a7@codeaurora.org>
 <6d7a3d050bd3f4ee9eac2aeb3de47786@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6d7a3d050bd3f4ee9eac2aeb3de47786@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 17, 2018 at 02:00:40PM +0530, poza@codeaurora.org wrote:
> On 2018-01-17 13:54, poza@codeaurora.org wrote:
> >On 2018-01-17 06:46, Bjorn Helgaas wrote:
> >>On Tue, Jan 16, 2018 at 03:28:40PM +0530, Oza Pawandeep wrote:
> >>>This patch renames error reporting to generic function with
> >>>pci prefix
> >>>
> >>>Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> >>>
> >>>diff --git a/drivers/pci/pcie/aer/aerdrv_core.c
> >>>b/drivers/pci/pcie/aer/aerdrv_core.c
> >>>index 4fda843..5ed9575 100644
> >>>--- a/drivers/pci/pcie/aer/aerdrv_core.c
> >>>+++ b/drivers/pci/pcie/aer/aerdrv_core.c
> >>>@@ -285,7 +285,7 @@ static void handle_error_source(struct
> >>>pcie_device *aerdev,
> >>> 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
> >>> 					info->status);
> >>> 	} else
> >>>-		do_recovery(dev, info->severity);
> >>>+		pci_do_recovery(dev, info->severity);
> >>> }
> >>>
> >>> #ifdef CONFIG_ACPI_APEI_PCIEAER
> >>>@@ -349,7 +349,7 @@ static void aer_recover_work_func(struct
> >>>work_struct *work)
> >>> 			continue;
> >>> 		}
> >>> 		cper_print_aer(pdev, entry.severity, entry.regs);
> >>>-		do_recovery(pdev, entry.severity);
> >>>+		pci_do_recovery(pdev, entry.severity);
> >>> 		pci_dev_put(pdev);
> >>> 	}
> >>> }
> >>>diff --git a/drivers/pci/pcie/pcie-err.c
> >>>b/drivers/pci/pcie/pcie-err.c
> >>>index 76e66bb..5792a9f 100644
> >>>--- a/drivers/pci/pcie/pcie-err.c
> >>>+++ b/drivers/pci/pcie/pcie-err.c
> >>>@@ -20,12 +20,12 @@
> >>> #include <linux/pcieport_if.h>
> >>> #include "portdrv.h"
> >>>
> >>>-struct aer_broadcast_data {
> >>>+struct pci_err_broadcast_data {
> >>> 	enum pci_channel_state state;
> >>> 	enum pci_ers_result result;
> >>> };
> >>>
> >>>-pci_ers_result_t merge_result(enum pci_ers_result orig,
> >>>+pci_ers_result_t pci_merge_result(enum pci_ers_result orig,
> >>
> >>Most of these functions started out static in aerdrv_core.c and should
> >>remain static.  Therefore, they do not need to be renamed.  Same for
> >>the struct aer_broadcast_data.
> 
> ok so in conclusion I should rename only do_recovery. nothing else
> to be renamed.
> and keep the functions static after moving them to pci_err.c.

Functions should always be static whenever possible.

Names of static functions need not contain the subsystem.  It's
sometimes nice if they do, but in this case I think a rename adds
confusion but no real benefit.
