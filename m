Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF119C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D2D2186A
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="r/7nWbt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfB0RnQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:43:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43684 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfB0RnQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 12:43:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so18902657wre.10
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2019 09:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2ita5f3x3g6zpXJvc8jUA4NavHo1vnCrqn2VmemdpI=;
        b=r/7nWbt5MNAnWwTWbavs8WQ20WDe0eC3WD3aqncqG7F9Tc6irfVHOgbQf9N3tE6TJP
         VDx+PZVia2X1Jq/ZI+ov5JleONQJ6l2lTv5ciCpAOPhEisLfYbxLAB6qCnQvNoCNKOl4
         1OpJ23aErDVYypIUNVCgZuOEugaFLUX3Hq7D0auyh4917yDOV1vgaWc76E/9b6unV/5X
         WCDXqZmc1iY9eq90MFTnIcdL0ZpWQIptnUZUNaGimGjibC4jJE9jIX+RDdRXWXH/fFIu
         KZ+RjWJ0D5pgYrGt+c6+gpR42VQKE9awJQyuScnZX3hYLhDRQ2Ntq858do2ib1WamsTc
         9Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2ita5f3x3g6zpXJvc8jUA4NavHo1vnCrqn2VmemdpI=;
        b=YBfSm5GuBOyvdZUwJIsBV/+p0WXygqMPLXbau26LcbkSxxUA6LtgafZKy6pFEiRf/V
         byNtnf0LWjzDhz2Q/F6+E7Gb3qKOexacy/ZJ3EIPFyrYw4m15SUdoyT7TqWFawXoV85z
         hWgJsua+bMXlhUtJgYLryEz88WlkO1wYtOZyLCiUGEWO665Zl+l/GsgZP7G2DLQgW1fB
         mgO05QVSfaHyQqMusyzgf73msbkp82F1y9dSVbmlw4uKYMHaujs21AgR4xxxSQETCHIr
         BZUIPYjVOQWdxP4QqfxuJED/13mdoCdBPwCRCxpHqApwAZR33XrLW/KEn7MjRNUQ/eon
         kH3Q==
X-Gm-Message-State: APjAAAXctKu8cQGhOQfHY+YYqLoNExHv4SXfFiAvcvEDgff4rge6MqoF
        HSnn5VZQ/TytPZSTvHdY+q6i+4eE9ou9cc8hN3/35A==
X-Google-Smtp-Source: APXvYqwdAGzFSrJzPn9sCk4imaMbxv5UJjfU2syzVEDiz0TwlV8nj27bgN4fL9lScio5jDFOQNtX7YozmI9wzzck/d8=
X-Received: by 2002:adf:9b11:: with SMTP id b17mr3359428wrc.168.1551289394707;
 Wed, 27 Feb 2019 09:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20190227165219.31911-1-l.stach@pengutronix.de> <CAOMZO5B5AyHPkvB9RqP6D43NW2gxUTiF=70=B2y+MXWMLzpH_g@mail.gmail.com>
In-Reply-To: <CAOMZO5B5AyHPkvB9RqP6D43NW2gxUTiF=70=B2y+MXWMLzpH_g@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 27 Feb 2019 09:43:03 -0800
Message-ID: <CAJ+vNU3HxaVWmkG634rcTzRaxGZBzqNVTPKNp+jx8d5iMATUSQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly disabled
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 9:25 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Lucas,
>
> On Wed, Feb 27, 2019 at 1:53 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
> > hierarchical API) the MSI init claims one of the controller IRQs as a
> > chained IRQ line for the MSI controller. On some designs, like the i.MX6,
> > this line is shared with a PCIe legacy IRQ. When the line is claimed for
> > the MSI domain, any device trying to use this legacy IRQs will fail to
> > request this IRQ line.
> >
> > As MSI and legacy IRQs are already mutually exclusive on the DWC core,
> > as the core won't forward any legacy IRQs once any MSI has been enabled,
> > users wishing to use legacy IRQs already need to explictly disable MSI
> > support (usually via the pci=nomsi kernel commandline option). To avoid
> > any issues with MSI conflicting with legacy IRQs, just skip all of the
> > DWC MSI initalization, including the IRQ line claim, when MSI is disabled.
>
> Thanks for the patch.
>
> > Fixes: c5925afbc58
> >        (PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API)
>
> Nit: the commit ID is missing the digit 7 as the first number.
>
> While at it, the Fixes lines should written as a single line
>
> Fixes: 7c5925afbc58 ("PCI: dwc: Move MSI IRQs allocation to IRQ
> domains hierarchical API")
>
> The " " symbols for the commit Subject is also missing in the commit log.

Lucas,

Also I think its worth having this in linux-stable for 4.20 and 4.19
(was introduced in 4.17)

Thanks,

Tim
