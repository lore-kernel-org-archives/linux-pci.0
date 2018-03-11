Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr00122.outbound.protection.outlook.com ([40.107.0.122]:16070
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932201AbeCKPDm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 11 Mar 2018 11:03:42 -0400
Date: Sun, 11 Mar 2018 18:03:34 +0300
From: "viktor.prutyanov" <viktor.prutyanov@virtuozzo.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz
Subject: Re: [PATCH v3 0/3] lspci: Add support of JSON output format
Message-ID: <20180311180334.4ba6baec@virtuozzo.com>
In-Reply-To: <20180218231251.23988-1-viktor.prutyanov@virtuozzo.com>
References: <20180218231251.23988-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

=D0=92 Mon, 19 Feb 2018 02:12:48 +0300
Viktor Prutyanov <viktor.prutyanov@virtuozzo.com> =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:

ping

> This collection of patches adds support of printing PCI info in JSON
> format.
>=20
> 1st patch adds skeleton for creating structured object which can be
> printed in JSON or another structured format.
> 2nd patch adds output of general PCI info which prints with -m, -k,
> -[v]+ options, but without capabilities.
> 3rd patch adds PCI-E capability.
>=20
> For example, we can easily, using jq utility, check speed of a device:
> lspci -Jvv | jq -r '.[][] | select(.Device =3D=3D "GK107M [GeForce GT
> 750M]") | .capabilities.express | {s1:.LnkCap.Speed,
> s2:.LnkSta.Speed, w1 :.LnkCap.Width, w2:.LnkSta.Width }'
>=20
> {
>     "s1": "8GT/s",
>     "s2": "5GT/s",
>     "w1": "x16",
>     "w2": "x4"
> }
>=20
> Viktor Prutyanov (3):
>   lspci: Add printing info in JSON format
>   lspci: Add PCI info output in JSON format
>   lspci: Add JSON PCI Express capabilities
>=20
>  Makefile    |   3 +-
>  common.c    |   2 +-
>  ls-caps.c   | 417 +++++++++++++++++++++++++++++++++++
>  ls-info.c   | 328 ++++++++++++++++++++++++++++
>  ls-kernel.c |  24 +++
>  lspci.c     | 706
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> lspci.h     |  56 +++++ lspci.man   |   3 +
>  pciutils.h  |   2 +-
>  9 files changed, 1537 insertions(+), 4 deletions(-)
>  create mode 100644 ls-info.c
>=20
