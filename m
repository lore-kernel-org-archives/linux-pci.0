Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B93B3BE2;
	Tue,  7 Apr 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565006; cv=none; b=c9e/NAar0mOKZ5pCATkOLggo2Xyc/YFgF4qqRo1WFjLI/GIurC9aaXa2ELOEBe3zh9IzdlCvOoHi95nfcjVyStG9+ZlHOl8fSST6T/PXMeP7Z1LzcCHsyexfJ+fPj0dE6VFfs2/cL/21z53YPe/yx/aXkDb7OSTqeKXQjV4hce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565006; c=relaxed/simple;
	bh=NSzYOUJrsZTTfsNyjyz8JWsUP567zhtdpZ2OHarUZ/s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uDMmtV3cuBMImcto/q4ZcbdHjpjHKLTjAji8ARtscFS97IrYPF4x6Kdox533eNvXXVDceMUzGjU+9nv4KxSXxx65H79VfqTI9NFgopXM//F1pV2Vq/SLM6PB7DEZwIapqfDichrQvuYqGeG5kdh02D7GxNh8gVzGE/jGxxnoELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jh9vJENh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jh9vJENh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775565006; x=1807101006;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NSzYOUJrsZTTfsNyjyz8JWsUP567zhtdpZ2OHarUZ/s=;
  b=Jh9vJENhuxhRbW7dZi0cVuCV9eeTD0PcK6Xthd+VUUf26Xtg3q8AAJ2i
   IEKRUUaLKGBHGsWbFZNsMHFAK/+i+Re8LnKa+/1hyrVHH67aWeGsXknq4
   Kn78V2KgC0/Kg9iWfWpuvEijRDzxBABVJ2Ja+ebrQbZq8XXZOjftk8APV
   GJwigCn6wZ2KmlktFDegJzzeXCC6Y7L7H3Bm22lE+jcqwt01WHZaGrw+F
   d3wl23a0Cf3ibnbIcPrFkkJkT9CObTCxXLd77kjQSsSvEZ9Ht4goB7Zkp
   ToV4QKFVfG48erZ/nz6ywkBJtSVq1oHOMHvnymAzcO1dPvRWRA/5h8PLy
   w==;
X-CSE-ConnectionGUID: hQaBeo2XQj2pGr9ssemp/g==
X-CSE-MsgGUID: whMmh9pgQTGZTCla+qlu2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76422650"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76422650"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:30:05 -0700
X-CSE-ConnectionGUID: 9uJN04r0Q7Opp9d1tgP7xw==
X-CSE-MsgGUID: r2jaGtjMTGi/5hN4XBezsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="233027760"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:30:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Apr 2026 15:29:59 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
    kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
    robh@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] PCI: dwc: Use common speed conversion function
