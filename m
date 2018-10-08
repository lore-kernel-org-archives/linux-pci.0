Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A3EC65C20
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 12:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68A02087D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 12:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByYxSNoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68A02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeJHTp4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:45:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43630 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJHTpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2018 15:45:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so10779822eds.10;
        Mon, 08 Oct 2018 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aiAgeQE8+ls6axisZMjCnRhqfBbp++OqABECBH9ceQ0=;
        b=ByYxSNoDfBp7BIKZ/ujJXTkJTgcJOE1EVc9c3hv9N+MRE7C0i7tPmeENCqhkGm3rsc
         9Ak0Tf34sg6CAo5wckR9j5sxaVxdPEOgB+RQhKB08VfeQwKZWOyFNNluD1aO4hTTeUzh
         dk5YANHPgOCpyKZSCf8hsRM+5yVO6tN/hXVqi9FVCBM2GZxKzsaYfOyVG7UJQE7mE1N8
         wdViiIqQRKL8GLliATOw14K3gIQlRhjCwPfTLwRyOZ4aTX6OZiLPDUBmd7vbuMdQkhAH
         ItGf1vBmOQUafValIlhJHWuznileW0vSfFoid6wKUT9/0AMNQ7zF5RYlNsa3BVbTl6Yj
         mNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiAgeQE8+ls6axisZMjCnRhqfBbp++OqABECBH9ceQ0=;
        b=KM9BICqEV4CNC2tJov2YDeqFYvRPW2tIjPdkz+tsZZ1+xjJegEk25p98G/xMSu/krm
         J452B1pIsXflQd9untO5GEGZpAW9d9cHrrDfhurv2unKQ1zP2uwc2q/S0yAk+UBw3Pux
         2r87Auhmn58i3R0AxA8FzjJ8BEJ4qPpdvZY4ghUV8gbhrAkSa7NTDjLOY5kEeZW27tA5
         xLXHY9a5/K1Am0BIrtrJ9Bv2XlA72Yj1qInEOnRfaV79rklGeT22StECm+Jq+ZqZ8+WG
         tggiJfHU1qKwOmlruw9qNuRY8OcsHTzW0JUSpVqKzkvoK3z4hvwbOCL5Qta/4kG+6Q7W
         +p6w==
X-Gm-Message-State: ABuFfogtjyghcxHgLfeOqnTMr+iav4gYu5f2KNIeRcfJ8pBJm9pPoAPV
        TVFNmahVLQIxhIIqbBp9Yi0AIWSn8gxs8VGy7vE=
X-Google-Smtp-Source: ACcGV63jnfPKffeWlwkuEvUKMnD+QQn2Je+nsultbRsduaq/FAg40811aYKQ5jENFvq8vucH6LJGu/KQ5n1xESVI8Vo=
X-Received: by 2002:a17:906:2d4a:: with SMTP id e10-v6mr2337554eji.105.1539002063699;
 Mon, 08 Oct 2018 05:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com>
 <20180926165721.GA28024@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmXc--Ph71DGu2b+ijTzB6xvHXzuESBJKp9zARE2gjqV6w@mail.gmail.com>
 <20181003201244.GG120535@bhelgaas-glaptop.roam.corp.google.com>
 <CAEUhbmUBic3RJbMH6bukw3NVis4qxMKr_pqJhn14vFtpGvES=w@mail.gmail.com> <2d2878e5a44c496cb0937f02d64e0b38@AcuMS.aculab.com>
In-Reply-To: <2d2878e5a44c496cb0937f02d64e0b38@AcuMS.aculab.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 8 Oct 2018 20:34:12 +0800
Message-ID: <CAEUhbmV3SoPLZeN2EOm8h0xfKqN1FBZmJjhv6ygQovHZVA9ZRg@mail.gmail.com>
Subject: Re: [PATCH] pci: Add a few new IDs for Intel GPU "spurious interrupt" quirk
To:     David.Laight@aculab.com
Cc:     helgaas@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thomas Jarosch <thomas.jarosch@intra2net.com>,
        stable <stable@vger.kernel.org>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

On Mon, Oct 8, 2018 at 6:06 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Bin Meng
> > Sent: 08 October 2018 10:44
> ...
> > Correct, disable the shared interrupt line keeps all devices using
> > that line from working, which is current kernel's behavior w/o this
> > quirk handling: it disables the (shared) interrupt line after 100.000+
> > generated interrupts. But the side effect is that other devices become
> > unusable after that (eg: USB devices which share the same interrupt
> > line with the Intel GPU). That's why the original commit, f67fd55fa96f
> > ("PCI: Add quirk for still enabled interrupts on Intel Sandy Bridge
> > GPUs") disables the GPU's interrupt directly, which should really be
> > done by the VGA BIOS itself (a buggy VBIOS!).
>
> Shouldn't the kernel just disable all PCI(e) interrupts by writing
> 1 to the config space control register bit during grope?
> Can it ever by right for this to be set?
>

Do you mean PCI_COMMAND_INTX_DISABLE bit of the command register in
the configuration space? Setting this bit indeed could disable the
INTx interrupt, but it does not work for all PCI devices as this bit
was introduced in PCI spec v2.3.

> Apart from VGA the 'bus master' bit also needs to be clear.
>
> ISTR some very early PCI systems which failed to reset the PCI
> bus during reboot - at least the 'bus master' bit remained
> set for an ethernet card.
> On a private LAN the OS got reinstalled and rebooted without
> using all the ethernet receive buffers and then died because
> a receive frame got written into 'random' memory.

Regards,
Bin
