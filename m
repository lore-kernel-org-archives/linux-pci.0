Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46405 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab3J2WP3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 18:15:29 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so891721iec.14
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2013 15:15:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1382346403-29576-3-git-send-email-sachin.kamat@linaro.org>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org> <1382346403-29576-3-git-send-email-sachin.kamat@linaro.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 29 Oct 2013 16:15:07 -0600
Message-ID: <CAErSpo4Ao2PjbTt-XTyG3kfspMEdw09cOUdh=Lne1jpPcGr8LA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: exynos: Remove redundant of_match_ptr
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 21, 2013 at 3:06 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> This driver is DT only. Hence of_match_ptr is not required.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Jingoo Han <jg1.han@samsung.com>

Applied with Jingoo's ack to my pci/host-exynos branch for v3.13, thanks!

> ---
>  drivers/pci/host/pci-exynos.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index ee692c2..c4798fb 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -647,7 +647,7 @@ static struct platform_driver exynos_pcie_driver = {
>         .driver = {
>                 .name   = "exynos-pcie",
>                 .owner  = THIS_MODULE,
> -               .of_match_table = of_match_ptr(exynos_pcie_of_match),
> +               .of_match_table = exynos_pcie_of_match,
>         },
>  };
>
> --
> 1.7.9.5
>
