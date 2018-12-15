Return-Path: <SRS0=lgj/=OY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78E0C43387
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 05:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973AC20645
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 05:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJcmN7HB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeLOFZS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:25:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34767 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbeLOFZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Dec 2018 00:25:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so579138wmd.1;
        Fri, 14 Dec 2018 21:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFbplDPFVR8IjguHTaUgm10Ph2HuOvI6GzWtn3DhDHY=;
        b=UJcmN7HB8m+Lny2r580zxxMsj84JUEsOvWI2n5UbpgJ09yxAISUGb/FTSKhp5K93am
         4yDlzHHyXTsvpJ1MVyQ+ZeSsHTtbuWegITmxFuhJ2inU6lPF7RVvkvWCaehTq62l+fen
         3MgwsE6M0a+Tf+NK/wbvDyLffadGmlh2dJVssKj4nxoibazKMaL+j2dgZaWaCsoJK4hB
         FgmDXwynv6jG0H9gcwJ5AEalc57hVb84Z0G1Wv97MThh2L6KcfcxJtm62mhOt860yHST
         GE77RTs2sYGGsHc1Jn0XI+6qEoHvYubgHfUABnjStoCxDXPQRcueF/p4whqWdWJ2rWe7
         ++uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFbplDPFVR8IjguHTaUgm10Ph2HuOvI6GzWtn3DhDHY=;
        b=OeOt2tJ4KZq0x2NvwALWo8QJ2eAQXxjrh1Jbk9lo97j1TwYcwcQevZwZzpb+JBx/tw
         Em/fX+bFkvuz5kXhu7VoloyfZyGsef7g2VcrI7IVaeXcvh6ZSdC5jhO585UpkjYHduM5
         M2WtK3GaHnLi+tPEIj1OzMNQqVRDJqLLtyKAoZmZovdc06abIK+xbaG4BtsmK7cjSlDf
         UMxXU/HA8CLkRt/R1RSlf+S7rDbCinZ2ZNzhwJRTxmgX43s4lYPPL3iy272bvJ9+Fu5+
         aTCZVqAo7oBkuMQLo+LpJDZn4whSjTdmTQkiK+KCkWMzRs4/Mj0TzIX8sQytrOTKccw8
         q5kg==
X-Gm-Message-State: AA+aEWYkLcLhy2hpyB9QdH0KaTGWr1KOkjpbqieIT0Z5vD5T32K8rKNu
        cOnyqFduXOHPSXQ/rR6c6atAlYcDl+ww7E2GIEq7rhTh
X-Google-Smtp-Source: AFSGD/VCwiyPHLqncxH9FtxhGLSi6Cu+BKOPjTeAP1+5DKDCWp+bSx3BeXvWjEbz+lGyk8kxTxowi2AwaPRyFHFOdK4=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr4843718wmf.127.1544851515376;
 Fri, 14 Dec 2018 21:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206121550.GA2725@e107981-ln.cambridge.arm.com> <20181214203828.GD20725@google.com>
In-Reply-To: <20181214203828.GD20725@google.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 14 Dec 2018 21:25:04 -0800
Message-ID: <CAHQ1cqG3s4J42V3oUPOGssUPw6dypZqYrtpkRphHPdiYFs9j1g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
To:     helgaas@kernel.org
Cc:     lorenzo.pieralisi@arm.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-imx@nxp.com,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 14, 2018 at 12:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Trent]
>
> On Thu, Dec 06, 2018 at 12:15:50PM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Dec 05, 2018 at 11:35:42PM -0800, Andrey Smirnov wrote:
> > > Everyone:
> > >
> > > This series contains changes I made in order to enable support of PCIE
> > > IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).
> > >
> > > NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].
> > >
> > > Changes since [v1]:
> > >
> > >  - Driver changed to use single "fsl,controller-id" property to
> > >    distinguish between two intances of PCIE IP block
> > >
> > >  - All code pertaining to L1SS was dropped to simplify the patch
> > >
> > >  - Documented additions to DT bindings
> > >
> > > Feedback is welcome!
> > >
> > > Thanks,
> > > Andrey Smirnov
> >
> > Andrey,
> >
> > I have applied the patches, ...
>
> When I merged your pci/dwc branch, I noticed what looks like a merge
> conflict between these commits:
>
>   d123765b58ee ("PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on IMX7")
>   1a059d994189 ("PCI: imx: Add support for i.MX8MQ")
>
> d123765b58ee added SOC_IMX7D:
>
>   -       depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
>   +       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
>
> and 1a059d994189 added SOC_IMX8MQ but dropped SOC_IMX7D again, which looks
> like a mistake:
>
>   -       depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
>   +       depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
>
> So my "next" branch[1] (current head 7053eeb009e0) is:
>
>   config PCI_IMX6
>         bool "Freescale i.MX6/7 PCIe controller"
>         depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
>         depends on PCI_MSI_IRQ_DOMAIN
>         select PCIE_DW_HOST
>
> which I think is wrong.

Yeah, this is definitely wrong, should be SOC_IMX8MQ || SOC_IMX6Q ||
SOC_IMX7D || (ARM && COMPILE_TEST)

> Lorenzo, if you update your pci/dwc branch,  I'll rebuild my "next" branch.
>
> If you want to tweak the switch statements and/or IMX8 checks, you
> could do that at the same time.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=next

OK, I'll use the branch above for v3 of the patches.

Thanks,
Andrey Smirnov
