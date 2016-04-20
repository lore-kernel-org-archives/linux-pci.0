Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35402 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbcDTRmp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 13:42:45 -0400
Date: Wed, 20 Apr 2016 10:42:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
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
Subject: Re: [PATCH 09/14] Input: touchscreen: Broadcom iProc: DT spelling
 s/clock-name/clock-names/
Message-ID: <20160420174241.GA28831@dtor-ws>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-10-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461166339-11109-10-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 20, 2016 at 05:32:14PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

> ---
>  .../devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> index 25541f30e38701f2..ac5dff412e25266f 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
> @@ -7,7 +7,7 @@ Required properties:
>    If this property is selected please make sure MFD_SYSCON config
>    is enabled in the defconfig file.
>  - clocks:  The clock provided by the SOC to driver the tsc
> -- clock-name:  name for the clock
> +- clock-names:  name for the clock
>  - interrupts: The touchscreen controller's interrupt
>  - address-cells: Specify the number of u32 entries needed in child nodes.
>    Should set to 1.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
