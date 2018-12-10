Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A3C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344FF2084C
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544467799;
	bh=YM43+q8aHIO7gaOpSGwBsHCIZ787wPnKuGrW4lQonjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eHatsZKyH9fGwgvIRqAHssAK9nm/FRPjy45S9P1a2JTeZLXt6dpLMvdjWclDEWEon
	 A9Khv2voreXqxCbfOoecfXqYDV8MdODIpw6zDm3UcRg2X6oEN1/c33Rd9hgD6KTe7S
	 WaOzgAXCTL7x67zXVmlwX5aUsdJe1NOPp5LGO/XM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344FF2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeLJSt6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:49:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeLJSt6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 13:49:58 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9472081F;
        Mon, 10 Dec 2018 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544467797;
        bh=YM43+q8aHIO7gaOpSGwBsHCIZ787wPnKuGrW4lQonjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maROWH64lrBwWWUOT27Yrr/oUjSBY1qQB1ZgtpHY+bxHAgYEV3dmpEwax9dfr+gWm
         hW+UV7bfL6PJJEOSGbcrWuFpTWD125uhXT/RkZ+oBvrm03fUEL6g9CwiyUMMgcSdlI
         pSqyEYcNdzhKtUtWpg4/X07o6XME1r5udPUa3Eyc=
Date:   Mon, 10 Dec 2018 12:49:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org, John Youn <john.youn@synopsys.com>
Subject: Re: [PATCH 1/2] pci: pci_ids: Move Synopsys HAPS platform device IDs
Message-ID: <20181210184954.GA47246@google.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 06:47:38PM -0700, Thinh Nguyen wrote:
> Move Synopsys HAPS platform device IDs to pci_ids.h.
> 
> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>

1) Run "git log --oneline include/linux/pci_ids.h" and follow the
style convention for patch subject.

2) Explain in the changelog why we're moving this to pci_ids.h.  Note
the comment at the top of pci_ids.h.  I think the move is fine because
you're using the definition in two places, so just mention that in the
changelog.

Thanks!

> ---
>  drivers/usb/dwc3/dwc3-haps.c | 4 ----
>  include/linux/pci_ids.h      | 3 +++
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-haps.c b/drivers/usb/dwc3/dwc3-haps.c
> index c9cc33881bef..02d57d98ef9b 100644
> --- a/drivers/usb/dwc3/dwc3-haps.c
> +++ b/drivers/usb/dwc3/dwc3-haps.c
> @@ -15,10 +15,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  
> -#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
> -#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
> -#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
> -
>  /**
>   * struct dwc3_haps - Driver private structure
>   * @dwc3: child dwc3 platform_device
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d157983b84cf..c48550aa67e3 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2354,6 +2354,9 @@
>  #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
>  
>  #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
> +#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
> +#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
> +#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
>  
>  #define PCI_VENDOR_ID_VITESSE		0x1725
>  #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
> -- 
> 2.11.0
> 
