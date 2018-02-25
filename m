Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f48.google.com ([209.85.160.48]:38796 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBYVDX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Feb 2018 16:03:23 -0500
From: Mark D Rustad <mrustad@gmail.com>
Message-Id: <FB2B33F6-69B7-4EC4-9E0E-3FB33FE61235@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_56A12B5B-41B4-4234-8E2C-854127D66B2B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [virtio-dev] [RFC PATCH V2] virtio_pci: Add SR-IOV support
Date: Sun, 25 Feb 2018 13:03:18 -0800
In-Reply-To: <7B7DC8E0-9F6A-403F-8077-39FC3939482E@redhat.com>
Cc: Mark Rustad <mark.d.rustad@intel.com>,
        virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.daly@intel.com, alex.williamson@redhat.com,
        alexander.duyck@gmail.com, mst@redhat.com
To: Yan Vugenfirer <yvugenfi@redhat.com>
References: <20180222175250.97135.98386.stgit@mdrustad-mac04.local>
 <7B7DC8E0-9F6A-403F-8077-39FC3939482E@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Apple-Mail=_56A12B5B-41B4-4234-8E2C-854127D66B2B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On Feb 25, 2018, at 7:20 AM, Yan Vugenfirer <yvugenfi@redhat.com> =
wrote:
>=20
> Small mistake in the commit message. Red Hat (Qumranet) vendor ID is =
1af4, virtio-net device ID is 1041.
> Should be:
> PF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 15fe
> VF: vendor: 1af4 device: 1041 subvendor: 8086 subdevice: 05fe

You are so right. I will fix it before I send the updated patch that =
provides the generic helper that Christoph suggested. Thanks for =
catching my mislabeling.

--
Mark Rustad, MRustad@gmail.com


--Apple-Mail=_56A12B5B-41B4-4234-8E2C-854127D66B2B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlqTJJYACgkQPA7/547j
7m7TuhAAshi4zxT0AiR4tCSyOlmR8gfGzr04W9dC5BH2D3mnGj0Se6WShvJ256J3
R9DqMz0cq02D5Z6KJHskng9oLj4HgPaLgTuVHpiET8UzdZKieuPOs5LCwtMsi2ID
9XNSt9TqjmAmMAdJZT0IETdAX26LWBb236RomQ96jV/HSDBpKX0Z6qnXURlnrX9B
yvnmwOgcMb+v6BkWdRTIvqvSXRuIc0UeYYRk/zxbaPzxBa2w8It3H0S5/Ua8nsMi
VQuKoumlK2lCVPZXLKvyxtPPEs0+4KRsQPZ8LrOZtSK87kREIRofZgBnPhaxwH5B
I9fmLMgj9+A9pSlbD04Tz1DxW7CWOt0C6dB8t5kXV7z1+a8AAxJMqqYzeCJZo0Za
OlUwbavDIuibzx7nOnDMB527+bmeW4DebNHfauhctZ8XZdMvRkKXdjV/iSS8glRh
XeJfM23A9Vv4YVueWU0b/xWGaLFSStkyYj1SnfKIwwNePNNwDOmy9i4nDhirVYk2
xQc4A+xNUL1HoJqn0MjuztyaXtOsqqhd6cCMaWVQ4WbpuAbwW8LEWwqlnybNjmqs
bt2xpzyZnKpCegyar62+RGJ3HLe5g2WkbW3GayNocjwPvwvhPEv9S4lBc0U1lEwu
HPhxtzG8grh3xybSm3PViESrbwpOoGt9qt7JcEEjXR5JOoX+bHg=
=g7no
-----END PGP SIGNATURE-----

--Apple-Mail=_56A12B5B-41B4-4234-8E2C-854127D66B2B--
