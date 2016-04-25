Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56189 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbcDYNoP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Apr 2016 09:44:15 -0400
Date: Mon, 25 Apr 2016 08:44:09 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vinod Koul <vinod.koul@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 10/14] misc: sram: DT spelling
 s/#adress-cells/#address-cells/
Message-ID: <20160425134409.GA4060@rob-hp-laptop>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-11-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461166339-11109-11-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 20, 2016 at 05:32:15PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/sram/sram.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sram/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
> index 227e3a341af1e2b5..add48f09015e212e 100644
> --- a/Documentation/devicetree/bindings/sram/sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sram.txt
> @@ -51,7 +51,7 @@ sram: sram@5c000000 {
>  	compatible = "mmio-sram";
>  	reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
>  
> -	#adress-cells = <1>;
> +	#address-cells = <1>;
>  	#size-cells = <1>;
>  	ranges = <0 0x5c000000 0x40000>;
>  
> -- 
> 1.9.1
> 
