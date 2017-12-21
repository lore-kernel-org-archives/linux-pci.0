Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45900 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdLUQjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Dec 2017 11:39:41 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Pankaj Dubey'" <pankaj.dubey@samsung.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>
References: <CGME20171012075438epcas2p32599c2db4ed1512c81d1039bb1ed5607@epcas2p3.samsung.com> <1507794889-11148-1-git-send-email-pankaj.dubey@samsung.com>
In-Reply-To: <1507794889-11148-1-git-send-email-pankaj.dubey@samsung.com>
Subject: Re: [PATCH] PCI: dwc: designware: don't sleep in atomic context
Date: Thu, 21 Dec 2017 11:39:38 -0500
Message-ID: <000301d37a7a$4b9681f0$e2c385d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, October 12, 2017 3:55 AM, Pankaj Dubey wrote:
> 
> In pcie-designware.c many places we are calling "usleep_range" which
> are in atomic context. This patch fixes these potential BUGs and
> replaces "usleep_range" with mdelay calls.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Sorry for my late response.

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/dwc/pcie-designware.c | 8 ++++----
>  drivers/pci/dwc/pcie-designware.h | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-
> designware.c
> index 88abddd..35d19b9 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -138,7 +138,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct
> dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
> 
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU_MIN);
>  	}
>  	dev_err(pci->dev, "outbound iATU is not being enabled\n");
>  }
> @@ -181,7 +181,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> int index, int type,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
> 
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU_MIN);
>  	}
>  	dev_err(pci->dev, "outbound iATU is not being enabled\n");
>  }
> @@ -239,7 +239,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct
> dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
> 
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU_MIN);
>  	}
>  	dev_err(pci->dev, "inbound iATU is not being enabled\n");
> 
> @@ -285,7 +285,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int
> index, int bar,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
> 
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU_MIN);
>  	}
>  	dev_err(pci->dev, "inbound iATU is not being enabled\n");
> 
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-
> designware.h
> index e5d9d77..13c17c9 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -28,8 +28,7 @@
> 
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
> -#define LINK_WAIT_IATU_MIN		9000
> -#define LINK_WAIT_IATU_MAX		10000
> +#define LINK_WAIT_IATU_MIN		9
> 
>  /* Synopsys-specific PCIe configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
> --
> 2.7.4
