Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E95DC282C6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 11:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097E4218AE
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 11:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfAXL5E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:57:04 -0500
Received: from foss.arm.com ([217.140.101.70]:55518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfAXL5E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 06:57:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB622EBD;
        Thu, 24 Jan 2019 03:57:03 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D864B3F237;
        Thu, 24 Jan 2019 03:57:01 -0800 (PST)
Date:   Thu, 24 Jan 2019 11:56:56 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
Message-ID: <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 07, 2019 at 02:45:09PM +0100, Koen Vandeputte wrote:
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
> Acked-by: Krzysztof Halasa <khalasa@piap.pl>
> Acked-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Olof Johansson <olof@lixom.net>
> CC: Robin Leblon <robin.leblon@ncentric.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Russell King <linux@armlinux.org.uk>
> CC: stable@vger.kernel.org # v4.0+
> ---
>  arch/arm/mach-cns3xxx/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I have applied both patches to pci/arm-cns3xxx for v5.1, however I had
to reformat and rewrite both logs (commit line wrappings,
capitalization, etc.) so have a look.

Thanks,
Lorenzo

> 
> 
> V2:
> --> resend to be in sync with new second patch
> --> added acked-by's based on patch comments
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
>  }
>  
>  static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
> -- 
> 2.17.1
> 
