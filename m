Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33967 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933233Ab2KEWar (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2012 17:30:47 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so4276393wgb.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2012 14:30:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1348016824-1895-1-git-send-email-airlied@redhat.com>
References: <1348016824-1895-1-git-send-email-airlied@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Nov 2012 15:30:25 -0700
Message-ID: <CAErSpo5Kz5fB35_3CJSSQVC2c3RYur_tgM2ULzoDOmJ+s8xwPA@mail.gmail.com>
Subject: Re: [PATCH] pci: don't touch card regs after runtime suspend D3
To: Dave Airlie <airlied@redhat.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2012 at 7:07 PM, Dave Airlie <airlied@redhat.com> wrote:
> If the driver takes care of state saving, don't touch any registers on it.
>
> Optimus (dual-gpu) laptops seem to have their own form of D3cold, but
> unfortunately enter it on normal D3 transitions via the ACPI callback.
>
> So when we use runtime PM to transition to D3, the card disappears off
> the PCI bus, however we then try to access registers on it in the
> runtime suspend finish, which really doesn't work.
>
> This patch check is the pci state is saved and doesn't attempt to hit
> any registers after that point if it is.
>
> (Looks okay to Rafael)
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>

I applied this to my pci/misc branch as v3.8 material.

Let me know if this should be v3.7 material or if it needs to be
backported to -stable (and how far if so).

> ---
>  drivers/pci/pci-driver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 5270f1a..214a40b 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1057,10 +1057,11 @@ static int pci_pm_runtime_suspend(struct device *dev)
>                 return 0;
>         }
>
> -       if (!pci_dev->state_saved)
> +       if (!pci_dev->state_saved) {
>                 pci_save_state(pci_dev);
>
> -       pci_finish_runtime_suspend(pci_dev);
> +               pci_finish_runtime_suspend(pci_dev);
> +       }
>
>         return 0;
>  }
> --
> 1.7.12
>
