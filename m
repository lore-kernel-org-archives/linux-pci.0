Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730880AbeHIQk6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 12:40:58 -0400
Date: Thu, 9 Aug 2018 09:15:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
Message-ID: <20180809141551.GH49411@bhelgaas-glaptop.roam.corp.google.com>
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717153135.25925-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 17, 2018 at 10:31:23AM -0500, Alexandru Gagniuc wrote:
> When we don't own AER, we shouldn't touch the AER error bits. This
> happens unconditionally on device probe(). Clearing AER bits
> willy-nilly might cause firmware to miss errors. Instead
> these bits should get cleared by FFS, or via ACPI _HPX method.
> 
> This race is mostly of theoretical significance, as it is not easy to
> reasonably demonstrate it in testing.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/pcie/aer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e88386af28..18037a2a8231 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -383,6 +383,9 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return -ENODEV;
>  
> +	if (pcie_aer_get_firmware_first(dev))
> +		return -EIO;

I like this patch.

Do we need the same thing in the following places that also clear AER
status bits or write AER control bits?

  enable_ecrc_checking()
  disable_ecrc_checking()
  pci_cleanup_aer_uncorrect_error_status()
  pci_aer_clear_fatal_status()

>  	pos = dev->aer_cap;
>  	if (!pos)
>  		return -EIO;
> -- 
> 2.14.3
> 
