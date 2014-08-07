Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34366 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158AbaHGBbC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Aug 2014 21:31:02 -0400
Date: Wed, 6 Aug 2014 20:59:22 -0400
From: "Chen, Gong" <gong.chen@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: bhelgaas@google.com, rdunlap@infradead.org, tony.luck@intel.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] RAS, trace: Update error definition format
Message-ID: <20140807005922.GA8961@gchen.bj.intel.com>
References: <1407313964-20794-1-git-send-email-gong.chen@linux.intel.com>
 <20140806093223.GA27033@pd.tnic>
 <20140806090853.GA21650@gchen.bj.intel.com>
 <20140806095939.GB27033@pd.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <20140806095939.GB27033@pd.tnic>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2014 at 11:59:39AM +0200, Borislav Petkov wrote:
> > Bjorn ever mentioned for this:
> > "I'd like to see all those "BIT(...)" things changed to use the #defines
> > that already exist in include/uapi/linux/pci_regs.h, e.g.,
> > PCI_ERR_COR_RCVR.  That way grep will find these uses, which will make
> > maintenance easier."
>=20
> So explain that in the commit message but don't use some bits out of
> context.
>=20
> In general, when you read your own commit message, always ask yourself
> whether other people will be able to understand it, long time from now
> and out of context.
>=20
> If yes, only then send out the patch.
>=20
Copy that. Thx a lot!

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT4s9qAAoJEI01n1+kOSLHj4EQAJX7/7IhLiR25HKCmZHo4boJ
/F3aMrYeK/boAgxz7zUh6HyV0NOJD7ryfYVyLhnDbLDitaB2JClY2HsMF+2ia+ya
qBraGaa34+ED2OtioiFaZFg1rUgLrSjPVyYH4OXThKcvSGPvkGSehviDKl/BbCdQ
ZjiGfqhembMhxtxDNNCeEEbMmy78WwYZ5B80MQmWWu3i4lTn3VBdOyt3QOU/JJ1Q
C4HNgw6jBnJlGwvUCVqzBDiPypUB4geHcl1OGH6AVvBt6ODRyPFfyNXj+Cgw/E8z
G0AnMBrDzcU/EKHz2RczzploX4FE50xmVtMtyazAy78H1u3vJzz9qvkVhCsZs77o
dOLkgfqtJMySzG6c1HdHktplkzHosuJgEMaBgJe/qkA2I9dyyFtu3x9+XXjdWE/k
T5hJ6ONUzZF/89nSeHlqUFxD0po03ldcfruG594PCt+O0Wwe8ifBD40odw4WVNP3
z3cDnrbttE83QO3dp6ovmF8lYOnV9RBTBigmbJaFyhFYrBt6q9d8nJKJ+AAAUEEw
PrWRFpPxAbmS/TFN9Kt/lScVkk3zx6ahQPqWy3dGI0jWqb18eylQO8L5ia1ZX4Gm
/0rDUeGLg+XJs4zckMS1DpzudjqS7+ZwjcbSdox9iikgPzLApZoEze11JVBzI6AY
fDsfI/gfncwOuNIIJnMR
=+QYX
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
