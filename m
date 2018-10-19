Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A3ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C142021476
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 07:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C142021476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJSPMu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:12:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37483 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSPMu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 11:12:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id r83so24672063vsc.4;
        Fri, 19 Oct 2018 00:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLmNJ36LwWMMqsWlkLCeV/YPO9vavlldT3NFPf3a7Oo=;
        b=mkBkbYQlL9remZ7zIFQc/WRs24XSXsoo+T9zT3xltSGafacSpjD1f0vOAg1sq2gWpJ
         w6iwa18JMUDv/3it2Ki2oTntrCPf/1l4DfHfy6Jdpt45xKw4RHmHMS8HJ5JH6MPkyvZD
         qKfRVmjp5S8xYJdCELNLpdx63u7kUqow8sJ8ujG2btWzDp+7EVuMGkWKJPoy1nt8tpOD
         eO3ebC4rfTmDF5D/b/nMxrnLxouBiiJqq/5NV+ergC4A+LlO2fnAYhOkJfBIhmOqiCL5
         1MYJQDM20N2qJ4mjq8fro2iDHpusuietHkXR8MFY5pDVPdrtGJnXO0HSwB8+sAO7r5rH
         oImw==
X-Gm-Message-State: ABuFfohq+rPdNfhU1i9MlAAaEpMsYYuQ1eNi8WouOeSJqDrVfy6uLpIh
        n1kHca7n6UNkjKwm7OCzEOOFhkNisOvo1XxUl3s=
X-Google-Smtp-Source: ACcGV63MZWH9kgfSRarxsGHQippQr9x3U34azOeqL/0fDkSg3YuBDZAUiWZsHYJl0HSyGNXWbm4+scC8JisJDruGpnk=
X-Received: by 2002:a67:7b56:: with SMTP id w83mr14117399vsc.152.1539932883023;
 Fri, 19 Oct 2018 00:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de> <CAMuHMdWMtxxu8iivcnT=uWTMHsp=iSq_QzXqDWQut5OHwTU8Sg@mail.gmail.com>
 <20181019070001.GA30556@lst.de>
In-Reply-To: <20181019070001.GA30556@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Oct 2018 09:07:51 +0200
Message-ID: <CAMuHMdXLug_T4onn23JormmYZXDWVnEFYaoMzA90bpGFvk6Eow@mail.gmail.com>
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

On Fri, Oct 19, 2018 at 9:00 AM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Oct 17, 2018 at 10:30:49AM +0200, Geert Uytterhoeven wrote:
> > Please use "git format-patch -v<N> --cover" to prepare patch series
> > for sending with git-send-email.
> >
> >   "-v<N>" to prefix all patches with version number <N>,
> >   "--cover" to have a "[PATCH 0/<M>]" prefix in the cover letter.
>
> We had that discussion before and I strongly disagree with messing
> up the subject lines like that.  The git-send-email defaults are
> perfectly fine.

Can you please clarify what exactly that would mess up?
Documentation/process/submitting-patches.rst even mentions the tags
to put in "[PATCH <tag>]"?

Without this:
  - It's hard to visually match your untagged cover letter with the
actual patches,
  - Your individual patches lack the version info, so people cannot see which
    version review comments in an email reply apply to.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
