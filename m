Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA33822AB;
	Fri, 18 Sep 2026 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763108; cv=none; b=nx0QNJ6+psv/GF91DLkTKPe591DaJS7+g5OPiRiGMf53HsnZ6KEc/31noVnOvR2kSDGbjqH+l7hVgz7CPS7iCuFjUbtn4XlZ6C5CMAUAnLdR3skkO+KMlZ88UPZNyRRRvNQsPFF27RfP2dNipRQKfd2vFD0pUQ4tnFt8nFei2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763108; c=relaxed/simple;
	bh=3JTMDa8xyqYzHvd0uT6xgVZ1Kf288bpBCb7loSUco9A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUNBouDsY2MDEqFy7dDr/SV1nSu05Vij+3klhZ4WHfXaEJk1ouJ5l3k3qBpXv2nIJNmBA0IDwnWCOBBNcpk1r/np1CU3slWVObcLf+YAkI6SVSYJl4eLKgKrnnQRrDoYBUYVHpThKKkzNbLT2oAODKrMZ2lujzjDuPEnQZmVjdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev; spf=pass smtp.mailfrom=httpd.dev; dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b=kLJGm/TP; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=httpd.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b="kLJGm/TP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=httpd.dev;
	s=protonmail3; t=1789763086; x=1790022286;
	bh=GEhcer4IUxntB2/PFfYkr4/cIYibKg0BnJl+Ie/zHbc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kLJGm/TPPMxRtsCqNjHRxEKvo6pfKlxGzSbPDe4I/aFiyqClIYPKixTjA4hAAcNz6
	 j+jNNB6wYKqZg1MQqQCvFsMvew8PfyAoFethOOz5OS4Wo30lYuDgNvqI/xndYzJ3Cz
	 H4T8G0qDm1iHOQ2UnJ7IshX9Sr4zDoVmRwHIFY3//ARm2/zBHyoqDEfSIvNX+3rMk4
	 BG0KLtFChLBlKTT6GKsYQ9DSvX9CUU6708OZRzK3TPirZNEp7o5g9WvNrkqWQVl5qI
	 apeThmhFdQJAzZKEyZdV77X6Uu63FdwkfFmZN4O6HyoQm3nwB34sD28/kkWglbooAj
	 rOlDFSOjM/uug==
Date: Fri, 18 Sep 2026 20:24:42 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
From: Angel J <iamanaws@httpd.dev>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org, herve.codina@bootlin.com, lizhi.hou@amd.com, andrea.porta@suse.com, florian.fainelli@broadcom.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v3] PCI: of_property: Omit bus properties without a subordinate bus
Message-ID: <vN9WO7kgAS9tXtyymIFn6Qxh8OzMCszLbZWEpONCFgXJgH8-TtGwjro4aXU3whbNqf0-FJwbxNBqYQc2Mbl-cWo80W-xZ8ff3QtmwZtpTQY=@httpd.dev>
In-Reply-To: <20260918202045.GA1191948@bhelgaas>
References: <20260918202045.GA1191948@bhelgaas>
Feedback-ID: 163474212:user:proton
X-Pm-Message-ID: 765e916740c698db3593238809d513bbce91b82f
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------87ebcbdce18e85b570166437990a4e3bac7a7705cfd5fe023eb4c7e1928c393f"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------87ebcbdce18e85b570166437990a4e3bac7a7705cfd5fe023eb4c7e1928c393f
Content-Type: multipart/mixed;boundary=---------------------a2c1a435c064bdab948fbb9ccdb71701

-----------------------a2c1a435c064bdab948fbb9ccdb71701
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

I didn't reply cuz I'm out for 3 weeks without access to that machine, so =
I can't test or confirm it works as expected (even though probably does)

Still, I will try to confirm as soon as I can.

Thanks

On Friday, September 18th, 2026 at 13:20, Bjorn Helgaas <helgaas@kernel.or=
g> wrote:

