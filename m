Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752217AbeBWXMi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Feb 2018 18:12:38 -0500
Date: Fri, 23 Feb 2018 17:12:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
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
Subject: Re: [PATCH v11 0/7] Address error and recovery for AER and DPC
Message-ID: <20180223231236.GO14632@bhelgaas-glaptop.roam.corp.google.com>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 01:53:57PM +0530, Oza Pawandeep wrote:
> This patch set brings in error handling support for DPC
> 
> The current implementation of AER and error message broadcasting to the
> EP driver is tightly coupled and limited to AER service driver.
> It is important to factor out broadcasting and other link handling
> callbacks. So that not only when AER gets triggered, but also when DPC get
> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> 
> DPC should enumerate the devices after recovering the link, which is
> achieved by implementing error_resume callback.
> 
> Changes since v10:
>     Christoph Hellwig's, David Laight's and Randy Dunlap's
>     comments addressed.
> 	> renamed pci_do_recovery to pcie_do_recovery
> 	> removed inner braces in conditional statements.
> 	> restrctured the code in pci_wait_for_link 
> 	> EXPORT_SYMBOL_GPL
> Changes since v9:
>     Sinan's comments addressed.
> 	> bool active = true; unnecessary variable removed.
> Changes since v8:
>     Fixed Kbuild errors.
> Changes since v7:
>     Rebased the code on pci master
> 	> https://kernel.googlesource.com/pub/scm/linux/kernel/git/helgaas/pci
> Changes since v6:
>     Sinan's and Stefan's comments implemented.
> 	> reordered patch 6 and 7
> 	> cleaned up
> Changes since v5:
>     Sinan's and Keith's comments incorporated.
>         > made separate patch for mutex
>         > unified error repotting codes into driver/pci/pci.h
>         > got rid of wait link active/inactive and
>           made generic function in driver/pci/pci.c
> Changes since v4:
>     Bjorn's comments incorporated.
>         > Renamed only do_recovery.
>         > moved the things more locally to drivers/pci/pci.h
> Changes since v3:
>     Bjorn's comments incorporated.
>         > Made separate patch renaming generic pci_err.c
>         > Introduce pci_err.h to contain all the error types and recovery
>         > removed all the dependencies on pci.h
> Changes since v2:
>     Based on feedback from Keith:
>     "
>     When DPC is triggered due to receipt of an uncorrectable error Message,
>     the Requester ID from the Message is recorded in the DPC Error
>     Source ID register and that Message is discarded and not forwarded Upstream.
>     "
>     Removed the patch where AER checks if DPC service is active
> Changes since v1:
>     Kbuild errors fixed:
>         > pci_find_dpc_dev made static
>         > ras_event.h updated
>         > pci_find_aer_service call with CONFIG check
>         > pci_find_dpc_service call with CONFIG check

Woof, v8, v9, v10, and v11 all in the last two days.  It's OK to wait
a couple days for feedback to settle out before posting a new version :)

> Oza Pawandeep (7):
>   PCI/AER: Rename error recovery to generic pci naming
>   PCI/AER: factor out error reporting from AER
>   PCI/ERR: add mutex to synchronize recovery
>   PCI/DPC: Unify and plumb error handling into DPC
>   PCI/AER: Unify aer error defines at single space
>   PCI/DPC: Enumerate the devices after DPC trigger event
>   PCI: Unify wait for link active into generic pci

Please capitalize the subject lines consistently.

Please capitalize acronyms in English text, e.g., PCI, AER, DPC.

Please use a blank line between paragraphs in changelogs.

I have more comments on individual patches.
