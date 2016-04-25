Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56352 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637AbcDYNpG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Apr 2016 09:45:06 -0400
Date: Mon, 25 Apr 2016 08:45:00 -0500
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
Subject: Re: [PATCH 12/14] phy: phy-stih41x-usb: DT spelling
 s/#phy-cell/#phy-cells/
Message-ID: <20160425134500.GA5523@rob-hp-laptop>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-13-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461166339-11109-13-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 20, 2016 at 05:32:17PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
> index 00944a05ee6b4998..744b4809542edd3b 100644
> --- a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
> @@ -17,7 +17,7 @@ Example:
>  
>  usb2_phy: usb2phy@0 {
>  	compatible	= "st,stih416-usb-phy";
> -	#phy-cell	= <0>;
> +	#phy-cells	= <0>;
>  	st,syscfg	= <&syscfg_rear>;
>  	clocks		= <&clk_sysin>;
>  	clock-names	= "osc_phy";
> -- 
> 1.9.1
> 