> On Fri, Sep 18, 2026 at 02:55:40PM -0500, Bjorn Helgaas wrote:
> > Author: Angel J <iamanaws@httpd.dev>
> >
> > PCI: of_property: Omit bus properties without a subordinate bus
> >
> > A bridge (a device with a Type 1 header) may not have a secondary bus
> > allocated (pdev->subordinate), e.g., if there are no available bus num=
bers
> > or the bridge secondary/subordinate bus numbers are not writable.
> >
> > The dynamic OF helpers of_pci_prop_bus_range() and of_pci_prop_intr_ma=
p()
> > dereference pdev->subordinate without checking it.  When
> > CONFIG_PCI_DYNAMIC_OF_NODES is enabled, this can cause a NULL pointer
> > dereference and early boot hang.
> >
> > Generate 'bus-range' and 'interrupt-map' properties only when a subord=
inate
> > bus exists.  Keep the node and its remaining properties for bridges wi=
thout
> > one.
> >
> > The problem was latent since 407d1a51921e ("PCI: Create device tree no=
de
> > for bridge"), but wasn't reachable until 1f340724419e ("PCI: of: Creat=
e
> > device tree PCI host bridge node"), which appeared in v6.15.  Before
> > 1f340724419e, of_pci_make_dev_node() returned early because the parent=
 OF
> > node was missing.
> >
> > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > Signed-off-by: Angel J <iamanaws@httpd.dev>
> > [bhelgaas: move pdev->subordinate test to callees, commit log]
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: stable@vger.kernel.org	# v6.6+
> > Link: https://patch.msgid.link/20260912043106.10715-1-iamanaws@httpd.d=
ev
> =


> I put this on pci/for-linus, planning to be in v7.3, but I would love
> to have testing reports to make sure it still works as the v2 does.
> =


> > ---
> > Changes in v3:
> > - Move pdev->subordinate tests to of_pci_prop_bus_range() and
> >   of_pci_prop_intr_map()
> >
> > Changes in v2
> > (https://lore.kernel.org/all/20260912043106.10715-1-iamanaws@httpd.dev=
):
> > - Keep the dynamic OF node and skip only bus-range and interrupt-map
> >   when no subordinate bus exists, following review of v1.
> > - Tested on Linux 6.18.44 with the v1 guard removed.
> >
> > v1
> > (https://lore.kernel.org/all/20260911230420.26244-1-iamanaws@httpd.dev=
)
> >
> > diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> > index 75a358f73e69..1500740cc55d 100644
> > --- a/drivers/pci/of_property.c
> > +++ b/drivers/pci/of_property.c
> > @@ -95,9 +95,13 @@ static int of_pci_prop_bus_range(struct pci_dev *pd=
ev,
> >  				 struct of_changeset *ocs,
> >  				 struct device_node *np)
> >  {
> > -	u32 bus_range[] =3D { pdev->subordinate->busn_res.start,
> > -			    pdev->subordinate->busn_res.end };
> > +	u32 bus_range[2];
> >
> > +	if (!pdev->subordinate)
> > +		return 0;
> > +
> > +	bus_range[0] =3D pdev->subordinate->busn_res.start;
> > +	bus_range[1] =3D pdev->subordinate->busn_res.end;
> >  	return of_changeset_add_prop_u32_array(ocs, np, "bus-range", bus_ran=
ge,
> >  					       ARRAY_SIZE(bus_range));
> >  }
> > @@ -220,6 +224,9 @@ static int of_pci_prop_intr_map(struct pci_dev *pd=
ev, struct of_changeset *ocs,
> >  	int ret;
> >  	u8 pin;
> >
> > +	if (!pdev->subordinate)
> > +		return 0;
> > +
> >  	pnode =3D pci_device_to_OF_node(pdev->bus->self);
> >  	if (!pnode)
> >  		pnode =3D pci_bus_to_OF_node(pdev->bus);
> =


-----------------------a2c1a435c064bdab948fbb9ccdb71701--

--------87ebcbdce18e85b570166437990a4e3bac7a7705cfd5fe023eb4c7e1928c393f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqtnfwJEBoBbwppzUxnRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeYy3a7JP56kUxTETMd3tLpOuXlBNvxVibWBagu
vzZBvBYhBEAFf9htFyVnqZzmVhoBbwppzUxnAABDxwEA0gPUiKor/KXbKNIy
feoz+puxzpDXWcjSxI/wr6ae7KEA/A99sQ32SNOG0C1LlqNRW195q+wb1mfL
3OrjvQqkQe4F
=DtXv
-----END PGP SIGNATURE-----


--------87ebcbdce18e85b570166437990a4e3bac7a7705cfd5fe023eb4c7e1928c393f--

