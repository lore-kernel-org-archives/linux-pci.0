Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39486 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbeFDBY6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2018 21:24:58 -0400
Received: by mail-pf0-f195.google.com with SMTP id r11-v6so7563291pfl.6
        for <linux-pci@vger.kernel.org>; Sun, 03 Jun 2018 18:24:58 -0700 (PDT)
Date: Sun, 3 Jun 2018 18:24:55 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-gpio@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: qcom: include gpio/consumer.h
Message-ID: <20180604012455.GA3374@builder>
References: <20180530215324.1178564-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530215324.1178564-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed 30 May 14:53 PDT 2018, Arnd Bergmann wrote:

> When CONFIG_GPIOLIB is disabled, we run into a build failure:
> 
> drivers/pci/dwc/pcie-qcom.c: In function 'qcom_pcie_probe':
> drivers/pci/dwc/pcie-qcom.c:1223:16: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
>   pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
> 
> Including gpio/consumer.h directly is the correct fix.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pci/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index b65bbf7c284e..17df19db851e 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -10,7 +10,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> -- 
> 2.9.0
> 
