Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:8448 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbeHBOGB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Aug 2018 10:06:01 -0400
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI: add support for Immediate Readiness
In-Reply-To: <20180802115627.GA27976@infradead.org>
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com> <20180802115627.GA27976@infradead.org>
Date: Thu, 02 Aug 2018 15:11:37 +0300
Message-ID: <877el9ufwm.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Christoph Hellwig <hch@infradead.org> writes:
>> +	unsigned int	immediate:1;	/* Supports Immediate Readiness */
>
> That name is a bit too generic.  immediate_ready (or imm_ready if you
> need it short) would be a lot more descriptive.

That can be easily patched. I'll until tomorrow for more comments then
send a v2

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlti9PkACgkQzL64meEa
mQZONBAAsRYihCxik68CU32/pvThZMy/jXV4Ylf0Iyiam4VZtc23LsAkuCxQxU95
R3ocFNe73uLSAMrfywq3stmdftiMSBM+4QEEG1CMBLQ3+CjS3RQPGOQNmvv6b8cm
ZrMboHUwCTqpZ4QfbLIUmegQ2IgSDzTeZUA2bb6WtvqToHXaDWCRO1X0TlvQDpk/
v/j3btl2lLpy5+fMhWr6MW1Q7hC9Zi+ltr0oSfGp+sFrWNttyoPVJGTMKNdvHdcp
pGxnE3X0hqf+M/jJ0IayfLfYC7ok4T96Hi7xW2d6XZ3vTmUzoEh7ev9E79eiSkyr
QN0BRzoHNS9FA+il0mh50Qeu3cIB0i+g8wMSqFEuRAulnrsA/DYnwYEb71XOWaCG
XffPmm9oLNUGWSR4FqffK0dctZh1DhaZwIuyODobyesnowj3+YUc55eb/Ri8qkMo
MJG2lN42MwcM/IwNl0WLQ36gD8rnugA5Ktlfy2DFgB6AXr8zpSzM5euAnWTu0xSD
yZURAONlociw6i6hjn5+hgrdL8qxzch5RjhcV2WbAgTvPaOo3mC93kUw2yjvpeo7
IKZ7Tt6yc7wNAV93a2g/BElbc3WxssN0D97DWahYhpY+bgT7RZH2yok+Bkl8Q8bG
bwZF+IP9ZAw0vCYVkQf1+YW07YwqSZdTTtYQ7vYfeagN/+hfJ6w=
=ofJw
-----END PGP SIGNATURE-----
--=-=-=--
