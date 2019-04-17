Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78026C282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 15:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3992921773
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 15:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPZEdjPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfDQPUB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:20:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38201 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQPUB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2019 11:20:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so32501804wro.5;
        Wed, 17 Apr 2019 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/6b+ukM6kvtwKRgAPxP8er09O/VlVChWu1+vdS7rg3k=;
        b=iPZEdjPfLaRL5OhBElRRcuvv4T1V7EmlFcK1p3asTbXGLJXUz5F2Co+4I5jV0ksS+F
         WQ/v5cfl7e12GWcBFoWQBXsM+YX+nNBQGonJdjuVUm/qEj46Ke5QTBMYu8NllpKfYt0R
         LtEPJ8c/FDN0GhO1koYCDlKzcYRbKR6I5ebtIFryxBt4dZWpkcGC6VCifWvpe1qLENOJ
         Q+EW5iInoVaD0E0IPzTsoRi8Ykrghivj2CqY6gyDbCLpZ8B+mF2CcI+HmTYyneBDZ4rS
         VWNiX6zyhIyCE2VBI2y4+m79GcFxXUdekGovcFt4KgJPxVqRcnv1U6HOPBX8LyLSKfRI
         Qbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/6b+ukM6kvtwKRgAPxP8er09O/VlVChWu1+vdS7rg3k=;
        b=Iw28OwzrNq4eTy2FLBpRYCRjH8A3dr4M+D9enM+fsLXRKAfb4nCReioKTuU+ykcfqL
         SPXR9d4YF6AJN4KLkietrb9WCxoXA26Jr1DQQu/XNEIF1CUk2G3oGaewVr8kWcLegwYF
         UG1KC0MFtic3W6bZ+gMauJjMumjtuWGfdO6OiLev2I6qCISmgMf/ebVURhRLLP67gsnq
         xSPeWI70mrVKoW5OczbiKo/Eh2CB185xsNY2IikzuXl9bG7d+6W0FkwL5f1aloFMeMIy
         Q7mT4ySUUqrKhVFEMeEdO+M5XPAmns07pd0XJjA2+dGyys1khQ6a+97udFinkO57th4W
         Esqw==
X-Gm-Message-State: APjAAAVoH81qTECg3LY/km6N32nWGx5UMRPvmfOgOyVCFNQOLr13UH8/
        sQXdu3V8iw0ZmwFBAEVtpc4=
X-Google-Smtp-Source: APXvYqzLko0mKWxdx10weCCIFsknWIMw+xe5CzjBKN1D+iSBLMZEOh+Yy0kcWt5kn6MlsPRdfVtj+g==
X-Received: by 2002:adf:e74f:: with SMTP id c15mr8000627wrn.23.1555514398701;
        Wed, 17 Apr 2019 08:19:58 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id c16sm5021921wme.31.2019.04.17.08.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 08:19:57 -0700 (PDT)
Date:   Wed, 17 Apr 2019 17:19:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 26/30] dt-bindings: pci: tegra: Document
 nvidia,plat-gpios optional prop
Message-ID: <20190417151956.GF26626@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-27-mmaddireddy@nvidia.com>
 <20190415141654.GA29254@ulmo>
 <b575fd56-0d31-bbe2-deef-5a21d6e4b33e@nvidia.com>
 <20190416153443.GA30777@ulmo>
 <51957dce-5e0b-647b-d6b8-0cc118ee95bc@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
