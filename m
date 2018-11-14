Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C8BC43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 09:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584C4223DD
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 09:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="l0oUMgVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584C4223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeKNTfk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:35:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43506 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeKNTfj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2018 14:35:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id y3-v6so16432693wrh.10
        for <linux-pci@vger.kernel.org>; Wed, 14 Nov 2018 01:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5Lp9ntbsbh28GYUXUxxGmzBKIyMj7U/1WLCquFYSRo=;
        b=l0oUMgVi8b67BPrJLTFJtkGqwT/S7KOtygHVB12epp3TAu+as9kZEYNzQ5xlB3/i3V
         C3xnHyo9y9fAYr5fqSM+ss9/25h26VRk88ljBcfwY9mI5paAIGJK9IHJFKsa/mnuSS9s
         cdDFCCYJgkvzRV1hqEisas4eE4Kptcmlt9EEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5Lp9ntbsbh28GYUXUxxGmzBKIyMj7U/1WLCquFYSRo=;
        b=JexCAKjLIssAun+9fiLjllJoFIB3ngNPcSZnHFPj1+UvddwS0mjuI0t1BCeeNVwE7g
         AHFqziEL/MfNEZ01/tEk/5g350jV8LcksOiGs/zerhEO21iY9913mChepksfRHeJBnYT
         BoiMFJGPVNw1Wj4Ty4v2dBDSg3OiHuMMdH5To/kWwQbOB0GZpFO+/J2Vx/5BvIz13uan
         Fad3OyOMtlVuzoqGQJdNAnW3L6QSGM1hpDmyCrqJNo44dMuGNVXN8H/xL6LJpLPi+Jg7
         uRtT0ZWyT93u13DpbvmR9AzE6gtc51CLFYxZ4z8HYSqEb3GWCFqhTgAzbk7ryH9XhEXZ
         jTFA==
X-Gm-Message-State: AGRZ1gINvW3EqAxeiSLMCtEn5v5d0A00V5XjvcyCRpQrWRlgxfZZDvY0
        6F25TVBuJPxNhw2zBbopBVmlabZ4dEQRMI76F1jwlQ==
X-Google-Smtp-Source: AJdET5cz1zJp/8q+kJ+haPqz1PNbmURdYIudfTmNyFrNugTqoS6UNGnpr5++Q/HS3izrFQjimH/MJlE+3ku/eYw52XM=
X-Received: by 2002:a5d:4ec4:: with SMTP id s4-v6mr1066220wrv.32.1542187990966;
 Wed, 14 Nov 2018 01:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com> <20181106131807.29951-16-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181106131807.29951-16-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Wed, 14 Nov 2018 15:03:26 +0530
Message-ID: <CAFZiPx270bWemYRekvk1BZ23RW3ecK+znEc6C1Dix_U-2y+cnA@mail.gmail.com>
Subject: Re: [PATCH 15/23] dt-bindings: pci: mobiveil: change gpio_slave and
 apb_csr to optional
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org,
        Leo Li <leoyang.li@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>, xiaowei.bao@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Acked-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Nov 6, 2018 at 6:50 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Change the "gpio_slave" and "apb_csr" to optional, the "gpio_slave"
> is not used in current code, and "apb_csr" is not used by some
> platorms.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/mobiveil-pcie.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> index a618d4787dd7..64156993e052 100644
> --- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> @@ -10,8 +10,10 @@ Required properties:
>         interrupt source. The value must be 1.
>  - compatible: Should contain "mbvl,gpex40-pcie"
>  - reg: Should contain PCIe registers location and length
> +       Mandatory:
>         "config_axi_slave": PCIe controller registers
>         "csr_axi_slave"   : Bridge config registers
> +       Optional:
>         "gpio_slave"      : GPIO registers to control slot power
>         "apb_csr"         : MSI registers
>
> --
> 2.17.1
>
