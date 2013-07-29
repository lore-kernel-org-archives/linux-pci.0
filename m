Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14158 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830Ab3G2Vw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Jul 2013 17:52:56 -0400
Message-ID: <1375134764.2104.1.camel@jtkirshe-mobl>
Subject: Re: [PATCH v2 3/3] PCI: Stop sriov after stop PF if PF's driver
 skip that
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To: Don Dutile <ddutile@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Greg Rose <gregory.v.rose@intel.com>
Date: Mon, 29 Jul 2013 14:52:44 -0700
In-Reply-To: <51F6DF35.40909@redhat.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
	 <1374937868-24437-2-git-send-email-yinghai@kernel.org>
	 <CAErSpo7xk-NGp+4ZFo-jnVnQSEomY=7=CXDSbZPzrhdjZ4zVSA@mail.gmail.com>
	 <51F6D161.1040106@redhat.com> <51F6D9A2.8020403@intel.com>
	 <51F6DF35.40909@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jaZkccha/MyR74flpKLM"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-jaZkccha/MyR74flpKLM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2013-07-29 at 17:31 -0400, Don Dutile wrote:
> On 07/29/2013 05:07 PM, Alexander Duyck wrote:
> > On 07/29/2013 01:32 PM, Don Dutile wrote:
> >> On 07/29/2013 03:58 PM, Bjorn Helgaas wrote:
> >>> On Sat, Jul 27, 2013 at 9:11 AM, Yinghai Lu<yinghai@kernel.org>   wro=
te:
> >>>> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
> >>>> (PCI: Simplify IOV implementation and fix reference count races)
> >>>> VF need to be removed via virtfn_remove to make sure ref to PF
> >>>> is put back.
> >>>>
> >>>> Some driver (like ixgbe) does not call pci_disable_sriov() if
> >>>> sriov is enabled via /sys/.../sriov_numvfs setting.
> >>>> ixgbe does allow driver for PF get detached, but still have VFs
> >>>> around.
> >>>
> >>> Is this something ixgbe should be doing differently?
> >>>
> >>> I'm not 100% sold on the idea of the VFs staying active after the
> >>> driver releases the PF.  It seems asymmetric because I think the
> >>> driver has to claim the PF to *enable* the VFs, but we don't disable
> >>> them when releasing the PF.
> >>>
> >>> What's the use case for detaching the PF driver while the VFs are
> >>> active?
> >>>
> >> VF's assigned to (KVM) guest (via device-assignment).
> >> Virtually, it's as if the enet cable is unplugged to the VF in the
> >> guest --
> >> the device is still there (the PF wasn't unplugged, just the driver
> >> de-configured).
> >>
> >> Pre-sysfs-based configuration, the std way to configure the VFs into
> >> a system was to unload the PF driver, and reload it with a vf-enabling
> >> parameter
> >> (like max_vfs=3D<n>  in the case of ixgbe, igb).
> >> Now, if someone unloaded the PF driver in the host, the unplanned remo=
val
> >> of the PF enabled the VF to crash the host (maybe AlexD can provide th=
e
> >> details how that occurred).
> >> So, the solution was to 'pause' the VF operation and let packets drop
> >> in the guest, and re-enable the VF operation if the PF driver was
> >> re-configured.
> >>
> >> So, as I stated in previous postings, this patch is acceptable if
> >> it doesn't cause a guest crash when a VF is assigned to a KVM guest.
> >> If you tested this case, then please state as such in the posting.
> >> If not, then can AlexD test this case ?
> >>
> >> - Don
> >
> > I actually haven't done much with direct assignment to guests.  I
> > believe it was Greg who did that work to fix this issue.
> >
> > I'm adding Jeff Kirsher to the CC.  Perhaps he can pull this patch into
> > a copy of the net tree and submit it to our validation team for testing
> > to see if they end up being able to reproduce the kernel panic issue
> > that was originally addressed by allowing the VFs to be persistent.
> >
> I'd appreciate hearing Jeff's test results....

