Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0401C65BAF
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 02:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFFB208E7
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 02:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJGT/7VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFFB208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbeLGCoZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:44:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGCoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 21:44:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so2417663wrb.2;
        Thu, 06 Dec 2018 18:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tU8RiHm05P1blXk/OPWBMPtrN8U4nIicFpULcBRTdYQ=;
        b=SJGT/7VV7VhXQ/z0IEc1ukMq/+p/9IeKvBeQDSbT1SrgP673ATh0cDHCU254NzjpCs
         RQOpk5oevNqTplLdUntfnBu/uHAO63PL9DVKuuwHHzMFQ/G3gMwLXxzLr5CwhI0EZeno
         ANV8dORTFf/8ybCcPmOzU9xv1F+R6NIinx6RDl8y1yXk5U/4LtJyv62WCpKerXjFszbD
         FZYQGTQ6YgOaS0eQLt6vgGKwhPQ4q9bE0TMBtbdC2pdYsZI92HubwU2fyc2Wl4I4aPsW
         T5aTnkUzmBPIS/DEqYS61NhO8JaBnDYwRGM6XaK/MoSYHAUnZhrvNVfubmmCG6xRoZbU
         WGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tU8RiHm05P1blXk/OPWBMPtrN8U4nIicFpULcBRTdYQ=;
        b=Ef3cn8LKGn5ANK8YqCrvptMhDy/jzeLZtEYUh3CwtrH+ZMEf3cBeXmgkSUgjZlzljF
         3Lifr7eP5unuMWeI0q1tazAT36fGgiVmMrQNoUUUs+SNOkMJ8Z/hk4enWbvPI0o6sb4p
         vuLiEOytsdOn3BWC/DJ9+fd+dDkD35cHnJqqiLlwHwBsgz7UVqotLN+wNJPyFRfmGhqL
         4Sg9klccvWaTbKwGhKeXHy2KRUCZT1fMkauhjf8gaCToUi0fI11TnOzAiDWqRDlyRqNY
         QxdIqvbH0oGprZovWe49yMu+UgFXDXrcFPVhsDa9Ux8JXwDjYZtmnOlGRNC9cNyflrPR
         F3nw==
X-Gm-Message-State: AA+aEWaHTyiZGYFhlkje6Z7D7r7S6ihWL6rq2tVNkhZ9hsRusSao5b55
        hP/1CwlhfR1fc5p5uz31y46RnmEB7TBfwWvUZyGUAmV0
X-Google-Smtp-Source: AFSGD/XZS8RVwHvM8u7WkQqbK14kEfizMmkJwIFCq4EqhCeIvSkd3cZSukJnW0P2LGAsuDXcqxg3/gWNn6GcSN1AVXk=
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr305977wrq.5.1544150662555;
 Thu, 06 Dec 2018 18:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20181206073545.10967-1-andrew.smirnov@gmail.com> <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 6 Dec 2018 18:44:11 -0800
Message-ID: <CAHQ1cqHVjNTQrHi2BgR9k74hKD8Wh93FqMoeZPmNEhGWnEmdjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
To:     lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 6, 2018 at 4:15 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Dec 05, 2018 at 11:35:42PM -0800, Andrey Smirnov wrote:
> > Everyone:
> >
> > This series contains changes I made in order to enable support of PCIE
> > IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).
> >
> > NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].
> >
> > Changes since [v1]:
> >
> >  - Driver changed to use single "fsl,controller-id" property to
> >    distinguish between two intances of PCIE IP block
> >
> >  - All code pertaining to L1SS was dropped to simplify the patch
> >
> >  - Documented additions to DT bindings
> >
> > Feedback is welcome!
> >
> > Thanks,
> > Andrey Smirnov
>
> Andrey,
>
> I have applied the patches, I would like to make the CC list in standard
> format so I kindly ask you firstname/surname for cphealy@gmail.com, I
> could not find it in the maintainers list but I want to keep the CC
> list as per patches (I removed the lists, though).

Oh, sorry about that! That would be Chris Healy <cphealy@gmail.com>.
Let me know if anything else is needed.

Thanks,
Andrey Smirnov
