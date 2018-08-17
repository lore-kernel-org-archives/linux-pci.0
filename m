Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQN6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2018 09:58:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 17 Aug 2018 16:25:23 +0530
From: poza@codeaurora.org
To: Jiecheng Wu <jasonwood2031@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH] dpc.c: fix missing return value check of
 pci_find_ext_capability()
In-Reply-To: <20180817081719.11156-1-jasonwood2031@gmail.com>
References: <20180817081719.11156-1-jasonwood2031@gmail.com>
Message-ID: <01c1740e09b6c970246da06ca792bbdf@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-17 13:47, Jiecheng Wu wrote:
> Function dpc_probe() defined in drivers/pci/pcie/dpc.c calls
> pci_find_ext_capability(). Function pci_find_ext_capability() returns
> the address of the requested extended capability structure within the
> device's PCI configuration space or 0 if the device does not support
> it. The return value of this function should be checked against 0.
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
nitpick: space here
>  	dpc->dev = dev;
>  	set_service_data(dev, dpc);

looks ok to me otherwise.

Regards,
Oza.
