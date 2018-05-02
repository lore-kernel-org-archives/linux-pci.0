Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 2 May 2018 21:11:25 +0100
From: James Hogan <jhogan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/13] arch: remove the ARCH_PHYS_ADDR_T_64BIT config
 symbol
Message-ID: <20180502201123.GA20766@jamesdev>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-8-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20180425051539.1989-8-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, sstabellini@kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3469111335176836528=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--===============3469111335176836528==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 07:15:33AM +0200, Christoph Hellwig wrote:
> Instead select the PHYS_ADDR_T_64BIT for 32-bit architectures that need a
> 64-bit phys_addr_t type directly.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/mips/Kconfig                      | 15 ++++++---------

For MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuobYAAKCRA1zuSGKxAj
8rcSAP9uo9v+ADH7S0A5ptU5zQJbehcDNcjsP+tV3mIWaMxo5AD9Fxc2fxERhWzk
sHBf3K14mN5e+PiMMLB9/hGD7t8eJAo=
=7djd
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--


--===============3469111335176836528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3469111335176836528==--
