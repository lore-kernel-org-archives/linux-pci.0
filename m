Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:41347 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab3LNQJo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Dec 2013 11:09:44 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so4498601iej.40
        for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2013 08:09:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPgLHd_kw4PNiJOCmiDBG2R86UPpD0DJRBtcD4WRVpzVdmjG1Q@mail.gmail.com>
References: <CAPgLHd_kw4PNiJOCmiDBG2R86UPpD0DJRBtcD4WRVpzVdmjG1Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 14 Dec 2013 09:09:22 -0700
Message-ID: <CAErSpo6V7HD5AcGUr4Wt+XmXTytd7VVJ=kvb1zwvF7hi3zuP8g@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: msi: fix sparse non static symbol warning
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 13, 2013 at 9:44 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fixes the following sparse warnings:
>
> drivers/pci/msi.c:119:6: warning:
>  symbol 'default_restore_msi_irq' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks, this is already fixed in my "next" branch.  Let me know if you
find otherwise.

Bjorn

> ---
>  drivers/pci/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index c0baa3d..3fcc1e6 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -116,7 +116,7 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
>         return default_teardown_msi_irqs(dev);
>  }
>
> -void default_restore_msi_irq(struct pci_dev *dev, int irq)
> +static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>  {
>         struct msi_desc *entry;
>
>
