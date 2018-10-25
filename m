Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12EAC46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78502075D
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 13:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78502075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeJYWbC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:31:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46538 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJYWbC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2018 18:31:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id u26so8047376otk.13;
        Thu, 25 Oct 2018 06:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDtRlOXRxRmsWOEb4YpZ7hNjZRPJrYgR3EOFzn3/5oE=;
        b=uMaEdLv2WVR0qO0NfeZTvPOZQ1Nl8/MD8PemR0ePALVDh2gM1SCswpfGTRk7L8qAwa
         z2WVVWqNnJPNq9Gxlx2J8kQTpa4PNW+XS72gRDlHuM5IGsmstLNWCuFalKgvy2LT3Oas
         foiZyG3JVD+2/2Rf15GCwN/fzfup36CNY2N344xCXGRJw7WJqCKVqfWh2FHZja8XK16S
         wQ8/qK3gdXvgsBMrpxMyrcQrn84V4Pzu0EckBiO5CQ51FKqNkmLz63NDj3d6YywbnFhu
         2zLzM0wOnZdKUl5RL//D9PSu0jikCAogHcbm9AstfrlynzZQvV7pRYh1+i79WDhmtraJ
         1bDA==
X-Gm-Message-State: AGRZ1gJXJ48ERDOVP1AdhEmm7A1nXMTkIvcrgbYEfaFRn3LFlDMMoNu3
        zIqz3TA5d5tIGWmSoz7HbSJsJFCGfIJC8Xv4cy0=
X-Google-Smtp-Source: AJdET5eAmc/S706Fl15bSUP4DrcrVUT5QV8beL1ySxZPCaCAm1z2hc6G+S1gLM5yU0+Bu9bX4Dk6t3hDWCSkMWvz44w=
X-Received: by 2002:a9d:4590:: with SMTP id x16mr1558038ote.258.1540475888600;
 Thu, 25 Oct 2018 06:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181023114552.22958-1-jarkko.nikula@linux.intel.com>
In-Reply-To: <20181023114552.22958-1-jarkko.nikula@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Oct 2018 15:57:57 +0200
Message-ID: <CAJZ5v0gna-KvmezNGmCJZTwMrSBHyxbXqPZi12aKjEkxkr=YPQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI / PM: Allow runtime PM without callback functions
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

On Tue, Oct 23, 2018 at 1:46 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> Commit a9c8088c7988 ("i2c: i801: Don't restore config registers on
> runtime PM") nullified the runtime PM suspend/resume callback pointers
> while keeping the runtime PM enabled.
>
> This causes that SMBus PCI device stays in D0 power state and sysfs
> /sys/bus/pci/devices/[SMBus PCI ID]/power/runtime_status shows "error"
> when the runtime PM framework attempts to autosuspend the device. This
> is due PCI bus runtime PM which checks for driver runtime PM callbacks
> and returns with -ENOSYS if they are not set.
>
> Since i2c-i801.c don't need to do anything device specific beyond PCI
> device power state management Jean Delvare proposed if this can be fixed
> in the PCI subsystem core level rather than adding dummy runtime PM
> callback functions in the PCI drivers.
>
> Change the pci_pm_runtime_suspend()/pci_pm_runtime_resume() semantics so
> that they allow change the PCI device power state during runtime PM
> transitions even if no runtime PM callback functions are defined.
>
> This change fixes the runtime PM regression on i2c-i801.c.
>
> It is not obvious why the code had hard requirements for the runtime PM
> callbacks. Test has been here since the code was introduced by the
> commit 6cbf82148ff2 ("PCI PM: Run-time callbacks for PCI bus type").
>
> On the other hand similar change than this was done to generic runtime
> PM callbacks way back in the commit 05aa55dddb9e ("PM / Runtime: Lenient
> generic runtime pm callbacks").
>
> Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: <stable@vger.kernel.org> # 4.18+
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> I Cc'ed stable since this fixes the regression on i2c-i801.c. But we
> probably want to get some test coverage first before applying into
> stable. Queueing for v4.20 sounds reasonable to me.
> v2:
> Previous version had a potential NULL dereference in WARN_ONCE() statement
> noted by Jean Delvare. Now covered by pm && pm->runtime_suspend test.
> Also handling of error code from pm->runtime_suspend() moved under the
> same code block where callback is called.
> v1:
> This is related to my i2c-i801.c fix thread back in June which I completely
> forgot till now: https://lkml.org/lkml/2018/6/27/642
> Discussion back then was that it should be handled in the PCI PM instead
> of having dummy functions in the drivers. I wanted to respin with a patch.
> ---
>  drivers/pci/pci-driver.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bef17c3fca67..33f3f475e5c6 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1251,30 +1251,29 @@ static int pci_pm_runtime_suspend(struct device *dev)
>                 return 0;
>         }
>
> -       if (!pm || !pm->runtime_suspend)
> -               return -ENOSYS;
> -
>         pci_dev->state_saved = false;
> -       error = pm->runtime_suspend(dev);
> -       if (error) {
> +       if (pm && pm->runtime_suspend) {
> +               error = pm->runtime_suspend(dev);
>                 /*
>                  * -EBUSY and -EAGAIN is used to request the runtime PM core
>                  * to schedule a new suspend, so log the event only with debug
>                  * log level.
>                  */
> -               if (error == -EBUSY || error == -EAGAIN)
> +               if (error == -EBUSY || error == -EAGAIN) {
>                         dev_dbg(dev, "can't suspend now (%pf returned %d)\n",
>                                 pm->runtime_suspend, error);
> -               else
> +                       return error;
> +               } else if (error) {
>                         dev_err(dev, "can't suspend (%pf returned %d)\n",
>                                 pm->runtime_suspend, error);
> -
> -               return error;
> +                       return error;
> +               }
>         }
>
>         pci_fixup_device(pci_fixup_suspend, pci_dev);
>
> -       if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
> +       if (pm && pm->runtime_suspend
> +           && !pci_dev->state_saved && pci_dev->current_state != PCI_D0
>             && pci_dev->current_state != PCI_UNKNOWN) {
>                 WARN_ONCE(pci_dev->current_state != prev,
>                         "PCI PM: State of device not saved by %pF\n",
> @@ -1292,7 +1291,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>
>  static int pci_pm_runtime_resume(struct device *dev)
>  {
> -       int rc;
> +       int rc = 0;
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>
> @@ -1306,14 +1305,12 @@ static int pci_pm_runtime_resume(struct device *dev)
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
