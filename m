Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog123.obsmtp.com ([207.126.144.155]:41749 "EHLO
	eu1sys200aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844Ab3JPFzR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2013 01:55:17 -0400
Date: Wed, 16 Oct 2013 11:24:27 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Marek Vasut <marex@denx.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 5/6] PCI: imx6: Force Gen1 operation
Message-ID: <20131016055427.GB2740@pratyush-vbox>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <1381853200-5534-6-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1381853200-5534-6-git-send-email-marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 16, 2013 at 12:06:39AM +0800, Marek Vasut wrote:
> Without forcing the PCIe core into Gen1 operation, the PCIe switch
> attached directly to the PCIe port is not recognised at all. The
> PCIe switch is Gen2 capable to make this issue even more puzzling.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <lznuaa@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/host/pci-imx6.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index ca8c5de..8402e9a 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -321,6 +321,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>  {
>  	int count = 0;
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> +	uint32_t tmp;
>  
>  	imx6_pcie_assert_core_reset(pp);
>  
> @@ -330,13 +331,23 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>  
>  	dw_pcie_setup_rc(pp);
>  
> +	/*
> +	 * FIXME:
> +	 * Force Gen1 operation. In case the IP block is in Gen2 operation
> +	 * mode, it does not detect the PCIe switch at all.
> +	 */
> +	tmp = readl(pp->dbi_base + 0x7c);
> +	tmp &= ~0xf;
> +	tmp |= 0x1;
> +	writel(tmp, pp->dbi_base + 0x7c);
> +

Since you are forcing RC to work in GEN1, so you will not be able to
connect any device at GEN2 now.

Yes, There are some buggy PCIe devices which works with GEN1 only host.

So better solution should be to initialize RC by default at GEN2 or
highest speed. Further, a parameter say gen_only can be passed from
DT to force GEN1 only mode.

What do you say?

Regards
Pratyush

>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
>  
>  	while (!dw_pcie_link_up(pp)) {
>  		usleep_range(100, 1000);
>  		count++;
> -		if (count >= 10) {
> +		if (count >= 200) {
>  			dev_err(pp->dev, "phy link never came up\n");
>  			dev_dbg(pp->dev,
>  				"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> -- 
> 1.8.4.rc3
