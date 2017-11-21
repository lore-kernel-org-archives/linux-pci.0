Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.195]:56774 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbdKUNBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Nov 2017 08:01:32 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Niklas Cassel' <niklas.cassel@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Niklas Cassel <niklass@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: endpoint: use ffz() instead of find_first_zero_bit()
Date: Tue, 21 Nov 2017 13:01:48 +0000
Message-ID: <5d80ad3162fb4d02aac25f510b94d6c4@AcuMS.aculab.com>
References: <20171117094248.15265-1-niklas.cassel@axis.com>
In-Reply-To: <20171117094248.15265-1-niklas.cassel@axis.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Niklas Cassel
> Sent: 17 November 2017 09:43
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> Calling find_first_zero_bit() with the wrong size unit
> will lead to insidious bugs.
> 
> Fix this by using replacing find_first_zero_bit() with ffz(),
> since ffz() only works on a single 'unsigned long' and therefore
> does not need a size argument.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 4f74386c1ced..96b984685640 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -108,8 +108,7 @@ static int pci_epc_epf_link(struct config_item *epc_item,
>  	if (ret)
>  		goto err_add_epf;
> 
> -	func_no = find_first_zero_bit(&epc_group->function_num_map,
> -				      sizeof(epc_group->function_num_map));
> +	func_no = ffz(epc_group->function_num_map);
>  	set_bit(func_no, &epc_group->function_num_map);
>  	epf->func_no = func_no;

Is set_bit() now setting the correct bit?
I'd guess that:
	epc_group->function_num_map |= 1ul << func_no;
would be more accurate?

	David