In-Reply-To: <70f81184-4900-499b-a6ee-fbe18367bd0a@163.com>
Message-ID: <2af36546-5c33-caf8-b15d-fbf8fec4417e@linux.intel.com>
References: <20260406105613.1228673-1-18255117159@163.com> <20260406105613.1228673-4-18255117159@163.com> <d2bb9eae-8731-b438-87dd-fcbcf2a17551@linux.intel.com> <70f81184-4900-499b-a6ee-fbe18367bd0a@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1691075706-1775564999=:983"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1691075706-1775564999=:983
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Apr 2026, Hans Zhang wrote:
> On 4/7/26 16:25, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 6 Apr 2026, Hans Zhang wrote:
> >=20
> > > Replace the private switch-based speed conversion in
> > > dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
> > > function.
> > >=20
> > > This eliminates duplicate conversion logic and ensures consistency wi=
th
> > > other PCIe drivers, while handling invalid speeds by falling back to
> > > hardware capabilities.
> > >=20
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware.c | 18 +++--------------=
-
> > >   1 file changed, 3 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 06792ba92aa7..ab8dee5d6c7a 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -861,24 +861,12 @@ static void dw_pcie_link_set_max_speed(struct
> > > dw_pcie *pci)
> > >   =09ctrl2 =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
> > >   =09ctrl2 &=3D ~PCI_EXP_LNKCTL2_TLS;
> > >   -=09switch (pcie_get_link_speed(pci->max_link_speed)) {
> > > -=09case PCIE_SPEED_2_5GT:
> > > -=09=09link_speed =3D PCI_EXP_LNKCTL2_TLS_2_5GT;
> > > -=09=09break;
> > > -=09case PCIE_SPEED_5_0GT:
> > > -=09=09link_speed =3D PCI_EXP_LNKCTL2_TLS_5_0GT;
> > > -=09=09break;
> > > -=09case PCIE_SPEED_8_0GT:
> > > -=09=09link_speed =3D PCI_EXP_LNKCTL2_TLS_8_0GT;
> > > -=09=09break;
> > > -=09case PCIE_SPEED_16_0GT:
> > > -=09=09link_speed =3D PCI_EXP_LNKCTL2_TLS_16_0GT;
> > > -=09=09break;
> > > -=09default:
> > > +=09link_speed =3D pcie_get_link_speed(pci->max_link_speed);
> > > +=09link_speed =3D pci_bus_speed2lnkctl2(link_speed);
> >=20
> > Its signature is:
> >=20
> > u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
> >=20
> > Using link_speed variable both for in and out does contradict with the
> > expected typing.
> >=20
> > Maybe it would be beneficial to rename the current 'link_speed' to
> > 'ctrl2_speed' (or something along those lines) to differentiate Link
> > Control 2 speed representation from PCI core's internal link speed
> > representation. And then reintroduce link_speed variable as the
> > pci_bus_speed. ...But this is just my suggestion, there may be better w=
ays
> > to untangle this type abuse.
>=20
> Hi Ilpo,
>=20
>=20
> Thank you for your review comments. This way it will be clearer. Here are=
 my
> revisions. If there are no issues, I will send the next version.
>=20
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> b/drivers/pci/controller/dwc/pcie-designware.c
> index 06792ba92aa7..21a709a47e82 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -843,8 +843,9 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>=20
>  static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  {
> -       u32 cap, ctrl2, link_speed;
> +       u32 cap, ctrl2, pci_bus_speed;

I meant something like this (instead of introducing variable named=20
"pci_bus_speed"):

=09enum pci_bus_speed link_speed;

>         u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +       u16 ctrl2_speed;

=2E..And keep this like you have it now.

--=20
 i.

>         cap =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>=20
> @@ -861,30 +862,18 @@ static void dw_pcie_link_set_max_speed(struct dw_pc=
ie
> *pci)
>         ctrl2 =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>         ctrl2 &=3D ~PCI_EXP_LNKCTL2_TLS;
>=20
> -       switch (pcie_get_link_speed(pci->max_link_speed)) {
> -       case PCIE_SPEED_2_5GT:
> -               link_speed =3D PCI_EXP_LNKCTL2_TLS_2_5GT;
> -               break;
> -       case PCIE_SPEED_5_0GT:
> -               link_speed =3D PCI_EXP_LNKCTL2_TLS_5_0GT;
> -               break;
> -       case PCIE_SPEED_8_0GT:
> -               link_speed =3D PCI_EXP_LNKCTL2_TLS_8_0GT;
> -               break;
> -       case PCIE_SPEED_16_0GT:
> -               link_speed =3D PCI_EXP_LNKCTL2_TLS_16_0GT;
> -               break;
> -       default:
> +       pci_bus_speed =3D pcie_get_link_speed(pci->max_link_speed);
> +       ctrl2_speed =3D pci_bus_speed2lnkctl2(pci_bus_speed);
> +       if (ctrl2_speed =3D=3D 0) {
>                 /* Use hardware capability */
> -               link_speed =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
> +               ctrl2_speed =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>                 ctrl2 &=3D ~PCI_EXP_LNKCTL2_HASD;
> -               break;
>         }
>=20
> -       dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_sp=
eed);
> +       dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 |
> ctrl2_speed);
>=20
>         cap &=3D ~((u32)PCI_EXP_LNKCAP_SLS);
> -       dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed=
);
> +       dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | ctrl2_spee=
d);
>=20
>=20
> Best regards,
> Hans
>=20
> >=20
> > > +=09if (link_speed =3D=3D 0) {
> > >   =09=09/* Use hardware capability */
> > >   =09=09link_speed =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
> > >   =09=09ctrl2 &=3D ~PCI_EXP_LNKCTL2_HASD;
> > > -=09=09break;
> > >   =09}
> > >     =09dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 |
> > > link_speed);
> > >=20
> >=20
>=20

--8323328-1691075706-1775564999=:983--
