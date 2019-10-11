Return-Path: <SRS0=SVWb=YE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D69ECE58C
	for <linux-pci@archiver.kernel.org>; Fri, 11 Oct 2019 08:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A9B21D7C
	for <linux-pci@archiver.kernel.org>; Fri, 11 Oct 2019 08:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzwLeD8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfJKIsx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:48:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41058 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJKIsw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2019 04:48:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so5669487pfh.8;
        Fri, 11 Oct 2019 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZE64hLgDWtbp5oSPHrZjFkaTZsSqEnl+J/6l+xL0R68=;
        b=ZzwLeD8APeW7v7gmHQ4brO/MpKDK5jv5GzZp6zGocmM93eqzhIhS5shfEp+tlUwmLd
         rDQF7RURyjqfi/ExjsSKGrkJ+209sPYbo1cajBUsWOZoDxOpCZC3uVi0iUtLcVo79ntG
         FPgUjHavDuw9h/AliOkJCDoVBRplw1WS0w/M3F2G0vJ1FipWWe41baGRMXpL0ODGzwrD
         CfemUW1YOmfmDLz9zM6PVQ9J0AKXpudfSrVxZ6G+XfpmzNnkzbzXPtbb0EnwiQM5lYgD
         7lDb9PDx0OqUy+x6SeakcN+U17CS8xYpdK/sbHYVAzxhNYp5Q/KyeuyWRrnCki7Mdcyb
         Wzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZE64hLgDWtbp5oSPHrZjFkaTZsSqEnl+J/6l+xL0R68=;
        b=ESoCszE7wsxfRIqUTpfV16KiNmSFFPCl0YODGh4BK6+3ohfjW8X6JkR+HaxMy7IHb1
         TJs5kz9MR0IFk3z7xk8hPFhdmC76k/g7aLiQlsJ+4O5ZwMVWAXJPWj8QF40uPRs+O/m7
         IL8yAkaj8LVvVnOKH52QhF/uxkbHiVjVmSyNwWBUJLkFTtMaf3d+2TFCg3mUXf9l0K3G
         vEm5Es1blKc1VSJ6Pf78k2pwfF/myMb970Wpo/P3ZhjO4pWgsJL4MUX/cIcESy0nvPLF
         AVgALJ+F0J/pWpVute7w8X7RAxlaB3K64YW3M8qdekji4peBOHPTf0a7R5Apb+dwFD+B
         JyfA==
X-Gm-Message-State: APjAAAXKMa7IewTCmIvrUumxIJwh3fWEjq4LeHytf403lzO4YhqPh84J
        4F9OhawKIBUY1hju6qK2/rnBxdZGJtUKJmEg+jQ=
X-Google-Smtp-Source: APXvYqyKqcLTN8qXhhUEJ5W9vQ79+Sa+VSx6rO4e4Aiud4YwnJ7oAtWN35B+bR2sgwouozH9FsEwTy2cE0vixNDWQOY=
X-Received: by 2002:a63:d0a:: with SMTP id c10mr13786067pgl.203.1570783731894;
 Fri, 11 Oct 2019 01:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
 <20191009200523.8436-3-stuart.w.hayes@gmail.com> <CAHp75Vc1mZ7qxKPGaqDVAQ9d_UjNq9LJDEPWHQHaYCfw7vGrmA@mail.gmail.com>
 <CAHp75VfNjnAxua6ESx1Vp=57O=pVM10P1UK8bGNQUk7FeY=Dmw@mail.gmail.com>
 <CAL5oW02uRk-ZLMaE6Skt7rX6xy=sQNttfSZ2N1JRBXPfjJpZNg@mail.gmail.com> <CAHp75VfEpH4Nv0J+wc3vhFWXYgVLcFdOr263dAFRZiz_ZEfZrw@mail.gmail.com>
In-Reply-To: <CAHp75VfEpH4Nv0J+wc3vhFWXYgVLcFdOr263dAFRZiz_ZEfZrw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Oct 2019 11:48:41 +0300
Message-ID: <CAHp75VeuQ0O9SxveRXqOKoRKQQJNwJ_1WX6taNfgWebiP0KdJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 11, 2019 at 9:49 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 10, 2019 at 11:37 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> > Thank you for the feedback!  An infinite loop is used several other places in
> > this driver--this keeps the style similar.  I can change it as you suggest,
> > though, if that would be preferable to consistency.
>
> Better to start the change now. I'll look into the file and see how we
> can improve the rest.

I found only one infinite loop there, the other timeout loop is done
as do {} while.
I'll send a patch to refactor the infinite one.

-- 
With Best Regards,
Andy Shevchenko
