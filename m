Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D6EC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43CD20838
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9v8zyRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfBUXCH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:02:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46484 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBUXCG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 18:02:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id f2so206696edy.13
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2019 15:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NprLxaSLXIjf/D4KgK5zBo9zDu/x6coN+Jsn61LfvRU=;
        b=m9v8zyRf+NLUExNfRS0ILQJFoX8qlMkwNJHHMTGkCvlhlQeRzU9X/VxkNDXziFfmuz
         dLd3vyqL+BVJA1qQ+G3mXqfXvNxU7VHQUjhZy+lgcY0Uf/hlTAF8e7D5djD4XKrYBjLN
         //PnjUR4tREMtE1jdHGwANjCSPNibd8efnD9WHz1BJeEitu2NJbvoSOqdoTJJ+EZFPSb
         bSMslnZEim0GUPZaiugN2mNhZyGK7ezqh8UwIBp6d3Dv4wUrkmoSRv3fv0b3aZQJxjGT
         6QIAzP+SY46lss7wk7WKxlEwmKUhApqS0KHd+wEWUIvSdiUK2d5s43EfhwjhH4zNmZLG
         WWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NprLxaSLXIjf/D4KgK5zBo9zDu/x6coN+Jsn61LfvRU=;
        b=O29M7WQo+NCpAsF4Sb6Kvh6k1zrZ00xZfwNg1rueE9+EWqppYvx0W7OPyJkLwu07DQ
         tLZ/KA5v1h3N+CmjBZ8Msr5E+QG3Jw5RSyE8EykeMNXRuxLdBXqA9YL9G+TcZ0Dhtwm7
         sGnGzLfKWuKVTIBNAqsaXqgtbNJ+kLXI7az6+uqCppaVbhPjZdnn3wUG1qw0/GTkLd/4
         xsIWcsoQAi0yqclhG1naqybp5R9pO+7gLBmqw9DO1+ZZdW+mK9Ni2HutaIbWWR/anBa1
         r+Ptn0GYLFWsYQcNWpzV1dedb5v7ifuT59F25PQN+10oC3p5ywC3yZHVsdufNhXFMi4u
         sWyQ==
X-Gm-Message-State: AHQUAuZiNW0fYN5dZYZ6bUG0r3eAlsvQlfWCoU3IyPeGEKJGa7x+iWG6
        no8NrFOoqBp+mZ8pwM9iEkPGKawV4KoIlaF+B14=
X-Google-Smtp-Source: AHgI3IZKjeppeJuq/RuCDi0K+UxvV5qAwzLOLz9bGthT4Fqmf9ds2Hm99L0CyI0PM8fUXrvNVgShWMK11CEitRk4VXk=
X-Received: by 2002:a17:906:f1d8:: with SMTP id gx24mr622251ejb.227.1550790125458;
 Thu, 21 Feb 2019 15:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com> <20190220094841.11129-2-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190220094841.11129-2-thomas.petazzoni@bootlin.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Thu, 21 Feb 2019 23:01:54 +0000
Message-ID: <CAEzXK1qhFrjtM=BdA2tXt_YR4DhD095vGVJPWa_4-=kOeG-FGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: pci-bridge-emul: Create per-bridge copy of
 register behavior
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
> The behavior of the different registers of the PCI-to-PCI bridge is
> currently encoded in two global arrays, shared by all instances of
> PCI-to-PCI bridge emulation.
>
> However, we will need to tweak the behavior on a per-bridge basis, to
> accommodate for different capabilities of the platforms where this
> code is used. In preparation for this, this commit creates a
> per-bridge copy of the register behavior arrays, so that they can
> later be tweaked on a per-bridge basis.
>
> Reported-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
> Reported-by: Leigh Brown <leigh@solinno.co.uk>
> Cc: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
> Cc: Leigh Brown <leigh@solinno.co.uk>
> Fixes: 1f08673eef123 ("PCI: mvebu: Convert to PCI emulated bridge config =
space")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
