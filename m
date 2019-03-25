Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8258AC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 15:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C8E2082F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="to1WT3ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfCYPEE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:04:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39546 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCYPEE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 11:04:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so3025962pga.6;
        Mon, 25 Mar 2019 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIjPQMEfFNnmxk2sYVSDBV/lHK9Z5CZQPf5ScXHK5UE=;
        b=to1WT3tyTEQ2fO+l4y5negMx9c9JuPTWVqDx7+A63y3E2+lzzJbKsyRnTsWOgBttq4
         5uPZDISOrvmMd/+ATJ6Y+v6tf+mNGjyuCRlUUPZreILU5j2k5+1yFtLK7ijDJsCPLaST
         iVz1ClHFb+icEIE8YkgmnWlTrSKge9C8IXnanMoeUHs6w01dkP8jbnEk6KZyYF3JJMrc
         4ONPMccBmBPxzAuoVSLZkik+gcmR6rTyBH7UEWN6pRz7C7C9+NgWCHGdLa8dmG22An0r
         XU/fgHy/JqkBQ/5FMY51Za82ID7FuMhbFBFkT/WbsTbtyRHZE6iX6+5N69/Iw9CNDK8w
         pxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIjPQMEfFNnmxk2sYVSDBV/lHK9Z5CZQPf5ScXHK5UE=;
        b=ph88LuVWLbkA3HaS/RqrEPtKDYnxB2uxiaWeMW5sef10KVcNsRSfU3C1grkkJ30ecE
         uLpxLDn4u2RayLAxYnh6/UNpwVpunT+aVNz6+4YQxmR29iBxjuDij/thY0Rpp/SGyA7H
         pWJO1q1VxIOJuoYh88VvWoRKIJsELI+KnuiaS1Z/P4ULR7A54Hpi+eIn9UeXI0JhH5FE
         sQa2dmqKL8Nojrw+EO76qUHQRPh8CQ5JpjAEDWyR41bxQ6leN72aY6RSAbJGJsPthuFd
         97bCHf/fP+vj0SpqaJZIVC5mwZ0Q+qWdT9QL+tYIkC0A5ZYuzcB5zEHhCg1Js+Qxpkuv
         /R4g==
X-Gm-Message-State: APjAAAWfMRwslaV96tqvdFEbyW0V7At80bstp5UEPv2ofOuyCBTTxuxL
        OJNRQMMbqADteoa8/WoxIM9z21Sn595Gs8ay1Pw=
X-Google-Smtp-Source: APXvYqzfAjm+v/MQ9UL6O5LFSlvho5wVwwMVpDD9Ecal2842bUMubnitMXOnJDXd6zoRLHwoqrTy/+sWdINzzOfRMzk=
X-Received: by 2002:a65:5acc:: with SMTP id d12mr23972047pgt.337.1553526243650;
 Mon, 25 Mar 2019 08:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
 <1553105650-28012-4-git-send-email-john.garry@huawei.com> <CAHp75VfyU5ZDqCZ55SoxW1pQt1KXZQZJeYixHQf8Kw2EZcXWrQ@mail.gmail.com>
 <1a26586d-803b-5fad-e611-449bdb49096e@huawei.com>
In-Reply-To: <1a26586d-803b-5fad-e611-449bdb49096e@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Mar 2019 17:03:52 +0200
Message-ID: <CAHp75VefTFx-HdaVhVG9uYO4Ec_S20eMjGRPeso+raCU4XEjeg@mail.gmail.com>
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

On Mon, Mar 25, 2019 at 11:49 AM John Garry <john.garry@huawei.com> wrote:
> On 23/03/2019 19:12, Andy Shevchenko wrote:
> > On Wed, Mar 20, 2019 at 8:14 PM John Garry <john.garry@huawei.com> wrote:
> >>
> >> Some prints in the code are for a hex number, but don't prefix "0x". Add
> >> the prefix, as is the norm.
> >
> >> -       pr_err("addr %llx not registered in io_range_list\n",
> >> +       pr_err("addr 0x%llx not registered in io_range_list\n",
> >>                (unsigned long long) addr);
> >
> > Can we use %pa at the same time?

> OK, I think that we can use %pa and drop the casting to unsigned long long.

Yes, that it is the point.

-- 
With Best Regards,
Andy Shevchenko
