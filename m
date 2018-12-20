Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96034C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 15:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0DE21720
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545318313;
	bh=pU1qiUpdARY0RhrguUJV+QXDWs9jVr6LBPKymW/y3LY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=11dm+7Mn6OGG4ci1p2/83vI3s4o0cuNzvasRzt6TF3eHM6HpXZYNgaUiBm6IM3WIa
	 z5lD3Iafb4Ds/OxvE/V8IukqHkNosdLqWTShxDu3fX7OmWEn/qqQ/Y+JxKcKjWkllB
	 OBX38uxbsAjHX8YCSiKZzx6Ar4K/QNNisf8/vRvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeLTPFM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbeLTPFM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 10:05:12 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E03218D3;
        Thu, 20 Dec 2018 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545318311;
        bh=pU1qiUpdARY0RhrguUJV+QXDWs9jVr6LBPKymW/y3LY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BKoi93q0Ey+xkCzuqqOQTHp+4u/DfalRPbHW2Qz9e849jTnhxKau5RC161IZ+DP88
         OwmgI5xxXVKG+JHalCnryZ+OBJKvudzsAjz4bBe5Hu9Bqx2lSnGAKCudk22sZyld0z
         fTfLjh+MAWHqFUgAbjZ48wyxMbcb0EnLSg46B9Iw=
Received: by mail-qt1-f180.google.com with SMTP id i7so2097139qtj.10;
        Thu, 20 Dec 2018 07:05:10 -0800 (PST)
X-Gm-Message-State: AA+aEWZXjzxAxDWPH9wmutuzZ1YY7q6KyUwnOJQn8YI8bajKvvIiyARH
        KT8N6OrNpkBOq1L8D13Tbuo2+4Hr+IYKE0wxeA==
X-Google-Smtp-Source: AFSGD/UnuIu7E3MzUS/BouOvxJ8zdia4VxZRbCWxRFN6Pdr0hyHOUB1E4X4aLpHc9e8tsdnhFPql4uFymmKZAHFEpn0=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr26473216qvi.90.1545318310028;
 Thu, 20 Dec 2018 07:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com> <20181218151533.GA2922@bogus>
 <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Dec 2018 09:04:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLcMb+RG8CJxzCRx0D8TdfZBFOtcx768ejHeNHtSSp5Wg@mail.gmail.com>
Message-ID: <CAL_JsqLcMb+RG8CJxzCRx0D8TdfZBFOtcx768ejHeNHtSSp5Wg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 12:09 PM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> On 12/18/2018 5:15 PM, Rob Herring wrote:
> > On Mon, Dec 17, 2018 at 08:07:02PM -0800, Andrey Smirnov wrote:
> >> Add code needed to support i.MX8MQ variant.
> >>
> >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> >> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
>
> >> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >>
> >> +Additional required properties for imx8mq-pcie:
> >> +- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0, PCIE2 is 1;
> >> +
> >
> > Remove this.
> >
> > If GPR register offset is what you need, then put that into DT.
> > Typically, we'd have a property with iomuxc phandle and offset.
>
> This series initially added explicit offsets but I suggested a single
> "controller-id" because:
>   * There are multiple bit and byte offsets
>   * Other imx8 SOCs also have 2x pcie with other bit/byte offsets
>
> Hiding this behind a compatible string and single "controller-id" seem
> preferable to elaborating register maps in dt bindings. It also makes
> upgrades simpler: if features are added which use other bits there is no
> need to describe them in DT and deal with compatibility headaches.

You don't have to describe all bit and byte offsets. Once you know 1,
you can derive all the others. In fact, it doesn't have to be a
register field at all, just provide whatever identifier you need:

<$syscon 0>

and

<&syscon 1>

Rob
