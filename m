Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58494 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab2HVRu3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Aug 2012 13:50:29 -0400
Received: by lbbgj3 with SMTP id gj3so807394lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 22 Aug 2012 10:50:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50303561.4020707@xenotime.net>
References: <50303561.4020707@xenotime.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 Aug 2012 10:50:07 -0700
Message-ID: <CAErSpo7yTV=+5o90xf6xe+zdEAqrGEMKG2QYy5aSWxtzMUMaJQ@mail.gmail.com>
Subject: Re: [PATCH] pci: fix drivers/pci/pci.c kernel-doc warnings
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 18, 2012 at 5:37 PM, Randy Dunlap <rdunlap@xenotime.net> wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> Fix kernel-doc warnings in drivers/pci/pci.c:
>
> Warning(drivers/pci/pci.c:1550): No description found for parameter 'pci_dev'
> Warning(drivers/pci/pci.c:1550): Excess function parameter 'dev' description in 'pci_wakeup'

Applied, thanks!

> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Cc:     Bjorn Helgaas <bhelgaas@google.com>
> Cc:     linux-pci@vger.kernel.org
> ---
>  drivers/pci/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-36-rc2.orig/drivers/pci/pci.c
> +++ lnx-36-rc2/drivers/pci/pci.c
> @@ -1543,7 +1543,7 @@ void pci_pme_wakeup_bus(struct pci_bus *
>
>  /**
>   * pci_wakeup - Wake up a PCI device
> - * @dev: Device to handle.
> + * @pci_dev: Device to handle.
>   * @ign: ignored parameter
>   */
>  static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
