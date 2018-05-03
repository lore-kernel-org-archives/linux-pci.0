Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 3 May 2018 07:47:32 +0100
From: James Hogan <jhogan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/13] mips, unicore32: swiotlb doesn't need sg->dma_length
Message-ID: <20180503064731.GA3971@jamesdev>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-12-hch@lst.de>
 <20180502222017.GC20766@jamesdev> <20180503035643.GA9781@lst.de>
MIME-Version: 1.0
In-Reply-To: <20180503035643.GA9781@lst.de>
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
Content-Type: multipart/mixed; boundary="===============5887177435862520522=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--===============5887177435862520522==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 05:56:43AM +0200, Christoph Hellwig wrote:
> On Wed, May 02, 2018 at 11:20:18PM +0100, James Hogan wrote:
> > On Wed, Apr 25, 2018 at 07:15:37AM +0200, Christoph Hellwig wrote:
> > > Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
> > > swiotlb.  swiotlb itself never merges segements and doesn't accesses =
the
> > > dma_length field directly, so drop the dependency.
> >=20
> > Is that at odds with Documentation/DMA-API-HOWTO.txt, which seems to
> > suggest arch ports should enable it for IOMMUs?
>=20
> swiotlb isn't really an iommu..  That being said iommus don't have to
> merge segments either if they don't want to, and we have various
> implementations that don't.  The whole dma api documentation needs
> a major overhaul, including merging the various files and dropping a lot
> of dead wood.  It has been on my todo list for a while, with an inner
> hope that someone else would do it before me.

Okay, for MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuqwggAKCRA1zuSGKxAj
8jJ0AQDBwGZ2k1NphYwyh6OgPS7IN3FDLAFiO2iFddGI2zSf4AEA9hgbj9kgtHKd
8c/TTL4ZMY/xIMHoCb/jXAC1q13gig8=
=IGGZ
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--


--===============5887177435862520522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5887177435862520522==--
