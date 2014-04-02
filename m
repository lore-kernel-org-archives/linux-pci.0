Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35935 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755075AbaDBE5V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Apr 2014 00:57:21 -0400
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Jingoo Han <jg1.han@samsung.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	"'Marek Vasut'" <marex@denx.de>,
	"'Richard Zhu'" <r65037@freescale.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>
Date: Wed, 2 Apr 2014 12:57:00 +0800
Subject: RE: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FEB13752@EAPEX1MAIL1.st.com>
References: <000801cf4d95$64322ef0$2c968cd0$%han@samsung.com>
In-Reply-To: <000801cf4d95$64322ef0$2c968cd0$%han@samsung.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Jingoo,

> -----Original Message-----
> From: Jingoo Han [mailto:jg1.han@samsung.com]
> Sent: Tuesday, April 01, 2014 4:00 PM
> To: 'Bjorn Helgaas'
> Cc: linux-pci@vger.kernel.org; Mohit KUMAR DCG; Pratyush ANAND; 'Marek
> Vasut'; 'Richard Zhu'; 'Kishon Vijay Abraham I'; 'Jingoo Han'
> Subject: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
> 
> According to the spec, the synopsys core does not implement the optional
> BARs such as BAR0/1. This is based on the assumption that the RC host
> probably has registers on some other internal bus and has knowledge and
> setup access to these registers already.
> So, remove unnecessary RC BAR setting.
> 
- Normally BARs in RC are not used but somehow available in the design. One possible
BAR use can be if RC has some memory connected to the BAR that needs to be accessed through link.

Otherwise we can ignore BARs setup here.

Thanks
Mohit
 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Tested on Exynos5440.
> 
>  drivers/pci/host/pcie-designware.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> index 6d23d8c..7bee01f 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -798,10 +798,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	}
>  	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
> 
> -	/* setup RC BARs */
> -	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
> -	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
> -
>  	/* setup interrupt pins */
>  	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
>  	val &= 0xffff00ff;
> --
> 1.7.10.4
> 

