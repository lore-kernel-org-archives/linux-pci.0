Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B23C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 11:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F8E2075B
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 11:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsPIzffy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfBMLet (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:34:49 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:39014 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbfBMLet (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 06:34:49 -0500
Received: by mail-ed1-f52.google.com with SMTP id b14so1630305edt.6
        for <linux-pci@vger.kernel.org>; Wed, 13 Feb 2019 03:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qLZz33ReVd1E6Xdctk1r6cfVRX+XnhYnKwEOTFcBr+E=;
        b=EsPIzffys8BC+N+jj2HJT08Shl1QTkqdMpEC3P8XFl7neIdMGHgCa/oVKHxMHdG+D+
         uTEn3q2MiB/GTEUUgAIILtus7YkBzMde5M2BzHMe1AFDdddJ0B1DNQn3P6wnO+84KphV
         B4+3Oa7Ktx9AfSInwlkIOMUDObjKna43DP09gDoY7Jg1Aoj+222QJqlY2jE7Gah3pCW1
         OUFKblnzpukyJTNitUMH/ohPKXCPRzDTN75X1BDS4DQ4srJKlrnSfyL2bfHPRu+l7Xd4
         tPPREl+tWIlGdfFcaMscAN/BiDCP4glv6xYyHazeFHl+sK6eiDu23sFnsXiD8NPRC1pQ
         x1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qLZz33ReVd1E6Xdctk1r6cfVRX+XnhYnKwEOTFcBr+E=;
        b=sMrDm47q0ftAL9boee5wKSh0GAlBp1RaJ7xtxFKZ+wGdoTgI081PqKKTOLfDU2z4H+
         g/Vc5c+wk1JLWmwhcv7ZsUaWtdVqYlZxiddpanBxj6xfiqHzYfAKXm60L9HWNFPZQA5i
         uS07dfImEa/HVJ+NoGoQpTo7u3/BWPb+7xpet36pJpr3+U114uHgVqxorzAGb9r033S6
         AQ3nMLok0CaC14VAEdEhdOHbYczsaHOVvQwdwEmnKZUy992Ii+WJeM89N6zCvN/8fvU6
         cRRi6jgDXa3N/FgJC0WmUfzxR4Cgui5cqjVWXJTo1lBCoigXgdW5WDqF5q4jd0ABuitY
         5APA==
X-Gm-Message-State: AHQUAuaNY5jPfuO13hxG1N2pnsoRO+NZcXhHvtquYK8CKka+FaR8XEFu
        wRd91P/AjY9KhMiNWbx+VvcedWPF3xmoE6QWoa0=
X-Google-Smtp-Source: AHgI3IYxtLJyxYT8UBni7uXLO0lHfKZXSkJksPO0XgEuP9ShLzvyrSOqemcfmDaeeqn6Di9Xeu8soVEjbk9rc0HfiYo=
X-Received: by 2002:a17:906:81d7:: with SMTP id e23mr6115963ejx.207.1550057687559;
 Wed, 13 Feb 2019 03:34:47 -0800 (PST)
MIME-Version: 1.0
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
 <20181218144702.752d97cd@windsurf> <20181218153404.45b038cf@windsurf>
 <CAEzXK1ryTQ5sbUSuZoq36ss=Z7ewLegaxsXtvsNOGqHyTQibmg@mail.gmail.com>
 <20181218213716.70d27f1f@windsurf> <CAEzXK1qKXikS4qd1q_kw7r-_ykBgYnKQzGFhV4TT_HXhq2v6Tw@mail.gmail.com>
 <20190108114817.2bb15d5e@windsurf> <CAEzXK1oQd1YNZ5pyNXA76h-3CbBRxmTke=Z-SRusyfqL=Wd8eA@mail.gmail.com>
 <20190109091520.23641675@windsurf> <CAEzXK1oHqOb3pojfX7JqrirxjOFj=UZZfi6tNNO4y6yC3u9LAA@mail.gmail.com>
 <CAEzXK1r_Xf=-JSzrP8+0pgeqE+RE0Vx0JAKM0PW7qzc4fgQLNg@mail.gmail.com> <20190212144156.655f6824@windsurf>
In-Reply-To: <20190212144156.655f6824@windsurf>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Wed, 13 Feb 2019 11:34:36 +0000
Message-ID: <CAEzXK1prnOXSkOEtTqXaR05pND=OMr2qiFHfqvnbUh+qyMyY-A@mail.gmail.com>
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

Hello Thomas,

The kernel with pci-mvebu-fix you provided is working nicely with the
AMD graphics card, and other PCI cards that I've tested including an
Intel I350.

If you want you can add a:
Tested-by: Luis Mendes <luis.p.mendes@gmail.com>

Luis

On Tue, Feb 12, 2019 at 1:41 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> Hello,
>
> On Mon, 4 Feb 2019 11:09:23 +0000
> Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> wrote:
>
> > Have you been able to find the issue from the logs?
>
> A separate issue was found with the pci-mvebu integration with the new
> emulated bridge code, I added you in the thread.
>
> Could you test if:
>
>   https://github.com/tpetazzoni/linux/tree/5.0/marvell/pci-mvebu-fix
>
> improves the situation for you ?
>
> Thanks!
>
> Thomas
> --
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
