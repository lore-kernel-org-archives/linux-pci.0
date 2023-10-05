Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57203E92FC9
	for <linux-pci@archiver.kernel.org>; Thu,  5 Oct 2023 22:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjJEWvK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Oct 2023 18:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjJEWvJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 18:51:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D5DE;
        Thu,  5 Oct 2023 15:51:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C844C433C7;
        Thu,  5 Oct 2023 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696546263;
        bh=6Z+aNRTykgUl2shYjBKN3j99iPvZlR6BDg/SD2cELU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MNukphMSInGVUe6e01X0aki2ed92AZyanoAXS1Tse2jkA9W3Ip2Vrq3qZXUuWFeAm
         5THAUEv1ZFV7lRkX73pa5wFZbrMZVnBtOOADNoSVhDoSwvQbgRCf2ReCyg2FU8JDiw
         hJBi1H9FhrZ6OnSz/lmhK+ZlshRSG+Z1VQ5zHtoIInARuChulTjTyRksLL+HT8wYwb
         /b2wAQVwnnFrh5H08XEA415LtQagTLgi6HT7mMLSLLrpdJGnm+chWdfYEO2Pvwz94V
         kz4ubbn+i563g6Wk23YSZYGgBg7iCQAhlJKyFUj281GiAyrIznmNiSXnDuSpnsUr5o
         bPn9QBR7/7oXQ==
Date:   Thu, 5 Oct 2023 17:51:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [-next 1/5] PCI: Add the pci_is_vga() helper
Message-ID: <20231005225101.GA792747@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830111532.444535-2-sui.jingfeng@linux.dev>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 30, 2023 at 07:15:28PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> The PCI code and ID assignment specification defined four types of
> display controllers for the display base class(03h), and the devices
> with 0x00h sub-class code are VGA devices. VGA devices with programming

I can update this with the spec details (PCI Code and Assignment spec
r1.15, secs 1.1 and 1.4).

> interface 0x00 is VGA-compatible, VGA devices with programming interface
> 0x01 are 8514-compatible controllers. Besides, PCI_CLASS_NOT_DEFINED_VGA
> is defined to provide backward compatibility for devices that were built
> before the class code field was defined. Hence, introduce the pci_is_vga()
> helper, let it handle the details for us. It returns true if the PCI(e)
> device being tested belongs to the VGA devices category.
>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  include/linux/pci.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cf6e0b057752..ace727001911 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -713,6 +713,33 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
>  		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
>  }
>  
> +/**
> + * The PCI code and ID assignment specification defined four types of
> + * display controllers for the display base class(03h), and the devices
> + * with 0x00h sub-class code are VGA devices. VGA devices with programming
> + * interface 0x00 is VGA-compatible, VGA devices with programming interface
> + * 0x01 are 8514-compatible controllers. Besides, PCI_CLASS_NOT_DEFINED_VGA
> + * is defined to provide backward compatibility for devices that were built
> + * before the class code field was defined. This means that it belong to the
> + * VGA devices category also.
> + *
> + * Returns:
> + * true if the PCI device is a VGA device, false otherwise.
> + */
> +static inline bool pci_is_vga(struct pci_dev *pdev)
> +{
> +	if (!pdev)
> +		return false;
> +
> +	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> +		return true;
> +
> +	if ((pdev->class >> 8) == PCI_CLASS_NOT_DEFINED_VGA)
> +		return true;

Are you seeing a problem that will be fixed by this series, i.e., a
PCI_CLASS_NOT_DEFINED_VGA device that we currently don't handle
correctly?

I think this makes sense per the spec, but there's always a risk of
breaking something, so it's nice if the change actually *fixes*
something to make that risk worthwhile.

> +	return false;
> +}
> +
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>  		if (!pci_is_bridge(dev)) {} else
> -- 
> 2.34.1
> 
