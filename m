Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982D0C43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD38206B2
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 02:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="m4/YNoiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD38206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389900AbeKWNT1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:19:27 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:39005 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNT1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Nov 2018 08:19:27 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wAN2ahNn028785;
        Fri, 23 Nov 2018 11:36:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAN2ahNn028785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940604;
        bh=Grkalro82XcZftrUmZQ9Uk6Q9M7QC4TvdZzw2JwHwGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m4/YNoiAWV2v+sVOr1fHL7xqC8GWiY8Vsf1Zh/Te7GtZA5n3DT+2PCGjPDWOyBiI5
         VDMkFN9xt471NqfL9TeLNSf5rMsiz2m9eX5uHzQWq1v91OzJqHgjI7jOKMJWSWGbZd
         9zxF+XIcf0OpzCBzmFgn40r/HGHy/lbtAWfS/28bhjHBfRUcyqAsAT8ByPrCKlT2so
         VEq+8z7jIfRkdqj/4ytGmuNF35qiArHgXpvMKLmrYGTyN0Mlkp3SdheV41Kpl8g3V6
         okWinZX5ZZw6Dcwx5HR1Gfvs6Dtmj79rb2pTHqHelZAiglvY/97E7vefBb3I9UJwM0
         s6819/ft24nwg==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id e7so6375326vsc.2;
        Thu, 22 Nov 2018 18:36:44 -0800 (PST)
X-Gm-Message-State: AGRZ1gI5fj3GDJrGMhIx666iUSjgED9gkvl8rcOkv6xlf9WLwscq1ANi
        Qkpo3eT3oSklbbCzNqB3VM+VjNsaQXd3VNhCr54=
X-Google-Smtp-Source: AJdET5cvDS4SzyKrkGSSYigRcVPdU3u9wSG0ScXvHCVHXLUFXKqmyJ6YAXR/wfz8J0hWT/0RlTy9yMtfPTbMsNHvyDU=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr5688953vsm.181.1542940603144;
 Thu, 22 Nov 2018 18:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
In-Reply-To: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:36:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARA-wbDDh_T2HghAUGizY-bF28O_8cjLmp9DMHaoxZPNw@mail.gmail.com>
Message-ID: <CAK7LNARA-wbDDh_T2HghAUGizY-bF28O_8cjLmp9DMHaoxZPNw@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v4
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 23, 2018 at 11:32 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Christoph,
>
>
> On Fri, Nov 16, 2018 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi all,
> >
> > currently every architecture that wants to provide on of the common
> > periphal busses needs to add some boilerplate code and include the
> > right Kconfig files.   This series instead just selects the presence
> > (when needed) and then handles everything in the bus-specific
> > Kconfig file under drivers/.
>
>
> Thanks for this work!
>
>
> I applied this series, and it is available at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> kconfig2


BTW, if you find questionable parts,
please let me know.

We still have plenty of time by the next MW.

Thanks.



-- 
Best Regards
Masahiro Yamada
