Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 8 Jun 2017 10:42:02 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/6] ACPI / PM: Suspend-to-idle rework to deal with
 spurious ACPI wakeups
Message-ID: <20170608084202.GA1609@light.dominikbrodowski.net>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
In-Reply-To: <8918199.uo13RZ8hZk@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rafael,

On Thu, Jun 08, 2017 at 02:00:40AM +0200, Rafael J. Wysocki wrote:
> Hi All,
>=20
> This series is a replacement for commit eed4d47efe95 (ACPI / sleep: Ignore
> spurious SCI wakeups from suspend-to-idle) which is still there in 4.12-r=
c4 but
> will be reverted shortly, because it triggered issues on quite a few syst=
ems.
>=20
> The last patch in the series is a counterpart of the above commit with a =
few
> modifications, mostly to avoid affecting suspend-to-RAM and to reorder me=
ssages
> printed to kernel logs to make them somewhat less confusing.
>=20
> The previous patches are pre-requisite changes plus some cleanups.  The m=
ajor
> ones are [1-2/6] and [4/6] that are really needed for things to work as e=
xpected
> after [6/6].
>=20
> In addition to that, this patch from Hans: https://patchwork.kernel.org/p=
atch/9762815/
> is needed for USB wakeup on Bay Trail and Cherry Trail systems to work in=
 general.

with eed4d47efe95 reverted and this patch series applied, suspend-to-mem
works as expected. Thanks!

	Dominik

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAlk5DdYACgkQmpdgiUyN
ow09iBAAmGePWAkgKbG/WUruF0gtdYq30TPk4ZePBWmvyRtTGkAB4tqtsA8xhQZU
SkIvSDgtL/R+a3jkPTxL6ay4iu5WUJfa7ZwU9JCFKK0CcIBqx1jLwTq8oT3LZw1J
X6nMrLPDd3h+NznSsoTEwfFE5J8vDN99nUoaDaiO9eYmyeU0ZLkesaauFzEDot5e
Rhv8uyYry4KMwO6Pk4hGpukRTHZmeo8x/DJPCE8kID+7dNtON1HTz66K9Pr3c0+G
pUACUeGJ50pNaOdv8O82HQp5D534tfA+/5kebC6C7e/aRHC2FRd+Wpf2rXYmdMW8
nt/s61+hZyyLmiN3iUGPGhFQ+dpr5/zPMHwYhx7RVxRDlGxdXSg6lKaBOwlIxHGD
hNf5M3lL6Z++oDSTzsQhVMIDapmCx5fTE0vsZp+WfcwwrMnLrcHIU3BxMA/z9M6H
og7NG6Lp5sJe157qaZQJTUcfH6C2Q2JTNAEgsEjt1BMx0ecRZyiGcCQAmRCmL/45
627yxeOLf/5/OyZBWJn7Ggzie30CLr+KvyCLA89oJXZcGgN+HZ+IPpcUoWVzR8aC
TdNHaJdDKW5kdw3bDYbLclZapCzO4aJGaGpd/Rn2HQisHgwkZbjr2Lmu+bVKc8Kg
SRIzMzleFiouf/BUTA+gyctekpC/B6u9NQrqxSQ10i95R/m+ioI=
=SpuP
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
