Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3151C282CB
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DB2207E0
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P26/5Y7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfBDLJl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:09:41 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37977 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbfBDLJg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Feb 2019 06:09:36 -0500
Received: by mail-ed1-f52.google.com with SMTP id h50so10873557ede.5
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 03:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=It2qJUgZHA/IxrrU5/q90W4ZzBFE46UxhoFBQ/C4WEg=;
        b=P26/5Y7yTqHnSix8Gh41F5jIotYKSUMEx1UNxuOISE5SQntLuj4kTIrFogpaIoOdyt
         /RqSYAMba0KriB3Tc5Y1UckR8ldDPI0yTjPkMPLT/zbXxj2RIBVTZPYXdya9iobLnNBV
         LrtUN4AYMgA5iPcYbz8iGH2CTiwCQKWKqBukI0P+cxrRMsyw1giUX7GpQoHa3gy39WWb
         xU7dr2FKxHWPjeYQdRpzFGRlyIrTZ/KIHLLTAhUjyqBkV8+3MewBb5R4/zwbReCNdZIs
         7rN/fYJDEdJ8ZHVrJxDVLAK4AifFueTJFfdEb+xayPmFiNHasaoZyanoFapKS3ZNivn2
         IshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=It2qJUgZHA/IxrrU5/q90W4ZzBFE46UxhoFBQ/C4WEg=;
        b=YgWuAH/Se/AF+UVOKWpEuFldecTcG3iHEL2ep7DcI5GL5L2G6411EIpHKPSGHw3mSN
         o3qtDf0l2xjLTEc7Cm2bCVuKzZ0MloZw+Ad+6aDnJTVUKhNh/amL7uTFqJe30EAoN7uM
         Ak6u0HeQKCdDTLU+MThg35M+G4zbFAHPhetQ//USK4zQrGpKwdvd+mW4zJ8sqB3csrVc
         idlncRqQD/tqMtYndA/6lndZYQGe1MeF7YwyaS303hpb0gn3GhVV6ytrTOMksfwkMU+u
         hgtVvFDzspvW/iFNqNrgDk1B1ZkF2uTmRYC7W0STaDj/NZRqlTNByRfHWkrNE3I0Hjb9
         yB0A==
X-Gm-Message-State: AHQUAuZYtk5eFSWirE1QR/peOOgaj7oS2/V3Bb8C0yNQTjDgEFVPjK5m
        sKboN/JEnnB+keZxK7+0+/Tdy5N/WtyqH6UvVWIA7w==
X-Google-Smtp-Source: AHgI3IZPA5JQX3LN1TmO7/1Irgz2QLx2XEb7G8T/3ZHe5Auzt24D3VLkLYDHw3FjVs/2nhqBoUucWzMyyZFBcAJr0s4=
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr30294010edy.81.1549278575066;
 Mon, 04 Feb 2019 03:09:35 -0800 (PST)
MIME-Version: 1.0
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
 <20181218144702.752d97cd@windsurf> <20181218153404.45b038cf@windsurf>
 <CAEzXK1ryTQ5sbUSuZoq36ss=Z7ewLegaxsXtvsNOGqHyTQibmg@mail.gmail.com>
 <20181218213716.70d27f1f@windsurf> <CAEzXK1qKXikS4qd1q_kw7r-_ykBgYnKQzGFhV4TT_HXhq2v6Tw@mail.gmail.com>
 <20190108114817.2bb15d5e@windsurf> <CAEzXK1oQd1YNZ5pyNXA76h-3CbBRxmTke=Z-SRusyfqL=Wd8eA@mail.gmail.com>
 <20190109091520.23641675@windsurf> <CAEzXK1oHqOb3pojfX7JqrirxjOFj=UZZfi6tNNO4y6yC3u9LAA@mail.gmail.com>
In-Reply-To: <CAEzXK1oHqOb3pojfX7JqrirxjOFj=UZZfi6tNNO4y6yC3u9LAA@mail.gmail.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Mon, 4 Feb 2019 11:09:23 +0000
Message-ID: <CAEzXK1r_Xf=-JSzrP8+0pgeqE+RE0Vx0JAKM0PW7qzc4fgQLNg@mail.gmail.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated bridge
 config space
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

Have you been able to find the issue from the logs?

Best regards,
Lu=C3=ADs Mendes

On Wed, Jan 9, 2019 at 2:38 PM Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> w=
rote:
>
> Hello Thomas,
>
> Replies in between.
>
> Best regards,
> Lu=C3=ADs
>
>
> On Wed, Jan 9, 2019 at 8:15 AM Thomas Petazzoni
> <thomas.petazzoni@bootlin.com> wrote:
> >
> > Hello Luis,
> >
> > On Tue, 8 Jan 2019 23:22:05 +0000, Lu=C3=ADs Mendes wrote:
> >
> > > > Sorry for the long delay, the Christmas/New Year vacation and some
> > > > personal issues got in the way.
> > > No problem, life has its priorities! and by the way: Happy new year!
> >
> > Thanks, you too!
>
> Thanks!
>
> >
> >
> > > > You will most likely have to increase CONFIG_LOG_BUF_SHIFT to avoid
> > > > having dropped messages, as my additional debug messages are quite
> > > > verbose. I'm using CONFIG_LOG_BUF_SHIFT=3D16.
> > > The logs from the new kernel are not starting at 0.0 sec, as
> > > CONFIG_LOG_BUF_SHIFT=3D16 wasn't large enough, but for the reverted
> > > patch case I changed to CONFIG_LOG_BUF_SHIFT=3D17.
> > > If you find relevant information can be missing tell me and I will
> > > recompile the kernel with the patch
> > > 1f08673eef1236f7d02d93fcf596bb8531ef0d12 applied and
> > > CONFIG_LOG_BUF_SHIFT=3D17. I believe it won't be needed though, since
> > > the pci logs are practically complete.
> >
> > Sadly, the kern_4.20_debug.log file is incomplete. I would like to at
> > least see it starting from:
> >
> > Jan  8 22:57:51 picolo kernel: [    6.792819] mvebu-pcie soc:pcie: MEM:=
 [mem 0xd0000000-0xefffffff], IO: [io  0xffe00000-0xffefffff]
> >
> > (this line from the reverted log, but I'd like to see it in the non-rev=
erted log as well)
>
> In attachment follows the requested complete log using CONFIG_LOG_BUF_SHI=
FT=3D17.
>
> >
> > Thanks!
> >
> > Thomas
> > --
> > Thomas Petazzoni, CTO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
