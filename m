Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:46510 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbdJNW0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2017 18:26:20 -0400
Received: by mail-io0-f173.google.com with SMTP id 101so12395101ioj.3
        for <linux-pci@vger.kernel.org>; Sat, 14 Oct 2017 15:26:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508018851-9272-2-git-send-email-festevam@gmail.com>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com> <1508018851-9272-2-git-send-email-festevam@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 15 Oct 2017 00:26:19 +0200
Message-ID: <CACRpkdZpjk5ji7FU4NKxJ9U+FqvUvHOZKTcQJQ3U5TOhyxzcqg@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: v3-semi: Fix platform_get_irq() error handling
To: Fabio Estevam <festevam@gmail.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 15, 2017 at 12:07 AM, Fabio Estevam <festevam@gmail.com> wrote:

> When platform_get_irq() fails we should propagate the real error value
> instead of always returning -ENODEV.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

OK

>         irq = platform_get_irq(pdev, 0);
> -       if (irq <= 0) {
> +       if (irq < 0) {

So 0 is NO_IRQ and not valid these days. See:
https://lwn.net/Articles/470820/

>                 dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
> -               return -ENODEV;
> +               return irq;

But this is right, if irq < 0.

Yours,
Linus Walleij
