Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: Thunderbolt 3 (Skylake / Alpine Ridge) hotplug
To: Bjorn Helgaas <helgaas@kernel.org>
References: <56D0085B.60402@jscinoz.so> <20160315172909.GF19974@localhost>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
From: Jack Coulter <jscinoz@jscinoz.so>
Message-ID: <56F101C2.7010904@jscinoz.so>
Date: Tue, 22 Mar 2016 19:26:42 +1100
MIME-Version: 1.0
In-Reply-To: <20160315172909.GF19974@localhost>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dS6p978QL5GtkaJO3eLAG1o5kNmQN8Ikn"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dS6p978QL5GtkaJO3eLAG1o5kNmQN8Ikn
Content-Type: multipart/mixed; boundary="k2WcETCtVujjDCtvn9m6SdflWLVkmS6SF"
From: Jack Coulter <jscinoz@jscinoz.so>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <56F101C2.7010904@jscinoz.so>
Subject: Re: Thunderbolt 3 (Skylake / Alpine Ridge) hotplug
References: <56D0085B.60402@jscinoz.so> <20160315172909.GF19974@localhost>
In-Reply-To: <20160315172909.GF19974@localhost>

--k2WcETCtVujjDCtvn9m6SdflWLVkmS6SF
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

> Can you open a report at http://bugzilla.kernel.org, category
> drivers/PCI, and attach complete "lspci -vv" output (run as root) and
> complete dmesg logs, both when hub is attached at boot, and when
> booting without hub and attaching hub later?
>
> I don't know much about Thunderbolt.  But since it appears as a PCI
> device, I would expect some sort of hotplug notification when you
> attach the hub.  If pciehp handles hotplug, it looks like we should
> see something from pcie_isr() in the dmesg log.
>
> Since you don't see that, I suspect we're getting ACPI notifications
> via the acpiphp driver.  I'm not as familiar with that, so I don't
> know what if anything it logs.  If you're inclined, you could add some
> printks in
>
>   acpiphp_add_context()
>   acpi_device_hotplug()
>   acpiphp_hotplug_notify()
>   hotplug_event()
>
> Then we'd at least see if we get any ACPI notifications.
>
> Bjorn

I've logged a report with the requested details; it can be found here:

https://bugzilla.kernel.org/show_bug.cgi?id=3D115121



Kind regards,
Jack



--k2WcETCtVujjDCtvn9m6SdflWLVkmS6SF--

--dS6p978QL5GtkaJO3eLAG1o5kNmQN8Ikn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8QHGAAoJEP0XuxcIDSnPh0QQAJoT6WyAO02yXww9EPBqxlCD
qLd8RoRimnQgHKCqbgF0iWWNX1VAt19rA9KdW8OIJ8X40Q7NyjzVvm1p+AVbtqrS
Sq2O4VB02hJewQr/O7IVQ8bafR0VAlYyaSRJ5Sw2pUEygpVXgbVz23WQA3pK/cR8
ERPr821v32xI+ICrnR4jbg1Tn+xCAT1+eyIFh14CHq+r0J2KET8n2qym/0oF0pXn
0dp8vhk/XQ2XeFqUejllHPWuXv6rcuDGb50DJOcafTtagwh41JZ53FLhCndxISMP
/Eh5jVHvKvVxBvWEw3Pf0weBpNTjVm/KQ8CLYcBn+KNfQ+T4TJOh4FX4vFj1CVQl
Nu+8StFZc49fLiKYAtr7TZXfsndOgHJ/C7ax/mSn/RW0ZRyPOUsAcADZulak8ZGq
ZPToJvOok8ac5j+9eL2pjypwi+WNL+wPOW5UvV0okAmu9zzDptMfytkdreF2ufOa
Swyw8QuJvco1/VeDh0k1jTDyO3CKo6ojB/gKt65vxqEkqnbwPZ3SKzxbxZCyRS/p
NzvS6vvTw+X6nKlCNmo7G77sSKQtSAUgn7lV13gTCgaTllL8JM+28EyPsWlBs2gv
pIqfhvmGWqBjK2LFb+pKoIUBEDJDQlJBRo/J+upVXvB8XvWFkJKyc6Q+32HjgLgR
ka0ulclz5cqFlFh/i2WF
=+Mgr
-----END PGP SIGNATURE-----

--dS6p978QL5GtkaJO3eLAG1o5kNmQN8Ikn--
