Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AACC43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 22:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809F121783
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545085783;
	bh=lSD+pMv5BCxuqBRwD4xuvcm5bLs+cvixxRwPTqh+RVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WeL5Jf8rNxaT67FNzPlf7UKUbo2yyiB7ptnc39WXg0Yc99/kokHepmC5e6GbUrHMg
	 sYkj15l1vJsdJkg5MuplzqIUJ+nYNlrgENbvGoy6+IIWqN7sS3VIX2cAMHDkwEViGU
	 wEfg6G2ilGYIXlYsR2+N/sYRex6MQHcLuCjBdq08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbeLQW3m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:29:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731254AbeLQW3m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 17:29:42 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97142214C6;
        Mon, 17 Dec 2018 22:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545085781;
        bh=lSD+pMv5BCxuqBRwD4xuvcm5bLs+cvixxRwPTqh+RVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UoWezalb/xIqAfcDDTYGv3PaQ5NgH6VTQ/UXd0LjHfbJyUk1q1vUQBR1B4e4ncJjr
         lKulHr2ho2kVlJZ32GgvDZSGcxfqA4eRTLkZrwyVn+I3EZURiFj3s/lAAyFmgL5KW/
         evbdmUzHcSFlfQI1CuEBPmuRGHCPD3E7HmIhYQCA=
Date:   Mon, 17 Dec 2018 16:29:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        John Youn <john.youn@synopsys.com>
Subject: Re: [PATCH v2 2/2] PCI: Override Synopsys USB 3.x HAPS device class
Message-ID: <20181217222940.GE28981@google.com>
References: <3aa06c4e54bf98a59e510d7a833934fce4b0083b.1544478969.git.thinhn@synopsys.com>
 <8994fd7d7ee2bf5c1b32ce5bca25be4beb4405b5.1544478969.git.thinhn@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8994fd7d7ee2bf5c1b32ce5bca25be4beb4405b5.1544478969.git.thinhn@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 10, 2018 at 02:08:01PM -0800, Thinh Nguyen wrote:
> Synopsys USB 3.x host HAPS platform has a class code of
> PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these
> devices should use dwc3-haps driver. Change these devices' class code to
> PCI_CLASS_SERIAL_USB_DEVICE to prevent the xhci-pci driver from claiming
> them.
> 
> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>

I applied both of these to pci/misc for v4.21, thanks!

> ---
> Change in v2:
> - Revise title to fit PCI patches' convention
> - Override pci class instead of driver
> 
>  drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4700d24e5d55..c84f81c42a1f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -618,6 +618,32 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
>  		quirk_amd_nl_class);
>  
> +/*
> + * Synopsys USB 3.x host HAPS platform has a class code of
> + * PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these
> + * devices should use dwc3-haps driver. Change these devices' class code to
> + * PCI_CLASS_SERIAL_USB_DEVICE to prevent the xhci-pci driver from claiming
> + * them.
> + */
> +static void quirk_synopsys_haps(struct pci_dev *pdev)
> +{
> +	u32 class = pdev->class;
> +
> +	switch (pdev->device) {
> +	case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3:
> +	case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI:
> +	case PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31:
> +		pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
> +		pci_info(pdev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
> +			 class, pdev->class);
> +		break;
> +	default:
> +		return;

I dropped this "default: return;" because it's superfluous.

> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> +			 quirk_synopsys_haps);
> +
>  /*
>   * Let's make the southbridge information explicit instead of having to
>   * worry about people probing the ACPI areas, for example.. (Yes, it
> -- 
> 2.11.0
> 
