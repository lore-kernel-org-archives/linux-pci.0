Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeIMB5i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Sep 2018 21:57:38 -0400
Date: Wed, 12 Sep 2018 15:51:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiecheng Wu <jasonwood2031@gmail.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH] dpc.c: fix missing return value check of
 pci_find_ext_capability()
Message-ID: <20180912205119.GL118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817081719.11156-1-jasonwood2031@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817081719.11156-1-jasonwood2031@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Keith, Sinan, Oza]

Please run "git log --oneline drivers/pci/pcie/dpc.c" and make your
subject match the existing style.

Also, please run "scripts/get_maintainer.pl -f drivers/pci/pcie/dpc.c" and 
cc people who seem interested in the file.

On Fri, Aug 17, 2018 at 04:17:19PM +0800, Jiecheng Wu wrote:
> Function dpc_probe() defined in drivers/pci/pcie/dpc.c calls pci_find_ext_capability(). Function pci_find_ext_capability() returns the address of the requested extended capability structure within the device's PCI configuration space or 0 if the device does not support it. The return value of this function should be checked against 0.

Needs a signed-off-by before I can apply it.  See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n416

> ---
>  drivers/pci/pcie/dpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f03279f..30ff550 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -226,6 +226,8 @@ static int dpc_probe(struct pcie_device *dev)
>  		return -ENOMEM;
>  
>  	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
> +	if (!dpc->cap_pos)
> +		return -ENODEV;

Keith is right that we shouldn't get here if there's no DPC
capability.  But it's a pain for readers to verify that because that
check is buried in the portdrv driver, so I'm not opposed to adding a
check here.

If we do add a check, I would move the pci_find_ext_capability() and
the check up above the devm_kzalloc().  I know devm will take care of
the cleanup, but I think it's better style to check for things that
require no cleanup first, before doing the things that do require
cleanup.

>  	dpc->dev = dev;
>  	set_service_data(dev, dpc);
>  
> -- 
> 2.6.4
> 
