Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85713C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534C2206A3
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556120076;
	bh=artLpvy7XegttF9q1AAZhR63pVhtH4JNaq2qzMlUh9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D+TOQ2wBDlZc86HDH6Q8HEj7bnlVEWCICGR4N5FlUDnl2ZBUFUqKIdGrKjpyjyobD
	 uDwRm/s2rtwz5u4QGCjQVUsHtWK9fryTSiANkA68VmpxzisaTJzfR3SEXjcfc48hTb
	 xLRaSpzb3FstxEXtvGS1DVWAkAeKM/d8vjFY+uiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfDXPef (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:34:35 -0400
Received: from casper.infradead.org ([85.118.1.10]:56212 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbfDXPef (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 11:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sqQ0QZ1qv0/cq0WsSzdCrhPHL6++zwMLBU3pK19WzZQ=; b=GUMia/JvBbB3zAQVnK3orn6C1j
        82JUj+d2DVCZLnWRQuk8r3JFWRh05Q5K0pNOo3seAOO3tsWm1//G0gBOb8WEgh1Xy/BgF4Txmw4Lf
        j4zOWVq9WGjAwYOrgT+eKNYUQL+OM+REyJk0uUJyMMByD/4HDigsOJYX6Dwk492azCivbCSYyyIWs
        p6cOqhwWC6MaDrFJh0/H4Ed2a99E/JMvOzAxZ8DLCMadovwmdlXnFFMg6aKnMGRoL3WKIMSuoaCPD
        5MBRbGKVmhYpf5JsYriwQwbj6ut2E5HcWzzcuHSbGc84agRYxtQsdDF/1evUgIy13eId83GOX3Wbk
        KbEkFIyQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJJup-0002ie-EU; Wed, 24 Apr 2019 15:34:31 +0000
Date:   Wed, 24 Apr 2019 12:34:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 30/63] Documentation: PCI: convert acpi-info.txt to
 reST
Message-ID: <20190424123425.3e63f970@coco.lan>
In-Reply-To: <20190423162932.21428-31-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-31-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 00:28:59 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/PCI/{acpi-info.txt =3D> acpi-info.rst} | 11 ++++++++---
>  Documentation/PCI/index.rst                        |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
>  rename Documentation/PCI/{acpi-info.txt =3D> acpi-info.rst} (97%)
>=20
> diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-inf=
o.rst
> similarity index 97%
> rename from Documentation/PCI/acpi-info.txt
> rename to Documentation/PCI/acpi-info.rst
> index 3ffa3b03970e..f7dabb7ca255 100644
> --- a/Documentation/PCI/acpi-info.txt
> +++ b/Documentation/PCI/acpi-info.rst
> @@ -1,4 +1,8 @@
> -		ACPI considerations for PCI host bridges
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ACPI considerations for PCI host bridges
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  The general rule is that the ACPI namespace should describe everything t=
he
>  OS might use unless there's another way for the OS to find it [1, 2].
> @@ -135,8 +139,9 @@ address always corresponds to bus 0, even if the bus =
range below the bridge
> =20
>      Extended Address Space Descriptor (.4)
>      General Flags: Bit [0] Consumer/Producer:
> -	1=E2=80=93This device consumes this resource
> -	0=E2=80=93This device produces and consumes this resource
> +
> +        * 1 =E2=80=93 This device consumes this resource
> +        * 0 =E2=80=93 This device produces and consumes this resource

Hmm.. I think that you would need to add some extra blank lines before
the above, e. g., something like:

	[4] ACPI 6.2, sec 6.4.3.5.1, 2, 3, 4:
	    QWord/DWord/Word Address Space Descriptor (.1, .2, .3)
	      General Flags: Bit [0] Ignored
=09
	    Extended Address Space Descriptor (.4)
	      General Flags: Bit [0] Consumer/Producer:

		* 1 =E2=80=93 This device consumes this resource
		* 0 =E2=80=93 This device produces and consumes this resource

> =20
>  [5] ACPI 6.2, sec 19.6.43:
>      ResourceUsage specifies whether the Memory range is consumed by
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 1b25bcc1edca..c877a369481d 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -12,3 +12,4 @@ Linux PCI Bus Subsystem
>     PCIEBUS-HOWTO
>     pci-iov-howto
>     MSI-HOWTO
> +   acpi-info



Thanks,
Mauro
