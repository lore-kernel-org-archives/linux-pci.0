Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Jan 2018 15:36:20 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kevin Hilman <khilman@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 5/7] PM: i2c-designware-platdrv: Use
 DPM_FLAG_SMART_PREPARE
Message-ID: <20180108143620.45lqfnqjqiv4ehuu@katana>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan>
 <2436726.ykYRzVD45y@aspire.rjw.lan>
 <1780798.HpLBO7aPyI@aspire.rjw.lan>
 <8924de22-96f5-0e10-7aaf-29b5a490afe2@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nfcbzpdksdfleslb"
In-Reply-To: <8924de22-96f5-0e10-7aaf-29b5a490afe2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nfcbzpdksdfleslb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2018 at 04:31:49PM +0200, Jarkko Nikula wrote:
> On 01/03/2018 02:35 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > Modify i2c-designware-platdrv to set DPM_FLAG_SMART_PREPARE for its
> > devices and return 0 from the system suspend ->prepare callback
> > if the device has an ACPI companion object in order to tell the PM
> > core and middle layers to avoid skipping system suspend/resume
> > callbacks for the device in that case (which may be problematic,
> > because the device may be accessed during suspend and resume of
> > other devices via I2C operation regions then).
> >=20
> > Also the pm_runtime_suspended() check in dw_i2c_plat_prepare()
> > is not necessary any more, because the core does it when setting
> > power.direct_complete for the device, so drop it.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/i2c/busses/i2c-designware-platdrv.c |   10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--nfcbzpdksdfleslb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpTgeQACgkQFA3kzBSg
KbZ0kA//cCPWMuiNnbOMM37736Uix7V3PigI6Uh7ZuMicNsfrDViEuD1ALN81y7/
CzbgZefPWNlBYXB0DVwNPHduWsT9syvT1lA1Ojl/JNZ9K2FbxSaj4OUb5PJS4dUg
FmrOXwo2HKQiwAFT/6OrGSl+0JtOOIl8AMrCnbOWjc2/1Ec64OrCwxPFaAcXvjBy
DeZixQCXmGZ/XiQoPVQL23uinFGrbEZAPrBMNNc6krdrtNmF56A/inzARcsWqLUR
m3HH533pzawZmOM4uyme1iLKvu5ZxIbw8xGO26llXf29tJdrtVRhe4oWcPWyMCW9
byDZ8Ekw4ks3Pc+QsBFgEfNYEwIoSbUlEEhlY3tTqALWWRA6jTsbhHxMbTzqjKwr
CUoNui5GpmChaouawcQTyrkYlA1e3FaCnD1D48XjvWZhHfp0NhXXT4TaiPGmPJkI
HKYTtROqnD4OtsvZDi5WXmwD9ETG4z4XZ76Dc3JLALjMNhvggpywn5RWzfn0usLo
pFJPA+fDC3xg3jNfi5mu0Z1QjurDvQUfCRlTVqZLj5qXun8tWlSQfUh7xyIcOooA
KyrzLdn9Dx5jTnKC3E3XVgZAL7RP0RIgpHE16+Qr0YoumStI/leV5kNY0KvL/uOe
1ChDnUjJhuio9goGGHAKPQraiUHvCAlSpMbCS6QRb7vhyUzUGo4=
=GdDV
-----END PGP SIGNATURE-----

--nfcbzpdksdfleslb--