In-Reply-To: <51957dce-5e0b-647b-d6b8-0cc118ee95bc@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 04:52:46PM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 16-Apr-19 9:04 PM, Thierry Reding wrote:
> > On Mon, Apr 15, 2019 at 11:28:29PM +0530, Manikanta Maddireddy wrote:
> >>
> >> On 15-Apr-19 7:46 PM, Thierry Reding wrote:
> >>> On Thu, Apr 11, 2019 at 10:33:51PM +0530, Manikanta Maddireddy wrote:
> >>>> Document "nvidia,plat-gpios" optional property which supports config=
uring
> >>>> of platform specific gpios.
> >>>>
> >>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +=
++
> >>>>  1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pc=
ie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> >>>> index fbbd3bcb3435..dca8393b86d1 100644
> >>>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> >>>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> >>>> @@ -73,6 +73,8 @@ Optional properties:
> >>>>    pinctrl phandle to allow driver to explicitly put PCIe IO in DPD =
state.
> >>>>  - pinctrl-1: PCIe IO(bias & REFCLK) deep power down(DPD) enable sta=
te.
> >>>>    Pass pinctrl phandle to allow driver bring PCIe IO out of DPD sta=
te.
> >>>> +- nvidia,plat-gpios: A list of platform specific gpios which contro=
ls
> >>>> +  endpoint's internal regulator or PCIe logic.
> >>> We discussed this with Vidya during review of the Tegra194 PCIe device
> >>> tree bindings and arrived at the conclusion that all of the GPIOs that
> >>> need to be controlled for PCI to work can be modelled as proper device
> >>> nodes (I think regulator and GPIO-controlled muxes were the only two
> >>> use-cases for which we need this).
> >>>
> >>> Can the same be done for this PCI controller? What use-cases are we
> >>> talking about?
> >> In Tegra194 case it is apt to use regulator framework because gpios ar=
e used
> >> to control regulators. However I published this patch to control vendo=
r defined
> >> gpios in endpoints. For ex: isolate gpio in RTL8111. Since I am not su=
re if
> >> regulator framework is apt, I published as gpio patch.
> >>>>  Required properties on Tegra124 and later (deprecated):
> >>>>  - phys: Must contain an entry for each entry in phy-names.
> >>>> @@ -567,6 +569,7 @@ Board DTS:
> >>>>  		pci@2,0 {
> >>>>  			phys =3D <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
> >>>>  			phy-names =3D "pcie-0";
> >>>> +			nvidia,plat-gpios =3D <&gpio TEGRA_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> >>>>  			status =3D "okay";
> >>>>  		};
> >>>>  	};
> >>> I recall this being the setup for Jetson Nano and the X.3 GPIO going =
to
> >>> an Ethernet device. Let's find out what exactly this GPIO is used for
> >>> and why we need it to be set up as part of the PCI controller driver
> >>> rather than the Ethernet device.
> >>>
> >>> If it turns out we can't model this other than with a generic GPIO ty=
pe
> >>> of property we need a better explanation than the above, and the Jets=
on
> >>> Nano use-case would provide that explanation.
> >>>
> >>> And if indeed we cannot model this more accurately, I think we should
> >>> use something like the gpio-hog binding rather than some custom PCI
> >>> controller property.
> >>>
> >>> Thierry
> >> Yes, in Jetson Nano gpio x.3 is controlling isolate pin of RTL8111.
> >> RTL8111 datasheet available online says that as long as isolate
> >> pin is asserted it'll not sample RX lanes and doesn't drive TX lanes.
> >> Since RTL8111 PCIe IP should be active when PCIe host driver is
> >> attempting link up, this gpio can be controlled by host driver only.
> >>
> >> I didn't go for gpio-hog because this gpio should be asserted
> >> during suspend, to enable wake on LAN.
> > I don't see code in gpiolib that would cause this to be deasserted
> > during suspend.
> >
> > Is there ever a need to manipulate this GPIO at all? Or do we just
> > need to make sure that it's always asserted?
>=20
> Following steps
> 1) ISOLATEB gpio should be deasserted during boot to enable PCIe section
> of RTL8111
> 2) PCIe host driver enumerates RTL8111
> 3) When suspend is initiated, ISOLATEB gpio should be asserted after PCIe
> host controller suspend is completed to disable PCIe section of RTL8111
> and enable Wake on LAN
> 4) During resume, first ISOLATE gpio should be deasserted to get PCIe lin=
k up

