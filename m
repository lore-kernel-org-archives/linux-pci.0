Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34823 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933130AbbEMNXh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2015 09:23:37 -0400
Received: by pabtp1 with SMTP id tp1so50785909pab.2
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2015 06:23:36 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Zhou Wang'" <wangzhou1@hisilicon.com>
Cc: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Mohit Kumar'" <mohit.kumar@st.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>,
	"'Zhichang Yuan'" <yuanzhichang@hisilicon.com>,
	"'Zhang Jukuo'" <zhangjukuo@huawei.com>,
	"'Liguozhu'" <liguozhu@hisilicon.com>
Subject: Re: [PATCH] PCI: designware: Add 8 lanes support
Date: Wed, 13 May 2015 22:23:29 +0900
Message-ID: <000001d08d80$04aea8b0$0e0bfa10$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 13 May 2015 14:44:34 +0800, Zhou Wang wrote:
> This patch adds 8 lanes support. Following suggestion from Arnd, just split
> this patch from http://www.spinics.net/lists/linux-pci/msg40467.html
>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

+cc: Pratyush Anand

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pcie-designware.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 2e9f84f..4ce0aa5 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -31,6 +31,7 @@
>  #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
>  #define PORT_LINK_MODE_2_LANES		(0x3 << 16)
>  #define PORT_LINK_MODE_4_LANES		(0x7 << 16)
> +#define PORT_LINK_MODE_8_LANES		(0xf << 16)
>  
>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
>  #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
> @@ -38,6 +39,7 @@
>  #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
>  #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
>  #define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
> +#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
>  
>  #define PCIE_MSI_ADDR_LO		0x820
>  #define PCIE_MSI_ADDR_HI		0x824
> @@ -778,6 +780,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	case 4:
>  		val |= PORT_LINK_MODE_4_LANES;
>  		break;
> +	case 8:
> +		val |= PORT_LINK_MODE_8_LANES;
> +		break;
>  	}
>  	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
>  
> @@ -794,6 +799,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	case 4:
>  		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
>  		break;
> +	case 8:
> +		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
> +		break;
>  	}
>  	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
>  
> -- 
> 1.9.1

