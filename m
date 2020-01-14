Return-Path: <SRS0=eZdz=3D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B6C33C9E
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 21:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ED924672
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 21:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BishUw6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANVkm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:40:42 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39412 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 16:40:42 -0500
Received: by mail-oi1-f196.google.com with SMTP id a67so13381117oib.6;
        Tue, 14 Jan 2020 13:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2X/3u52wahb7NGy1ojTFR4c4yUjd1i5XgPJPjD8koM=;
        b=BishUw6RdDy3BtA5hJJ/yzahdPhOrLYKOXBAabjCh4MDn8huO8LALML38GACHX4RfW
         6LJyxE/IRPWFgqEN3ZCbwZDOuJjzz06AADj0HIiAaOOkffmHYdSGCuSYmQevUMSLsFnW
         exJ3aGniAjvaLOq0laLSAOQ3mmpEyFHANl1oE9DbIRgS2TUpBM02VKlQ9zINmgNvD1up
         Ldw/vP6Tl1g+OKv7JfCNy25dVgZum3Ic7rSkUPfyZi9+OPsWrdeYmwg9lArIA80E11CM
         6xJE2ZkO1JcNLRHAxMlbq5aY3tdCAUDf/XTwcqdXzkO/FshCyYkbaG3td3ZjdS9QdLla
         n10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2X/3u52wahb7NGy1ojTFR4c4yUjd1i5XgPJPjD8koM=;
        b=MCzNznLGwPccxeJVa/8EGNfmZaSIaUjNHYvqF/3L3U1Fy56e+GhmoZ3XtCVk9GDjOF
         5Zrlys8AN4ITCaFZC5JP+KaKsORAckp3rkR5RLX0GhBns9c4G5bd25WGmxiNFftt20oI
         Ou0Fpn3vTcSNSGTEPbUwZfwP0UOS9W3j2Zp5DfW2n+De/i2jw5OcPDbsOu+gyJJoRpaH
         bFiF/mpUjMqHt4n5hjOJZbJ21xQQKX/EkXGRn7EpoP6LMbOoZMBtX/AogOCejqTfRcKg
         DGiK/mS2KbPIQGQ9Xc+F1TwxSYvyjIiyXDO4FguaDKWxNHUQFA51rNVyBZm22GjzcRXu
         q/Bg==
X-Gm-Message-State: APjAAAXw6pE2fTy/HlhsHV9x83hw3S40VwmQo8U+oQcUXs6TXcbqUeF3
        3pN3G84RrvUbk51EDz7V3D+nTyScL2MW1oZ3i+g=
X-Google-Smtp-Source: APXvYqyGtqmUfz782Nh+91u6hWzKZM0F7xbelpycsO7fFRwkr7uh3ZKCe4ZONjmOCjA5kJ0fL31PByYcSAIVpLWHQ+4=
X-Received: by 2002:aca:f445:: with SMTP id s66mr17313773oih.95.1579038041363;
 Tue, 14 Jan 2020 13:40:41 -0800 (PST)
MIME-Version: 1.0
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
 <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com>
In-Reply-To: <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Tue, 14 Jan 2020 23:40:29 +0200
Message-ID: <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com>
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 11:38 PM Ramon Fried <rfried.dev@gmail.com> wrote:
>
> On Tue, Jan 14, 2020 at 2:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Ramon Fried <rfried.dev@gmail.com> writes:
> > > While debugging the root cause of spurious IRQ's on my PCIe MSI line it appears
> > > that because of the line:
> > >     info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> > > in pci_msi_create_irq_domain()
> > >
> > > The IRQF_ONESHOT is ignored, especially when requesting IRQ through
> > > pci_request_threaded_irq() where handler is NULL.
> >
> > Which is perfectly fine.
> >
> > > The problem is that the MSI masking now only surrounds the HW handler,
> > > and all additional MSI that occur before the threaded handler is
> > > complete are considered by the note_interrupt() as spurious.
> >
> > Which is not a problem as long as the thread finishes before 100k MSIs
> > arrived on that line. If that happens then there is something really
> > wrong. Either the device fires MSIs like crazy or the threaded handler
> > is stuck somewhere.
> >
> > > Besides the side effect of that, I don't really understand the logic
> > > of not masking the MSI until the threaded handler is complete,
> > > especially when there's no HW handler and only threaded handler.
> >
> > What's wrong with having another interrupt firing while the threaded
> > handler is running? Nothing, really. It actually can be desired because
> > the threaded handler is allowed to sleep.
> What do you mean, isn't it the purpose IRQ masking ?
> Interrupt coalescing is done to mitigate these IRQ's, these HW
> interrupts just consume
> CPU cycles and don't do anything useful (scheduling an already
> scheduled thread).
Additionally, in this case there isn't even an HW IRQ handler, it's
passed as NULL in the request IRQ function in this scenario.
> Thanks,
> Ramon.
> >
> > Thanks,
> >
> >         tglx
