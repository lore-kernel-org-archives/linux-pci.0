Return-Path: <SRS0=5lyS=PH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28E3C43612
	for <linux-pci@archiver.kernel.org>; Sun, 30 Dec 2018 01:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9DB217F4
	for <linux-pci@archiver.kernel.org>; Sun, 30 Dec 2018 01:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546131991;
	bh=YtaPTXGknpyU/bcWB2uz0k5w2UEfoyeiuTnK+iJnJ/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TzcOqATNE4hndivQAUE5eawNJB/TCOvxFNXp2FJnzOreQLXxysYZ9uTHsFtLDvavC
	 Tr+mZRQm/8AMoQZ3pL56nXgc8DFGVh+yLS7zg1fYwPBYKGkHQPF02aITHzr8q7X/xl
	 TBHcZ+b5iPHQhtgl6L5E7H4ncVtQAKEN2dZWL6Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbeL3BGa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 29 Dec 2018 20:06:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbeL3BGa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Dec 2018 20:06:30 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A95B220866;
        Sun, 30 Dec 2018 01:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546131988;
        bh=YtaPTXGknpyU/bcWB2uz0k5w2UEfoyeiuTnK+iJnJ/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JutblmnK5sLieLI4VTbKTDtf7zYBSWqgOQ/YlAefQY1MBefA347szUcXUSFck0p7k
         vDZOv1g9oP9avd6eHV6X/6AMIZaI9zjQP96RYJpKLSCv4TVUQ/y/+U72gxOTJ2czX3
         1nIB/eOE/pT7eY8i6jxUnk7u3BMe7Vf6MYe8EBE0=
Date:   Sat, 29 Dec 2018 19:06:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
        Robin Leblon <robin.leblon@ncentric.com>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Halasa <khalasa@piap.pl>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
Message-ID: <20181230010625.GC159477@google.com>
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Tue, Dec 18, 2018 at 12:17:43PM +0100, Koen Vandeputte wrote:
> Originally, cns3xxx used it's own functions for mapping, reading and writing registers.
> 
> Commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> removed the internal PCI config write function in favor of the generic one:
> 
> cns3xxx_pci_write_config() --> pci_generic_config_write()
> 
> cns3xxx_pci_write_config() expected aligned addresses, being produced by cns3xxx_pci_map_bus()
> while the generic one pci_generic_config_write() actually expects the real address
> as both the function and hardware are capable of byte-aligned writes.
> 
> This currently leads to pci_generic_config_write() writing
> to the wrong registers on some ocasions.
> 
> First issue seen due to this:
> 
> - driver ath9k gets loaded
> - The driver wants to write value 0xA8 to register PCI_LATENCY_TIMER, located at 0x0D
> - cns3xxx_pci_map_bus() aligns the address to 0x0C
> - pci_generic_config_write() effectively writes 0xA8 into register 0x0C (CACHE_LINE_SIZE)
> 
> This seems to cause some slight instability when certain PCI devices are used.
> 
> Another issue example caused by this this is the PCI bus numbering,
> where the primary bus is higher than the secondary, which is impossible.
> 
> Before:
> 
> 00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 255
>     Bus: primary=02, secondary=01, subordinate=ff, sec-latency=0
> 
> After fix:
> 
> 00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
>     Flags: bus master, fast devsel, latency 0, IRQ 255
>     Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
> 
> And very likely some more ..
> 
> Fix all by omitting the alignment being done in the mapping function.
> 
> Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Krzysztof Halasa <khalasa@piap.pl>
> CC: Olof Johansson <olof@lixom.net>
> CC: Robin Leblon <robin.leblon@ncentric.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Russell King <linux@armlinux.org.uk>
> CC: Tim Harvey <tharvey@gateworks.com>
> CC: stable@vger.kernel.org # v4.0+
> ---
>  arch/arm/mach-cns3xxx/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
> index 318394ed5c7a..5e11ad3164e0 100644
> --- a/arch/arm/mach-cns3xxx/pcie.c
> +++ b/arch/arm/mach-cns3xxx/pcie.c
> @@ -83,7 +83,7 @@ static void __iomem *cns3xxx_pci_map_bus(struct pci_bus *bus,
>  	} else /* remote PCI bus */
>  		base = cnspci->cfg1_regs + ((busno & 0xf) << 20);
>  
> -	return base + (where & 0xffc) + (devfn << 12);
> +	return base + where + (devfn << 12);

802b7c06adc7 replaced cns3xxx_pci_write_config(), which always used
__raw_writel() so it only did 32-bit accesses, with
pci_generic_config_write(), which uses writeb/writew/writel()
depending on the size.

802b7c06adc7 also converted cns3xxx_pci_read_config() from always
using __raw_readl() (a 32-bit access) to using
pci_generic_config_read32(), which also always does a 32-bit access.

This makes me think the cnx3xxx hardware is only capable of 32-bit
accesses, and this patch should change the driver to use
pci_generic_config_write32() instead of pci_generic_config_write() in
addition to the mapping fix above.

What do you think?

I don't think hardware that only supports 32-bit PCI writes can be
quite spec-compliant (see the comments in
pci_generic_config_write32()).  So (1) you may see an additional
dmesg warning when you convert to use it, and (2) it's possible that
there may still be instability related to the corruption caused by
using a 32-bit write when an 8-bit write was intended.

>  }
>  
>  static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
