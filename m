Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <9f48e2a8-e1e0-e3db-af48-12297f8521f2@kleine-koenig.org>
Date: Thu, 12 Jan 2017 14:18:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 linux-arm-kernel@lists.infradead.org,
 Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: multipart/mixed; boundary="===============6745860731278047750=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6745860731278047750==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XUuhLucNQLGUfMka6ILx5CsjoiaugVEGE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XUuhLucNQLGUfMka6ILx5CsjoiaugVEGE
Content-Type: multipart/mixed; boundary="2PQKE2rFpqmOul4133NS8FBk5UoS82H42";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>
Message-ID: <9f48e2a8-e1e0-e3db-af48-12297f8521f2@kleine-koenig.org>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>

--2PQKE2rFpqmOul4133NS8FBk5UoS82H42
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:02 PM, Bjorn Helgaas wrote:
> Hi Uwe,
>=20
> On Wed, Jan 11, 2017 at 08:49:46PM +0100, Uwe Kleine-K=F6nig wrote:
>> Hello,
>>
>> on an Marvell Armada 385 based machine (Turris Omnia) with 4.9 the
>> ath10k driver fails to bind to the matching hardware if CONFIG_PCIEASP=
M
>> is enabled:
>>
>> [...]
> We have several open issues related to ASPM:
>=20
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D102311 ASPM: ASMEDA asm=
1062 not working
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D187731 Null pointer der=
eference in ASPM
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D189951 Enabling ASPM ca=
uses NIC performance issue
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D60111 NULL pointer dere=
f in ASPM alloc_pcie_link_state()
>=20
> I don't recognize yours as being one of these.  Can you open a new
> issue and attach the complete dmesg log and "lspci -vv" output?

Done: https://bugzilla.kernel.org/show_bug.cgi?id=3D192441

> Is this a regression?

As written in the bug report this also happens on 4.7.

Best regards
Uwe



--2PQKE2rFpqmOul4133NS8FBk5UoS82H42--

--XUuhLucNQLGUfMka6ILx5CsjoiaugVEGE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlh3gjcACgkQwfwUeK3K
7AnG0Af/cRR4WnRtA1abp9p2zpEunYrWI01jOXeqg1U3XzNdqUGYchne/usqGJmJ
wmudfb8nl84e77mDwjYHhSInHo9G0l/n+hEXPFxW4IjP/GaL5JofAg3rggVUThMq
rrgpHvBV92Wf37TLo3hQlxQCb85wKeQ77y+1Z4tfGxL1oXnjHjKnMJAXWdGhiYUe
E/zomHEU45ZG4G1id3tLUadA+NvhLoy9cFmrgDCsYtgClsrvuxPZTpPVadYoc3ON
DDZhfS2CCUe5AupTIDludFizEWqP4jWF7D+z4wLDWJWVUDLGgopsbq3nbCL98+p/
THbwJyvF8lmAbDnLnIwFV9WQ2YS5nw==
=+99D
-----END PGP SIGNATURE-----

--XUuhLucNQLGUfMka6ILx5CsjoiaugVEGE--


--===============6745860731278047750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6745860731278047750==--
