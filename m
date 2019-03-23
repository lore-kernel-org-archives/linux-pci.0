Return-Path: <SRS0=AkHN=R2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2160C43381
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 19:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96632183E
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 19:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFxKH/XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfCWTNF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:13:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38822 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCWTNE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Mar 2019 15:13:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so3687915pfo.5;
        Sat, 23 Mar 2019 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFPsg5xZxrAnRY+lzOwJFqF2W8DUp/fhIWgq8m53w24=;
        b=vFxKH/XXnaJvOmeFe3VLU2Wph+MX6f36jmBm3DB6ru9KVi83kLcpzUS7xByZfRayKI
         UXqtJYM/mksbMWWF2dL3qSLU96w5NdpnPZQ4ORZksuTt3QoyU70E/ojBN1LgR9EhA6l8
         7I8EjykTpSLrW06YNuADQw7bznc5bhERc8LfmjGbKHvwv1sQfv6sJ9zSQhvhNchHsj/B
         HcV+n6l+KzUGE50iMTQLqNm1R/D7S/tLx/yK2RwE8aBHMBFo3uheEv/Qq/wfQH3fR4os
         kflu7agHit3rrGQMTHOs+KXO5SWFYbLg0LwB78C3/fHM+XOY9CziqIaBQYjK3gIJys+c
         LVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFPsg5xZxrAnRY+lzOwJFqF2W8DUp/fhIWgq8m53w24=;
        b=cMqCtyycAtw2B4PEj5pGYVe7GbPfcjHMSUOavjywfqOiGCfA07sq1BC8T+DGzIzjRi
         Kcyy+CeadDGm3YR7smdNMEZRu5l5yhKuBvNYz7MamZEWRxtEbaeko8LGRyviZVvKUzqj
         wTyQU51qW8JuCpn/ZpEcIhhJB1n1MqZ4+9ZWkeQOQWBjTZL00qn9yO4lc6PDatgIYDaX
         FV65fBhrNdTkE6vOzv+5RhPi35DdoG7P0hrT/issa0QXyiQ4kVzTafHfwgiy0zeFfaGC
         Px6ShdrGSL61zllTtVtGFUgmlAaCJWmFjedazy3PxFbY0Wt/GUzqzGdnKRJgr7rnqeZj
         NB6A==
X-Gm-Message-State: APjAAAVfHh2EfuVZ7U/mqQu/CoSZ4uF72L98Kfv/dGKapS4o3yplPgAO
        nhSuB7p6IhXMH2/iHOGFhnyAVYZNWyaABmyE3lo=
X-Google-Smtp-Source: APXvYqzvHjCE0S+an15nLvKqEoHLEroB03TWbEmfRQfwe3jkOyu6+aCKHCF3yX04JZZonimq2ivs97GlnGHf48/K5TQ=
X-Received: by 2002:aa7:914f:: with SMTP id 15mr15711075pfi.49.1553368384028;
 Sat, 23 Mar 2019 12:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com> <1553105650-28012-4-git-send-email-john.garry@huawei.com>
In-Reply-To: <1553105650-28012-4-git-send-email-john.garry@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 23 Mar 2019 21:12:52 +0200
Message-ID: <CAHp75VfyU5ZDqCZ55SoxW1pQt1KXZQZJeYixHQf8Kw2EZcXWrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lib: logic_pio: Make some prints explicitly hex
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
> Some prints in the code are for a hex number, but don't prefix "0x". Add
> the prefix, as is the norm.

> -       pr_err("addr %llx not registered in io_range_list\n",
> +       pr_err("addr 0x%llx not registered in io_range_list\n",
>                (unsigned long long) addr);

Can we use %pa at the same time?

-- 
With Best Regards,
Andy Shevchenko
