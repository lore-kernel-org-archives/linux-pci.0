Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55286 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbeIFIyk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 04:54:40 -0400
Message-ID: <74f9bd788d4c3d659eade8d30c4db5070fff9f6e.camel@kernel.crashing.org>
Subject: Re: [PATCHv2 20/20] PCI: Unify device inaccessible
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
        poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>,
        Christoph Hellwig <hch@lst.de>,
        Russell Currey <ruscur@au1.ibm.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 06 Sep 2018 14:20:35 +1000
In-Reply-To: <20180905203546.21921-21-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
         <20180905203546.21921-21-keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-09-05 at 14:35 -0600, Keith Busch wrote:
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 2264001f695b..1ee7206689b5 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -52,9 +52,9 @@ static int report_error_detected(struct pci_dev *dev,
>         const struct pci_error_handlers *err_handler;
>  
>         device_lock(&dev->dev);
> -       dev->error_state = state;
>  
> -       if (!dev->driver ||
> +       if (!cmpxchg(&dev->error_state, state, pci_channel_io_normal) ||
> +               !dev->driver ||
>                 !dev->driver->err_handler ||
>                 !dev->driver->err_handler->error_detected) {
>                 /*

(CC some of our folks)

Should we make this some kind of helper (pci_set_channel_state) ? We
should then use it in EEH and powerpc PAPR specific hotplug as well.

We could also implement the rule about the valid transition in the 
helper itself.

(Feel free to merge this patch as-is, what I suggest can be done on top
of this).

Cheers,
Ben.
