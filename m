Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85581C63697
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9C324199
	for <linux-pci@archiver.kernel.org>; Thu, 19 Nov 2020 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="an3c4i3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgKSORj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Nov 2020 09:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbgKSORj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 09:17:39 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFA724199;
        Thu, 19 Nov 2020 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605795458;
        bh=tRhzgdnm49wLGYBksavMXrneoZPG3bG+rYPWCGwty94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=an3c4i3/DR0eegqVhBgJASPzCAUqbuw0i6yqXdVFm63zrutAXecwqwhxsbd2T8/+0
         Vx/sUvWnGfyrMTxDMmD/Cgj6e7pKor/xTDNlebSCRfoSUH/8F3gCMMq02UxVNnIfR2
         BmmSwsaYs1PtAhkC1J3iX5IKxqJijwUETa+7QiH8=
Received: by mail-oi1-f170.google.com with SMTP id s18so5313016oih.1;
        Thu, 19 Nov 2020 06:17:38 -0800 (PST)
X-Gm-Message-State: AOAM530jMBODYN8FFCMWLHWdGAbh703z8CDQzJc3EnBnIwRNYtHjO0IB
        DWlYVf+xsx9pxg/BL0MdUKZkGmby+EYoWgfCtQ==
X-Google-Smtp-Source: ABdhPJy5aycKt4bA/mJAKjfO7Q4kZb+EgCZ07oXCa+mWpPC51S/i92s2ptkiAs0/ZTKg40x95hPXeAYFk9BQvyQfpiw=
X-Received: by 2002:aca:fdd4:: with SMTP id b203mr3032696oii.152.1605795457466;
 Thu, 19 Nov 2020 06:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20200921074953.25289-1-narmstrong@baylibre.com>
 <CAL_JsqLZzxXcvoqd29NM45UjL-mbSiHphTO_zOwbCwPKd+jWEw@mail.gmail.com> <20201119111201.GA19942@e121166-lin.cambridge.arm.com>
In-Reply-To: <20201119111201.GA19942@e121166-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Nov 2020 08:17:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKxLxijhcG7SHEqfA3j6xM6cJpv-3fT2r1Nysst_8ireg@mail.gmail.com>
Message-ID: <CAL_JsqKxLxijhcG7SHEqfA3j6xM6cJpv-3fT2r1Nysst_8ireg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc/meson: do not fail on wait linkup timeout
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 19, 2020 at 5:12 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Sep 22, 2020 at 11:30:30AM -0600, Rob Herring wrote:
> > On Mon, Sep 21, 2020 at 1:50 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > >
> > > When establish link timeouts, probe fails but the error is unrelated since
> > > the PCIe controller has been probed succesfully.
> > >
> > > Align with most of the other dw-pcie drivers and ignore return of
> > > dw_pcie_wait_for_link() in the host_init callback.
> >
> > I think all, not most DWC drivers should be aligned. Plus the code
> > here is pretty much the same, so I'm working on moving all this to the
> > common DWC code. Drivers that need to bring up the link will need to
> > implement .start_link() (currently only used for EP mode). Most of the
> > time that is just setting the LTSSM bit which Synopsys thought letting
> > every vendor do their own register for was a good idea. Sigh.
>
> Should I drop this patch then ?

Yes, this is done by my series.

Rob
