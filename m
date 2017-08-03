Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:52924 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751988AbdHCJT6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:58 -0400
Subject: Re: [PATCH] PCI: qcom: Use gpiod_set_value_cansleep()
To: Fabio Estevam <festevam@gmail.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
References: <1500245798-20886-1-git-send-email-festevam@gmail.com>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <bca7f466-cd7d-99b5-f625-83b34aea7553@mm-sol.com>
Date: Thu, 3 Aug 2017 12:19:49 +0300
MIME-Version: 1.0
In-Reply-To: <1500245798-20886-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Thanks for the patch!

On 07/17/2017 01:56 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The reset GPIO can be connected to a I2C or SPI IO expander, which
> may sleep, so it is safer to use the gpiod_set_value_cansleep()
> variant instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/pci/dwc/pcie-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

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
> 
