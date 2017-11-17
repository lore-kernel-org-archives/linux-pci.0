Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751760AbdKQSXA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Nov 2017 13:23:00 -0500
Date: Fri, 17 Nov 2017 12:22:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: bhelgaas@google.com, jonathan.derrick@intel.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: don't call recovery process for correctable
 errors
Message-ID: <20171117182256.GA16907@bhelgaas-glaptop.roam.corp.google.com>
References: <1503940184-29423-1-git-send-email-tbaicar@codeaurora.org>
 <20171002231903.GE5407@bhelgaas-glaptop.roam.corp.google.com>
 <86882a99-ef54-a71b-3e97-8ecc46d8d14b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86882a99-ef54-a71b-3e97-8ecc46d8d14b@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 15, 2017 at 09:46:42AM -0500, Tyler Baicar wrote:
> On 10/2/2017 7:19 PM, Bjorn Helgaas wrote:
> >On Mon, Aug 28, 2017 at 11:09:44AM -0600, Tyler Baicar wrote:
> >>Correctable errors do not need any software intervention, so
> >>avoid calling into the software recovery process for correctable
> >>errors.
> >>
> >>Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> >>---
> >>  drivers/pci/pcie/aer/aerdrv_core.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> >>index b1303b3..4765c11 100644
> >>--- a/drivers/pci/pcie/aer/aerdrv_core.c
> >>+++ b/drivers/pci/pcie/aer/aerdrv_core.c
> >>@@ -626,7 +626,8 @@ static void aer_recover_work_func(struct work_struct *work)
> >>  			continue;
> >>  		}
> >>  		cper_print_aer(pdev, entry.severity, entry.regs);
> >>-		do_recovery(pdev, entry.severity);
> >>+		if (entry.severity != AER_CORRECTABLE)
> >>+			do_recovery(pdev, entry.severity);
> >I think this is fine, and it mirrors what is done in
> >handle_error_source().
> >
> Hello,
> 
> Will this patch be pulled into 4.15?

Sorry, I didn't get to this in time for v4.15, but I put it on pci/aer
for v4.16.  I expanded the changelog to note that this means we won't
call the driver's callbacks or emit the "recovery successful" message
for correctable errors from APEI, and that this matches what we
already do for the non-APEI path.

Bjorn


commit 72761170e6d5519c91136fd6cc80805a74ef9cfd
Author: Tyler Baicar <tbaicar@codeaurora.org>
Date:   Mon Aug 28 11:09:44 2017 -0600

    PCI/AER: Skip recovery callbacks for correctable errors from ACPI APEI
    
    PCIe correctable errors are corrected by hardware.  Software may log them,
    but no other software intervention is required.
    
    There are two paths to enter the AER recovery code: (1) the native path
    where Linux fields the AER interrupt and reads the AER registers directly,
    and (2) the ACPI path where firmware reads the AER registers and hands them
    off to Linux via the ACPI APEI path.
    
    The AER do_recovery() function calls driver error reporting callbacks
    (error_detected(), mmio_enabled(), resume(), etc), attempts recovery (for
    fatal errors), and logs a "AER: Device recovery successful" message.
    
    Since there's nothing to recover for correctable errors, the native path
    already skips do_recovery(), so it doesn't call the driver callbacks and or
    emit the message.  Make the APEI path do the same.
    
    Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 744805232155..3e354f224422 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -633,7 +633,8 @@ static void aer_recover_work_func(struct work_struct *work)
 			continue;
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
-		do_recovery(pdev, entry.severity);
+		if (entry.severity != AER_CORRECTABLE)
+			do_recovery(pdev, entry.severity);
 		pci_dev_put(pdev);
 	}
 }
