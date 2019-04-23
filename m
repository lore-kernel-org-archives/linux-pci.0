Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D26DC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 11:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4DF21738
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 11:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpGIAr3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfDWLC5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:02:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50556 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfDWLC5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 07:02:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so1708156wmk.0;
        Tue, 23 Apr 2019 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Te6FwGVHll9Zv0Ti5HT2OlEeL5SccauLLwPHWxuDvco=;
        b=KpGIAr3JBhjumfdCExZw/ZZNS1Ll1JW9JB7SXgoMfUvk9ZS5Ln7vwbropeHL/q7szP
         CCt5qCZObbsSVIoz+NAqR8Tyc8VyTpbkDqqqaFy/xizM6TrIElnd/Inx18/N/3TRJCLg
         cEHBNWyELSCSLeV1sHPyGkuAypBiL0ZUXrelg/AIc0ShWbiU9WG4G8qOFgzeDqRsCk0r
         8B0dkkJToUpClaBOIDOiwqBF4KqngHKPi1v2xTdxO+am40bX+Unj0voG8myVzXkfUVkb
         B+Uu392coYl99w7gcU3yrB0R9ZaNjD99eugRQaZig1iV1dFo9X4+ZwYdNphqgqijowrd
         bDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Te6FwGVHll9Zv0Ti5HT2OlEeL5SccauLLwPHWxuDvco=;
        b=lw8TvBYf+0gBIutynUs6mtCHXTYwYBWYw4+rJJWQJjIC26U+zkhLaaexSLY9o7kaMf
         Joqbkg4IhLTYcW0txf9cJTaJ1kjo1bDKDwgDgw/7Ac7YQ+w4TK0ukaa0aDq+9wp08z1N
         5gAw5D0uFz2O4d73fKUlRGGTtTa7L/WfGN/KuRoaJm++OqbxriQ/xoiKOvOC+kDbYLuw
         +xIVvlaXXRw4c/8xFE8J8+E23/ZwgHjM3c2WEsPcti6RQwhumjulEZAMzk67PVLORzLd
         4BrIhH/YLRwhmQVnCC1fZrfDGQzvE0Qp2JUSpFF+NMHviHJis3bGGwDduuTMkj1Y9dgz
         Uc8Q==
X-Gm-Message-State: APjAAAXSEgWpY7oTMkcdOLjdkDeHrNsFGC2ZWOzdsjQfCn+zzhlyh47M
        6TVLvMFx8n+QVxBVmGWBQQw=
X-Google-Smtp-Source: APXvYqx/trzhgnu6Nb7JzBgLiwAtm+9bAgfswfj9kzYTAhh7jhbRqNTTCJ6ixRIvYZAaEzMM1wT1AA==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr1789855wme.91.1556017371348;
        Tue, 23 Apr 2019 04:02:51 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id w2sm11435099wrm.74.2019.04.23.04.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 04:02:50 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:02:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicolas Chauvet <kwizart@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: disable nv_msi_ht_cap_quirk_leaf quirk on arm/arm64
Message-ID: <20190423110248.GA23448@ulmo>
References: <20180730094213.11973-1-kwizart@gmail.com>
 <20190415092537.14305-1-kwizart@gmail.com>
 <20190415134813.GA111421@google.com>
 <20190416113504.GG10907@ulmo>
 <20190418231704.GD126710@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20190418231704.GD126710@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2019 at 06:17:04PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 16, 2019 at 01:35:04PM +0200, Thierry Reding wrote:
> > On Mon, Apr 15, 2019 at 08:48:13AM -0500, Bjorn Helgaas wrote:
> > > On Mon, Apr 15, 2019 at 11:25:37AM +0200, Nicolas Chauvet wrote:
> > > > This patch disable the use of nv_msi_ht_cap_quirk_leaf quirk on arm=
 and
