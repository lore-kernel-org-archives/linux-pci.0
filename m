Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:52642 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab3LEJOA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 04:14:00 -0500
Received: by mail-bk0-f48.google.com with SMTP id v10so7040312bkz.35
        for <linux-pci@vger.kernel.org>; Thu, 05 Dec 2013 01:13:58 -0800 (PST)
Date: Thu, 5 Dec 2013 10:12:58 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jay Agarwal <jagarwal@nvidia.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Subject: Re: [Discussion]: ARM: PCIE: Setup bridges not happening with
 portbus driver enabled
Message-ID: <20131205091257.GA13010@ulmo.nvidia.com>
References: <C79B248886DD134989C8FF6B096A91AB92139701C7@BGMAIL01.nvidia.com>
 <20131205064822.GB2298@pratyush-vbox>
 <C79B248886DD134989C8FF6B096A91AB92139701C9@BGMAIL01.nvidia.com>
 <CAE9FiQUqnSYFnmETkJcSeFh=5S9Qh5XsCuvA1YoXkU4608cXmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
In-Reply-To: <CAE9FiQUqnSYFnmETkJcSeFh=5S9Qh5XsCuvA1YoXkU4608cXmQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2013 at 12:27:40AM -0800, Yinghai Lu wrote:
> On Wed, Dec 4, 2013 at 11:38 PM, Jay Agarwal <jagarwal@nvidia.com> wrote:
> >> On Thu, Dec 05, 2013 at 01:44:53PM +0800, Jay Agarwal wrote:
> >> > I am seeing below issue on an ARM platform with CONFIG_PCIEPORTBUS
> >> > enabled in kernel
> >> >
> >> > ISSUE:  Any memory access by devices fails
> >> >
> >> > FINDINGS:
> >> >
> >> > 1. No bridge windows like below are setup and probably this is not
> >> > allowing any memory access by devices
> >>
> >> Does your RC driver calls pci_assign_unassigned_resources after
> >> pci_common_init?
> >>
> > No it does not. Btw, I tried calling it but it also did not help and sa=
me problem.
>=20
> Please make sure you pci_assign_unassigned_resources get called via
> fs_initcall().

Why does this have to be called as fs_initcall() time? Does it have to
be exactly then or can it be at any later time?

The Tegra PCIe driver is actually a regular driver, and run at the time
of device_initcall(). In fact it may even be probed much later because
it can depend on regulators and such that only become available later
and therefore cause the PCIe driver to defer it's probe.

Thierry

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSoEOZAAoJEN0jrNd/PrOhmCUQAJazDav+tul3VnOtVviw2rQi
MZonciutNGG72AyGF8WPf3++ilt6bzx+aHMOWBypNa1FSX5C8NwGQzohw1f7Uoux
fqKjVri0JCItsuIrBYkZPNI2I+xdkMuGuMvfd3V6fiSRQc35W4eKvsRX7dzbBs+B
ggBgw1QqfZvnXecUg1QHaNYTwKPwPHrocjFxnPSmLGzPDhUb1BGPmw6Iqy7KOokD
y6DeIXs7dbeNtBjQ573opyzpzxlNE6TqRC+3o596OZa5Mvk2kfvJM5Bb5HGl7pN7
U685cZGDoYZIMzATO/CyCMvsaArQ5Ct3iAGCZ2WDCk0WCdn94XRg9y2UwtYhtyCR
pEAYURkSiU8miiMcHqEVMvXp3KIF0gPSz2sbPy7XWWLqN29FTH1QBuDIwa19wTzw
FsRcMa/GEsQriEApYKGXLCwUUvnt5tg+YR+Xu9gmUclOjgFwqKZRHjCC0MrN3CYU
DewDIlnluSabM7c+xHxc6GtvsI8l50ePVBgRB3rUl5nBHJzDjcd4tpgVOEPQoQnY
G6ztvEAiVr6QRHk2AOjP2qi+Td559MA5xJxFtw0WjIiv7xS/Bv6fqR6bSWF8nYgz
0Bz8OXLcmEJ6Dq+6G8qqY8QOPXYpf9cKhZKyMEXJjN65HCdRrcB6ueFaMnf7iKNK
ID7kmchNSdM0zDLXepdD
=JlJ3
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
