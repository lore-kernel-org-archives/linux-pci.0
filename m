Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 2 May 2018 23:20:18 +0100
From: James Hogan <jhogan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/13] mips, unicore32: swiotlb doesn't need sg->dma_length
Message-ID: <20180502222017.GC20766@jamesdev>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-12-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20180425051539.1989-12-hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============3237485630161774899=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--===============3237485630161774899==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Apr 25, 2018 at 07:15:37AM +0200, Christoph Hellwig wrote:
> Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
> swiotlb.  swiotlb itself never merges segements and doesn't accesses the
> dma_length field directly, so drop the dependency.

Is that at odds with Documentation/DMA-API-HOWTO.txt, which seems to
suggest arch ports should enable it for IOMMUs?

Cheers
James

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuo5nwAKCRA1zuSGKxAj
8toFAQDILXOi2KhP1yoO3zabIiof3I/tmRomgzUgGA3ESVm5lgEA4elhmn7zDXhX
YG33reqJ7xyPenaOF8AX63cB5eqjOQ8=
=UDV2
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--


--===============3237485630161774899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3237485630161774899==--
