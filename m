Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53720 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbcETRcJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 May 2016 13:32:09 -0400
Received: from [192.168.1.130] (CPE002401f30b73-CM78cd8ec1b205.cpe.net.cable.rogers.com [99.224.138.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: axs)
	by smtp.gentoo.org (Postfix) with ESMTPSA id CAEA6340BFA
	for <linux-pci@vger.kernel.org>; Fri, 20 May 2016 17:32:07 +0000 (UTC)
From: Ian Stakenvicius <axs@gentoo.org>
Subject: [PATCH] Fix lack of exposure of pci_init for LIBPCI_3.0 on
 pciutils-3.5.0
To: linux-pci@vger.kernel.org
Message-ID: <1c0deb86-fee3-4de3-fb00-baf6e71ac7fd@gentoo.org>
Date: Fri, 20 May 2016 13:31:59 -0400
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u9GHCILH8k2kehMq6UixEl2EVg11M5TpI"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u9GHCILH8k2kehMq6UixEl2EVg11M5TpI
Content-Type: multipart/mixed; boundary="iDTPCg1HqOiuiJoL8OIMNwlxMPui0LjPr"
From: Ian Stakenvicius <axs@gentoo.org>
To: linux-pci@vger.kernel.org
Message-ID: <1c0deb86-fee3-4de3-fb00-baf6e71ac7fd@gentoo.org>
Subject: [PATCH] Fix lack of exposure of pci_init for LIBPCI_3.0 on
 pciutils-3.5.0

--iDTPCg1HqOiuiJoL8OIMNwlxMPui0LjPr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

The changes included in commit ab61451d47514c473953a24aa4f4f816b77
were not sufficient to maintain ABI compatibility with older versions
of libpci.so.3, as pci_init is only exposed under symbol version
LIBPCI_3.5.

This patch uses the code pattern for the versioning of pci_fill_info()
to ensure a pci_init symbol is exposed with LIBPCI_3.0 version.

Bug: http://bugs.gentoo.org/583580
---
 lib/init.c     | 2 ++
 lib/internal.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/lib/init.c b/lib/init.c
index 9a043ee..c7800e0 100644
--- a/lib/init.c
+++ b/lib/init.c
@@ -214,6 +214,8 @@ pci_init_v35(struct pci_access *a)
 }
  STATIC_ALIAS(void pci_init(struct pci_access *a), pci_init_v35(a));
+DEFINE_ALIAS(void pci_init_v30(struct pci_access *a), pci_init_v35);
+SYMBOL_VERSION(pci_init_v30, pci_init@LIBPCI_3.0);
 SYMBOL_VERSION(pci_init_v35, pci_init@@LIBPCI_3.5);
  void
diff --git a/lib/internal.h b/lib/internal.h
index f2027f8..cbac2a7 100644
--- a/lib/internal.h
+++ b/lib/internal.h
@@ -61,6 +61,7 @@ void *pci_malloc(struct pci_access *, int);
 void pci_mfree(void *);
 char *pci_strdup(struct pci_access *a, const char *s);
 +void pci_init_v30(struct pci_access *a) VERSIONED_ABI;
 void pci_init_v35(struct pci_access *a) VERSIONED_ABI;
  /* access.c */
--=20
2.7.3



--iDTPCg1HqOiuiJoL8OIMNwlxMPui0LjPr--

--u9GHCILH8k2kehMq6UixEl2EVg11M5TpI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlc/ShUACgkQAJxUfCtlWe2GQwD+OYl7g9hlZOlL7sIwDTSzc7Of
NmZNS3oybEz2LEAJDiIA/ilBbBYbD/c3t70qZLDYqLSyzGHwxoXFZTJFnmBAF6SU
=S4zR
-----END PGP SIGNATURE-----

--u9GHCILH8k2kehMq6UixEl2EVg11M5TpI--