Can I apply this patch as a standalone? or will I need the entire 3
patch series?

>=20
> > Thanks,
> >
> > Alex
> >
> >>>> But how about PF get removed via /sys or pciehp finally?
> >>>>
> >>>> During hot-remove, VF will still hold one ref to PF and it
> >>>> prevent PF to be removed.
> >>>> That make the next hot-add fails, as old PF dev struct is still arou=
nd.
> >>>>
> >>>> We need to add pci_disable_sriov() calling during stop PF .
> >>>>
> >>>> Need this one for v3.11
> >>>
> >>> Don had a concern that there might be a regression here ... I'm a bit
> >>> confused on the details, but you guys need to come to agreement that
> >>> this doesn't make things worse.
> >>>
> >>>> Signed-off-by: Yinghai Lu<yinghai@kernel.org>
> >>>> Cc: Jiang Liu<liuj97@gmail.com>
> >>>> Cc: Alexander Duyck<alexander.h.duyck@intel.com>
> >>>> Cc: Donald Dutile<ddutile@redhat.com>
> >>>> Cc: Greg Rose<gregory.v.rose@intel.com>
> >>>>
> >>>> ---
> >>>>    drivers/pci/remove.c |    2 ++
> >>>>    1 file changed, 2 insertions(+)
> >>>>
> >>>> Index: linux-2.6/drivers/pci/remove.c
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> --- linux-2.6.orig/drivers/pci/remove.c
> >>>> +++ linux-2.6/drivers/pci/remove.c
> >>>> @@ -25,6 +25,8 @@ static void pci_stop_dev(struct pci_dev
> >>>>                   pci_proc_detach_device(dev);
> >>>>                   pci_remove_sysfs_dev_files(dev);
> >>>>                   device_del(&dev->dev);
> >>>> +               /* remove VF, if PF driver skip that */
> >>>> +               pci_disable_sriov(dev);
> >>>>                   dev->is_added =3D 0;
> >>>>           }
> >>>>
> >>
> >
>=20



--=-jaZkccha/MyR74flpKLM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAABCgAGBQJR9uQsAAoJEOVv75VaS+3ODXkP/1+HNhkFWujijUVsXeWktLPy
Z4j60goC71z8SbAV9QTMr0naPtnda2mGvJVIHUaetLX2b28S7mrou8+lTYeNpheh
AP2eAw5jNakEC4Km7HONluh2cZEry32j/FA+o+FhuhadS/4M/5f5Heubaf+3I9/8
QSFgrGBIYG78/3b8DlBGxe0tOOMA57Sr4c8bvh2O6ZtAlqSO/4/z+vngBAwdk9Wx
RjAYUQmnNnNbk04B9Su/MlrGxhKDeMPFKKC9Zgn9yP71nhlEaZyYU1PIcSFwzW87
8vyllDav50b0VfUrNmR0XFqAylWona4IngdX5n4jdNfLNnEvESoQuIbWJdiwAs6s
AW1UK82Smrurd7pFsWhR6kfjpqz77uAOhTojsXYJIehPLTY1dP80ZyaHeGb79Xej
5R0m0rlz1s+0NQ3sGTWaqaysS5nCVLZ/fuDpLFkZhAoxG+7VmBshmhKUkp1/oiRH
e4nbjKPyz28eePVm0VVhMkMT4V4SNO8RFmqNb+NQ6qH33lNRqnHMLBtMgozW4Lhe
rk/rgPm/G75Ou39/K55s92+TEIuc4QXuGTVPQbLP4+C55NUlQRz9mQz3iB4aUEfC
fchruV9fhZpMMvOYdDjfIRiuofc9FCXy9tITGBmdBjm8zFFE0NG4x+XHLIZt1VQT
k3DbVEECzUwaB2CLZSWs
=DLv6
-----END PGP SIGNATURE-----

--=-jaZkccha/MyR74flpKLM--

