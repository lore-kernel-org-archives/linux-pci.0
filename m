Return-Path: <SRS0=U8Bn=5W=imgtec.com=Paul.Burton@kernel.org>
Return-Path: <SRS0=U8Bn=5W=imgtec.com=Paul.Burton@kernel.org>
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Michal
 Simek" <michal.simek@xilinx.com>, Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v4 0/4] PCI: xilinx: Fixes, optimisation & MIPS support
Date: Sat, 17 Jun 2017 13:01:11 -0700
Message-ID: <136169243.oaJPRDUV91@np-p-burton>
In-Reply-To: <20170615213505.GG12735@bhelgaas-glaptop.roam.corp.google.com>
References: <20170602185420.22281-1-paul.burton@imgtec.com> <20170615213505.GG12735@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1537183.C4uXkd0vjk";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-pci.vger.kernel.org>

--nextPart1537183.C4uXkd0vjk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 15 June 2017 14:35:05 PDT Bjorn Helgaas wrote:
> On Fri, Jun 02, 2017 at 11:54:15AM -0700, Paul Burton wrote:
> > This series fixes an issue found using INTx interrupts with the Xilinx
> > AXI PCIe Host Bridge IP on the Imagination Technologies MIPS Boston
> > development board, performs a couple of optimisations to interrupt
> > handling & allows the driver to be used on MIPS systems.
> > 
> > Applies atop v4.12-rc3.
> > 
> > Paul Burton (4):
> >   PCI: xilinx: Fix INTX irq dispatch
> >   PCI: xilinx: Unify INTx & MSI interrupt decode
> >   PCI: xilinx: Don't enable config completion interrupts
> >   PCI: xilinx: Allow build on MIPS platforms
> >  
> >  drivers/pci/host/Kconfig       |  2 +-
> >  drivers/pci/host/pcie-xilinx.c | 57
> >  +++++++++++++++--------------------------- 2 files changed, 21
> >  insertions(+), 38 deletions(-)
> 
> Hi Paul, et al.,
> 
> Waiting for resolution on patch 1 and ack from maintainers.

Thanks Bjorn, hopefully v5 will pass muster.

Paul
--nextPart1537183.C4uXkd0vjk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAllFiocACgkQgiDZ+mk8
HGUHtg//Tdc49pwCMNDk2LsHtly4xktqbL5KCW6TwRv4ypW/BrIhM//x2Jv9cPyb
ULEWLD7wKMv0y64awoWmeiUf38L7Nk6XmOd01Vtx9rRAxOmMb71+JZKYvRiwbk9z
z1a2WyRKMFJ13ASRFz1x2tZy83LsEWQbkP+KXZaORp9Yq9xbS7skFVfFFT3io+4W
VGtpkTj85zYW6VcMIM0wl7mloCqbXudYJ0moJozGaWa/mWcp1FpNLYaaoKZnDoM2
/horp56BepjSEz03jEntqLV58fDzpKSiLDID71RTIcYHKPApauuW+pW/Si9ZtwQa
v4af5QFvwFuuZciKFxWgSr1KIUybNH2NwFDKw8L5yofpGYgnHAQDM0SfQCQPOoOi
+tpLsB1wkdWwVRvPgyciPfxvyeYt3BUGh7H8MIYtfbNP0D0AjE1+X5ZehxJG5oqQ
R8dQvQA/aTYcPBRBwP1lzGzkEGr1io/gE682NDs3HYPp/P6wbtI5ebimONsYhvUQ
0qGl7Chf9037FnX3DNoExm2kyBWJ3zDv0Ckf2WdTgxUtOR8AjTN5VxYOmsTSoEyx
Ec+SXERnDMXzoWX8jb8xGswBRDMr9q2AsaLpQjH9BdQ4QmsfJ1hVmGv8bVntvkRb
taVKGVdtwDRaAi/yE6lRR1deC/V4VquBTQVcMdbOVNbcS0QvNBA=
=rmCy
-----END PGP SIGNATURE-----

--nextPart1537183.C4uXkd0vjk--
