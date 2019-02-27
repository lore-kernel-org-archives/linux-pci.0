Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F93C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BEF21850
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 17:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpnq2zV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfB0RZg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:25:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40635 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfB0RZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 12:25:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id v20so15041810otk.7
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2019 09:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2qOFsvxPYSPOXLYIeNbQJP5T8m2N9pOi7FexvvyPBc=;
        b=mpnq2zV95SaOafjMTFo8FANpyuMpkYumFEW7rhMTiAE7MFgMVX7tuVOKTwCDjmQEAZ
         3GB/FrTnpJK4dFlwM7mD8iCTZ0DQPCa7AtgN5PNyV8+E8zIqt2nV3F5MaPXsLJs6ND7k
         3qWjY1+eXFebgU825T+uPn2M0xBxpGYwPbRxiEKAJeTOoa9Rd2YsLrfwggT67BoNO+9k
         HbjM1CiILg4UWTSrxIkIPBHh3YDXgIAygyXYrFEH4I4KSvj2TJu+dBiq+Ft9fwh6GJ9M
         XLdbVgRw9zOzzOVA4ADk6APCACjSHxH5PoIEqhnk1qDodT3GK4UgIssnAWlIagl2e0zN
         Vv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2qOFsvxPYSPOXLYIeNbQJP5T8m2N9pOi7FexvvyPBc=;
        b=L/ufLvwbyfcXRkS3CjqCZFjreLjxvi9Nkj65PgFqOVat1ueY7U3TlQ/eRtHLJ9fic6
         RRh5oOj5DjiQZ6wTE1l3KhmQ50P5mCxEStUGo6Pl6Zvfrroe9+ec+TtKZGhC7Yl3tdTs
         0j1EBMVOdj8gr3gzDt+NhHsCHl0Eps8MRgwv3C+h9tbShI3LSOqJy+d2SUFaUxLxeVre
         zKRMadXNKr64cS91jJ7/Wu3mDELCjX//5viE8Dbxb+Q2DSdIuRc72onuXBZqqRP+3JOJ
         nP3ARLEthbiqPobm4R3AQUet8cfSfdqdTjZ5O+Vo81f5sFj1tyHYYFNgsCNKDsC0QoPK
         zvWQ==
X-Gm-Message-State: AHQUAua9Pf13yWKdNIIvUNzme1MxOgJF1IccepHyF2CRXyt5eRwY3vof
        hdSvhpxnCqz0oDe+MQyaOZg+7ULux+Jq3Zv98x4=
X-Google-Smtp-Source: APXvYqybLFR3GrklDY//en/v4log6m5GYdzz1firLV9gXJN7b5n5aEiNZGPmb7Vs0pIaRAT9pVyDnQbU+b3wthmm3q0=
X-Received: by 2002:a9d:7d02:: with SMTP id v2mr2914711otn.203.1551288333643;
 Wed, 27 Feb 2019 09:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20190227165219.31911-1-l.stach@pengutronix.de>
In-Reply-To: <20190227165219.31911-1-l.stach@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 27 Feb 2019 14:25:23 -0300
Message-ID: <CAOMZO5B5AyHPkvB9RqP6D43NW2gxUTiF=70=B2y+MXWMLzpH_g@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly disabled
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lucas,

On Wed, Feb 27, 2019 at 1:53 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
> hierarchical API) the MSI init claims one of the controller IRQs as a
> chained IRQ line for the MSI controller. On some designs, like the i.MX6,
> this line is shared with a PCIe legacy IRQ. When the line is claimed for
> the MSI domain, any device trying to use this legacy IRQs will fail to
> request this IRQ line.
>
> As MSI and legacy IRQs are already mutually exclusive on the DWC core,
> as the core won't forward any legacy IRQs once any MSI has been enabled,
> users wishing to use legacy IRQs already need to explictly disable MSI
> support (usually via the pci=nomsi kernel commandline option). To avoid
> any issues with MSI conflicting with legacy IRQs, just skip all of the
> DWC MSI initalization, including the IRQ line claim, when MSI is disabled.

Thanks for the patch.

> Fixes: c5925afbc58
>        (PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API)

Nit: the commit ID is missing the digit 7 as the first number.

While at it, the Fixes lines should written as a single line

Fixes: 7c5925afbc58 ("PCI: dwc: Move MSI IRQs allocation to IRQ
domains hierarchical API")

The " " symbols for the commit Subject is also missing in the commit log.
