Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753091AbdKHAhS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Nov 2017 19:37:18 -0500
Date: Tue, 7 Nov 2017 18:37:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: bhelgaas@google.com, linuxarm@huawei.com,
        linux-pci@vger.kernel.org, wangzhou1@hisilicon.com
Subject: Re: [PATCH] MAINTAINERS: Remove Gabriele Paoloni as HiSilicon PCI
 maintainer
Message-ID: <20171108003715.GD22847@bhelgaas-glaptop.roam.corp.google.com>
References: <1509624086-9076-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509624086-9076-1-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 02, 2017 at 12:01:26PM +0000, Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> Gabriele is now moving to a different role, therefore remove him
> as HiSilicon PCI maintainer
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks for all your help, Gabriele!

Applied to for-linus for v4.14 so you don't get spammed unnecessarily.

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af0cb69..6eb7141 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10471,7 +10471,6 @@ F:	drivers/pci/host/pci-thunder-*
>  
>  PCIE DRIVER FOR HISILICON
>  M:	Zhou Wang <wangzhou1@hisilicon.com>
> -M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> -- 
> 2.7.4
> 
> 
