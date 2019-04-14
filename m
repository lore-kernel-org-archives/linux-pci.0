Return-Path: <SRS0=uRTt=SQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57BEC10F13
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 18:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC6C20850
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 18:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvqUnDX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfDNSrE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:47:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34956 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDNSrE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 14:47:04 -0400
Received: by mail-io1-f65.google.com with SMTP id p16so12792862iod.2;
        Sun, 14 Apr 2019 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqu9krHIbKjaQcsq7mCVfA57RsiBKmmVtQ1eJQ+C2/A=;
        b=kvqUnDX1m6tndAv9WJGkRpoRATLXO2N7D3ixbeyBi6T1RnVjpoNfkomsmv1XiWOpPb
         O/321ft8sg9U/er1N4HCBfU/qHI4dkbhEOPQ25KFVbjSt7OGzypJImMpkNBrEnXVTaDP
         8aHttjUsZv92ePzcRBAgfHhwqb+/ZW/Aa0K1oLE4+UxvIAterWudTRIyCQXFI8+CnUh3
         fX5+39AWbbBfWdzHwm1UYGlMtRfW3PzCX2C+ieEmHVsn2BEUKq35f9Sj8UK6L+w8Dazq
         snN2yPtpMO6NtjhH59rF+fnxA2QMtS0nMDqCLpa7FiHI+WVxCiWynAY6ijHrETIp188n
         v7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqu9krHIbKjaQcsq7mCVfA57RsiBKmmVtQ1eJQ+C2/A=;
        b=Umneg3It7t8/MB5J3vRfvpnaUPutCxvd6flzSo+G591X+yd8TWriebLobU5kakSRmv
         F1iIfdNRGMAI/QeTR8L/93pOUBmnOu85M/TBO1TgFwmtsEAZkFR4riFrEtY1magXQVnj
         oOJ6ojnJ9xwtTLsfoGs9d90Q1AR+eD9scMyNGI/k4f3t1kucOLcVSPoMcvFVQUV1YQXS
         F4g/51+IWsP5tI51UNzcRgeARZzCJw9jJyJgnvwXNRBrMAzP25LaQwVJvSG1QER61jGZ
         KUK+04thASAZKrGDLzMqb/6CZ77hdgKqhn42jIkJLvuu1my5mCm3iBPrx1EqPXlLX/Kv
         qmvw==
X-Gm-Message-State: APjAAAXwdXVL8nxTAcVrdGRG3AyB5fBFklNNDdhlpFi8JzyHeJw9wM35
        +zAJpiluR2dvoIdZjilOkZbHA1eYAc9VlqKiXbs=
X-Google-Smtp-Source: APXvYqysNHpvf+ZHwu/r0IkykU6Ay9gm7nAUK9mH1b/mvWD9RnfiY/KQsc0Fa+cyZm7w4osqrHaRUPk/QIH6HL4d8FI=
X-Received: by 2002:a6b:c909:: with SMTP id z9mr44231920iof.244.1555267623624;
 Sun, 14 Apr 2019 11:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
 <20190401042547.14067-9-andrew.smirnov@gmail.com> <1555085573.11529.36.camel@pengutronix.de>
In-Reply-To: <1555085573.11529.36.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sun, 14 Apr 2019 11:46:52 -0700
Message-ID: <CAHQ1cqGFkj8GcFc-A9u0EGT9Xc-D9r7p39jkvss4OMU8bW=-0Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] PCI: imx6: Simplify pcie_phy_poll_ack()
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 9:12 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Sonntag, den 31.03.2019, 21:25 -0700 schrieb Andrey Smirnov:
> > Simplify pcie_phy_poll_ack() by incorporating shifting into constant
> > definition and convert the code to use 'bool'. No functional change
> > intended.
> >
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index a49e5e491e12..7c3ffb751002 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -112,7 +112,7 @@ struct imx6_pcie {
> > >  #define PCIE_PHY_CTRL_RD           BIT(19)
> >
> >  #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
> > -#define PCIE_PHY_STAT_ACK_LOC 16
> > > +#define PCIE_PHY_STAT_ACK          BIT(16)
> >
> > >  #define PCIE_LINK_WIDTH_SPEED_CONTROL      0x80C
> >
> > @@ -151,16 +151,16 @@ struct imx6_pcie {
> > >  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN               BIT(5)
> > >  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN                BIT(3)
> >
> > -static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
> > +static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
>
> This looks like only going half the way to me. The parameter type is
> changed to bool, but the callers still use 0 and 1 directly. If we use
> bool here the callers should be changed to true/false.
>

OK, will change in next version.

> >  {
> >       struct dw_pcie *pci = imx6_pcie->pci;
> > -     u32 val;
> > +     bool val;
> >       u32 max_iterations = 10;
> >       u32 wait_counter = 0;
> >
> >       do {
> > -             val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
> > -             val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> > +             val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT) &
> > +                     PCIE_PHY_STAT_ACK;
>
> I think this needs to be
> val = !!(dw_pcie_readl_dbi(pci, PCIE_PHY_STAT) & PCIE_PHY_STAT_ACK);
> as the ACK bit isn't shifted down into bit position 0 anymore.
>

That should already be taken care of by conversion to bool/_Bool(see
"Using bool" in Documentation/process/coding-style.rst) and was one of
the reasons I converted "val" to that type.

Thanks,
Andrey Smirnov
