Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 Jun 2018 12:45:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-gpio@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: qcom: include gpio/consumer.h
Message-ID: <20180604174526.GA30381@bhelgaas-glaptop.roam.corp.google.com>
References: <20180530215324.1178564-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530215324.1178564-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 11:53:06PM +0200, Arnd Bergmann wrote:
> When CONFIG_GPIOLIB is disabled, we run into a build failure:
> 
> drivers/pci/dwc/pcie-qcom.c: In function 'qcom_pcie_probe':
> drivers/pci/dwc/pcie-qcom.c:1223:16: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
>   pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
> 
> Including gpio/consumer.h directly is the correct fix.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied with the other Bjorn's reviewed-by to pci/host/qcom for v4.18,
thanks!

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
