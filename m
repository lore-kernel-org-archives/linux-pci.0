Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:59091 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755419Ab1LMSxb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2011 13:53:31 -0500
Date: Tue, 13 Dec 2011 10:53:27 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ajaykumar Hotchandani <ajaykumar.hotchandani@oracle.com>,
	linux-pci@vger.kernel.org
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
	Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] PCI: Set device power state to PCI_D0 for device
 without native PM support
Message-ID: <20111213105327.55c6e098@jbarnes-desktop>
In-Reply-To: <4EE5BAF8.4000303@oracle.com>
References: <4EE5BAF8.4000303@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/z13y.u08.XAxORlxHwn05Lh"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/z13y.u08.XAxORlxHwn05Lh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Ok I applied this to for-linus, but git am didn't like it so I had to
merge it by hand.  Please check it out and make sure it still works for
you.

Thanks,
jesse

On Mon, 12 Dec 2011 13:57:36 +0530
Ajaykumar Hotchandani <ajaykumar.hotchandani@oracle.com> wrote:

> Hi Jesse,
>=20
> Have following query, please point me to correct person if I am asking=20
> this to wrong person:
> Any particular reason, why this is not checked in yet? Is something=20
> missing here?
>=20
> Thanks,
> Ajay
>=20
> -------- Original Message --------
> Subject: 	Re: [PATCH] PCI: Set device power state to PCI_D0 for device=20
> without native PM support
> Date: 	Fri, 28 Oct 2011 17:36:43 +0530
> From: 	Ajaykumar Hotchandani <ajaykumar.hotchandani@oracle.com>
> To: 	Jesse Barnes <jbarnes@virtuousgeek.org>,=20
> "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,=20
> "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> CC: 	Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Yinghai Lu=20
> <yhlu.kernel@gmail.com>
>=20
>=20
>=20
> On 10/27/2011 08:31 PM, Stefano Stabellini wrote:
> >  On Thu, 27 Oct 2011, Ajaykumar Hotchandani wrote:
> >>>  BTW I am OK with your patch.
> >>  Should we revert 47e9037ac16637cd7f12b8790ea7ce6680e42168 (your chang=
es
> >>  in register_slot() )
> >>  I think, after this change, it's not needed. Or, am I missing some sc=
enario?
> >>
> >  I think you are right, 47e9037ac16637cd7f12b8790ea7ce6680e42168 is not
> >  needed anymore, so I am OK with reverting it.
>=20
> Thanks, following is updated patch.
>=20
> [PATCH -v2] PCI: Set device power state to PCI_D0 for device without
> native PM support
>=20
> During test of one IB card with guest VM, found that, msi is not
> initialized properly.
>=20
> It turns out __write_msi_msg will do nothing if device current_state is
> not PCI_D0.
> And, that pci device does not have pm_cap in guest VM.
>=20
> There is an error in setting of power state to PCI_D0 in
> pci_enable_device(), but error is not returned for this.
> Following is code flow:
> pci_enable_device() -->   __pci_enable_device_flags() -->
> do_pci_enable_device() -->   pci_set_power_state() -->
> __pci_start_power_transition()
> We have following condition inside __pci_start_power_transition():
>          if (platform_pci_power_manageable(dev)) {
>                  error =3D platform_pci_set_power_state(dev, state);
>                  if (!error)
>                          pci_update_current_state(dev, state);
>          } else {
>                  error =3D -ENODEV;
>                  /* Fall back to PCI_D0 if native PM is not supported */
>                  if (!dev->pm_cap)
>                          dev->current_state =3D PCI_D0;
>          }
>=20
> Here, from platform_pci_set_power_state(), acpi_pci_set_power_state() is
> getting called and that is failing with ENODEV because of following
> condition:
>          if (!handle || ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0",&tmp)=
))
>                  return -ENODEV;
>=20
> Because of that, pci_update_current_state() is not getting called.
>=20
> With this patch, if device power state can not be set via
> platform_pci_set_power_state and that device does not have native pm
> support, then PCI device power state will be set to PCI_D0.
>=20
> -v2: This also reverts 47e9037ac16637cd7f12b8790ea7ce6680e42168, as it's
> not needed after this change.
>=20
> Signed-off-by: Ajaykumar Hotchandani<ajaykumar.hotchandani@oracle.com>
> Signed-off-by: Yinghai Lu<yinghai.lu@oracle.com>
> ---
>   drivers/pci/hotplug/acpiphp_glue.c |    1 -
>   drivers/pci/pci.c                  |    3 +++
>   2 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c
> b/drivers/pci/hotplug/acpiphp_glue.c
> index 2202857..11431c1 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -212,7 +212,6 @@ register_slot(acpi_handle handle, u32 lvl, void
> *context, void **rv)
>=20
>          pdev =3D pci_get_slot(pbus, PCI_DEVFN(device, function));
>          if (pdev) {
> -               pdev->current_state =3D PCI_D0;
>                  slot->flags |=3D (SLOT_ENABLED | SLOT_POWEREDON);
>                  pci_dev_put(pdev);
>          }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9651f0..6866937 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -664,6 +664,9 @@ static int pci_platform_power_transition(struct
> pci_dev *dev, pci_power_t state)
>                  error =3D platform_pci_set_power_state(dev, state);
>                  if (!error)
>                          pci_update_current_state(dev, state);
> +               /* Fall back to PCI_D0 if native PM is not supported */
> +               if (!dev->pm_cap)
> +                       dev->current_state =3D PCI_D0;
>          } else {
>                  error =3D -ENODEV;
>                  /* Fall back to PCI_D0 if native PM is not supported */


--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/z13y.u08.XAxORlxHwn05Lh
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO558nAAoJEIEoDkX4Qk9hh60P/0xaC5az67Voj0aOUsdlAHgf
bs7Tn//qFiTlBJBOxkM3Fx+BZhr69YG1xVUMQhXxLqxY21qNrhNWWAXuf/vqWobS
apQxnXV9Jdt4hH6/Erl3U+ticbAKmkTCsrcsQBu0+XOQTGh8gEITa9CeSaDx1Qd4
aUM5AtmoPMCJd1PqSIsoF3VECw715+LiE2VOpxy/Q0+IawGxo8Hv7H6kWzihNtw6
G6xRhw8HTMsKYBXU3IvnGED9H/qUQfqxtEw57FSrGwefhn9jhYQUqU+TI9UM/bmI
hnFiXrcaBMHss2PKWKW4rYXhgBB5RazltGLvtbQ96mXqbBxMWgUOpLdr5mhUULvG
/Ligtze792BE9BHU3mTMTxvzrmr0z1haQdGyOTVSO8mpwGsiyIhjPzuerH4OU15u
d9h+IlE5BM/BNdtwX7gIr7Bz94MLifPtaN4G0SKw+IVLj3PQ2hHGYQc+OWSR+/Ix
9baWIHr+N0oRrrTYDuAjvWdF3PzmO0biqecsXoQFtZ2Myvo9B1vgOX2Q4Z1qruuX
yKBcGlg8QjCr3r+aelVtL4+5N0STPPm2m3iE8heHbZEA0ODyjn9F/ClQ+Rsg1XCH
8F7xnkjfcMr4v52MxelIU+VMS3tDKIGpEg+CMTOfI7luaMrTZTEpNFwdz1cx2DT+
FEgBwhR8UMz9j+QW/nOy
=8u0i
-----END PGP SIGNATURE-----

--Sig_/z13y.u08.XAxORlxHwn05Lh--