I think it's important that we be very clear here. If ISOLATEB is
asserted, does that mean the PCIe link is down? Or does it only mean
that the RTL8111 cannot be enumerated.

If the PCIe link remains down as long as ISOLATEB is asserted, then it
sounds like there's more going on than this GPIO just keeping the
RTL8111 from talking on the PCI bus. In that case we would probably have
to model this as some sort of power regulator for the bus.

However, if the PCIe link can be brought up if the RTL8111 is isolated,
but if the device can only not be enumerated, then we could still have
the RTL8111 driver deassert ISOLATEB early during resume. We only have
to make sure that it happens before any PCI requests are sent to the
device.

Thierry

> > The problem with adding this to nvidia,plat-gpios in the PCI root port
> > node is that there's no context at all, so the PCI host driver can't
> > really do anything with this, other than perhaps exactly one fixed
> > operation, but then it's pretty much equivalent to a gpio-hog.
> >
> > If we do need control over the pin, I think it might be worth looking at
> > adding support to gpiolib for initial pin configuration (so that it does
> > not hog the GPIO, but still configures it). That would allow us to take
> > the PCI device out of isolation initially and once the device has been
> > probed we can control the GPIO from the PCI device. That way the device
> > driver has the necessary context to assert and deassert the pin at the
> > appropriate time, while still giving us the possibility to make the
> > device appear on the PCI bus.
>=20
> ISOLATEB gpio disables the PCIe section in RTL8111(Rx is not sampled &
> doesn't drive Tx), if PCI client driver controls it, then it has
> to do it after host controller suspend_noirq callback is completed.
> Only suspend callback available after suspend_noirq is syscore_ops.
> I didn't go with it because it is take void arguments, so client
> driver has to maintain global pointers and I see only core drivers
> like irqchip, clk, etc are using it.
>=20
> Manikanta
>=20
> >
> > As a side-note, I think it would've been better if the ISOLATEB signal
> > was wired up such that it would've been active by default. That would
> > mean that if the bootloader and/or OS were not aware of the ISOLATEB
> > signal, they would still be able to use the Ethernet device. I think
> > that would've been a more sensible default, especially if the bus that
> > the device is on requires the signal to be controlled without even
> > knowing that the device exists.
> >
> > Thierry
>=20

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly3RBoACgkQ3SOs138+
s6FPPA//YFTYbCBwej1IT5sXtlhZv5UwMfQyAPOQO6kZw1sz9aqt0uv3enWT9jaB
UtAMFeNl/JxUXQ03e9x5TiLGybPcifjw+OZjzRDdwTDW36kRp5KwHwJNeiZE36au
td9/8a8co5Ccvs1OTbRoIu79OSCVb1hxVSeiyw5MtoJg4jEcBCpCPw/FWXfeVnEK
HL2fYwKnerJrA+PvRxuIBpQG3GbnVK66Z4VonHf+DM4neWHrMg6QzvPHJ4KfLy01
LjlXeMkPge+a4QHNBagkJyFXsO1PXr3FotHImYJsA9qscJjp7PDc8UXlOkR2vAB8
eInnzwtF5M6JHJl2k3JibjCSY3V2GHZhok5I6Tx228CT+7l523yPJDYIIJzm4b5+
PAj2/Bk1zSXg71pHDRto1ZAe4ujy7v8sJp5D9tPtAFGlD2RElZwPjissKu5pBfsX
VyTevs3vk9Lm07XCWGELj/SE2RfldwaQz4UJIbBF41/hbg2uWpHV0lLZrNwXDNuW
HRttOT+QswxdT6XkIssEQPLvWieHUv4Q+oW0tNNtDoit4YcajDOV8sxaS2w9+++q
IPt0dW65t4McVxiLxZggTrqvLDHEfmmqLnFUagiLmnMpDmgN0A70ziW+mNBY98Ap
XtB/hInVfDSYHDzS/O6RfXofVnMbMuENYHQr0cNd57pFQW/5gHU=
=F9K9
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
