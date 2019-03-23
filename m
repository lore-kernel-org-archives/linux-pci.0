Return-Path: <SRS0=AkHN=R2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85B2C43381
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 19:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2802183E
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 19:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doUMYgml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCWTPt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:15:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33360 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCWTPt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Mar 2019 15:15:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so3704953pfd.0;
        Sat, 23 Mar 2019 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyTEchqo88XvKvKn+o7M3Lh5SAaVdhz8XAw9ZD0flb0=;
        b=doUMYgmlRaoGxToWvZaTxqC0OR7GoZyV7YF9nTi2A+HYkHlR0SjsCzjkXkCYQBd7IG
         Oaln1D974DYG9zUy47drhHQ/mSWfb171r8y6Rta2COkw5eqKaLnqa19k8+J4uRVjd0vp
         OxTJhNjmxP4B/rPgdBIL/PcSrX2jcVQGdp1COazsO9pkYLrTECT8/g5ryx/Cbv/EKgS7
         gqx+Dr2NFWkEqQ2uQew+XGKsxZh4dxwlFGYhEfsRJ897nRVohkGc6pPPy5lGK7B1QleN
         5zyLkNkj1XFnKBSrdyvV9fmMJmIcQBVtRct+cBUUffT5j/3ND9ZhuWvpGydoz+8Re7F1
         S24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyTEchqo88XvKvKn+o7M3Lh5SAaVdhz8XAw9ZD0flb0=;
        b=cc2KWQF2t1e406H8floedKU0IukjDRQJMfN0dLrJqT/lhv+8H8PaUqHupjCQvJdzYH
         mNAcLfNzM6ibsRjVfmpkG9I979u5bUB3SUstDOkgLwuQHfvISwTMg8dTSIzom5AjLsdi
         vUf6sOaQ0kXK9EyVQrFRYFNXUxFpLgPbdwwfYlowO6LQxUIUEEzpNF+E/TI9VwaCCzbR
         Ch45B+GfMPNb9rZ74BBcAsc/4p5U7m+0r3vPh45PruR5/DOM+O8yJK0jkA9UooQ7P482
         HtmKAwLe1C5nNJYWWYEDn5NikpXopeYsgT8SqyjJzTTckCBKjrk7dimKH0g21zOOJmY8
         aacA==
X-Gm-Message-State: APjAAAWgEoJeeQC4CqjBicXTwdEQAYUc5aEefS1PdjX20vp17Qmdqxbf
        5dx3U7JMZxecZF7VKDLr44iNgJP1Mayta5E0gZo=
X-Google-Smtp-Source: APXvYqw6xQyd2piEJr9y8L5GgkI43JHDpjCi1Eu4vzDQX/97pVuFeduwjBYV7sO4a+p5blV/qn07N428j04n2SwoaZk=
X-Received: by 2002:a65:5acc:: with SMTP id d12mr15442555pgt.337.1553368549093;
 Sat, 23 Mar 2019 12:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com> <1553105650-28012-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1553105650-28012-3-git-send-email-john.garry@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 23 Mar 2019 21:15:38 +0200
Message-ID: <CAHp75VfRwp+XGdE6k4KU6hvLNu=h3TRVbm5AFOAZgsp-i1Ehjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] lib: logic_pio: Reject access to unregistered CPU
 MMIO regions
To:     John Garry <john.garry@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>, Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 20, 2019 at 8:14 PM John Garry <john.garry@huawei.com> wrote:
>
> Currently when accessing logical indirect PIO addresses in
> logic_{in, out}{,s}, we first ensure that the region is registered.
>
> However, no such check exists for CPU MMIO regions. The CPU MMIO regions
> would be registered by the PCI host (when PCI_IOBASE is defined) in
> pci_register_io_range().
>
> We have seen scenarios when systems which don't have a PCI host or, they
> do, and the PCI host probe fails, that certain devices attempts to still
> attempt to access PCI IO ports; examples are in [1] and [2].
>
> And even though we would protect against this by ensuring the driver call
> request_{muxed_}region(), some don't do this:
>


>  #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
> +#define INVALID_RANGE(range) (!range || \
> +                             (range->flags == LOGIC_PIO_CPU_MMIO && !range->ops))

It would be better to read in a form
#define foo(x) \
 (...)

> +               ret = range->ops->in(range->hostdata,                   \
> +                                    addr, sizeof(type));               \

Can it fit one line?

-- 
With Best Regards,
Andy Shevchenko
