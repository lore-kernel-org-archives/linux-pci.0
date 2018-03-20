Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35747 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbeCTHW5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 03:22:57 -0400
Date: Tue, 20 Mar 2018 08:22:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Neuling <mikey@neuling.org>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Fix NULL ptr deref in EEH code
Message-ID: <20180320072255.GA15059@lst.de>
References: <20180320002242.10416-1-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180320002242.10416-1-mikey@neuling.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 20, 2018 at 11:22:42AM +1100, Michael Neuling wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b6f43b738f..404b346e3c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2626,6 +2626,9 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>  {
>  	struct nvme_dev *dev = pci_get_drvdata(pdev);
>  
> +	if (!dev)
> +		return PCI_ERS_RESULT_NEED_RESET;

This implies the method has been called before ->probe has been finished
or after ->remove has been called.  That would be fundamentally racy
and needs to be fixed in the PCI layer, not papered over in drivers.
