Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48427 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3J3QEq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2013 12:04:46 -0400
Received: by mail-ie0-f182.google.com with SMTP id as1so2634164iec.41
        for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2013 09:04:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Oct 2013 10:04:25 -0600
Message-ID: <CAErSpo4-gZRTub=vVbhKuYEo=kjC0rdOkEx=HmU4=m7B=uaidA@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: imx6: Remove redeundant of_match_ptr
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sean Cross <xobs@kosagi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 21, 2013 at 3:06 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> imx6_pcie_of_match is always compiled in. Hence of_match_ptr is
> not required.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Sean Cross <xobs@kosagi.com>

Applied with Shawn's ack to my pci/host-imx6 branch for v3.13, thanks.

> ---
>  drivers/pci/host/pci-imx6.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 5afa922..64aaa8e 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -558,7 +558,7 @@ static struct platform_driver imx6_pcie_driver = {
>         .driver = {
>                 .name   = "imx6q-pcie",
>                 .owner  = THIS_MODULE,
> -               .of_match_table = of_match_ptr(imx6_pcie_of_match),
> +               .of_match_table = imx6_pcie_of_match,
>         },
>  };
>
> --
> 1.7.9.5
>
