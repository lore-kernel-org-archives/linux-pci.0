Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39868 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdKVKbt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 05:31:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id x63so9068738wmf.4
        for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2017 02:31:48 -0800 (PST)
Date: Wed, 22 Nov 2017 11:31:46 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Karol Herbst <kherbst@redhat.com>
Cc: nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [Nouveau] [PATCH v2] drm: don't continue with anything after the
 GPU couldn't be woken up
Message-ID: <20171122103146.GA30667@ulmo>
References: <20171121150116.24956-1-kherbst@redhat.com>
 <20171121174609.GA28301@ulmo>
 <CACO55tv6J+eY_KNvQxdKShaLi2Td7dDpQa-ety4tgFqvsij34Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <CACO55tv6J+eY_KNvQxdKShaLi2Td7dDpQa-ety4tgFqvsij34Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2017 at 08:03:20PM +0100, Karol Herbst wrote:
> On Tue, Nov 21, 2017 at 6:46 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, Nov 21, 2017 at 04:01:16PM +0100, Karol Herbst wrote:
> >> This should make systems more stable where resuming the GPU fails. This
> >> can happen due to bad firmware or due to a bug within the kernel. The
> >> last thing which should happen in either case is an unusable system.
> >>
> >> v2: do the same in nouveau_pmops_resume
> >>
> >> Tested-by: Karl Hastings <kazen@redhat.com>
> >> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> >> ---
> >>  drm/nouveau/nouveau_drm.c | 31 +++++++++++++++++++++++--------
> >>  1 file changed, 23 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drm/nouveau/nouveau_drm.c b/drm/nouveau/nouveau_drm.c
> >> index 8d4a5be3..6e4cb4f7 100644
> >> --- a/drm/nouveau/nouveau_drm.c
> >> +++ b/drm/nouveau/nouveau_drm.c
> >> @@ -792,6 +792,27 @@ nouveau_pmops_suspend(struct device *dev)
> >>       return 0;
> >>  }
> >>
> >> +static int
> >> +nouveau_set_power_state_D0(struct pci_dev *pdev)
> >> +{
> >> +     struct nouveau_drm *drm =3D nouveau_drm(pci_get_drvdata(pdev));
> >> +     int ret;
> >> +
> >> +     pci_set_power_state(pdev, PCI_D0);
> >> +     /* abort if anything went wrong */
> >> +     if (pdev->current_state !=3D PCI_D0) {
> >> +             NV_ERROR(drm, "couldn't wake up GPU!\n");
> >> +             return -EBUSY;
> >> +     }
> >
> > Looks to me like the more idiomatic way to do this is:
> >
> >         ret =3D pci_set_power_state(pdev, PCI_D0);
> >         if (ret < 0 && ret !=3D -EIO)
> >                 return ret;
> >
>=20
> I thought so too, but it ends up returning 0 even if setting the power
> state fails. Or maybe I did something wrong when installing the
> kernel. I could take another shot at it, but what I came up with seems
> to work. Adding airlied in CC, because he saw my patch and didn't
> complain about it. Hopefully he knows more.

pci_raw_set_power_state(), called by pci_set_power_state(), contains
this, which looks to me like it would be the only case where the problem
you're describing could be coming from:

	dev->current_state =3D (pmcsr & PCI_PM_CTRL_STATE_MASK);
	if (dev->current_state !=3D state && printk_ratelimit())
		dev_info(&dev->dev, "Refused to change power state, currently in D%d\n",
			 dev->current_state);

Do you happen to see this in the kernel logs? Perhaps this should be
considered an error rather than just an KERN_INFO level message?

Adding Bjorn and linux-pci for visibility.

Thierry

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloVUg4ACgkQ3SOs138+
s6HlKg/+P9wAU5R0wbRzMUyKp/BmAhLy6clFutf9ouz83ptvf9h83DbeAsUVWJx4
8w5/o3XJXYc18hCb9w2VgVnRUNpKtIrVDV1JVs5rzeSV4ruGZoFsfKxBEbS1BXzY
6VH1zSogkreqeSfMysfIjyp6r9JsQd9ecS5jk2g/Lf98RRyofSt0QTrqhKIKd7cH
a2m6kUBq9Mdhd+nGfAxO8DVBqGUPJufNscJAlp43o5S8Z9vXYUVn2Kx93KfpiQno
TlHBDQxFX06fEviH1Eu76EQjF9vdF5Lod1l0S7P9MgRDRIGPpCIqi3I9Aoi7f1oD
0EyGqQ1nP8DnnsHnsaQUBGplfEztxoRCRBMOHkfi+x5af4MdPR0DuElfrRuebBMv
rpAF2egXa2mbw/PspoVFnKOLXJotmYXFXttpqpVTM0oLXZZ6d2MyTEUEGwcyZT4h
S0YBKdb5YVt7RQBC6+Wio2AakvXSCx0CpTv8aDdUYt6b8rgWrYsm4/Oc/TQreXUX
z72JTYA1uVbqPZuPiUdoJBVCxHFLUV/PVbFOjnfoyaXJr6S0DwKVw36Ac19+BddI
IwjID7lw+zAn/ZRL4AlzygmNiwEIPtHGR18h5iRumw5/AVnPOBjI1trnxZxJqrjK
7cUsT8H7D6THnX8RtCPQRBLpRJWkO8TIPnBfEWyxHlN5ey9m7Sg=
=v1wf
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
