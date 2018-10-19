Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEBAECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD1621476
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD1621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeJSP1L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:27:11 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36390 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSP1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 11:27:11 -0400
Received: by mail-ua1-f68.google.com with SMTP id b3so7107257uak.3;
        Fri, 19 Oct 2018 00:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9M+23qGHXE/U2KlyBiQJk5FJr+RRde46uCiNZoKMKs=;
        b=CAWnV7jujHeA08O1f96OUn1j4lCt6HajzJjvsFuG+Zj1Rn2Ev8K05NLwROpwT4UkiU
         7JtXAp2u67Z7ww/SvgKTiWZsPfUKwj2Sbj5ydOEnI5mNXpvCfRpVgbjQRciNSLv8n6CV
         fkS2yByhTMqYEDoNgL4uosPRAbmSg6JCU8GdeJK8Z5KU8iCYzRDwpNsMh1UMBmw82mLr
         nrwMrQaNWcujM9uiTAIq1RwIacSqIS49ALf7HObzWW5gJZPJe5XhpQncRcx0cYSSUSNv
         iyqCe+Y/f33cFvLLHyYXFTi/9CvgOzOSTNfy0nAPTuLBh515IMjlIYCuGVKeL5REZ57W
         bMuw==
X-Gm-Message-State: ABuFfoj52C1kRZAtq5KN3yJiPK7mFhDaJNlKmCZSGC60haU4rFCw48zG
        7YTmJsjHRrWcHbN0Ft6WZShHhR3yFPcNy39ij6hntTAv
X-Google-Smtp-Source: ACcGV629ggddtMEIiseKreDw2VqZ5fppJthrh/nXaz8t/qT25KuCsWCBbhQ+XNIjv0DaAIRtFmGlGIHhmY1yWYLd0EE=
X-Received: by 2002:a9f:308a:: with SMTP id j10mr4392208uab.28.1539933740665;
 Fri, 19 Oct 2018 00:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de> <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com>
 <20181019070001.GA30556@lst.de> <CAMuHMdXLug_T4onn23JormmYZXDWVnEFYaoMzA90bpGFvk6Eow@mail.gmail.com>
 <20181019071057.GA31656@lst.de>
In-Reply-To: <20181019071057.GA31656@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Oct 2018 09:22:08 +0200
Message-ID: <CAMuHMdXqPNOwcjWVmH08YSfZopc0pWLUj-r0s6g=q0oUdqWhWw@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On Fri, Oct 19, 2018 at 9:10 AM Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Oct 19, 2018 at 09:07:51AM +0200, Geert Uytterhoeven wrote:
> > Without this:
> >   - It's hard to visually match your untagged cover letter with the
> > actual patches,
> >   - Your individual patches lack the version info, so people cannot see which
> >     version review comments in an email reply apply to.
>
> All of that is trivially solved by mail threading.

You forgot to answer this question:

| Can you please clarify what exactly that would mess up?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
