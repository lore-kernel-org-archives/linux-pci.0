Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Jan 2018 15:36:33 +0100
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
Subject: Re: [PATCH 6/7] PM: i2c-designware-platdrv: Optimize power management
Message-ID: <20180108143633.rtnc3jagelybdfnn@katana>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan>
 <2436726.ykYRzVD45y@aspire.rjw.lan>
 <6243259.Xh4soKtjBb@aspire.rjw.lan>
 <bb17c593-d8ab-ace6-4127-249da0b8af54@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o5jmihrbbyvkzvwd"
In-Reply-To: <bb17c593-d8ab-ace6-4127-249da0b8af54@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--o5jmihrbbyvkzvwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2018 at 04:31:58PM +0200, Jarkko Nikula wrote:
> On 01/03/2018 02:37 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > Optimize the power management in i2c-designware-platdrv by making it
> > set the DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED which
> > allows some code to be dropped from its PM callbacks.
> >=20
> > First, setting DPM_FLAG_SMART_SUSPEND causes the intel-lpss driver
> > to avoid resuming i2c-designware-platdrv devices in its ->prepare
> > callback, so they can stay in runtime suspend after that point even
> > if the direct-complete feature is not used for them.
> >=20
> > It also causes the ACPI PM domain and the PM core to avoid invoking
> > "late" and "noirq" suspend callbacks for these devices if they are
> > in runtime suspend at the beginning of the "late" phase of device
> > suspend during system suspend.  That guarantees dw_i2c_plat_suspend()
> > to be called for a device only if it is not in runtime suspend.
> >=20
> > Moreover, it causes the device's runtime PM status to be set to
> > "active" after calling dw_i2c_plat_resume() for it, so the
> > driver doesn't need internal flags to avoid invoking either
> > dw_i2c_plat_suspend() or dw_i2c_plat_resume() twice in a row.
> >=20
> > Second, setting DPM_FLAG_LEAVE_SUSPENDED enables the optimization
> > allowing the device to stay suspended after system resume under
> > suitable conditions, so again the driver doesn't need to take
> > care of that by itself.
> >=20
> > Accordingly, the internal "suspended" and "skip_resume" flags
> > used by the driver are not necessary any more, so drop them and
> > simplify the driver's PM callbacks.
> >=20
> > Additionally, notice that dw_i2c_plat_complete() only needs to
> > schedule runtime PM resume for the device if platform firmware
> > has been involved in resuming the system, so make it call
> > pm_resume_via_firmware() to check that.  Also make it check the
> > runtime PM status of the device instead of its direct_complete
> > flag which also works if the device remained suspended due to
> > the DPM_FLAG_LEAVE_SUSPENDED driver flag.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/i2c/busses/i2c-designware-core.h    |    2 -
> >   drivers/i2c/busses/i2c-designware-platdrv.c |   31 ++++++++++--------=
----------
> >   2 files changed, 12 insertions(+), 21 deletions(-)
> >=20
> This doesn't apply to linux-next due 0326f9f801b2 ("i2c: designware: rena=
me
> i2c_dw_plat_prepare_clk to i2c_dw_prepare_clk"). It was trivial to fix wh=
ich
> I did locally for testing.
>=20
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--o5jmihrbbyvkzvwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpTgfEACgkQFA3kzBSg
KbZ6zA//YAuzRvfpd0Ga5+Y/PCEFp0ZZUu3Jrp3GgGYUOxl/gvL2cgg8Dj635Cmk
Dg4AX+gfQ/fxz7rQ6NNkQUKmA6HcqpAXhnaMcI+lAt0oE0gCmsr/vI5VTrAUKRi6
mT8Dfw3Ja7kravQVnKBT+pd2YXTaDRKa0SfxUzAIvdrg9mulsE7DRkB7qoR/CKEg
PPcouVDk04SVcQyYRirAKKRG1yQTUr1HcspSNNnLNWioSaLrgCSh0uFwrUD7iV2G
mKPFVXemZKSxwPaohOcI4jx91LHK1Q4/wjwY8MA7RRduAYNuXBu5RDfSgzG4E+jp
CW7ut0e/HwICxDQ5QYH40OHLncTfdTwvnS5b5NvC3jrK4I28RZbp2G24POyc/RJr
gKm+qIZ7pZqug5ZEFAhg+rixSR/6wqpX651CqJ9sopjcr/DDmzUEVqGxT6BMU2Po
KrLVQ5ySgCQNwBFi1UHAyl7S55RScdoLrj0EfwpaH05ZJUHiKU2P3Hbdnyb6oNC8
PxnPbQvnuRdJSI5R2SzRN+kyDrodVHLflulx699U97J5xMHA1s9RrXvwt6y2PI3r
9IczwyhVhr25vVhPnSIxiOdembyf4zUJoHalTHaAO3dgutNb9YrcxLhtA/oZ/t2u
8TMPHiuhfQhh4nAMDJr+klTw1nrAZXgnT/dO80k9uA5ErXyBNCE=
=v7u5
-----END PGP SIGNATURE-----

--o5jmihrbbyvkzvwd--