> > > > arm64 NVIDIA devices such as Tegra
> > > >=20
> > > > This fixes the following output:
> > > > "pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host bridge"
> > > > as experienced on a Trimslice device with PCI host bridge enabled
> > > >=20
> > > > v3: exclude the quirk for arm and arm64 instead of only for x86
> > > >=20
> > > > v2: use __maybe_unused to avoid a warning on nv_msi_ht_cap_quirk_le=
af
> > > >=20
> > > > Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> > > > Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > > Acked-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > >  drivers/pci/quirks.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index a59ad09ce911..1ac65f09d7ee 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -2811,12 +2811,15 @@ static void nv_msi_ht_cap_quirk_all(struct =
pci_dev *dev)
> > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_msi_ht_ca=
p_quirk_all);
> > > >  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_AL, PCI_ANY_ID, nv_ms=
i_ht_cap_quirk_all);
> > > > =20
> > > > -static void nv_msi_ht_cap_quirk_leaf(struct pci_dev *dev)
> > > > +static void __maybe_unused nv_msi_ht_cap_quirk_leaf(struct pci_dev=
 *dev)
> > > >  {
> > > >  	return __nv_msi_ht_cap_quirk(dev, 0);
> > > >  }
> > > > +/* HyperTransport is not relevant on theses arches */
> > > > +#if !IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)
> > >=20
> > > I don't see any of the previous versions or discussion on the list, so
> > > I can't tell what led to this #ifdef, but I'd prefer to avoid #ifdefs
> > > like this because they're checking for arch at the wrong level.
> > >=20
> > > If you're seeing that warning message, apparently your system contains
> > > an Nvidia device that has an HT_CAPTYPE_MSI_MAPPING capability, so
> > > HyperTransport is at least in the picture, even on arm/arm64.
> > >=20
> > > The quirk assumes a host bridge at 00:00.0, which is really a
> > > device-specific assumption, or maybe something specific to
> > > HyperTransport.  It's certainly not required by the PCI specs, which
> > > don't require a host bridge to be visible as a PCI device at all.
> > >=20
> > > I'd be tempted to just change that pci_warn() to a pci_info() or maybe
> > > even remove it altogether.  It would be nice to have the complete
> > > "lspci -vv" and dmesg log archived for future reference, since this
> > > quirk has such a broad reach (matching PCI_ANY_ID) and it has a long
> > > and ugly history already.
> >=20
> > I've been thinking about this a bit and it seems to me like the
> > intention of the quirk is to make sure that all devices have their HT
> > MSI mapping capabilities disabled if the system doesn't support HT.
> > As you said, the fact that a host bridge may not be present isn't an
> > error, however, it also means that we have to assume that HT is not
> > supported in such cases and make sure the HT MSI mapping capability gets
> > disabled for all devices.
> >=20
> > The following patch tries to address this and gets rid of the warning on
> > Tegra systems.
>=20
> Also interesting that Nicolas' original patch took this quirk
> completely out of the picture for ARM/ARM64, while your patch actively
> disables HT MSI mapping if there's no HT host bridge.

I should note here that this is just my interpretation of what I think
the quirk was originally meant to be. I don't have any hardware to test
this on, nor do I know much (well, nothing, to be frank) about Hyper-
Transport.

So my thinking was that if there's no HT host bridge, then it doesn't
make any sense to enable HT MSI mapping either, which I think may have
been the intent of this quirk: make sure that if the system is not HT
capable, that none of the PCI devices try to use HT MSI mapping.

Thierry

