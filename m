Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA8C5ACCC
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 15:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518DC21476
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 15:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518DC21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeJRXKZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:10:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44295 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeJRXKZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Oct 2018 19:10:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id p23so30065814otf.11;
        Thu, 18 Oct 2018 08:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vj/ZwtQ2Ma4iJ7zwt0qHBGZvtABqocHjHPGWuAMHPeI=;
        b=ou28gPAWVDIwLzjY4cZgoj/8jUCFFOxR36Po7kr59UOy9ZxAoar1vTS9h7wbHo8lD7
         RotFNKlf1q54JSq42X9SHG35sC7itiurbYe1mkY7qSoxJe7CGFiifJZ569dpU0tn1Eu4
         U7dszjj2ogDQML5I10TgNRkwNfzA65Woo9YC3TDjQ7QkO8F5yLOFi+y4efohrMUzDVYn
         bo1v1QCRxfN1X8Vy4p9IfsQa++c/zgHwg/HBxYw2fO6BHYlyhWenzlq1Ftv7IkJG4G6S
         dH+KdLO2ds1ixfR7jFgLDH8cSEA7ML3nzYDMGo/1l3nnJWwvlYss46G31Q/f/+vNhKVa
         FHPQ==
X-Gm-Message-State: ABuFfoiMiFz6R/0EljfYpQCiefmHZoJGoXg6ObnjMjl4XCHhsBR1Mt3p
        RJowmxCoUjrhINM5JhQTsN4XnYlpIxKwCz+1Kx4=
X-Google-Smtp-Source: ACcGV63xhfoCdxPzTZFDAtkzau2Bqmv7bpo4xePjxq8/DGH9p1xMCTzwCCXz1anl3eLOi4Gd267242IuD9x1i3jRsXA=
X-Received: by 2002:a9d:4590:: with SMTP id x16mr20664913ote.258.1539875337836;
 Thu, 18 Oct 2018 08:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
In-Reply-To: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Oct 2018 17:08:46 +0200
Message-ID: <CAJZ5v0jyS+E_tzpoRs1uvet_ydZphqfLQ0012Q0RroYk+C67Wg@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 18, 2018 at 2:30 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> Allow PCI core to do runtime PM to devices without needing to use dummy
> runtime PM callback functions if there is no need to do anything device
> specific beyond PCI device power state management.
>
> Implement this by letting core to change device power state during
> runtime PM transitions even if no callback functions are defined.
>
> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> This is related to my i2c-i801.c fix thread back in June which I completely
> forgot till now: https://lkml.org/lkml/2018/6/27/642
> Discussion back then was that it should be handled in the PCI PM instead
> of having dummy functions in the drivers. I wanted to respin with a
> patch.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci-driver.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..6185b878ede1 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1239,7 +1239,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>         pci_power_t prev = pci_dev->current_state;
> -       int error;
> +       int error = 0;
>
>         /*
>          * If pci_dev->driver is not set (unbound), we leave the device in D0,
> @@ -1251,11 +1251,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
>                 return 0;
>         }
>
> -       if (!pm || !pm->runtime_suspend)
> -               return -ENOSYS;
> -
>         pci_dev->state_saved = false;
> -       error = pm->runtime_suspend(dev);
> +       if (pm && pm->runtime_suspend)
> +               error = pm->runtime_suspend(dev);
>         if (error) {
>                 /*
>                  * -EBUSY and -EAGAIN is used to request the runtime PM core
> @@ -1292,7 +1290,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>
>  static int pci_pm_runtime_resume(struct device *dev)
>  {
> -       int rc;
> +       int rc = 0;
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>
> @@ -1306,14 +1304,12 @@ static int pci_pm_runtime_resume(struct device *dev)
>         if (!pci_dev->driver)
>                 return 0;
>
> -       if (!pm || !pm->runtime_resume)
> -               return -ENOSYS;
> -
>         pci_fixup_device(pci_fixup_resume_early, pci_dev);
>         pci_enable_wake(pci_dev, PCI_D0, false);
>         pci_fixup_device(pci_fixup_resume, pci_dev);
>
> -       rc = pm->runtime_resume(dev);
> +       if (pm && pm->runtime_resume)
> +               rc = pm->runtime_resume(dev);
>
>         pci_dev->runtime_d3cold = false;
>
> --
> 2.19.1
>
