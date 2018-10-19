Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2B6ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 04:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A3721476
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 04:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qJfHf/u8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A3721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJSM6j (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:58:39 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26252 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJSM6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 08:58:38 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9J4s1sX025423;
        Fri, 19 Oct 2018 13:54:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9J4s1sX025423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539924842;
        bh=RNkLfLEq3b1sRQCAYs++9f55uIJFFKxyLPJfhC9T2Aw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qJfHf/u8FhXixU0ilqZedST8iJ1W1PIdeDL1fVUyIwzDJsg4Z5ST4R6yourONQzzN
         awVlWuWyA278Uu5nTn8Ft4nwOwS5MdGjDp3dYgnGmp7YAkcYiD+dhsuMwwJxB3Xtis
         klcQaBxGpMdretBm2+Ivzwcgly3vVlwpWrBmpGcLPLs75LevBw4ZrcwH2qZbJJEwvI
         JmlcX1XJ188AhD7vFeGA8R85efoQFRibx0ZLypIFSmiY8P7zJUSpOzNlhZRBw+o6d8
         Eno6aI1nR8+fx1jf9FkS9D1qyvUKgleiEw3S2k6tdqzNBOB9Fgy9a1MvWLQ1fLS64l
         tA47w20SAbyLw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id y195so8776559vsc.7;
        Thu, 18 Oct 2018 21:54:01 -0700 (PDT)
X-Gm-Message-State: ABuFfoixF6mbxfJjcduO+8toPGMMWdsqUCkdpJmWn3flUlS+w7X8+F/Y
        IieO8PrzhQQ+OLtfLdjKW1CsQ043gdNVFfv2/n8=
X-Google-Smtp-Source: ACcGV614NCU3U5tl4IH6UVmjLSYbhNBDCyShM6XvSrcxkB5ZyAbXiToqAFqwdzImaDPGXuq6OVnOPtfyUM9GhgoLfe8=
X-Received: by 2002:a67:65c3:: with SMTP id z186mr14242000vsb.54.1539924840809;
 Thu, 18 Oct 2018 21:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de> <20181017080201.10866-7-hch@lst.de>
In-Reply-To: <20181017080201.10866-7-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Oct 2018 13:53:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNASnVLk50oYjGSE0ir3SDja3acPq1=oLjzZCLoSNiUNVdQ@mail.gmail.com>
Message-ID: <CAK7LNASnVLk50oYjGSE0ir3SDja3acPq1=oLjzZCLoSNiUNVdQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] rapidio: consolidate RAPIDIO config entry in drivers/rapidio
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
> There is no good reason to duplicate the RAPIDIO menu in various
> architectures.  Instead provide a selectable HAS_RAPIDIO symbol

Nit.

HAS_RAPIDIO -> HAVE_RAPIDIO.



> that indicates native availability of RAPIDIO support and the handle
> the rest in drivers/pci.

Copy-paste mistake?

drivers/pci -> drivers/rapidio



>  This also means we now provide support
> for PCI(e) to Rapidio bridges for every architecture instead of a
> limited subset.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>




-- 
Best Regards
Masahiro Yamada
