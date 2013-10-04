Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:41198 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3JDSJn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 14:09:43 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so9775289iej.20
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2013 11:09:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380363121-1977-2-git-send-email-sachin.kamat@linaro.org>
References: <1380363121-1977-1-git-send-email-sachin.kamat@linaro.org> <1380363121-1977-2-git-send-email-sachin.kamat@linaro.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 4 Oct 2013 12:09:22 -0600
Message-ID: <CAErSpo6nO_t9HOZt8Z7S8Ca7yKjntWJWEg7uON05LmvHWEieZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: driver: Staticize pci_dev_pm_ops
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 28, 2013 at 4:12 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'pci_dev_pm_ops' is local to this file. Make it static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied to pci/misc, thanks!

Bjorn

> ---
>  drivers/pci/pci-driver.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 38f3c01..653c8c5 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1124,7 +1124,7 @@ static int pci_pm_runtime_idle(struct device *dev)
>
>  #ifdef CONFIG_PM
>
> -const struct dev_pm_ops pci_dev_pm_ops = {
> +static const struct dev_pm_ops pci_dev_pm_ops = {
>         .prepare = pci_pm_prepare,
>         .complete = pci_pm_complete,
>         .suspend = pci_pm_suspend,
> --
> 1.7.9.5
>
