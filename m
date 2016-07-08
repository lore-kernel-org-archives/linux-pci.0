Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58296 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbcGHJgZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2016 05:36:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Niklas Cassel <niklass@axis.com>
Subject: Re: [PATCH] bindings: PCI: artpec: correct pci binding example
Date: Fri, 08 Jul 2016 11:39:24 +0200
Message-ID: <1838529.X3K6mcn6MA@wuerfel>
In-Reply-To: <1467934090-12834-1-git-send-email-niklass@axis.com>
References: <1467934090-12834-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 8, 2016 1:28:10 AM CEST Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
>  - Increase config size. When using a PCIe switch,
>    the previous config size only had room for one device.
>  - Add bus range. Inherited optional property.
>  - Map downstream I/O to PCI address 0. We can map it to any
>    address, but let's be consistent with other drivers.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> index 330a45b..5ecaea1 100644
> --- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> @@ -24,16 +24,17 @@ Example:
>  		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
>  		reg = <0xf8050000 0x2000
>  		       0xf8040000 0x1000
> -		       0xc0000000 0x1000>;
> +		       0xc0000000 0x2000>;

If this is your config space size

>  		num-lanes = <2>;
> +		bus-range = <0x00 0xff>;

then the bus range looks too large. These two are typically connected.
I couldn't immediately see which config space access function is
used, but if you have 0x1000 bytes per bus, then the bus range matching
a 0x2000 byte config space would be either <0x00 0x01> or <0x00 0x02>
depending whether the root bus is part of that range.

	Arnd
