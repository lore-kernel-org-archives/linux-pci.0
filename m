Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.hostpark.net ([212.243.197.30]:33581 "EHLO
	mail.hostpark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605AbaGRLvG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jul 2014 07:51:06 -0400
Message-ID: <53C90895.6070109@elsoft.ch>
Date: Fri, 18 Jul 2014 13:44:21 +0200
From: =?UTF-8?B?IkRhdmlkIE3DvGxsZXIgKEVMU09GVCBBRyki?=
	<d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Lucas Stach <l.stach@pengutronix.de>
CC: Tim Harvey <tharvey@gateworks.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Richard Zhu <r65037@freescale.com>,
	Fabio Estevam <festevam@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>	 <20140626031247.GN2224@dragon>	 <CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>	 <20140626054937.GB7859@dragon>	 <CAJ+vNU0DNCT5pcvnptNBo-tPTVOH1HnrCwy7uCZt33dfyq8U-g@mail.gmail.com> <1405675599.6072.8.camel@weser.hi.pengutronix.de>
In-Reply-To: <1405675599.6072.8.camel@weser.hi.pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello

Lucas Stach wrote:
> @@ -215,6 +215,8 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>  			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> 

Sorry, this doesn't seem to fix the problem (at least not with my
hardware).

Dave

