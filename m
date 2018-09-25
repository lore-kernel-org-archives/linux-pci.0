Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A0BC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 09:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3812145D
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 09:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp4eC/9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3812145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeIYP6q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:58:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35593 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYP6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 11:58:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id z14-v6so7625468qtn.2;
        Tue, 25 Sep 2018 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1EtgfBVq/RyIbM+4rjMy5JxcxJmdrOn6NGo5Mv2VPM=;
        b=Dp4eC/9xIFxoAJdxAej4zfuFw5uH2IwevIxjIBZd8T21xSKVTply5sToSjjoW0n4Rn
         Oqq1EA/tBOZTrlbak0lViobP+/UVZ5Ug4P3gCpwU1pnCyXkKlX9Ehy6S1JbL/fwtFwAU
         qh5L1a6M1kouawe5pp+yP5Fc5PtPavkt8PIPW8NboODfDg13c/m3HPSWm6yZZNMDkvTR
         rN+qLxiWwMzDPap9xmr17+QU2FjTDjrEDAtu3KGaQt+KRLQy8GM/XgB9pA6iW30zpgvn
         HxQ3/0BMlFXP0F0r66wKwxnN1LqHS2rzIH1ADhAt6c7E51CFU9vOF8ysvLM8KRM1S6JK
         w4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1EtgfBVq/RyIbM+4rjMy5JxcxJmdrOn6NGo5Mv2VPM=;
        b=MUvjUEQWNsLViSK9ywc5QTiH1tiU2QJfowwll7DjZ52k3KDXGjzQrLr77rq2vcCzj3
         Shik80olN/GsUOSHKuBLOe5PL8NE2fghur9iOvr0CtinJoExfl2Aeq0pofXaQf91cHKi
         VvBwslHLdHFeLNDXTGLZg2sDxoNFfa3NgNUQcOb4+jmtOGsqpcGjD/BfGDqnyB7+KxWa
         DkvnRN1gK0XSj8N6O7gf5pvvBxi2wy1cWK3y+YW4Abs4Fb9+lOkrEjiXPIswlLzgWOgN
         nIVH2MORVGiX4iySsjuwXpzLqAj60Her//EpAHZW5sIy3OxzTfnRM3/c4z9WuK9eHCHG
         cb2Q==
X-Gm-Message-State: ABuFfojkkINjP1Sn+5iZR7pydDEbnieoNvb7j496O/1YryWC2n++pJ3R
        cvq8HBL0mBxN1O530Nb4hyr8j+pKQyndKK4o1wI=
X-Google-Smtp-Source: ACcGV61EdmrwZjhGJZ/uPIvK9jSLIE8Ybq0t7c76nOobRxsdXs5T7u9KuAkFMf6irQWdD0KNCh9HZQvZBIDn2D6YTaw=
X-Received: by 2002:ac8:16c5:: with SMTP id y5-v6mr116803qtk.187.1537869121115;
 Tue, 25 Sep 2018 02:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <1537770916-16337-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537770916-16337-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75Vd7eLgK59DdmVCE7jZgnkpGq0+21DqU=f6PghdvpUEzuA@mail.gmail.com> <CA+RiK64ExuUXKHk8tRAoYT7aSCqX4T4hofWrpkD4KysG0WrhyQ@mail.gmail.com>
In-Reply-To: <CA+RiK64ExuUXKHk8tRAoYT7aSCqX4T4hofWrpkD4KysG0WrhyQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Sep 2018 12:51:49 +0300
Message-ID: <CAHp75VdiGrBR1cVKDKo=kNJpzLY7YyFtTwTWva5uo1R1R5833Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mpt3sas: Introduce mpt3sas_base_pci_device_is_available
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 12:46 PM Suganath Prabu Subramani
<suganath-prabu.subramani@broadcom.com> wrote:

> > > +               pr_err(MPT3SAS_FMT
> > > +                   "%s: pci error recovery reset or"
> > > +                   " pci device unplug occurred\n",
> >
> > This should be just one line.
> Above line crosses over 80 characters, so it is in two lines.

For years there is no such requirement for string literals.
Please, don't split string literals in ugly way like this.

-- 
With Best Regards,
Andy Shevchenko
