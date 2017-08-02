Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdHBVn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:43:56 -0400
Date: Wed, 2 Aug 2017 16:43:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] PCI: qcom: Use gpiod_set_value_cansleep()
Message-ID: <20170802214351.GL20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1500245798-20886-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500245798-20886-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 16, 2017 at 07:56:38PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The reset GPIO can be connected to a I2C or SPI IO expander, which
> may sleep, so it is safer to use the gpiod_set_value_cansleep()
> variant instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Any opinion, Stanimir?

> ---
>  drivers/pci/dwc/pcie-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 68c5f2a..8359de0 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -141,13 +141,13 @@ struct qcom_pcie {
>  
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
> -	gpiod_set_value(pcie->reset, 1);
> +	gpiod_set_value_cansleep(pcie->reset, 1);
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
>  static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>  {
> -	gpiod_set_value(pcie->reset, 0);
> +	gpiod_set_value_cansleep(pcie->reset, 0);
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
> -- 
> 2.7.4
> 
