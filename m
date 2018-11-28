Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74853C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 01:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8522082F
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 01:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga/g5Az4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8522082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeK1M2O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:28:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50991 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeK1M2N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 07:28:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id 125so896703wmh.0;
        Tue, 27 Nov 2018 17:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JcnDy7jgAld4GixisXnricG8EofDL0nd37oUN/+JHA=;
        b=ga/g5Az4G+L5cEjCgHVMqaTNGTDwMAugz5choy5S7oGSmRYIU19z4Ft3/bacj7yNw/
         6Kkv4AkySk5DuNh8nWtziDWaqktBb1WwiOSUbNldQ98qm53dblHQjJy8Z76CIXpB7v/Q
         ExLXV+RQUBnOtwQnGw+5KWooFJy1DKn7inmnd0LekV1/j5magzwoqYWgcHGo2s1AMNPh
         USvrNfnephtnNbsQA+Ss/gNBCBG60fYWH+f2EjBAQD8vAldpE1spUeJFpjXh54ZOadqa
         4x3SrC6P/hczrU8LMjm4bLpOVrcea+9+E/eNgcMlVsWxRw6XwH0urjJeDN4Rs2VxKRcY
         GRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JcnDy7jgAld4GixisXnricG8EofDL0nd37oUN/+JHA=;
        b=hsrPICfz3+HhAHIE0QQ4I6e0ZH0cFuSnnbdVbWiIC3GoMDE5FJScsDVpz9rUNnQgCc
         BlijUhli/UEwXogS02qpvOV5ZzyR9usRmZ7dgzptDi7e4EMcsNA3tdpL29B1vBt4a8lt
         sKddsuM9nB9gPFZCqoshn1gMSobFafQbjQYmhiJLa1Zekj/AlXxPL+g88S9Pee94j744
         WX6gIzC6bxKhx4wYXj6VHKs0u7JqJ1LKPPhvFHUtp1KfudmcCZS0xBe4i0PlE4xmB4g5
         RmIOoraI0Ix1bATtpRHEN1Rf42oyqHIdWdS7zZOFni939PWjOdu0GOghfQJuAspr0KJf
         RSjQ==
X-Gm-Message-State: AA+aEWYcIUVJQSPd+5egEjWEGtDqfPOuQY2uJLJzyKCK42b7gqc0bYqx
        KPcFayDGvYHuISIxkdw4dKSUCJI5ko3XtpO+2o0U8t9N
X-Google-Smtp-Source: AFSGD/WY/SxJer6fUSBrRgSPkgcY4AkeU6WY9ToHTcMz9fcW3N+JF0sok2kUzTxEGTi88eKl3h1JS3hAzHR5wOUeLd0=
X-Received: by 2002:a1c:8a09:: with SMTP id m9mr904393wmd.27.1543368504862;
 Tue, 27 Nov 2018 17:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20181120132705.6917-1-stefan@agner.ch> <20181120132705.6917-3-stefan@agner.ch>
 <CAHQ1cqEfjqtJbb6qxTRa-rVvgy8+_Og4Eh21XMRETJHnRG9a6w@mail.gmail.com> <CAOMZO5DZRUUkkqNPRZWhK0C56sRU+eQqFzV+akpEvwcKHW1DNw@mail.gmail.com>
In-Reply-To: <CAOMZO5DZRUUkkqNPRZWhK0C56sRU+eQqFzV+akpEvwcKHW1DNw@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 27 Nov 2018 17:28:13 -0800
Message-ID: <CAHQ1cqFprD4k+aO_x-znEs6sXpx9jxih-moSuNZZ3dAKHuLpPw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: imx6: limit DBI register length
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Stefan Agner <stefan@agner.ch>, Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Trent Piepho <tpiepho@impinj.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 5:12 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Tue, Nov 27, 2018 at 10:57 PM Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>
> > Could this be a regression? Prior to 415b6185c541 ("PCI: imx6: Fix
> > config read timeout handling") all of the imprecise aborts were caught
> > and handled via no-op handler. I did an experiment on i.MX6Q board
> > that I have (ZII RDU2) and adding a simple no-op for imprecise aborts
> > via
> >
> > hook_fault_code(16 + 6, imx6q_pcie_no_op_handler, SIGBUS, 0,
> >                        "imprecise external abort");
> >
> > seems to "resolve" this problem:
>
> Please check https://patchwork.kernel.org/patch/9720313/
>
> This commit fixed a kernel crash on mx6q boards with a PCI switch.
>
> So we can't go back to the simple no-op.

It's probably not exactly clear form my message, but I wasn't
proposing to go back to a no-op. What I had in mind is having a no-op
handler for imprecise aborts _alongside_ the non-linefetch handlers
that is already there when running against i.MX6Q type of the IP
block.

Thanks,
Andrey Smirnov
