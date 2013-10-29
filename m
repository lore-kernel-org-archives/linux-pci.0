Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46307 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab3J2WUk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 18:20:40 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so900199iec.14
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2013 15:20:39 -0700 (PDT)
Date: Tue, 29 Oct 2013 16:20:36 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>, Frank Li <lznuaa@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: imx6: increase link startup
Message-ID: <20131029222036.GB15159@google.com>
References: <1382505138-23286-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382505138-23286-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 22, 2013 at 10:12:18PM -0700, Tim Harvey wrote:
> An increase link startup delay is required when certain PCI switches are
> attached to the root complex.  This was tested with a Pericom switch
> and a PLX switch.
> 
> From: Marek Vasut <marex@denx.de>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Acked-by: Tim Harvey <tharvey@gateworks.com>

I applied this with Shawn's ack to my pci/host-imx6 branch for v3.13,
thanks!

I assume the intent was that this patch was written by Marek, per the
"From:" line you added above, so I fixed that in the patch so Marek
appears as the author.  Let me know if this is incorrect.

> ---
>  drivers/pci/host/pci-imx6.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 90fce05..34c571a 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -318,7 +318,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>  	while (!dw_pcie_link_up(pp)) {
>  		usleep_range(100, 1000);
>  		count++;
> -		if (count >= 10) {
> +		if (count >= 200) {
>  			dev_err(pp->dev, "phy link never came up\n");
>  			dev_dbg(pp->dev,
>  				"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> -- 
> 1.7.9.5
> 
