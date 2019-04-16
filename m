Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BC3C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 15:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F4B2087C
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 15:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8FaGgJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfDPPes (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:34:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42296 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDPPes (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 11:34:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so27684188wrx.9;
        Tue, 16 Apr 2019 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sJrCKdWQXVWjIKPUKN0w9LVmv9/xQMjURccuypMeSNE=;
        b=g8FaGgJoZdv7jgRuSyA0oXGRFThkc6GLSkQZswyWsbzrKkbH+Jk7WPsqeikxz9NNXO
         4Hay1h+FITNu3/ZEEWdQCgd+VVXAWBvHvofABuQcqHGWnO3guzZm0acmE8VFu2IqER5p
         O6Ghz9WqBthNE3VBIonT7Q1045pu9zU7NPISadQDTijAk1pLGPMPsn1cgOfGC3gq40h+
         B6EYbSSKzrnCMxjYqGfB+d1WOMnHQjnpmrZV+W1Wzw6vBbff1PmiMhhM4eM75BMK3Mib
         NnTcFuAgAwv0c0+DKG8bOnASaP6aM03aXwEhbwF6ONQ12oqjPckLXcnpXE0e9hs//BVj
         KyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJrCKdWQXVWjIKPUKN0w9LVmv9/xQMjURccuypMeSNE=;
        b=XpBrxfiu71/Iz+eBpIDhRsQCLCy/kx4U+2s4FkWk7wiEIP4ENY/SiW7JQQ9cCcVeto
         xjozBJLlQu2KEGuMFoQK15uhZvPNY9RRRLJxr9L+MKaRul98aLnctfYzFuHs3lbmQLVB
         L328EhgCcdltWRhsAANWqM2hQNPIfSEnVJC0604at1r7HhsR7110NatFH61hB8NPSwtx
         dEBn/8dldft76IJ4cQX3zOu/QRRayEZtfpRUtbxC/o8ws28ex9xvZLQ+bSmbflQ3djdx
         ajJWjeTszbcDH/9ct1dsvnRouPtd7xIU1dVL2/raPAqWr90cm23uBAdW5WGJX56vA1Pc
         6gYg==
X-Gm-Message-State: APjAAAWBSxLpBsyYdkQkyDcIeMnSHCgoXlrjckv7kjI5AWVAQUUFQvMS
        xagAL78sBhWa6fiGIcLZmSg=
X-Google-Smtp-Source: APXvYqwwaRqGlqEhhiXaK1EwOQrr7TsKcIxCliIwAkVdj8lckckfskruZbACFnzBRuIYc6ibiUsk7w==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr51853542wrr.147.1555428885808;
        Tue, 16 Apr 2019 08:34:45 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id s21sm24625812wra.45.2019.04.16.08.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 08:34:44 -0700 (PDT)
Date:   Tue, 16 Apr 2019 17:34:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 26/30] dt-bindings: pci: tegra: Document
 nvidia,plat-gpios optional prop
Message-ID: <20190416153443.GA30777@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-27-mmaddireddy@nvidia.com>
 <20190415141654.GA29254@ulmo>
 <b575fd56-0d31-bbe2-deef-5a21d6e4b33e@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <b575fd56-0d31-bbe2-deef-5a21d6e4b33e@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 11:28:29PM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 15-Apr-19 7:46 PM, Thierry Reding wrote:
> > On Thu, Apr 11, 2019 at 10:33:51PM +0530, Manikanta Maddireddy wrote:
> >> Document "nvidia,plat-gpios" optional property which supports configur=
ing
> >> of platform specific gpios.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> ---
> >>  Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie=
=2Etxt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> >> index fbbd3bcb3435..dca8393b86d1 100644
> >> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> >> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> >> @@ -73,6 +73,8 @@ Optional properties:
> >>    pinctrl phandle to allow driver to explicitly put PCIe IO in DPD st=
ate.
> >>  - pinctrl-1: PCIe IO(bias & REFCLK) deep power down(DPD) enable state.
> >>    Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
> >> +- nvidia,plat-gpios: A list of platform specific gpios which controls
> >> +  endpoint's internal regulator or PCIe logic.
> > We discussed this with Vidya during review of the Tegra194 PCIe device
> > tree bindings and arrived at the conclusion that all of the GPIOs that
> > need to be controlled for PCI to work can be modelled as proper device
> > nodes (I think regulator and GPIO-controlled muxes were the only two
> > use-cases for which we need this).
> >
> > Can the same be done for this PCI controller? What use-cases are we
> > talking about?
> In Tegra194 case it is apt to use regulator framework because gpios are u=
sed
> to control regulators. However I published this patch to control vendor d=
efined
> gpios in endpoints. For ex: isolate gpio in RTL8111. Since I am not sure =
if
> regulator framework is apt, I published as gpio patch.
> >>  Required properties on Tegra124 and later (deprecated):
> >>  - phys: Must contain an entry for each entry in phy-names.
> >> @@ -567,6 +569,7 @@ Board DTS:
> >>  		pci@2,0 {
> >>  			phys =3D <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
> >>  			phy-names =3D "pcie-0";
> >> +			nvidia,plat-gpios =3D <&gpio TEGRA_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> >>  			status =3D "okay";
> >>  		};
> >>  	};
> > I recall this being the setup for Jetson Nano and the X.3 GPIO going to
> > an Ethernet device. Let's find out what exactly this GPIO is used for
> > and why we need it to be set up as part of the PCI controller driver
> > rather than the Ethernet device.
> >
> > If it turns out we can't model this other than with a generic GPIO type
> > of property we need a better explanation than the above, and the Jetson
> > Nano use-case would provide that explanation.
> >
> > And if indeed we cannot model this more accurately, I think we should
> > use something like the gpio-hog binding rather than some custom PCI
> > controller property.
> >
> > Thierry
> Yes, in Jetson Nano gpio x.3 is controlling isolate pin of RTL8111.
> RTL8111 datasheet available online says that as long as isolate
> pin is asserted it'll not sample RX lanes and doesn't drive TX lanes.
> Since RTL8111 PCIe IP should be active when PCIe host driver is
> attempting link up, this gpio can be controlled by host driver only.
>=20
> I didn't go for gpio-hog because this gpio should be asserted
> during suspend, to enable wake on LAN.

