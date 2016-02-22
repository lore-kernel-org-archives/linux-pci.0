Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58735 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbcBVT5R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 14:57:17 -0500
Date: Mon, 22 Feb 2016 13:57:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, Babu Moger <babu.moger@oracle.com>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Subject: Re: [PATCHv3 4/4] pci: Blacklist vpd access for buggy devices
Message-ID: <20160222195713.GA3134@localhost>
References: <1455525722-122040-1-git-send-email-hare@suse.de>
 <1455525722-122040-5-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455525722-122040-5-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 15, 2016 at 09:42:02AM +0100, Hannes Reinecke wrote:
> From: Babu Moger <babu.moger@oracle.com>
> 
> Reading or Writing of PCI VPD data causes system panic.
> We saw this problem by running "lspci -vvv" in the beginning.
> However this can be easily reproduced by running
>  cat /sys/bus/devices/XX../vpd
> 
> As even a simple read on any VPD data triggers a system
> lockup on certain cards this patch implements a PCI quirk
> to disabling VPD acces altogether.
> This is done by setting the by setting the vpd length
> to '0' initially for those devices, which will then inhibit
> access completely..

IIRC, Babu was going to open bugzillas with details about the actual
falures.  I'd like references to them here.

> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/pci/access.c |  4 ++--
>  drivers/pci/quirks.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 253e0c8..8b6f5a2 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -393,7 +393,7 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
>  	if (pos < 0)
>  		return -EINVAL;
>  
> -	if (!vpd->valid) {
> +	if (!vpd->valid && vpd->base.len > 0) {
>  		vpd->valid = true;
>  		vpd->base.len = pci_vpd_pci22_size(dev, vpd->base.len);
>  	}
> @@ -459,7 +459,7 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
>  	if (pos < 0 || (pos & 3) || (count & 3))
>  		return -EINVAL;
>  
> -	if (!vpd->valid) {
> +	if (!vpd->valid && vpd->base.len > 0) {

I think these changes to pci_vpd_pci22_read() and
pci_vpd_pci22_write() are unnecessary because pci_vpd_pci22_size()
already returns 0 when you pass 0 to it.

>  		vpd->valid = true;
>  		vpd->base.len = pci_vpd_pci22_size(dev, vpd->base.len);
>  	}
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0575a1e..df1178f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2135,6 +2135,49 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
>  
>  /*
> + * A read/write to sysfs entry ('/sys/bus/pci/devices/<id>/vpd')
> + * will dump 32k of data. The default length is set as 32768.
> + * Reading a full 32k will cause an access beyond the VPD end tag.
> + * The system behaviour at that point is mostly unpredictable.
> + * Apparently, some vendors have not implemented this VPD headers properly.
> + * Adding a generic function disable vpd data for these buggy adapters
> + * Add the DECLARE_PCI_FIXUP_FINAL line below with the specific with
> + * vendor and device of interest to use this quirk.
> + */
> +static void quirk_blacklist_vpd(struct pci_dev *dev)
> +{
> +	if (dev->vpd) {
> +		dev->vpd->len = 0;
> +		dev_warn(&dev->dev, "PCI vpd access has been disabled due to firmware bug\n");
> +	}
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f,
> +		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
> +		quirk_blacklist_vpd);
> +
> +/*
>   * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
>   * VPD end tag will hang the device.  This problem was initially
>   * observed when a vpd entry was created in sysfs
> -- 
> 1.8.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
