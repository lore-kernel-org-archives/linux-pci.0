Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:45933 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757538AbbA2CSV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jan 2015 21:18:21 -0500
Received: by mail-oi0-f52.google.com with SMTP id h136so22404393oig.11
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2015 18:18:21 -0800 (PST)
Date: Wed, 28 Jan 2015 09:17:12 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Halasa <khalasa@piap.pl>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] ARM: cns3xxx: fix typo in PCI config accessor
Message-ID: <20150128151712.GA12050@google.com>
References: <2000255.rnmr9HfSOg@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2000255.rnmr9HfSOg@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 28, 2015 at 02:53:07PM +0100, Arnd Bergmann wrote:
> The recent patch to convert the cns3xxx PCI code added an
> extraneous opening bracket, which makes the build fail,
> so remove this.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 10e2c5540d48 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
> ---
> 
> Hi Bjorn,
> 
> The broken patch just showed up in linux-next. Please apply this one on top,
> or fold it into the original patch if you don't mind rebasing.

I folded it in, thanks!  I guess Fengguang's autobuilder must not build
this config, because I got a success report from it.

> diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
> index e41fc339d100..c622c306c390 100644
> --- a/arch/arm/mach-cns3xxx/pcie.c
> +++ b/arch/arm/mach-cns3xxx/pcie.c
> @@ -101,7 +101,7 @@ static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
>  		 * for a PCIe bridge. So we must fixup the class code
>  		 * to 0x604 here.
>  		 */
> -		*val = (((((*val << shift) & 0xff) | (0x604 << 16)) >> shift) & mask;
> +		*val = ((((*val << shift) & 0xff) | (0x604 << 16)) >> shift) & mask;
>  
>  	return ret;
>  }
> 
