Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40545 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdKWMLV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Nov 2017 07:11:21 -0500
Received: by mail-wr0-f194.google.com with SMTP id s41so11981573wrc.7
        for <linux-pci@vger.kernel.org>; Thu, 23 Nov 2017 04:11:21 -0800 (PST)
Subject: Re: [PATCH V2 24/29] backlight: deprecate pci_get_bus_and_slot()
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
 <1511390964-9979-25-git-send-email-okaya@codeaurora.org>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <337c09a3-08c9-8172-8430-3579aee20829@linaro.org>
Date: Thu, 23 Nov 2017 12:11:16 +0000
MIME-Version: 1.0
In-Reply-To: <1511390964-9979-25-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 22/11/17 22:49, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Hard-coding the domain as 0.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

I've no opinion on the wisdom or otherwise of removing the restrictive 
API but, providing the removal of that API from the header file collects 
the appropriate ack, then:

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/apple_bl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backlight/apple_bl.c
> index d843296..6a34ab9 100644
> --- a/drivers/video/backlight/apple_bl.c
> +++ b/drivers/video/backlight/apple_bl.c
> @@ -143,7 +143,7 @@ static int apple_bl_add(struct acpi_device *dev)
>   	struct pci_dev *host;
>   	int intensity;
>   
> -	host = pci_get_bus_and_slot(0, 0);
> +	host = pci_get_domain_bus_and_slot(0, 0, 0);
>   
>   	if (!host) {
>   		pr_err("unable to find PCI host\n");
> 
