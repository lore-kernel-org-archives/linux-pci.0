Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B81C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 18:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A16121900
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 18:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzdtyI56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfABS2X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:28:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36923 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfABS2X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 13:28:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so31364059wrt.4;
        Wed, 02 Jan 2019 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gMhKoB56fl1CENDGxaDFPrqlt7cUUK874k7xw397NdU=;
        b=JzdtyI56NkMTgEJWWUI7nVrrdM4ObN36HtPjzfrSSjcdqdR9Gtl9t/46owiSX02KfJ
         wude1FNPPx52lUIBO6Mj1WbUQ7dn1GEkoUAWSBE0ruGW/AYS1ZdrVE4WEG+cjM3s9gDR
         POqYiDhxqJkxRfi/ZQiGRyw+4M3gWrbKCVED24XGoMjWdIchuBU3I7Qy08q7YX29sIRl
         C45vCtxvK5eXALv38zLCau929LZIPSi7uRWZXAZqMmFxcagAMxgyR+2mO7MegAWSvLAk
         kG2L+cFubVPh+1r7Unm9pPfxY26p6AQdjpHnpqt7xJNVRwcb8LLKTAinlvtgIm1zyhP+
         cv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gMhKoB56fl1CENDGxaDFPrqlt7cUUK874k7xw397NdU=;
        b=UQaP2uu2nEQpRfBo+5x5dzF1sR3riT+ZTpdXTfdFsntMfXhruUjMtHX6jlkvTK3KBY
         TKwcDPKAHbDADSxod69YXpaoyjBnGi84lt5rg8x93t9spznLdH6f7wfGb8fxZjl9P8q7
         Bp3NMj2WQRb6ab6Nlbob5Yx7ypPvbbny4hBZfxXX+G4L0+CfXvtHmo9ufHKxF9DnT+lq
         fZUpgAH9oR0UIjPfY6lBTHZ+wW5wt8y0F0wDUjiaPJfhJa2Ws9QVMRyN6AEYIdN1Iw1K
         hKDIkbP3DzEehYiaemrwBwenB7FPdAorjrt3oOLXc8sOMDFxCclRSniWRpTpZzNQYSCY
         ZDmQ==
X-Gm-Message-State: AJcUukcgHALA0TK2anEac40v9gozn2o3Z5U7+MYmCw6tbanX6yapS3B2
        a2b0i/SDj8l5erkKYa5FMzJ1DfGkuOxtT1slFRk=
X-Google-Smtp-Source: ALg8bN5DG7KGiHBMbCIxnPHPogckdubzNMt/jjijDA8hZ2AZq8k3DkpH3670RP94iJyqTvr7cTVkl8RWceaALOX7seg=
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr37134675wrq.5.1546453701202;
 Wed, 02 Jan 2019 10:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-12-andrew.smirnov@gmail.com> <86e8172d-d1dc-59d6-0b64-b11ce014b6a4@synopsys.com>
In-Reply-To: <86e8172d-d1dc-59d6-0b64-b11ce014b6a4@synopsys.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 2 Jan 2019 10:28:09 -0800
Message-ID: <CAHQ1cqH3uFj51ORhp1eHPp6jVNoM0D1nv5qHvQESnmPX3-ESoQ@mail.gmail.com>
Subject: Re: [PATCH 11/21] PCI: designware: Make use of BIT() in constant definitions
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 26, 2018 at 7:19 AM Gustavo Pimentel
<gustavo.pimentel@synopsys.com> wrote:
>
> Hi,
>
> On 21/12/2018 07:27, Andrey Smirnov wrote:
> > Avoid using explicit left shifts and convert various definitions to
> > use BIT() instead. No functional change intended.
> >
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c |  2 +-
> >  drivers/pci/controller/dwc/pcie-designware.h | 18 +++++++++---------
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index d123ac290b9e..086e87a40316 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -300,7 +300,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int i=
ndex,
> >       }
> >
> >       dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> > -     dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);
> > +     dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
>
> This is unrelated with the patch description purpose.
>

This is a direct result of converting PCIE_ATU_ENABLE to BIT(31).
BIT(31) expands to (1UL << 31) so, without that cast I get

drivers/pci/controller/dwc/pcie-designware.c: In function
=E2=80=98dw_pcie_disable_atu=E2=80=99:
drivers/pci/controller/dwc/pcie-designware.c:303:40: warning: large
integer implicitly truncated to unsigned type [-Woverflow]
  dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~PCIE_ATU_ENABLE);

on AArch64. I am guessing that original definition of (1 << 31) avoids
this problem by being an "int" instead of "unsigned long".

Thanks,
Andrey Smirnov
