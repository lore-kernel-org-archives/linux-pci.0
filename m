Return-Path: <SRS0=dd4N=OL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37700C04EB8
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 10:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F23206B7
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 10:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F23206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rempel-privat.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbeLBKoa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 05:44:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:43625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbeLBKoa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Dec 2018 05:44:30 -0500
Received: from [192.168.1.241] ([31.18.251.131]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZxch-1gnY75389P-00LlKF; Sun, 02
 Dec 2018 11:44:08 +0100
Subject: Re: [PATCH v6 1/2] misc: cardreader: add new Alcor Micro Cardreader
 PCI driver
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel@pengutronix.de, linux-mmc@vger.kernel.org,
        peter.wein@gmx.de, drake@endlessm.com, chiu@endlessm.com,
        linux@endlessm.com, morling.huang@alcorlink.com,
        bob@alcormicro.com, jin.tsai@alcorlink.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181202103046.29377-1-linux@rempel-privat.de>
From:   Oleksij Rempel <linux@rempel-privat.de>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@rempel-privat.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c61aab2e-67b1-2cab-253c-bc78b3ff384a@rempel-privat.de>
Date:   Sun, 2 Dec 2018 11:44:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202103046.29377-1-linux@rempel-privat.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BuRi53VjqypJJK4pfLGMVsJQZH1eVXaAr"
X-Provags-ID: V03:K1:rpfpXTCZtulU2Tf5v76tZUUBedxxFnpyNH3pWDsK5fwOvqoUFg2
 i5j5Ux07OKGqZju5jxYCEElIuA52/RYSPnYqMTlKtkM8PIoFX2Hag5yHRXsuGflBcSEoOhf
 E5zF1N0577cEmf+p3avhWNeLOn4L1p73UjdTLl9pNH5+eCBeYlGDodXeYeSGpxm8qTSizmC
 qgf85vySyzwKRw5/mJVtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7aJt3UDDpA8=:0Me9HneO6L3h3VvAPSeIRM
 +lFMhSdRoZRa+vGGRCWhOe4PI1Xp90BhBXP+fT9RkJxB82Zms4FO/p//V2/2w3OE1D2s0E5Xi
 P2dk5LPq1knUjoJ88XEgWMFoaPBBw0qCV/ljA6nDQxgMes5K8prhOcbNjbY44feBiTyMRr7ja
 vKZKOC/VDcKWOYAf6UlbN3tBU8F/lWVXvTe8ijB5lSpZbadoGP1emrQbYN5gpGs958KjgGGV2
 /KIBS+Cod0+DrKyjjUNvTR0E47ZnoJGryrFAkMO1FAjFiVfNIHg18Bn6MEOkSzlot3gbMfkbI
 Ah28kRyBC4cvkLTpuiohmZ0PoWyFV8JkOzUZVjOcrXzV3fYZjHvHsHcz//tkR6Jw53Tu3WddL
 1c0Y6oqmSvPQbv3glILpdvj/HLlwnXadU9MwKXUWzBGoGrmvGB2StXEjy3FEXlDxGn/eCSpYn
 FONgnMyaDWO1Bzg3w3b8x5Ee2QBRCMsGdlf5Bpvq+lxUcEI0cM7LBKTLP3un3NdNARG5Wtpim
 W/DHUdhLdcDfsEha392sv4uC+4u4ZZS3/i3XLpfLIx5sV8L9RmYMAUQUn5Qx954eQK4FQOLuM
 IXfxlfQZN573ah/YdoynhKid98OgAcBRFrlRRRIPffmIXIjWjGV+63b5WU/3GtHt4e6CYDew0
 PhY8ntm3oMbCCGVcfKnVa9g/F2Qnb9VfncoXaluvdjNRm/JryLl0uhYL2KdO/Gv3WNOyqEvoD
 fKVvWHQiTxVXH+efRPYOQ+vbb7UuZ15tEA8Xb6wjO/XBjyJN1T1aPnmVy9HfQMfu0absSnoTJ
 Iw+Gws6r/QbI5aAWdUIvDxcLJjVuaYl4TYANwTInGJ9kzH1sUyxMHjOO73NIGP4HH7B2yOjVc
 A3560xV7D4hB7DfGBnXDNx5SqguBb34BR2poerW2do4Z6DPfIuShPCfmHcJHlr
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BuRi53VjqypJJK4pfLGMVsJQZH1eVXaAr
Content-Type: multipart/mixed; boundary="b0CoB1SiiHs1gUzIX5qni7VQYS6dFUB3D";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, peter.wein@gmx.de,
 drake@endlessm.com, chiu@endlessm.com, linux@endlessm.com,
 morling.huang@alcorlink.com, bob@alcormicro.com, jin.tsai@alcorlink.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <c61aab2e-67b1-2cab-253c-bc78b3ff384a@rempel-privat.de>
Subject: Re: [PATCH v6 1/2] misc: cardreader: add new Alcor Micro Cardreader
 PCI driver
References: <20181202103046.29377-1-linux@rempel-privat.de>
In-Reply-To: <20181202103046.29377-1-linux@rempel-privat.de>

--b0CoB1SiiHs1gUzIX5qni7VQYS6dFUB3D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 02.12.18 um 11:30 schrieb Oleksij Rempel:
> This driver provides support for Alcor Micro AU6601 and AU6621
> card readers.
>=20
> This is single LUN HW and it is expected to work with following standar=
ds:
> - Support SDR104 / SDR50
> - MultiMedia Card (MMC)
> - Memory Stick (MS)
> - Memory Stick PRO (MS_Pro)
>=20
> Since it is a PCIe controller, it should work on any architecture
> supporting PCIe. For now, it was developed and tested only on x86_64.
>=20
> This driver is a result of RE work and was created without any
> documentation or real knowledge of HW internals.
>=20
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>

Forgot to add a changelog for this patchset:
20181202 v6:
- split one patch to two patches: cardreader and mmc
- use SIMPLE_DEV_PM_OPS in mmc driver
- use ida_simple_get/remove
- move DRV_NAME_ALCOR_PCI to cardreader driver. Other defines are shared
between drivers.
- fix some typos
- rebase against 4.20-rc4 and test it.


--=20
Regards,
Oleksij


--b0CoB1SiiHs1gUzIX5qni7VQYS6dFUB3D--

--BuRi53VjqypJJK4pfLGMVsJQZH1eVXaAr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlwDt3YACgkQdQOiSHVI
77TowQf/XmHatoSDzOtQayi6Q8Opi2VhhQOeyxLNn0b/8mlI3Wq9QZpda61JR9ot
3FjGg0gHqgOPpoIPQhWFpiLnbw/nhhTAvY+EWlP84H3nuxjqHSU61rM6zxYvrBx3
pQXlDFwU8LvpLMWr5vEXfTOlAe+q1aaHZxzyWG7kKKDCFTgBQQ3lKSjQXAy8dLQC
tu0H5OY8KVunh4UkPUJDXi8v5diCYOqcqEwBPHRVPi9IG0733QGfU0V8FUeo42RH
gvCtKUpBu1kvsfnZqh1UM6Yapox5d8VBUWmvJT2ulQqQ9an/QgeljMgIFFXyc9wo
6CsVAwOEFqRVEYK1D/s1Muw1ApUgww==
=VK1e
-----END PGP SIGNATURE-----

--BuRi53VjqypJJK4pfLGMVsJQZH1eVXaAr--
