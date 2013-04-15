Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:44774 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648Ab3DOUTj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2013 16:19:39 -0400
Received: by mail-oa0-f53.google.com with SMTP id m6so1319317oag.26
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2013 13:19:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2415503.p0WDU1yixb@vostro.rjw.lan>
References: <2415503.p0WDU1yixb@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 15 Apr 2013 14:19:18 -0600
Message-ID: <CAErSpo7UMyyVwkR-j0URYtzzDw51EfT48yzCzbZp87ek7axORw@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Make pci_pme_active() ignore devices without
 PME support
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 10, 2013 at 2:32 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make pci_pme_active() ignore devices without PME support, so that
> it doesn't print the "PME enabled" or "PME disabled" debug messages
> for devices that don't support PME.
>
> So that pci_pme_active() doesn't have to check pm_cap in addition
> to pme_support, make pci_pm_init() clear pme_support upfront to
> make sure that it will be 0 for pm_cap equal to 0.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/rafael-pm
for v3.10.

Thanks!

> ---
>  drivers/pci/pci.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1575,7 +1575,7 @@ void pci_pme_active(struct pci_dev *dev,
>  {
>         u16 pmcsr;
>
> -       if (!dev->pm_cap)
> +       if (!dev->pme_support)
>                 return;
>
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> @@ -1924,6 +1924,7 @@ void pci_pm_init(struct pci_dev *dev)
>         dev->wakeup_prepared = false;
>
>         dev->pm_cap = 0;
> +       dev->pme_support = 0;
>
>         /* find PCI PM capability in list */
>         pm = pci_find_capability(dev, PCI_CAP_ID_PM);
> @@ -1975,8 +1976,6 @@ void pci_pm_init(struct pci_dev *dev)
>                 device_set_wakeup_capable(&dev->dev, true);
>                 /* Disable the PME# generation functionality */
>                 pci_pme_active(dev, false);
> -       } else {
> -               dev->pme_support = 0;
>         }
>  }
>
>