> If HT MSI Mapping Capability is enabled, the device is supposed to map
> MSIs into HyperTransport interrupt messages (HyperTransport I/O Link
> spec r3.10e, sec 7.12).  I don't know what that even means if the
> device is on a PCIe link instead of an HT chain.
>=20
> > --- >8 ---
> > From 69fb3b269cc852964385436694d79765d5c1cab3 Mon Sep 17 00:00:00 2001
> > From: Thierry Reding <treding@nvidia.com>
> > Date: Tue, 16 Apr 2019 13:27:53 +0200
> > Subject: [PATCH] PCI: Be less noisy if no HT host bridge exists
> >=20
> > Embedded systems will typically not expose a host bridge's configuration
> > space, so such setups must be assumed not to support HyperTransport, and
> > consequently the HT MSI mapping capability should be disabled for all
> > devices.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/pci/quirks.c | 34 +++++++++++++++++++---------------
> >  1 file changed, 19 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index f9cd4d432e05..705891c88073 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2792,24 +2792,28 @@ static void __nv_msi_ht_cap_quirk(struct pci_de=
v *dev, int all)
> >  	 */
> >  	host_bridge =3D pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), =
0,
> >  						  PCI_DEVFN(0, 0));
> > -	if (host_bridge =3D=3D NULL) {
> > -		pci_warn(dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
> > -		return;
> > -	}
> > -
> > -	pos =3D pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
> > -	if (pos !=3D 0) {
> > -		/* Host bridge is to HT */
> > -		if (found =3D=3D 1) {
> > -			/* it is not enabled, try to enable it */
> > -			if (all)
> > -				ht_enable_msi_mapping(dev);
> > -			else
> > -				nv_ht_enable_msi_mapping(dev);
> > +	if (host_bridge) {
> > +		pos =3D pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
> > +		if (pos !=3D 0) {
> > +			/* Host bridge is to HT */
> > +			if (found =3D=3D 1) {
> > +				/* it is not enabled, try to enable it */
> > +				if (all)
> > +					ht_enable_msi_mapping(dev);
> > +				else
> > +					nv_ht_enable_msi_mapping(dev);
> > +			}
> > +			goto out;
> >  		}
> > -		goto out;
> >  	}
> > =20
> > +	/*
> > +	 * Some systems, such as embedded devices, may not expose the host
> > +	 * bridge's configuration space. Assume such systems to not support
> > +	 * HyperTransport and disable the HT MSI mapping capability for all
> > +	 * devices.
> > +	 */
> > +
> >  	/* HT MSI is not enabled */
> >  	if (found =3D=3D 1)
> >  		goto out;
> > --=20
> > 2.21.0
> >=20
>=20
>=20

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly+8NYACgkQ3SOs138+
s6G96BAApfBcVDCCj0+a5cgdRmc8l9ris9798oHHF4/Ib1ySBrLG+06AFM/MR117
XFg/cpAyJbpmj+I8u+rjX+JQPRNM3FTiKWlYhh6AEgHDlranksSFtV/ZFxFt+vh+
ssqLBqCVOh498PJ84me/8bLiV8bL8hJml5y3OFngByzFtrnLrd6C3RldaG5Djwtu
di11mohR0TNfhRtZbmfbFIMuVtEcFIPOSiUyigT0+82XDoyEKIWnj8Pl+6NfpMtF
JxonGWxjAbUbWco3n7IsuDmzeY4xNWn3z0lntdHCxvIX7sZ+MPZndrqQosjdAXjR
Z2u1M+RiTiv5ejKYn5/ZpSXolIjbm4Jglc+leF/zBPAqw7vhuH0owHv9F/smtJv7
C8Kv1vwoA/qJA+8s5ZxbNKxSESvInEAAUMzO6me8dQ0dLRuBspqrUJwfj5k8wIIB
P/kXy5Ojc5Ci4U30wtFmcc5hro6LbGN9qwaWCFqPLPiRe/VlXa6iqjveM1+G9ZyB
54wQq7YCrA5HQhZ+YyHZpyfe+xrTJkWLTxT4mf/vpW/j/SjrwQQYYr/H3DTD/wC4
JdLMYekHMCh1i2Nx2DrrFDEIISLQVyHIwA4H+bnS+TJOx0nc0p+uaG51kRaF3gTG
B4CxeYywwZCnLIHts8XouAiTOGkQJCiPyXc0vQL8UgCkgeS90N0=
=9E12
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
