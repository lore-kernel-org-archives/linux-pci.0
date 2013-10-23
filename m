Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:48701
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751568Ab3JWHqm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2013 03:46:42 -0400
Date: Wed, 23 Oct 2013 15:46:27 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Tim Harvey <tharvey@gateworks.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: imx6: increase link startup
Message-ID: <20131023074618.GL2839@S2101-09.ap.freescale.net>
References: <1382505138-23286-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

Acked-by: Shawn Guo <shawn.guo@linaro.org>

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

