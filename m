Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 11 Jan 2017 20:49:46 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To: linux-pci@vger.kernel.org
Subject: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>
Content-Type: multipart/mixed; boundary="===============4592653797111913026=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--===============4592653797111913026==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfx2moozahffmabd"
Content-Disposition: inline


--yfx2moozahffmabd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

on an Marvell Armada 385 based machine (Turris Omnia) with 4.9 the
ath10k driver fails to bind to the matching hardware if CONFIG_PCIEASPM
is enabled:

# dmesg | grep ath
[    7.207770] ath10k_pci 0000:02:00.0: Refused to change power state, currently in D3
[    7.237955] ath10k_pci 0000:02:00.0: failed to wake up device : -110
[    7.238146] ath10k_pci: probe of 0000:02:00.0 failed with error -110

if however PCIEASPM is off, the driver probes correctly and the ath10k
adapter works fine.

I wonder if someone has an idea what needs to be done to fix this
problem. (OK, I could disable PCIEASPM, but I'd like to have a solution
for a distribution kernel where I think PCIEASPM=y is sensible in
general.)

Best regards
Uwe

--yfx2moozahffmabd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlh2jFMACgkQwfwUeK3K
7An5bwf5AUJHojrpPHJYX4EqhNkcnrmatOhAC/FmRNyF9R7T0vOUHHSy7Q/CJEix
emJ6ZQomlwNIBIc8lKHCWXh/NDCtbhMy5we47/Y6xZ3sZEoFvL61zDI+ySrqjWHH
m+cPcf3BwUrBbWaKMDjZCYtvwHnrdJqPROn8tipdhyUrSFVJQ89w45QQxFXq3Aqm
oZQ+shj7Zivv2O4YC0EhcwVa/jn/z0ZHXg3YlD4vpDTKqaKXbkVVD+cUfuPlEOzN
xGpKe64fWwjuYJM2xhWS0Sj1PL+DWl2CXnfbgd1ghTqgWft6hArVbo45x7RGHAoI
xRMbnnY5wHaLoEMjFyICC9hEUkxCpQ==
=Ejk8
-----END PGP SIGNATURE-----

--yfx2moozahffmabd--


--===============4592653797111913026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4592653797111913026==--
