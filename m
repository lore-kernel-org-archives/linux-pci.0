Return-Path: <SRS0=Od/I=KX=linux.intel.com=felipe.balbi@kernel.org>
Return-Path: <SRS0=Od/I=KX=linux.intel.com=felipe.balbi@kernel.org>
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, stable@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: Fix bit definitions for LNKCAP2 register
In-Reply-To: <CAErSpo595gmyeWNtY4Ur6VQoxS82bx8JQ-PoSv0oUdn-j7pJCA@mail.gmail.com>
References: <20180803065120.29322-1-felipe.balbi@linux.intel.com> <20180806182327.GA30691@bhelgaas-glaptop.roam.corp.google.com> <87lg9ia8q6.fsf@linux.intel.com> <CAErSpo595gmyeWNtY4Ur6VQoxS82bx8JQ-PoSv0oUdn-j7pJCA@mail.gmail.com>
Date: Wed, 08 Aug 2018 09:30:56 +0300
Message-ID: <87va8l8j4v.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Bjorn Helgaas <bhelgaas@google.com> writes:
>> Bjorn Helgaas <helgaas@kernel.org> writes:
>> > On Fri, Aug 03, 2018 at 09:51:20AM +0300, Felipe Balbi wrote:
>> >> Even thhough commit b891b4dc1eed claimed that original bit definitions
>> >> were wrong, that's not really the case. After verifying PCI
>> >> Specification Revisions 3.0, 3.1 and 4.0, Link Capabilites 2
>> >> Register's bit definitions were always starting from Bit 0.
>> >>
>> >> This has been causing issues reporting correct link speeds on sysfs.
>> >
>> > Can you elaborate on this a bit?  b891b4dc1eed still looks correct to
>> > me.  I'm looking at PCIe r4.0, sec 7.5.3.18, where it shows:
>> >
>> >   bit    0  RsvdP
>> >   bits 7:1  Supported Link Speeds Vector
>>
>> I had missed this detail, actually. It was a misinterpretation of the
>> spec. Sorry for the noise.
>
> No problem.  You were seeing something incorrect in sysfs, so if we
> can help diagnose or fix whatever the real problem is, don't hesitate
> to ask!

Sure thing, but I think this is a problem elsewhere :)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltqjiIACgkQzL64meEa
mQYZQRAAgHifmyahzYrbCaZXS79zbYJX8uLdHExj7K/zq2+R07S1w8tNOL1oHY0E
CCgfvTcywxkcz62o49j2g5hV0tjcrr82d/ce29KhA+JxBPmvl+4qAVcMp7+KgU0/
78s2d8bMUyNJjQ5KoF2SC+vHN2b4juuXHQZyPFA8rn0QuZ7m+CrtjCpTKGwqC+vh
LOftPEn48dYuxyWMMrIolyxwYxwuTaxyWLi2buOI5+C1yH6zFJE+yPMWr2zwM95S
Cq/SEMXaJlc+lThD3B8Sx002ivOQVbk3lXdN4LZLsw/XvgfuH5Qppjg68jSNbv+p
Vl5QvoU7ofIRpD7TiylcbPSgIqnT865GaEOIxlhrhplacyI5Gu0Ez6B3bCrI+yFx
X20ndIZmQOcnKfTAYitn8WR5XwadH+pqko9URBQbdRmlPM5Vu4iLEZs8c9lqLpa7
Qp+P2WvPnNg+XBx0vqiEkSIzH6zR8+T4C/+XxrhvPi3e3CWiyJML2pL00nB/YbKa
h24w2KieWppmBVSmm5sEoYIzgopj2V6O67EnF/IeYb2OAJ/T/I28Ck8MSQ259rv8
69mjUu0pe/BoXyqc5Mm/yOHmvAq8XfXeO8GVJuYYEqiscRni1QHbzL9fK6g7RQa7
CmSrJse33RVU1NNFPUAIdP0n739OAGh7eUKLEkYKCLzBFiIo2B0=
=5Eq8
-----END PGP SIGNATURE-----
--=-=-=--
