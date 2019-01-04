Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CEAC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 10:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9045120652
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 10:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfADKaf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:30:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39604 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfADKae (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 05:30:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CF2EEBD;
        Fri,  4 Jan 2019 02:30:34 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78CC3F575;
        Fri,  4 Jan 2019 02:30:32 -0800 (PST)
Date:   Fri, 4 Jan 2019 10:30:25 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     bhelgaas@google.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: amlogic: fix build failure due to missing
 linux/gpio/consumer.h header
Message-ID: <20190104103015.GA3738@red-moon>
References: <1546592917-27846-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546592917-27846-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 04, 2019 at 09:08:37AM +0000, Corentin Labbe wrote:
> When building on x86, I got the following build failure:

Hi,

what tree are you testing on and which config ?

Thanks,
Lorenzo

> drivers/pci/controller/dwc/pci-meson.c: In function ‘meson_pcie_assert_reset’:
> drivers/pci/controller/dwc/pci-meson.c:290:2: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
>   gpiod_set_value_cansleep(mp->reset_gpio, 0);
>   ^~~~~~~~~~~~~~~~~~~~~~~~
>   gpio_set_value_cansleep
> drivers/pci/controller/dwc/pci-meson.c: In function ‘meson_pcie_probe’:
> drivers/pci/controller/dwc/pci-meson.c:540:19: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_gpio_free’? [-Werror=implicit-function-declaration]
>   mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>                    ^~~~~~~~~~~~~~
>                    devm_gpio_free
> drivers/pci/controller/dwc/pci-meson.c:540:48: error: ‘GPIOD_OUT_LOW’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_LOW’?
>   mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>                                                 ^~~~~~~~~~~~~
>                                                 GPIOF_INIT_LOW
> 
> This is due to the missing linux/gpio/consumer.h header
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 241ebe0c4505..e35e9eaa50ee 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
> -- 
> 2.19.2
> 