I don't see code in gpiolib that would cause this to be deasserted
during suspend.

Is there ever a need to manipulate this GPIO at all? Or do we just
need to make sure that it's always asserted?

The problem with adding this to nvidia,plat-gpios in the PCI root port
node is that there's no context at all, so the PCI host driver can't
really do anything with this, other than perhaps exactly one fixed
operation, but then it's pretty much equivalent to a gpio-hog.

If we do need control over the pin, I think it might be worth looking at
adding support to gpiolib for initial pin configuration (so that it does
not hog the GPIO, but still configures it). That would allow us to take
the PCI device out of isolation initially and once the device has been
probed we can control the GPIO from the PCI device. That way the device
driver has the necessary context to assert and deassert the pin at the
appropriate time, while still giving us the possibility to make the
device appear on the PCI bus.

As a side-note, I think it would've been better if the ISOLATEB signal
was wired up such that it would've been active by default. That would
mean that if the bootloader and/or OS were not aware of the ISOLATEB
signal, they would still be able to use the Ethernet device. I think
that would've been a more sensible default, especially if the bus that
the device is on requires the signal to be controlled without even
knowing that the device exists.

Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly19hAACgkQ3SOs138+
s6HUkQ//bBixhLLmfviWROSmcDAGsTPFP10KIavKAWo4DYGB/n2AWEku7r83+82E
xlHGdhT9I3coPh2sdEAr6w8PCkR46TVFsyRxKO/0agoVwBq8T181rXPDyKAxWyM0
hXCd+VvdnYesx3CPSlADar0apDL7kh4ESb270DCC2ddB5EkN7bvCnvj3lwbQOwNB
oVmneTgahQDBhQzN8DHQg5Wi4yoWaA1+prXcuKgRzRgrd5joz99NdCePcB21Uu8d
ym91CsTN7vKv8QZZdTFMMJaF6/0YIxeycvrF+IH/crXTdgvJmnDtofYtwEoeAjxE
iAZ/AlMFEd/ExLaX7Pnw+4nc9yILHijIMSsCnf11IiGfvXzyLZCpWGOnco5PcNwU
mD0zYbjswIcC7WkPlCXMvl8i6hS4PJ48YCUXi2MRhRfFnpXhd2waZKT9wwS6o8mV
FVQNde2b4OXd0uf4G5gD/580ha8T6o5whCbPQLxIFiyTMD7bqLlM8665PehLxLwU
OIyi/7t9r7LzKWgGmVGnMon3AOR/UkcG4Gy796UcCHYqg7vvFidVL7OhYcwRR+f7
dXKH1nv7yQzUnL00K0sTLZG8e/a2uWYPq2Mq7/PyChlT9l4y2ad1oUW4ocVOwXXB
bL2vDq69q6vVkfvrVtcXbeWirHwQznOH5EqNfFSruuG5BhIv+Ig=
=tVFb
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
