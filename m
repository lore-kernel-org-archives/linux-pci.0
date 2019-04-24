Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699AAC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A3C218FD
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117382;
	bh=eKT5cGpa/N6uVy3PXWjUhccXi5Ylw7j0RttvaKGYkOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WVfjkwCDfij/pv/Fr7gJo2sgeC7gR73XNs1W3tDV4KnLpgh1m2aaLVmu1Dqhdmy6X
	 GKbUpi+aXfKX3kiBM2aPK2hPEoqVg+B5zxQ+jSggpiKDKYz79gTL4841QQdPi+cu8z
	 VaeNvfLppvf8O9WKwoRkc+r6aW0f0PZVSVPbtKIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfDXOtl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:49:41 -0400
Received: from casper.infradead.org ([85.118.1.10]:49896 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbfDXOtk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 10:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nKCwBmfBp7mcLbr5EtlGrsX2M4qchKLnLez+nRU0bpI=; b=K7z4gYOLG9Il8dGxDROWgW3h/o
        MYvPnBQP80XVXEXulkopPsVc5wm+6NlqWcd/h2GHY3dzlCsYNfMZwRIspSRtPn50ov6mWI7dYevoz
        Op4iC7kUpyf+8Iaupsix7o+x8aQHFYHq6klmdRM9vB7ejyII0LotHwKOuiRIbr4IxvHjKgxLH9tBq
        ITroLpqZ7ZXbSNCR5tVqWibzTT+tOR/rcWV2m2ClwNBKBCpAQWPtNRnKUTiyoUrq2s/DSJ382XW8A
        iK9KoevgVOZ/uGvzAp7Yfr6zpGJ+HoxP0Vd4eTDbv6uUKRktdGwvoa20r8TVjoTVh0Rxg6nMqUKQ1
        EPhv6+3g==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJJDM-0000dE-Qa; Wed, 24 Apr 2019 14:49:37 +0000
Date:   Wed, 24 Apr 2019 11:49:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 22/63] Documentation: ACPI: move lpit.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190424114930.09df0827@coco.lan>
In-Reply-To: <20190423162932.21428-23-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-23-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:51 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/firmware-guide/acpi/index.rst    |  1 +
>  .../lpit.txt =3D> firmware-guide/acpi/lpit.rst}  | 18 +++++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>  rename Documentation/{acpi/lpit.txt =3D> firmware-guide/acpi/lpit.rst} (=
68%)
>=20
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/=
firmware-guide/acpi/index.rst
> index fca854f017d8..0e60f4b7129a 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -22,3 +22,4 @@ ACPI Support
>     gpio-properties
>     i2c-muxes
>     acpi-lid
> +   lpit
> diff --git a/Documentation/acpi/lpit.txt b/Documentation/firmware-guide/a=
cpi/lpit.rst
> similarity index 68%
> rename from Documentation/acpi/lpit.txt
> rename to Documentation/firmware-guide/acpi/lpit.rst
> index b426398d2e97..aca928fab027 100644
> --- a/Documentation/acpi/lpit.txt
> +++ b/Documentation/firmware-guide/acpi/lpit.rst
> @@ -1,3 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Low Power Idle Table (LPIT)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
>  To enumerate platform Low Power Idle states, Intel platforms are using
>  =E2=80=9CLow Power Idle Table=E2=80=9D (LPIT). More details about this t=
able can be
>  downloaded from:
> @@ -8,13 +14,15 @@ Residencies for each low power state can be read via F=
FH
> =20
>  On platforms supporting S0ix sleep states, there can be two types of
>  residencies:
> -- CPU PKG C10 (Read via FFH interface)
> -- Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
> +
> +  - CPU PKG C10 (Read via FFH interface)
> +  - Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interfa=
ce)
> =20
>  The following attributes are added dynamically to the cpuidle
> -sysfs attribute group:
> -	/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> -	/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> +sysfs attribute group::
> +
> +  /sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
> +  /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> =20
>  The "low_power_idle_cpu_residency_us" attribute shows time spent
>  by the CPU package in PKG C10



Thanks,
Mauro
