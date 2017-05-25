Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48083 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755275AbdEYKQw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 May 2017 06:16:52 -0400
Date: Thu, 25 May 2017 18:12:57 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: linux-pci@vger.kernel.org
Cc: changbin.du@intel.com, linux-kernel@vger.kernel.org
Subject: [Q] What about PCI mmio access alignment?
Message-ID: <20170525101256.GA12183@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, guys,
I have a basic quesion about the alignment when access PCI bar mmio space. Is
the address accessed must be DW aligned and count must be DW aligned?

As far as I know, The address field of TLB ignore lower 2 bits and the unit of
length field also is DW. So does it mean above question is Yes? Else will CPU
handle unaligned access for mmio space?

I want to know wether below access illegal or not:
  - readb(bar0)
  - readb(bar0 + 1)
  - readl(bar0)

Thanks,
Changbin Du

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJZJq4oAAoJEAanuZwLnPNUVioH/itIChSCXqNBQlYK15avvp37
+HUW+SXu9gLYKZrDXhBqjy70V58dqDYyeq78ToLxlv0kgBK28QprA7LvO3JYDcFo
HmeidsisuewASkcPJeZ390JUMjgRmLfFz5/iJ1bi1l6hFERa8xnsTcVOux+ESPqp
jLAVBtDxZivt+Gbx6eZ7oiasvOkfhx7suEzES5NvzkEC+IKMRjge5ZJ6mwPquein
C1wERsXCt3fIE2AjvukTced2JAWLjy1f4BIr3Ys6pBV0Ux1As52jt0qPQdZQgMyb
TT7q+GLlEdb5gn+S8tXj0BQ6BBn3/Gfi7P7u5Rw1NtCDgy0n91vGgqFCqBrMLgs=
=vMEV
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
