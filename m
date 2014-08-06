Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30735 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164AbaHFJoU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Aug 2014 05:44:20 -0400
Date: Wed, 6 Aug 2014 05:08:54 -0400
From: "Chen, Gong" <gong.chen@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: bhelgaas@google.com, rdunlap@infradead.org, tony.luck@intel.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] RAS, trace: Update error definition format
Message-ID: <20140806090853.GA21650@gchen.bj.intel.com>
References: <1407313964-20794-1-git-send-email-gong.chen@linux.intel.com>
 <20140806093223.GA27033@pd.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
In-Reply-To: <20140806093223.GA27033@pd.tnic>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2014 at 11:32:23AM +0200, Borislav Petkov wrote:
> Date: Wed, 6 Aug 2014 11:32:23 +0200
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: bhelgaas@google.com, rdunlap@infradead.org, tony.luck@intel.com,
>  linux-pci@vger.kernel.org
> Subject: Re: [PATCH 1/5] RAS, trace: Update error definition format
> User-Agent: Mutt/1.5.23 (2014-03-12)
>=20
> On Wed, Aug 06, 2014 at 04:32:40AM -0400, Chen, Gong wrote:
> > Previous format definition uses MACRO BIT(...), which is not very
> > maintainable.
>=20
> What does that "not very maintainable" mean?
>=20
Bjorn ever mentioned for this:
"I'd like to see all those "BIT(...)" things changed to use the #defines
that already exist in include/uapi/linux/pci_regs.h, e.g.,
PCI_ERR_COR_RCVR.  That way grep will find these uses, which will make
maintenance easier."

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4fClAAoJEI01n1+kOSLH0YAQAKsk8wkTOHinhFwr+pKbmDfY
CwT6kVtR27UKO0ggs0+946xApbDMitdKhrTLvw7xzgnlMlwGyTcAU/q6WXpnVeSr
1JJpgPL0ZbiOV7ghQtBju0NQgrZX0Apz77C3pnZpahtCEGDPKNz3tbRx6NSDmQl0
ZCXAm4DmQUAAOlWJalC+hTSHv7ViVqeZCL3CQBp2XYMsRSD6i4+GEICOSpDQibtv
Q08M8O4BUIRo5nS/uQwLlqT8BEdgJKKVw3VrVRc5eLR3wfVOOQM9Y2koWzwX69a8
iQoGhCanAsKqn1UPc/kLzMiu/o4ZjCL7HvC2juUkqRVsHiT95N21w8ElD459/tQf
EJdW+g7wT2rP3p3WOhCYt1Fj1nDfglGQslY9qV3aNykGR/h8GlGuwH6gbZfaYdEu
V8IwTuPeqHvyHQGtWtRatrXz0FUAAmhtMbyVrRp9B/SW6etYKfKWiG1g+Lrmvt2i
2g2G1uszZ4UfUZqhiNiBOqZOkj765qe5vy2l9A49yHiYcsDl99B6aFGXiBb0FqIM
LkLFoxiwgyOndm2nQuJIYb0/CrKB98knpZwImFgA5RfUhDbA6dg0Mbuahf/vk0gZ
kHwPwe1hs1AXBvB+kMRmoEnrmaxVlruIq0NIvcTY2jlrC6YbPYHEKas69mYXAkq2
ZwA35HfKtqn87Wz1PdEu
=xpTZ
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
