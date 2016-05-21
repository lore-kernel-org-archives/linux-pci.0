Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34742 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbcEUBes (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2016 21:34:48 -0400
Received: by mail-pf0-f174.google.com with SMTP id y69so46149441pfb.1
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 18:34:47 -0700 (PDT)
Received: from gnubox.corp.yahoo.com ([2001:4998:effd:50b:3e97:eff:fe8f:3483])
        by smtp.gmail.com with ESMTPSA id g84sm29881545pfj.42.2016.05.20.18.34.46
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 May 2016 18:34:46 -0700 (PDT)
Date: Fri, 20 May 2016 18:34:44 -0700
From: Arun SAG <sagarun@gmail.com>
To: linux-pci@vger.kernel.org
Subject: MacbookPro 11,1 thunderbolt hotplug doesn't work - 4.6.0
Message-ID: <20160521013444.GA1635@gnubox.corp.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When i boot the laptop connected to thunderbolt apple display,=20
everything works fine. However, if i unplug the display and
re-plug linux doesn't detects the monitor. Seems like a device
hotplug problem

The bug with more description is availble at
https://bugzilla.kernel.org/show_bug.cgi?id=3D118591

Let me know if you need any more information from me.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXP7s0AAoJEIRjrlNwyTqS6HcP/AkxouZNGLqPlONYH1SPMPaf
TkaOMFI4j/DSoCKvt7BAvpyLlvW/Nnzi+Sot1hcZG7VVD9zhz89S0GlBiTCTz+YP
+RohfHN+rztgvBVrbaVXf3f9adqFTbgptg9P/dxIicdz7l7c1ko90mqlyC0Tu0u5
iG43vih6gGMKtQ/KRfs2TQSbMNsBhLlCAfQ/vFdqtf75QaTVRecWKXRaTSuHeq1Q
/k3E7VWp76Vq9sE+5LdyliVtT0xTG56XXKMkLi1MdwsM3jJRRWb3ZF0pMIj1Yvop
3IuoXv9cvD6j2J5Jr1J69u3PYOG5neO3MoVgfluNxE0AuFHdAh/E90IAdro7eCWJ
xjbTau4xfReT3kU5syhfIlvYWyCTuloI+e93IQdNsn7CSyUj2Od1TGMBGFe2xEEF
8zVv66Wx6McL88L6yp8TznEJ8CH0Sx8FZuKYbtglZnkhfvCIUoXX34D4787bFdMf
fedmlYXlsWmnR3UwikXMoeBzx2qBfOG3CK865YUb/mtVrY7UldcRDKytCnRxMy3i
gU8V1J07dU1aHDmN3EIYtGhBz4n26BRZRvHjEoqbeajuowhkqwuYOo9X/6TMiiWM
T/iqqghLV/YbpdoJ8Rn3MRFd6+EEHoeQZ+JNsuVJB4XH8p8kOJMQGhii16ADrc61
1mN+Ilj3lqMwSFlW75+H
=5Tug
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
