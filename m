Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35254 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbbJXAwE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2015 20:52:04 -0400
Subject: Re: [PATCH] pci: Update VPD size with correct length
To: Hannes Reinecke <hare@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
References: <1445591396-95395-1-git-send-email-hare@suse.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <562AD631.3040603@gmail.com>
Date: Fri, 23 Oct 2015 17:52:01 -0700
MIME-Version: 1.0
In-Reply-To: <1445591396-95395-1-git-send-email-hare@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/23/2015 02:09 AM, Hannes Reinecke wrote:
> PCI-2.2 VPD entries have a maximum size of 32k, but might actually
> be smaller than that. To figure out the actual size one has to read
> the VPD area until the 'end marker' is reached.
> Trying to read VPD data beyond that marker results in 'interesting'
> effects, from simple read errors to crashing the card.
> This path modifies the attribute size to the avialable VPD size.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/pci/access.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 6bc9b12..4f8208e 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -409,6 +409,34 @@ static int pci_vpd_f0_dev_check(struct pci_dev *dev)
>   	return ret;
>   }
>
> +/**
> + * pci_vpd_size - determine actual size of Vital Product Data
> + * @dev:	pci device struct
> + * @old_size:	current assumed size, also maximum allowed size
> + *
> + */
> +size_t
> +pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
> +{
> +	loff_t off = 0;
> +	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
> +
> +	while (off < old_size && pci_read_vpd(dev, off, 1, header)) {
> +		if (header[0] == 0x78)	/* End tag descriptor */
> +			return off + 1;
> +		if (header[0] & 0x80) {
> +			/* Large Resource Data Type Tag */
> +			if (pci_read_vpd(dev, off+1, 2, &header[1]) != 2)
> +				return off + 1;
> +			off += 3 + ((header[2] << 8) | header[1]);
> +		} else {
> +			/* Short Resource Data Type Tag */
> +			off += 1 + (header[0] & 0x07);
> +		}
> +	}
> +	return old_size;
> +}
> +

My understanding is that the end tag can have some data associated with 
it such as a checksum.  What you may want to look at doing is process 
long tag and short tag bits first.  Then you could do a mask and compare 
after and if ((header[0] & ~0x7) == 0x78) then you return off + 1.

Also I was wondering if you have looked at the cxgb4 network driver? 
They are using the vpd read/write calls to access their EEPROM and I 
assume they are doing so outside the actual VPD fields.

- Alex
