Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D18BC43387
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD82214C6
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T53Yq8pX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfAJPUu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:20:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45952 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfAJPUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jan 2019 10:20:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so10007260ljd.12
        for <linux-pci@vger.kernel.org>; Thu, 10 Jan 2019 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wuv+ErdZeIPOmUMsRDVMGvhZI48dR8gLNMeJlEMPlUE=;
        b=T53Yq8pX5muDD8Ul/8zMODkCDCB0eHnH7hkmagCBomBnIVRuUcGj1CAocgK/0970br
         s4Exx/+FTtmP3UV3g3MkhaFYjsMt4xr0RvIefaGtDuKv8RJNvQ+ZuJ+9eMnvmHxj3/zp
         hv3zQJ25XanzIu48Iz6ZyCJUUhdndxUcTqyWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wuv+ErdZeIPOmUMsRDVMGvhZI48dR8gLNMeJlEMPlUE=;
        b=AWm4Yf27RT6wMewN/7+jOzIBT1Cnx6o+zegZRPBVggfM5wTEFxORPyLLBDw1rQaOY5
         1x3Y0yAWcSEjlcePeXALGUh7d/QNXTmBo55uTRq/ONrw3zIqRPImuLuCpL0mcF9nwVn8
         Fee+XMnkqF52R+3F5iSP7dyORVutJXYBrS6CeapouclP+0+gAR4BRbHbPnNqVYiN0KeU
         ZEdA+whZxvlc99JQXiZOgofxaKFxk5GhJoS1guVaYD+25ch4iR+oRHdiwv1hQpaKDJt6
         OiCmY8SBgrsqLZUY8UhjIVAbsc8ErQHHJR35E9ouEr/+OdQyZ3UoVRrM9Nr+K3kQ0LYz
         ky3A==
X-Gm-Message-State: AJcUukdUH4S/hU4aaA1Gfz8q9vRbwyutP1kR/lyV+k+oqOTTr7rgBLjQ
        u3oDHOD9BJhpQ/cyh9dhY+XSUtMultMMRRX7ze4jMg==
X-Google-Smtp-Source: ALg8bN7gkhYVUz5T/kLz9HGBPgGRlWesnuS3xp3z13omcSKb777TZ+mtBdW1x+aVD9o4v0yaZin6uBaea6aOJBwf/r0=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr6204789ljp.12.1547133647748;
 Thu, 10 Jan 2019 07:20:47 -0800 (PST)
MIME-Version: 1.0
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
In-Reply-To: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Jan 2019 16:20:35 +0100
Message-ID: <CACRpkdY3Uphb13rAcnWvnd=cirHYeqkWk3sb3yWSNL=jzA1cHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mvebu: implement get_direction
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        linux-pwm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 10, 2019 at 1:27 PM Baruch Siach <baruch@tkos.co.il> wrote:

> struct gpio_chip documentation recommends to always implement this
> callback function.
>
> A more concrete motivation is to be able (in combination with
> GPIOD_ASIS) to detect whether the bootloader has changed the state of a
> GPIO signal.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

This is strongly recommended for all drivers to implment so patch
applied.

Yours,
Linus Walleij
