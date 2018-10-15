Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB1C28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 06:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BF92086A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 06:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GyLZ+46i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BF92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeJOObn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:31:43 -0400
Received: from condef-01.nifty.com ([202.248.20.66]:64955 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeJOObn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 10:31:43 -0400
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-01.nifty.com with ESMTP id w9F6dG1N032023;
        Mon, 15 Oct 2018 15:39:16 +0900
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9F6ctgF009205;
        Mon, 15 Oct 2018 15:38:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9F6ctgF009205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539585536;
        bh=FYdlgiyhR1emINlVOJJ7iG9fxuZSD3FtlSJJ8ALoZNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GyLZ+46iwH58pJJ9dZBfBo8O5ZR3Qcof4bp1jimBMk1j24qPE5O5PllVNUuoJNlSo
         kVNBk/bXs+Y6UrPJtC8i8Nb3TZY+jqdo+JJqJyAjeOOaHfy+DVDTTJHwcPwkmfXqyU
         07L887dEMPMhDzfjC9hRW5TmI9sEIsobXU/EkltwyG0CDdThQuBPaqaGHF6wQ9F14X
         UJKHNqeiu2bDZTdzUnbslyduAqHG6Jx8SFWDihmr31vps6IUBArmWoVp0ZTbjPPFZD
         BV0jUIeixJQh/hAEaw35ZVEJUTqsiksYhGfdFOE11fGdD+N2VceeuNhrfVQjZ+wDIr
         iCyYGEuFwM8OA==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id a202so15599820vsd.5;
        Sun, 14 Oct 2018 23:38:55 -0700 (PDT)
X-Gm-Message-State: ABuFfogU/xoJP5xL0EJ/wH4J1RV35UMoGEe1p6LWt4+u8BA8hESyuJO4
        Y/Es8n/XWk06M96wiQuCIHCghpYKvlzTGUbLpZY=
X-Google-Smtp-Source: ACcGV61s6G43qzxF+3g7ymfJAzcYzoexaIe7pUXSgcq/yzNXU3xzYFOQWFpatejDM62wd4WC7af4ZLpHLdSEPMIxqqM=
X-Received: by 2002:a67:61c1:: with SMTP id v184mr6208631vsb.179.1539585535007;
 Sun, 14 Oct 2018 23:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de>
In-Reply-To: <20181013151016.31674-1-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 15 Oct 2018 15:38:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3SNStaA6-tOWhm0QHWpNczO07x9T2F7gMcusduMS7GA@mail.gmail.com>
Message-ID: <CAK7LNAQ3SNStaA6-tOWhm0QHWpNczO07x9T2F7gMcusduMS7GA@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, alex.bou9@gmail.com,
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

On Sun, Oct 14, 2018 at 12:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> currently every architecture that wants to provide on of the common
> periphal busses needs to add some boilerplate code and include the
> right Kconfig files.   This series instead just selects the presence
> (when needed) and then handles everything in the bus-specific
> Kconfig file under drivers/.
>

Thanks for great work again.

However, I suspect some breakages
(not testing yet, just quick review by my eyes.)

I left some comments in individual patches.



--
Best Regards
Masahiro Yamada
