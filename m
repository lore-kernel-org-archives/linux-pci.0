Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81733C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6ED20838
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWZI2+83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfBUXDf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:03:35 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34017 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBUXDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 18:03:35 -0500
Received: by mail-ed1-f68.google.com with SMTP id a16so271075edn.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2019 15:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FXlxvF4xhFiRMVY9dsmk97DoXxTAN7l0XRbieA4sju4=;
        b=iWZI2+832YMkH7XL4pcR60BH69F+1P6eq3Sx+4B6f1/nuMqvpG1jZpsD3vxuyNYv8K
         ptmt8OphBlOX90c2+sz7HKYLx8/wulSEKzOGEhYZN0kW3vbNQUGchi8XSXgl33t6iZAT
         u8myPqU/bgcQpEexg6o5s84Kc7oI2QxcPBkMiDcFaLg3kYCtLkwRWuPyhBEQX0EYCkfa
         V7/c6qnUb5m+rcKxAq52l5s6EeiMZccPF2ht+4E1hguLO4kA/Wxf9UfN6nMQUwToFOrC
         W6L7u5vVo9747/TRYwuUwNlXHhzbsPLnbBmqeChhK0z4y+abne0yq4Z4I2ipgeu255HI
         oE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FXlxvF4xhFiRMVY9dsmk97DoXxTAN7l0XRbieA4sju4=;
        b=FszKgc/NSW6lMGKd8bTpArkvC/7y0K9RHbQeowx+EGA3bOjp/xP7mzB71Pewzjd0lY
         JVOfyMREmQjpynvPPHSQtue4HnIp+/sn0jUv60jCXY99yMTne2fKuK/pTbXwz6eYKQyI
         3tudBapHfsWPxZbqpl5mL+7FnaqJ8qYU3zl62p/xyA6YLY3dbjXy20vkPm/E/u5OvaZy
         ouZAlcwJUnECs14vSmd4xqrONxxNoU8VODX5ME4oujfRXIpaqqngeu9OJ3sh2YLocDLM
         Fu0PrnqIKvpDRUOyyGi4LkwGb/5k0Jv4cbaDS4k71/h7mEXIqt2qMKjq6LIY1FKzTPkR
         bUew==
X-Gm-Message-State: AHQUAuYG7Q0ClrFW7yf5ti3ppk2NFRYQi886fPsocmAhU4BfRjobomMP
        gv6CwUmFE9NGKzCyxx2nnEDFCahJ1q3n1CLEgYckg9iQA/E=
X-Google-Smtp-Source: AHgI3IY6cWP1liHfymzWlnw5OQhm45XWPQ0FJx5U9jmWG9cYHeH/1sbmyKOzWnXjm+xeHUTemrW3pXX8onWq9TKSye0=
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr751453edq.14.1550790213842;
 Thu, 21 Feb 2019 15:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com> <20190220094841.11129-3-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190220094841.11129-3-thomas.petazzoni@bootlin.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Thu, 21 Feb 2019 23:03:22 +0000
Message-ID: <CAEzXK1qiHaV_Ehfq_CAsDMVn=A65opeffpjyVAX-Mj73W7NGYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: pci-bridge-emul: Extend pci_bridge_emul_init()
 with flags
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Leigh Brown <leigh@solinno.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tested patch against Vanilla kernels 4.20.11 and 5.0-rc7. It is
working properly on both kernels.

Tested-by: Luis Mendes <luis.p.mendes@gmail.com>

On Wed, Feb 20, 2019 at 9:48 AM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> Depending on the capabilities of the PCI controller/platform, the
> PCI-to-PCI bridge emulation behavior might need to be different. For
> example, on platforms that use the pci-mvebu code, we currently don't
> support prefetchable memory BARs, so the corresponding fields in the
> PCI-to-PCI bridge configuration space should be read-only.
>
> To implement this, this commit extends pci_bridge_emul_init() to take
> a "flags" argument, with currently one flag supported:
> PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR, that will make the prefetchable
> memory base and limit registers read-only.
>
> The pci-mvebu and pci-aardvark drivers are updated accordingly.
>
> Reported-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
> Reported-by: Leigh Brown <leigh@solinno.co.uk>
> Cc: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
> Cc: Leigh Brown <leigh@solinno.co.uk>
> Fixes: 1f08673eef123 ("PCI: mvebu: Convert to PCI emulated bridge config =
space")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 2 +-
>  drivers/pci/controller/pci-mvebu.c    | 2 +-
>  drivers/pci/pci-bridge-emul.c         | 8 +++++++-
>  drivers/pci/pci-bridge-emul.h         | 7 ++++++-
>  4 files changed, 15 insertions(+), 4 deletions(-)
>
