Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:53050 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbeHVNMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Aug 2018 09:12:52 -0400
Subject: Re: [PATCH v2] PCI: dwc: fix scheduling while atomic issues
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <20180821141512.368e3df2@xhacker.debian>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <ae663623-6af5-9c53-0e4b-f48b9c517a46@synopsys.com>
Date: Wed, 22 Aug 2018 10:45:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180821141512.368e3df2@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jisheng

On 21/08/2018 07:15, Jisheng Zhang wrote:
> When programming inbound/outbound atu, we call usleep_range() after
> each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
> can be called in atomic context:
> 
> inbound atu programming could be called through
> pci_epc_write_header()
>   =>dw_pcie_ep_write_header()
>     =>dw_pcie_prog_inbound_atu()
> 
> outbound atu programming could be called through
> pci_bus_read_config_dword()
>   =>dw_pcie_rd_conf()
>     =>dw_pcie_prog_outbound_atu()
> 
> Fix this issue by calling mdelay() instead.

Makes sense. Thanks.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Regards,
Gustavo

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> 
> Since v1
>  - use mdelay() instead of udelay() to avoid __bad_udelay()
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 778c4f76a884..2153956a0b20 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
>  }
> @@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  		if (val & PCIE_ATU_ENABLE)
>  			return;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
>  }
> @@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
>  
> @@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +		mdelay(LINK_WAIT_IATU);
>  	}
>  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 96126fd8403c..9f1a5e399b70 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -26,8 +26,7 @@
>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
> -#define LINK_WAIT_IATU_MIN		9000
> -#define LINK_WAIT_IATU_MAX		10000
> +#define LINK_WAIT_IATU			9
>  
>  /* Synopsys-specific PCIe configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
>
