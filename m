Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59777 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932416AbdJZUlm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Oct 2017 16:41:42 -0400
Date: Thu, 26 Oct 2017 22:41:40 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 11/12] PM: i2c-designware-platdrv: Optimize power
 management
Message-ID: <20171026204140.wzrq4lronz4nu6la@ninjato>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <2298462.BTY6P2Oy1l@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4od3itvpvopd5d5"
In-Reply-To: <2298462.BTY6P2Oy1l@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--p4od3itvpvopd5d5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 03:31:17AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Optimize the power management in i2c-designware-platdrv by making it
> set the DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED which
> allows some code to be dropped from its PM callbacks.
>=20
> First, setting DPM_FLAG_SMART_SUSPEND causes the intel-lpss driver
> to avoid resuming i2c-designware-platdrv devices in its ->prepare
> callback, so they can stay in runtime suspend after that point even
> if the direct-complete feature is not used for them.
>=20
> It also causes the PM core to avoid invoking "late" and "noirq"
> suspend callbacks for these devices if they are in runtime suspend
> at the beginning of the "late" phase of device suspend during
> system suspend.  That guarantees dw_i2c_plat_suspend() to be
> called for a device only if it is not in runtime suspend.
> Moreover, it also causes the PM core to set the device's runtime
> PM status to "active" after calling dw_i2c_plat_resume() for
> it, so the driver doesn't need internal flags to avoid invoking
> either dw_i2c_plat_suspend() or dw_i2c_plat_resume() twice in
> a row.
>=20
> Second, setting DPM_FLAG_LEAVE_SUSPENDED enables the optimization
> allowing the device to stay suspended after system resume under
> suitable conditions, so again the driver doesn't need to take
> care of that by itself.
>=20
> Accordingly, the internal "suspended" and "skip_resume" flags
> used by the driver are not necessary any more, so drop them and
> simplify the driver's PM callbacks.
>=20
> Additionally, notice that dw_i2c_plat_complete() only needs
> to schedule runtime PM for the device if platform firmware
> has been involved in resuming the system, so make it call
> pm_resume_via_firmware() to check that.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

So, if the designware maintainers ack it, I will, too.


--p4od3itvpvopd5d5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnySIQACgkQFA3kzBSg
KbZqfg//eepQ7dfIR99euQ0zyI993jzfRLKBz6UAy5kdpVCo6Hl2E2QcJNecTwFU
eyNRbrPW6EpXZvE2QqVASNHVVqYCQXSK1mJtopwDmZJHPq1WL1fQ7LlXvk4fPc8S
KaiPqvZ4s3leeseUgOCkEW8Ee8g2V5k6mZUmotDjL9lGdi80sKcycm4BJ3nWZLaH
/6KwYYHy7UKTw7LlXgoTQ4qeqLKjngHh6/tv7U/qkeD9Ai9ia21x6x6hzHcshfnS
QUNPdKMAqJdHJgdXxBQB8aOdupkKj1lV0AXMw+v+CmMh/8gDfsSET5HWt1teVPVR
2SBZv9bw/AFuZrnAM5vlLvxeBFs91VfP7C/RzjKT+vfHxmiiOfJMgGY2aCY3JsOe
SqfhT/5gdemKcn3lcPvLjMA+0g4woZI59VOaeSETdSvXPHxfe4Y0D4LtNEKtubc/
4vw8Kkh5XDLv6WtI1zDjoHcxcdwyQ7tluK/2jUGN2ekm0lnCHjUtKAkQSpZnWSE0
MXQhqdwatY8GXi5wGxlPu/eAqcgt471/qi1yHvFf1DdKlmcLNRQcF3a7/xW+u2Ct
qK1w7Y8GElRdzacu0so2bfRMEYPh3tH3JKbFAH/PpmoYIi9+83zi5kLohOPdQ/WI
9ALXn8cRYaKM0zpFotULZ75sZqEoJqta974bnGTP14m4zLHnkGo=
=JoV4
-----END PGP SIGNATURE-----

--p4od3itvpvopd5d5--
