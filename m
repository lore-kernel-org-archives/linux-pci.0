Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935985AbeFSVbX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jun 2018 17:31:23 -0400
Date: Tue, 19 Jun 2018 16:31:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCHv2 0/7] DPC updates
Message-ID: <20180619213121.GB33049@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402162203.3370-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180402162203.3370-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 02, 2018 at 10:21:56AM -0600, Keith Busch wrote:
> I am terribly sorry about the delay getting this back to you. I had some
> scheduling issues with test equipment and other unrelated conflicts.
> 
> I added Oza's legacy IRQ fix into this series, as I didn't see this
> staged yet, and it really does fix some issues as well as provide the
> means to clean up other parts.
> 
> I'm sending this later than I intended, but hoping you might see a way
> to including this to 4.17. I can rebase to 'next' where the file is
> renamed to 'dpc.c'.
> 
> Keith Busch (6):
>   PCI/DPC: Enable ERR_COR
>   PCI/DPC: Leave interrupts enabled while handling event
>   PCI/DPC: Defer event handling to work queue
>   PCI/DPC: Remove rp_pio_status from dpc struct
>   PCI/AER: API for obtaining AER information
>   PCI/DPC: Print AER status in DPC event handling
> 
> Oza Pawandeep (1):
>   PCI/DPC: Fix PCI legacy interrupt acknowledgement
> 
>  drivers/pci/pcie/aer/aerdrv.h      |   1 +
>  drivers/pci/pcie/aer/aerdrv_core.c |   8 +--
>  drivers/pci/pcie/pcie-dpc.c        | 106 +++++++++++++++++--------------------
>  include/uapi/linux/pci_regs.h      |   1 +
>  4 files changed, 55 insertions(+), 61 deletions(-)

Hi Keith, I'm sorry, with the exception of Oza's patch, I didn't get
these applied, and now they don't apply cleanly.  Would you mind
rebasing them to v4.18-rc1?

Bjorn
