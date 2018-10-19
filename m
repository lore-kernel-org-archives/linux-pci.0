Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329DCECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 04:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6AB2083A
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 04:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0iIMhwfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6AB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJSMxW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:53:22 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:37776 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSMxW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 08:53:22 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9J4mto3016890;
        Fri, 19 Oct 2018 13:48:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9J4mto3016890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539924536;
        bh=FyBXPZb6jyuBzv8irLjTgnaBuu5+uDweGqVCUHokX+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0iIMhwfspe5XKMeWAwT04VJ5MmgmULvXe3FY9yFVdIQArEwjLUeyeMAlgKadghEzd
         uNQRC3O6S+XrUE9wNM6jMvnfuNp0yMKOe6dXaSubWrMGS7auskPZbyTM9ftMc5/eFE
         GqZjgk2XISMmgyUbO/nbTT3YHMou3RXUD73G5nHoA/F4LdZ0XvZDBtKYlC0RC3FKrR
         dEsFoQ/43iK9JBPA6KQlD2s3blCXQU2ERctvViEIZnSj/enWHl5OvrSpjNBCeh0cTt
         XFM0+K4k27VcPAd1bciULI1vW7FBoI9QDmopbsQzDgJxMfy/1ekb9J6km9PtpKSS7I
         jqqcgz3LVsybw==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id y128-v6so7806026vky.4;
        Thu, 18 Oct 2018 21:48:56 -0700 (PDT)
X-Gm-Message-State: ABuFfogixMZnXWgWuxdP4Zc8r+V3+0ho3pkXrmY7Z0yuWDe/IuM3rxry
        yglDRCrhDm+YIfgzyk0OLp4NCHofyPYEEWzizVM=
X-Google-Smtp-Source: ACcGV61ED3uOk4PfLYjkeDtUX81TT1OdfmxJ+WdXMJn3e2O3hj/T8Nd6sgKwrZ6bQ1llnke/KRBnWBXfL30XVLPPeqI=
X-Received: by 2002:a1f:5503:: with SMTP id j3-v6mr13630030vkb.34.1539924535097;
 Thu, 18 Oct 2018 21:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de> <20181017080201.10866-8-hch@lst.de>
In-Reply-To: <20181017080201.10866-8-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Oct 2018 13:48:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAk1oL8xbwp4RqMcZc5CtU7=YCqN2wHcSOq4RsJtJgRA@mail.gmail.com>
Message-ID: <CAK7LNATAk1oL8xbwp4RqMcZc5CtU7=YCqN2wHcSOq4RsJtJgRA@mail.gmail.com>
Subject: Re: [PATCH 7/8] eisa: consolidate EISA Kconfig entry in drivers/eisa
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 17, 2018 at 5:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Let architectures opt into EISA support by selecting HAS_EISA and

Nit.

HAS_EISA -> HAVE_EISA
since you renamed it in this version.



> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---
-- 
Best Regards
Masahiro Yamada
