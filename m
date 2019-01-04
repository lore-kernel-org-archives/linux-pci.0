Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5DDC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566C721872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 18:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnQSsnbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfADSwY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:52:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38398 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfADSwY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 13:52:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so2117944wml.3;
        Fri, 04 Jan 2019 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyuUEfuTmvLhi67JS1rUvXvyUvFfSZPSyZaSd19L4GQ=;
        b=NnQSsnbz4YbBYK57SjeCoU/J+ug6Tmj8kMnUjyShlT+W4E0eEIL2be8pRzNgFuYlaK
         +FQhAYfblbB4mwxlXQ6ZxVSyFhLEyRsm2HZtWrGnAZIOM35BcNnee4gutE2TjrESNzRh
         to4jXNx2R3/SP/tKxPfpBhoReJ67XxP/FTQBqgkvTNhmkkGZqDvHdAbV2cxXc+6ALMaI
         +fv3pch4Pt4DGTU139scBJkC1KU1tl0C0gUr83gEiL0o8BE4lEXkrrhmRyXRIC//RJEE
         sqtae4CgPXuHH7/YCDTdhEdMU4LzBo4xe95v4y+sYwYo6FCSSppyLAgw8MecrixYFaet
         mpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyuUEfuTmvLhi67JS1rUvXvyUvFfSZPSyZaSd19L4GQ=;
        b=JBWhMH5NIqAsJTHyro9Zyibkoy8L8VQiFfYf/96ZokSPe+HqZMwQyoG9X+d+VuJWLq
         Qb+dGUcXRASCHJMhxTO9stHKbDWwWcqjW2PZ+LTlqj0SsUmox34hNOAcF/XUZ196IlJf
         qtokqPCgVz+QTFIOthDVgGepLAdVJzb5OYMoZaW/O24/YnMD66cwqRUhjwfT9YStCWJO
         V6LXBYmNj9CWd17ieLAZ5RLS9gAi2ht/PVogWq0slCeBXXsjBa3ALfR8azYjvAXtNhIl
         CmrPsCmJy3Is/rMo64lIE3a5AS4pmLUivsZPkpHEIokSTnwO9Ux6XmNUz5+tHVmIgXBE
         6nlg==
X-Gm-Message-State: AJcUukcSUgGpX3Rxy5zQKb+d78NUZ68rKw27uQw1kBa7O2CYiZWNmJXC
        MxBj2CFF50jnB5q1tFPzhEWDbRUhmbQLkPEbDAs=
X-Google-Smtp-Source: ALg8bN5kCCB961KFTPcrrskQbky8VXN0Wm99dD6nYDN4XYlp9012ACMUURVoxrUAHBpzrHCfOe70Il70mxSksZCrYR8=
X-Received: by 2002:a1c:760c:: with SMTP id r12mr2032207wmc.127.1546627941636;
 Fri, 04 Jan 2019 10:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-8-andrew.smirnov@gmail.com> <9b275993-c511-50d3-e18e-b421010c1bba@synopsys.com>
 <ddbf72a52cd5b6c5e2cba2c6f301d12be651e220.camel@perches.com>
In-Reply-To: <ddbf72a52cd5b6c5e2cba2c6f301d12be651e220.camel@perches.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 4 Jan 2019 10:52:10 -0800
Message-ID: <CAHQ1cqGbeJjKyGW1xed+nqTOyMNG6NFe-o-3cHbRfyBvYTrK_Q@mail.gmail.com>
Subject: Re: [PATCH 07/21] PCI: designware: Make use of IS_ALIGNED()
To:     Joe Perches <joe@perches.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 4, 2019 at 10:38 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-01-02 at 09:33 +0000, Gustavo Pimentel wrote:
> > On 21/12/2018 07:27, Andrey Smirnov wrote:
> > > Make the intent a bit more clear as well as get rid of explicit
> > > arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
> > > "size". No functional change intended.
> []
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> []
> > > @@ -22,7 +22,7 @@
> > >
> > >  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
> > >  {
> > > -   if ((uintptr_t)addr & (size - 1)) {
> > > +   if (!IS_ALIGNED((uintptr_t)addr, size)) {
>
> The (uintptr_t) cast could probably be removed as well.
>

Unfortunately no. IS_ALIGNED(x, a) is going to expand (((x) &
((typeof(x))(a) - 1)) == 0), so we'll end up with (((addr) & ((void
*)(size) - 1)) which has two problems:

1. It tries to use & operator on two  void * pointers
2. On 64-bit platforms (e.g. AArch64) it will try to cast an "int" to
a pointer, resulting in "warning: cast to pointer from integer of
different size"

When working on it, I initially wrote the code without the cast, but
was quickly reprimanded by GCC and had to add it back in.

Thanks,
Andrey Smirnov
