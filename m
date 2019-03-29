Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8B5C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 01:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FDB21773
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 01:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b="jsRKuF6d";
	dkim=pass (1024-bit key) header.d=rjmx.net header.i=@rjmx.net header.b="xZcN976a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfC2Bac (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 21:30:32 -0400
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:53192 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727675AbfC2Bac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 21:30:32 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2019 21:30:31 EDT
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-01v.sys.comcast.net with ESMTP
        id 9g4hhMhZVqYAL9gDvhZ3DH; Fri, 29 Mar 2019 01:22:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1553822543;
        bh=hPPcc5jj+1exKbfL6vv2gxy6DKocg8gq0VPTXC0DpKU=;
        h=Received:Received:Received:To:From:Subject:Message-ID:Date:
         MIME-Version:Content-Type;
        b=jsRKuF6dL+RZcBgOxJzXNNOoXO/n89MjMde5vd/Zx2Hb7EmZrK+ID1le2JA/8+rCE
         Fz8o9Lq+HT10XQCT3lv+5+pZTmz1IaV8oee9i4tgLwr8CvOXBiX4IsfwuFBCxgRuNZ
         DrlO9cHpuU707Cg8/OjtSoJ2mf3YEg853fNiirQCsaj9NPQwfB8wLzWlC2lS/Nfi/x
         TOIX44WZwJWJRfKfHRv76sx3+d3z7Kitfc5y6BWlZkxMMawlgcS+gl9uVEe5KZl8QQ
         NuplVWJPAxoHDwQvBnrC4YewlLR29wlVrEf9XfYFq9+vislcOKbxcGs7YJa8iRhdVA
         qQf5XcT+FNnyQ==
Received: from mail.rjmx.net ([IPv6:2601:183:cb80:1f3::7])
        by resomta-ch2-11v.sys.comcast.net with ESMTPA
        id 9gDuhsN1Ybjph9gDuhQADs; Fri, 29 Mar 2019 01:22:23 +0000
X-Xfinity-VMeta: sc=0;st=legit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjmx.net;
        s=rjmx20160127; t=1553822541;
        bh=hPPcc5jj+1exKbfL6vv2gxy6DKocg8gq0VPTXC0DpKU=;
        h=To:From:Subject:Date:From;
        b=xZcN976acSpsw4C8dHtn0ob03tpHM1M5fcxoRuBsXK1aAZ7ONRt0B3hGQDkBvZOJd
         jAb77qeLo0zzrOr+SRBEH4zHGxBDUaC7ZZNh9JYwbP/o50CdTNrogqlrdAjwXlHybs
         QFO2v6a6eV3XBkPuI+nvWZcK5ecVVizOYTaZErkY=
Received: from [IPv6:2601:183:cb80:1f3::2] (khufu.rjmx.net [IPv6:2601:183:cb80:1f3:0:0:0:2] (may be forged))
        (authenticated bits=0)
        by mail.rjmx.net (8.15.2/8.15.2/Debian-8) with ESMTPSA id x2T1MJI6005596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 28 Mar 2019 21:22:20 -0400
To:     linux-pci@vger.kernel.org
From:   Ron Murray <rjmx@rjmx.net>
Subject: PCI device appears intermittently
Openpgp: preference=signencrypt
Autocrypt: addr=rjmx@rjmx.net; prefer-encrypt=mutual; keydata=
 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
 dGZIEA==
Message-ID: <06ca8af7-46e3-2769-cce0-48596ce99211@rjmx.net>
Date:   Thu, 28 Mar 2019 21:22:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="i6MvggfLqvqpeIo6NpVswPA4QZA0hJ5Xl"
X-Virus-Scanned: clamav-milter 0.100.2 at tinkerbell
X-Virus-Status: Clean
X-Scanned-By: MIMEDefang 2.79
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i6MvggfLqvqpeIo6NpVswPA4QZA0hJ5Xl
Content-Type: multipart/mixed; boundary="kE2Gysww4cXpeCvQEirtZMjzLTp7QVSQV";
 protected-headers="v1"
