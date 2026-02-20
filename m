Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC232E132;
	Fri, 20 Feb 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586398; cv=none; b=ijfHWNEABQhQ///WK19otmdbgbHmNfSWAguYdF6PBMrW7T1JCvWRtXJnrZ+cvVYud4ffsMupIiP4lPO1CEQ4PwtdsHL0RCAROoo4cvrZmDC+7g7hhm/sXwh1ppNYQJFU0/IyTC36wxMSAZ+5pkAo6Fc7JjFjyI0z6FK6HumOajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586398; c=relaxed/simple;
	bh=YdwYL+1IyhDnPHQcLJTAomqNZp88Modu80gL8LdvHk8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QIunMjYVIxxeBNouzc3jK7bdVd5dRVDSiw5SK25oT6/PHwjFZBR6UugNRfcQhceNFkM2GR/owDex+GT4Updsg62RLqko+r3Y+w2iNVlfzuhbv7X3L1fgJE+i5fivXEbKjV1tP/B+upT6He/zKgl6fbkZ51/Kjxj5b+wqzW7bCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxJKl2in; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxJKl2in"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771586398; x=1803122398;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=YdwYL+1IyhDnPHQcLJTAomqNZp88Modu80gL8LdvHk8=;
  b=BxJKl2inKFVtwjjcaUkXZvq8F5FmryPygG1MHMKniN2jWHd8jUQzGA0f
   BlwiLCsp768vByFs+eXDprCjYJbHAw6YkAfP7huzequIlYRtZiV6HHloQ
   GpW0P952f6SgJCqsFVxpxmJP/qJ2gLnCR/H9Gc4r3FmSj2akTV7kP9U2n
   KqCb4nQd4iYUYGi3dbY421hQuNZCzGAAZfnioafmEg9kMJMnaZBueB1l2
   1kRLgTZAOSMgcsOuUgjjNwtiM13owp3XLpzPhf+w81wje0zWKATWUPhoA
   mYmhw3gUzgIofMUwa+IJvyLnbaxFBMlug9FQjArJ1R7BxjnifUQxhNyN4
   w==;
X-CSE-ConnectionGUID: QQ6/B7GyTGKk6e6+6I2mVg==
X-CSE-MsgGUID: UlNYyJIkTjCoHfPXmFhX0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="84039076"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="84039076"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:19:57 -0800
X-CSE-ConnectionGUID: txO0B58QR2yXBy9LluWKWw==
X-CSE-MsgGUID: YWxv2cSdQEea53CFAFZR0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="245403675"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 03:19:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Feb 2026 13:19:51 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    RavitejaX Veesam <ravitejax.veesam@intel.com>
Subject: Re: [PATCH 1/1] PCI: Account fully optional bridge windows
 correctly
In-Reply-To: <20260219213238.GA3498861@bhelgaas>
Message-ID: <0b09757e-c88c-4838-f063-1219c22bc4f9@linux.intel.com>
References: <20260219213238.GA3498861@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-902767794-1771585950=:974"
Content-ID: <c63633d1-40a8-4f08-3598-4025fb523ebd@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-902767794-1771585950=:974
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7d02b6f0-1269-99b4-c57b-fa5e16ba78dd@linux.intel.com>

On Thu, 19 Feb 2026, Bjorn Helgaas wrote:

> On Thu, Feb 19, 2026 at 12:34:18AM +0200, Ilpo J=E4rvinen wrote:
> > pbus_size_mem_optional() adds dev_res->add_size of a bridge window into
> > children_add_size when the window has a non-optional part. However, if
> > the bridge window is fully optional, only r_size is added (which is
> > zero for such a window).
>=20
> I guess this means we might not make a bridge window big enough for
> optional resources, even if space is available?

Yes, the size calculations are off for the upstream windows.

> > Also, a second dev_res entry will be added by pci_dev_res_add_to_list()
> > into realloc_head for the bridge window (resulting in triggering the
> > realloc_head-must-be-fully-consumed sanity check after a single pass of
> > the resource assignment algorithm):
> >=20
> >   WARNING: drivers/pci/setup-bus.c:2153 at pci_assign_unassigned_root_b=
us_resources+0xa5/0x260
> >=20
> > Correct these problems by always adding dev_res->add_size for bridge
> > windows and not calling pci_dev_res_add_to_list() if the dev_res entry
> > exists.
> >=20
> > Fixes: 6a5e64c75e82 ("PCI: Add pbus_mem_size_optional() to handle optio=
nal sizes")
>=20
> We merged 6a5e64c75e82 for v7.0, so it looks like this fix is also
> v7.0 material, right?

Preferrably yes.

> > Reported-by: RavitejaX Veesam <ravitejax.veesam@intel.com>
>=20
> Is there a public report of this?  I didn't see anything on lore that
> looked relevant.

I got an internal report a CI failure from gfx people. I couldn't=20
immediately find anything from gitlab.freedesktop.org (not a guarantee=20
there wouldn't be anything there).

--=20
 i.

> > Tested-by: RavitejaX Veesam <ravitejax.veesam@intel.com>
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/setup-bus.c | 29 ++++++++++++++++-------------
> >  1 file changed, 16 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 32aa72456a44..0c8cbbfaf8d7 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1217,31 +1217,34 @@ static bool pbus_size_mem_optional(struct pci_d=
ev *dev, int resno,
> >  =09struct resource *res =3D pci_resource_n(dev, resno);
> >  =09bool optional =3D pci_resource_is_optional(dev, resno);
> >  =09resource_size_t r_size =3D resource_size(res);
> > -=09struct pci_dev_resource *dev_res;
> > +=09struct pci_dev_resource *dev_res =3D NULL;
> > =20
> >  =09if (!realloc_head)
> >  =09=09return false;
> > =20
> > -=09if (!optional) {
> > -=09=09/*
> > -=09=09 * Only bridges have optional sizes in realloc_head at this
> > -=09=09 * point. As res_to_dev_res() walks the entire realloc_head
> > -=09=09 * list, skip calling it when known unnecessary.
> > -=09=09 */
> > -=09=09if (!pci_resource_is_bridge_win(resno))
> > -=09=09=09return false;
> > -
> > +=09/*
> > +=09 * Only bridges have optional sizes in realloc_head at this
> > +=09 * point. As res_to_dev_res() walks the entire realloc_head
> > +=09 * list, skip calling it when known unnecessary.
> > +=09 */
> > +=09if (pci_resource_is_bridge_win(resno)) {
> >  =09=09dev_res =3D res_to_dev_res(realloc_head, res);
> >  =09=09if (dev_res) {
> >  =09=09=09*children_add_size +=3D dev_res->add_size;
> >  =09=09=09*add_align =3D max(*add_align, dev_res->min_align);
> >  =09=09}
> > +=09}
> > =20
> > +=09if (!optional)
> >  =09=09return false;
> > -=09}
> > =20
> > -=09/* Put SRIOV requested res to the optional list */
> > -=09pci_dev_res_add_to_list(realloc_head, dev, res, 0, align);
> > +=09/*
> > +=09 * Put requested res to the optional list if not there yet (SRIOV,
> > +=09 * disabled ROM). Bridge windows with an optional part are already
> > +=09 * on the list.
> > +=09 */
> > +=09if (!dev_res)
> > +=09=09pci_dev_res_add_to_list(realloc_head, dev, res, 0, align);
> >  =09*children_add_size +=3D r_size;
> >  =09*add_align =3D max(align, *add_align);
> > =20
> >=20
> > base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
> > --=20
> > 2.39.5
> >=20
>=20
--8323328-902767794-1771585950=:974--
