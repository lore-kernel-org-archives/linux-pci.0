Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE1FC43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0708420874
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE2hQJ5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeLQRL1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:11:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38739 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbeLQRL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 12:11:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so13068917wrw.5;
        Mon, 17 Dec 2018 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZY5abb5RJfKSZwIuefMoxZ8yU6NpVNydtn2GiM4hyg=;
        b=bE2hQJ5VNOfh1ytM66ct3zjSi/JsfqigkAoclkdGTispgNcAEBXfdwfVzWtfVf6nce
         bPXUMnUNhUs+DTNOx42ARgRrOxntgkYiU1c+JG2uirmSEBqLgg1hclY97DOIRB5xNZna
         d/1W4qUW1VL2iipDMCfhDgtNnJspUv6GMWF8KVskOEYRt5GT9Oa63l/jt4ZMiWz6BNUu
         1/vpJObiJ/zmY6RKTIlkid53cDewhOiX1akjx3k7KJsABTTuh5nQYb5CcWhgPEAfsYF1
         EGcNBQkgSWasDceiWVum3EOmiNicsT/DgKeAbQ69CrYKqQ8g4vh2qVFtOvamVvxUdfN5
         i5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZY5abb5RJfKSZwIuefMoxZ8yU6NpVNydtn2GiM4hyg=;
        b=NxSSKbCp8YTygohuT3Hh4uq479i3NImEh0/VCXxrikJyt2DJLjjsyBIwVzl/tfC80W
         jZWBOfy+URWZYLeXge8qfxSgJowDq/a1rcJJxBwL9vsAl4hNVeVjs4Pj0+ad3KxIvLlf
         DJGxpVeTEFXQQG5YwNvYj/lWm6BIzaoVo3ow8nw79o/cN5ESGCOd2fKSpKQl0Rn1s3JI
         9X92XNNi1TIfBUYYFYKe34bci790tw1wA8CQ4ksWd5YS/x1z867ow15LjZC/zs3QA6ax
         Opx2WLPUci7pmbdWYby+kzu48wSbVaJTurL0k/ZHhLfa9PVUeI34Pdt7CSum/bLwtLsE
         OGuQ==
X-Gm-Message-State: AA+aEWaFUrgoulOeM3K22QsNuizuMPQqbcE1lLONRZLjIXT+Ji53gWIc
        Imal6vX9rvsn3ZKBGMcK6Ozl3DwdfRXdwTJpAFg=
X-Google-Smtp-Source: AFSGD/XElLSSUsi/CjNXXV69Ucpm1nJRDdp2hbTudva9JuEPERBBb4MaDH9moukhIcpeZbFIF/HY8JBtm2dFva2MeH0=
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr10814319wrx.259.1545066685084;
 Mon, 17 Dec 2018 09:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
 <20181216230916.22982-3-andrew.smirnov@gmail.com> <VI1PR04MB5533AAAEA69A54F1CF01D44CEEBC0@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5533AAAEA69A54F1CF01D44CEEBC0@VI1PR04MB5533.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 17 Dec 2018 09:11:13 -0800
Message-ID: <CAHQ1cqEo86-B0mw8edqr0fr9834YRziFJPJbssqoutYnfroyog@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: imx6: Invert checks in imx6_pcie_reset_phy() and imx6_setup_phy_mpll()
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 2:24 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 12/17/2018 1:09 AM, Andrey Smirnov wrote:
> > In order to avoid having potentially ever growing list of variants
> > that don't support methods implemented in imx6_pcie_reset_phy() and
> > imx6_setup_phy_mpll(), change logical checks in the to check for SoC's
> > that _do_ support what they implement. While at it, share the code via
> > a small helper function.
> >
> > +static bool imx6_pcie_has_imx6_phy(struct imx6_pcie *imx6_pcie)
> > +{
> > +     return imx6_pcie->variant == IMX6Q ||
> > +            imx6_pcie->variant == IMX6SX ||
> > +            imx6_pcie->variant == IMX6QP;
> > +}
>
> This would be an ideal match for adding a field inside drvdata, sadly
> that was part of a series which stalled:
>
> https://patchwork.kernel.org/patch/10712261/

OK, I can pick up that individual patch into this series.

Thanks,
Andrey Smirnov
