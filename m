Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.192]:62347 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdK1Jwz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Nov 2017 04:52:55 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Niklas Cassel' <niklas.cassel@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Niklas Cassel <niklass@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] PCI: endpoint: Fix find_first_zero_bit() usage
Date: Tue, 28 Nov 2017 09:53:12 +0000
Message-ID: <227791f09ccd4aa8972ba334fd948f4e@AcuMS.aculab.com>
References: <20171127154955.22214-1-niklas.cassel@axis.com>
 <20171127154955.22214-4-niklas.cassel@axis.com>
In-Reply-To: <20171127154955.22214-4-niklas.cassel@axis.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Niklas Cassel
> Sent: 27 November 2017 15:50
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> Calling find_first_zero_bit() with the wrong size unit
> will lead to insidious bugs.
> 
> Fix this by calling find_first_zero_bit() with size
> BITS_PER_LONG, rather than sizeof().
> 
> Also add proper error handling for find_first_zero_bit(),
> since this was missing.
> 
> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index e1f5adc9e113..0a22a7976580 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -109,7 +109,12 @@ static int pci_epc_epf_link(struct config_item *epc_item,
>  		return ret;
> 
>  	func_no = find_first_zero_bit(&epc_group->function_num_map,
> -				      sizeof(epc_group->function_num_map));
> +				      BITS_PER_LONG);

Surely this should be either 8 * sizeof() or you should use ffz()
that takes a numeric argument rather than the function designed
for arbitrary size bitmaps.

	David
