Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194C3C43387
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 16:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E472120896
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 16:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfARQCk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:02:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37970 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfARQCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jan 2019 11:02:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id m17so856621qki.5;
        Fri, 18 Jan 2019 08:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDodKVKZE68GaTWQnw/8diyvuXpkz6/WYntpU/2umcM=;
        b=Vj1vvq09GGlCHLuKcAjh8pL9We6h99Y6gJ1ogFR4LwKYjsD2fF/qGYLXXJDWYwPIbz
         +/MQexgZW0vL3deOdE7I4UF+4ekC+LgJD+wZ2w+lokCkcQcbnxFl/j6MiCj5L6me5rZ2
         ZDp6rX26oEkukQDgCKipYcRrq1wLwLOOIzxjyaKozw0AsujwMvP0UqN5fcRGGlKk+4w6
         nQS+b+ZIulTc2Q6eZFkviS/Zvjs0Nq3dDz3MLyedKj8oHG0N5f0s3C/bt7bvWzhhkHtd
         0Ibbx75MX3AAld3MaXU4POyKDdB3o7tdQ47m1VsR43TJJAA9bRRebgYgxuprBuZK9O2g
         mOxQ==
X-Gm-Message-State: AJcUukcdVdG7eAXvnsxWTUXkrsqWwmTTH535rCqLyhdH0Eofi+TeWnCE
        nV8QRCrfOQxsADqu2Wic8qMgDHq3NQyh6qZvuL4=
X-Google-Smtp-Source: ALg8bN6pE87HFJeIEYKnf1asy3R2yG9dZIxH+fpuakhGTiL3Whec42E8wvd9lm9HoVlK17a+U5oWtuQtlXKiaYl5cVw=
X-Received: by 2002:a37:324a:: with SMTP id y71mr15685363qky.291.1547827358315;
 Fri, 18 Jan 2019 08:02:38 -0800 (PST)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089538-175682-1-git-send-email-lsun@mellanox.com> <1541089538-175682-5-git-send-email-lsun@mellanox.com>
In-Reply-To: <1541089538-175682-5-git-send-email-lsun@mellanox.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Jan 2019 17:02:21 +0100
Message-ID: <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
To:     Liming Sun <lsun@mellanox.com>
Cc:     Olof Johansson <olof@lixom.net>, David Woods <dwoods@mellanox.com>,
        Robin Murphy <robin.murphy@arm.com>, arm-soc <arm@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 1, 2018 at 5:49 PM Liming Sun <lsun@mellanox.com> wrote:
>
> An external host can connect to a Mellanox BlueField SoC via an
> interface called Rshim. The Rshim driver provides boot, console,
> and networking services over this interface. This commit is
> the common driver where the other backend (transport) driver will
> use.
>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

Hi Liming,

I've taken a new look at your patch series for drivers/soc/ now,
thanks for your continued submissions.

This is again just a set of very high-level comments, but I think we
should resolve some of the fundamental questions first.
Incidentally, Vincent Whitchurch has recently posted another
patch series with a very similar intention, but for other hardware
and taking a different approach.

In both cases, the idea is to use virtio based drivers to provide
services from a host machine into another Linux instance running
on an embedded system behind a PCIe slot or similar. Your
Bluefield SoC patches are well written, but are intentionally
kept specific to a particular use case and tied to one piece
of hardware. In contrast, Vincent uses the existing code from
drivers/misc/mic/vop/ that is equally hardware specific, but he
extends it to be applicable to other hardware as well.

It would be good if you could look at each other's approaches
to see where we could take it from here. I think ideally we
should have a common driver framework for doing the same
thing across both of your devices and as well as others.

That would also resolve my main concern about the drivers,
which is the placement in drivers/soc/ for a set of drivers
that are unlike most drivers in that directory not mean for
running on the SoC itself in order drive unusual functionality
on the SoC, but are (at least partially) meant for running on
a host machine to communicate with that SoC over PCIe
or USB.

As an example, your network driver should really be placed
in drivers/net/, though it is unclear to me how it relates
to the existing virtio_net driver. In the case of mic/vop,
the idea is to use virtio_net on the device side, but have
vhost_net or a user space implementation on the host side,
but that is apparently not what you do here. Can you
explain why?

Another high-level question I have is on how your various
drivers relate to one another. This should normally be
explained in the 0/9 email, but I don't seem to have received
such a mail. I see that you have multiple back-end drivers
for the underlying transport, with one of them based on USB.
Have you come up with a way to use the same high-level
driver such as the network link over this USB back-end,
or is this for something else?

      Arnd
