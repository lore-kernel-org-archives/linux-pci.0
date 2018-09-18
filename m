Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42532 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeIRQXe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 12:23:34 -0400
Date: Tue, 18 Sep 2018 12:51:30 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH][RFC] PCI: rcar: Add bus notifier so we can limit the DMA
 range
Message-ID: <20180918105130.GA1545@kunai>
References: <20180521220514.30256-1-marek.vasut+renesas@gmail.com>
 <20180918101555.GB26886@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
In-Reply-To: <20180918101555.GB26886@e107981-ln.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 11:15:55AM +0100, Lorenzo Pieralisi wrote:
> On Tue, May 22, 2018 at 12:05:14AM +0200, Marek Vasut wrote:
> > From: Phil Edworthy <phil.edworthy@renesas.com>
> >=20
> > The PCIe DMA controller on RCar Gen2 and earlier is on 32bit bus,
> > so limit the DMA range to 32bit.
> >=20
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-renesas-soc@vger.kernel.org
> > To: linux-pci@vger.kernel.org
> > ---
> > NOTE: I'm aware of https://patchwork.kernel.org/patch/9495895/ , but the
> >       discussion seems to have gone way off, so I'm sending this as a
> >       RFC. Any feedback on how to do this limiting properly would be ni=
ce.
> > ---
> >  drivers/pci/host/pcie-rcar.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
>=20
> The issue solved by this patch was solved in a more generic way through
> this series:
>=20
> https://lists.linuxfoundation.org/pipermail/iommu/2018-July/028792.html
>=20
> I will therefore drop this patch from the PCI patch queue.

Cool. Thanks for this series and thanks for the heads up!

Marek, can you confirm our issue is fixed (if you haven't done already)?


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlug2K0ACgkQFA3kzBSg
KbZbog/9HpLjP7awzf8xQT6xcAs8cZNt838mEeXqiSqFyCxx84l1CKo3Wg+2ArHm
9g9ZZvRrR9V9gy4pM42AWdZactmJ5PmIIHQHqDuhk+zzgh12qKmxWmtAcrqG20n2
8udK1VDmYV0A73AXfcReKPLB30XoE3eMGYhjaX8ftt31kl/YZfYKTf96R8hyl1YD
qtJsRMYmerLpbGjIGrEcC55fq9jx7/AuQDIo1cK85HVqzCUUTSiUiga8qim11E+I
4J9ugAfPQVDrtRxLNdBJjvA2LHzanQU1PKAw5Uu1J14dioVmlXMxUHUmoH1VRC1W
EHsYNpvN39NQeXZiEbqsCtEUnLqMB09aag/aEKrFLPke6WTeqel394Pg98IcMRjj
udnKev0CcwObGURU2zUk/cS/tSTGRcC4GA0NApx5xwVr4EcmR6u6zrm5d0DRBzLy
fLrJhhJj28SaDjbAjtGpoDdm8eekVyYkPJwL0Jr/dKn6xNBwauFkHHWfr4bqsEpV
CAM2DpSJU4IxmSURe3BGTWmyQGifXAG5MwCUwPKZjvCpY0LLG/9bU31Wq39WwMN0
rl33JCYszh5PyIqhyAGvwGlUzkLy2wEF9BozZSy7CYCMqBzSfEYP83oqTasWmtzD
riB1GMdg/zpgTrz1n5b5W0e3aU9EssWMIpu89NLVMvOpKm+RriQ=
=mBfT
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
