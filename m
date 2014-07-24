Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34578 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758463AbaGXDpQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 23:45:16 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N97005BV6FETBA0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 24 Jul 2014 12:45:14 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Richard Zhu' <r65037@freescale.com>,
	'Shawn Guo' <shawn.guo@freescale.com>, kernel@pengutronix.de,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1406137217-11294-1-git-send-email-l.stach@pengutronix.de>
 <1406137217-11294-2-git-send-email-l.stach@pengutronix.de>
In-reply-to: <1406137217-11294-2-git-send-email-l.stach@pengutronix.de>
Subject: Re: [PATCH 1/3] MAINTAINERS: add myself as co-maintainer for i.MX6 PCI
 driver
Date: Thu, 24 Jul 2014 12:45:13 +0900
Message-id: <001001cfa6f1$ad1ef4d0$075cde70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 24, 2014 2:40 AM, Lucas Stach wrote:
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> I've talked privately to Richard about this and he's
> in favor, but still should give an public ACK.

OK, I see. I also think that you are the proper person for
maintaining the i.MX6 PCI driver.

Acked-by: Jingoo Han <jg1.han@samsung.com>

However, you still need the ACK from Richard Zhu or Shawn Guo.

Best regards,
Jingoo Han

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 134483f206e4..54c23c4fcbb0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6775,6 +6775,7 @@ F:	arch/x86/kernel/quirks.c
>  PCI DRIVER FOR IMX6
>  M:	Richard Zhu <r65037@freescale.com>
>  M:	Shawn Guo <shawn.guo@linaro.org>
> +M:	Lucas Stach <l.stach@pengutronix.de>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> --
> 2.0.1