From: Ron Murray <rjmx@rjmx.net>
To: linux-pci@vger.kernel.org
Message-ID: <06ca8af7-46e3-2769-cce0-48596ce99211@rjmx.net>
Subject: PCI device appears intermittently

--kE2Gysww4cXpeCvQEirtZMjzLTp7QVSQV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

I have an ASRock 970A-G/3.1 motherboard, which, with current Linux
kernels, occasionally "finds" an extra PCI device on the initial scan. I
wouldn't mind, but it finds it early in the piece, and that changes the
PCI allocation of my Ethernet board from 02:06.0 to 03:06.0, and, with
systemd, Linux comes up with no network connection. A reboot fixes it,
mostly.

Here's the first few lines of 'lspci' when Linux doesn't find the extra d=
evice

> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI]
> RD9x0/RX980 Host Bridge (rev 02) 00:00.2 IOMMU: Advanced Micro
> Devices, Inc. [AMD/ATI] RD890S/RD990 I/O Memory Management Unit
> (IOMMU) 00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
> RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GFX port 0) 00:11.0
> SATA controller: Advanced Micro Devices, Inc. [AMD/ATI]
> SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)=20

and here's the same thing when it does:

> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI]
> RD9x0/RX980 Host Bridge (rev 02) 00:00.2 IOMMU: Advanced Micro
> Devices, Inc. [AMD/ATI] RD890S/RD990 I/O Memory Management Unit
> (IOMMU) 00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
> RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GFX port 0) 00:09.0
> PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980
> PCI to PCI bridge (PCI Express GPP Port 4) 00:11.0 SATA controller:
> Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA
> Controller [AHCI mode] (rev 40) 00:12.0 USB controller: Advanced Micro
> Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller=20

The 00:09.0 device is the extra one. Anything else I can provide to assis=
t?

=C2=A0Thanks,


=C2=A0.....Ron

--=20
Ron Murray <rjmx@rjmx.net>
PGP Fingerprint: 4D99 70E3 2317 334B 141E  7B63 12F7 E865 B5E2 E761



--kE2Gysww4cXpeCvQEirtZMjzLTp7QVSQV--

--i6MvggfLqvqpeIo6NpVswPA4QZA0hJ5Xl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Using GnuPG with Thunderbird - https://www.enigmail.net/

iQIzBAEBCgAdFiEETZlw4yMXM0sUHntjEvfoZbXi52EFAlydc0oACgkQEvfoZbXi
52EGThAArNljkML1PSHg4gaLaR4A15kKlPSODgd49u8P8lqJxxHRCzYpHZjUWPy0
7BCLfkNyXavED7eql54sAGaJcXLiqshENKyIc/RclIG1p7FTGF24kWQI+FlGPigd
mdTzmSDIUmBtyNHeWIzKeWM1rLl05GX6nz9qKSlO/njYfx7Kd0WkKZ2segHXwAm5
k0ql7EL3mKcyJqdf5eYsgufiSHjfn9uT2pRPDbZ6DJvr8CElbMywYV0g2t0dUHSH
/gE/V88MId9uRJSscG+jyuj4JOtNrKKuUueYgTN5mdy4BxNSUO2EYpCjVMm0bzj4
3IOPEh33SquxTXg3WdltnXXrrvF8TRhmer3J2ZjXzWFwGgo8QTzFPV4+/j36d3O6
ZAZxlyqs1ivs7h/NxsSfOWHcdbAxPTWdzUkBE+n40V5rRfzS8FF6Obuos/bqcXqv
1/cBq5gge4ciSt6SywbMdt48MnHnXeMfXIEUvDIZ22aqJCyWq3WRpcWaE6aOY6vI
EX5amk06/zJnFX/UwNOP9W5UJ/V+f38tHwpNIqkj+YcflImU8lLaqN6aame++hBc
hfNlUQkqrCmtEvt3dD+Fgj39MNrw0Bd5G6ySnBUCjUcIBlkioID12P9EM5X74pg5
HwRxFsu9PusecvGhgmJr9/QsxKXXgG7opea+/MVoE40E1ArG8Ao=
=WNta
-----END PGP SIGNATURE-----

--i6MvggfLqvqpeIo6NpVswPA4QZA0hJ5Xl--
