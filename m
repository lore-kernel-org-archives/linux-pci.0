Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88882C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 23:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5A621874
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553210526;
	bh=qTC7yS2h3KzLCXNTvHs/l8ASP0bquxSEjlH8Ima2wWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GQmVd09EweU6LP28qAM1NNhysOo9Wie68D2JGCu1Q0d7dMgMrw1GRlWuSLBhqZmLG
	 5ODj3+ano0lO8EcS3wL0I9WPG03tXzK/9oBh8K7NbyA4hAXv1X8UWcX+mgywpmCwHM
	 1bewKIQxOMql2tY9zgN2qGoPJQEAgNB5nkEiKyzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfCUXWF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:22:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38915 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfCUXWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 19:22:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id b4so363251oif.6;
        Thu, 21 Mar 2019 16:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1Qqx9voHCC3xEJcZyXIOse36IMkps8hsS+4N7LMXD4=;
        b=MQFOL6hX4zkGnPVyJ51XmT3J2Y5cabVFyIJx8MvbykNt5NjFk/wj5EV/RrWSyywcWc
         sPqhwMDxPLlTrJP1i+lhC87gbWnB+eDaqKN7rPcZJ2VAP9Jx1zlclk/QzqXf4aEojRwC
         JeyTkpfcnqQVzodvND19CDAHj+qc4sNA5/coS9iiHaO1HbsDR4kZ4L0Dk/UMjggMPhSR
         +bABQ07RbEckrdDc7mKeoQS9eghRMmxCoWiyaYcOapCKc7YMpyyQIMO5z7HLHLRfriIn
         TH+/K24lEB7EOcGxe6MtuZLwQ58PHYH9ziow6wFdVQ5qma3k8Lcs1MVsD6dQQsjoLDCw
         Z3eg==
X-Gm-Message-State: APjAAAXCHsRSkCROyoWhHjbsVuG/BcXnbNiYIRe0mJKUUSufXLcabBKZ
        kIPTaf5l8XbzWJsw6vpJe0BwnCHWIIjz3/6Qzgk=
X-Google-Smtp-Source: APXvYqyLok8SYEWtagDfsgpYdG18epPJuYV5WIZKtu/U1xmkxxR5nHr/NShbcBTem4aQKbD96uZYKWRSb4VkrmF3/bQ=
X-Received: by 2002:aca:6046:: with SMTP id u67mr1321057oib.84.1553210522438;
 Thu, 21 Mar 2019 16:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c4ba820579737025@google.com> <000000000000461a4c0584a2cfd2@google.com>
In-Reply-To: <000000000000461a4c0584a2cfd2@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Mar 2019 00:21:51 +0100
Message-ID: <CAJZ5v0jVquKnFHrQ+=AyZM2rwOx3CkdGng1z2g2UX30+PJaKDQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6 (2)
To:     syzbot <syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, daniel@iogearbox.net,
        David Miller <davem@davemloft.net>, devel@acpica.org,
        Herbert Xu <herbert@gondor.apana.org.au>, kuznet@ms2.inr.ac.ru,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-can@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, Lv <lv.zheng@intel.com>,
        mkl@pengutronix.de, netdev <netdev@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robert Moore <robert.moore@intel.com>, socketcan@hartkopp.net,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 22, 2019 at 12:08 AM syzbot
<syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 64fd1c7040880292710e6592ddc88d0d73cfb6fb
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Mon Jun 12 20:48:41 2017 +0000
>
>      ACPI / PM: Run wakeup notify handlers synchronously
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1555b12b200000
> start commit:   64fd1c70 ACPI / PM: Run wakeup notify handlers synchronously
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1755b12b200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1355b12b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=240f9766d6be3d69431e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f35e4d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1280edbd400000
>
> Reported-by: syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com
> Fixes: 64fd1c704088 ("ACPI / PM: Run wakeup notify handlers synchronously")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I don't see how the commit turned up by the bisection can be related
to the reported crash.
