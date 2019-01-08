Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68359C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FA920850
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546959816;
	bh=Ni2jY8BSlUw+zzt7FwhubZ0FnbgogMb5ITHx8PCr7Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fDvdEkxuD+TNEsVH2ZXoN8KvmiFzrLVt12yUJe+008T0zCO6YmDBjlcpbVUei4DnF
	 a89LuWpfrhF5j1C5aFO8z3NfiUGUKfTlJfRIg1r6B1LzXLLwKEWOSOYd3QBbea1xnJ
	 rJixONffktP3Ckq6hx+JE0FA8QDL4FuwCKVkj6J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfAHPDf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:03:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHPDf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 10:03:35 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6612B20827;
        Tue,  8 Jan 2019 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546959814;
        bh=Ni2jY8BSlUw+zzt7FwhubZ0FnbgogMb5ITHx8PCr7Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSCB//w5DwA84EPH7K4vetwRQx007y0QhwnfN0mGRqvui5mPa5zKj2K6HmJgQmw++
         SxPno4mEY18O08dH4fzeJdXZv/TuxRW0Pb7hEs4ycVPS1ia/FGqlFUB80kg44tIuTB
         AshZVdX6/woDkcQNoofjIoJzAt8XfCGhOl7Pq0Xs=
Date:   Tue, 8 Jan 2019 09:03:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] PCI: amlogic: Fix build failure due to missing gpio
 header
Message-ID: <20190108150333.GA96414@google.com>
References: <20190107172223.28881-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107172223.28881-1-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 07, 2019 at 05:22:23PM +0000, Lorenzo Pieralisi wrote:
> From: Corentin Labbe <clabbe@baylibre.com>
> 
> Building the driver when GPIOLIB=n is not selected is causing the
> following compilation failure:
> 
> drivers/pci/controller/dwc/pci-meson.c: In function 'meson_pcie_assert_reset':
> drivers/pci/controller/dwc/pci-meson.c:290:2: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
>   gpiod_set_value_cansleep(mp->reset_gpio, 0);
>   ^~~~~~~~~~~~~~~~~~~~~~~~
>   gpio_set_value_cansleep
> drivers/pci/controller/dwc/pci-meson.c: In function 'meson_pcie_probe':
> drivers/pci/controller/dwc/pci-meson.c:540:19: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
>   mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>                    ^~~~~~~~~~~~~~
>                    devm_gpio_free
> drivers/pci/controller/dwc/pci-meson.c:540:48: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
>   mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>                                                 ^~~~~~~~~~~~~
>                                                 GPIOF_INIT_LOW
> 
> Add the missing linux/gpio/consumer.h header to fix it.
> 
> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe
> controller driver")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> [lorenzo.pieralisi@arm.com: commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Applied to for-linus for v5.0, thanks!

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
