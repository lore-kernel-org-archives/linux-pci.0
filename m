Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733A2C43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A84208E4
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qt35qG0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfDZQH2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:07:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46866 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfDZQH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 12:07:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so5099254wrw.13;
        Fri, 26 Apr 2019 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dt7eA8/Rb6cygGAF7Blffe6UBX8AUE/LgVAg18GA+j0=;
        b=qt35qG0isL8+xlbkD8siGE7BJeb0DDp6YDtisS8Y8uuX4dMUr2r2aSuG/O1EmdbFa3
         fyNxV0OApFPgoLpO5bL+63paWT/ARpC/bpTIZNfifhuvGK/lD47WEPB1OARaR7Y32t02
         YIJ8RmKYqpZC2j2WZEe/mkFmnDQSjb+xAkQp+7FaAT6cPK6pe1teAs2qZAT+GljnQFUj
         j0U/yoY1nx57wzsn4kXpIqnSchTTq86ysvErRi3vSclWuvnhfS0FGorvP8v8fyxAwAiP
         0xdLkZ40GB/OUcfgNO+0C9sHiyTqyLx0JDL7YAWhcQXuGNBrh6Nn+J9HZV52W/E9uCHM
         w2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dt7eA8/Rb6cygGAF7Blffe6UBX8AUE/LgVAg18GA+j0=;
        b=FbUryDUUqnlAzdDeG5Mj0us9bLMPwJTXWoEps4u+qQqzl8h/eRi6Wx3FhIHkWLzBa8
         ER5r2WdXJuhL1r+IgH7TqMMwzTGMwQPKzzZ/3dyFB8QSVb1nPHYsgotsc2HBsMU4+4GK
         +LxjSefkskmnIdng5k8lR6TPWFGWP6NZDR2NRYPt9gcSwsSKgHqQOpAzlb4lkE+3U2Tq
         J7HG/eW/rkzin6qHNOODL87EFX/m/MdJnipKIF3DgNFiA+ISSJxNNVKhurgHqYkimmcN
         BGuwn3PaLU/W0xJlfYLXUSM472NbP+HM1c2sveBSkKAI32n2yTs+vTz3c3z5Cefi6Ekr
         Dzdw==
X-Gm-Message-State: APjAAAVm59yLdQEKS5JWViXcauaObvCk5XufJvYA7XCZwq0MKX3CNrwM
        F4JeVM+QVLJKbsJw8F2BCfs=
X-Google-Smtp-Source: APXvYqwfioVpSEjaBZV5h4w4DX/4OMAFnAELKYGVWqgEmlU+3BIEZtqD/4kiy9hN9BhsLHK88nLyIA==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr376855wrv.126.1556294845102;
        Fri, 26 Apr 2019 09:07:25 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id m14sm13973248wru.51.2019.04.26.09.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 09:07:24 -0700 (PDT)
Date:   Fri, 26 Apr 2019 18:07:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, mark.rutland@arm.com, jonathanh@nvidia.com,
        kishon@ti.com, catalin.marinas@arm.com, will.deacon@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 11/16] dt-bindings: PHY: P2U: Add Tegra 194 P2U block
Message-ID: <20190426160723.GB3204@ulmo>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-12-vidyas@nvidia.com>
 <20190426154519.GA19329@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20190426154519.GA19329@bogus>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 10:45:19AM -0500, Rob Herring wrote:
> On Wed, Apr 24, 2019 at 10:49:59AM +0530, Vidya Sagar wrote:
> > Add support for Tegra194 P2U (PIPE to UPHY) module block which is a glue
> > module instantiated one for each PCIe lane between Synopsys Designware =
core
> > based PCIe IP and Universal PHY block.
>=20
> Missing Sob.
>=20
> > ---
> > Changes since [v4]:
> > * None
> >=20
> > Changes since [v3]:
> > * None
> >=20
> > Changes since [v2]:
> > * Changed node label to reflect new format that includes either 'hsio' =
or
> >   'nvhs' in its name to reflect which UPHY brick they belong to
> >=20
> > Changes since [v1]:
> > * This is a new patch in v2 series
> >=20
> >  .../bindings/phy/phy-tegra194-p2u.txt         | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-=
p2u.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt=
 b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> > new file mode 100644
> > index 000000000000..8b543cba483b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> > @@ -0,0 +1,28 @@
> > +NVIDIA Tegra194 P2U binding
> > +
> > +Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVID=
IA High
> > +Speed) each interfacing with 12 and 8 P2U instances respectively.
> > +A P2U instance is a glue logic between Synopsys DesignWare Core PCIe I=
P's PIPE
> > +interface and PHY of HSIO/NVHS bricks. Each P2U instance represents on=
e PCIe
> > +lane.
> > +
> > +Required properties:
> > +- compatible: For Tegra19x, must contain "nvidia,tegra194-p2u".
> > +- reg: Should be the physical address space and length of respective e=
ach P2U
> > +       instance.
> > +- reg-names: Must include the entry "ctl".
>=20
> -names is pointless when there is only 1.

We've occasionally done this in the past for other types of resources.
When we did it was to preempt having to verbosely describe exactly what
order -names entries need to be in if ever a new entry was required.

For example, if we document only one clock for a module and leave out
the clock-names property, then if ever we need to add another clock, it
means that clock-names must be documented in such a way that the "main"
clock (the one that was always documented) would need to be first in the
list of clock-names, so that it's matching entry in the clocks property
is at index 0, because that's effectively what the ABI is.

I think the same essentially applies to memory regions, though
admittedly I have a hard time seeing us add a second region at any point
in the future.

Thierry

> > +
> > +Required properties for PHY port node:
> > +- #phy-cells: Defined by generic PHY bindings.  Must be 0.
> > +
> > +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> > +
> > +Example:
> > +
> > +p2u_hsio_0: p2u@3e10000 {
>=20
> phy@...
>=20
> > +	compatible =3D "nvidia,tegra194-p2u";
> > +	reg =3D <0x03e10000 0x10000>;
> > +	reg-names =3D "ctl";
> > +
> > +	#phy-cells =3D <0>;
> > +};
> > --=20
> > 2.17.1
> >=20

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzDLLgACgkQ3SOs138+
s6Epyg/+NYm+Bee23zwcz30bxm/XqjxnKrbi7tlfaFwLhhNbvr4sECS2qNrK6Yzw
t9bFEDDP0KXY6I5iHtS6uYkbnbq2+BEF8mb+oOp6LFs72oRvKYwyp0egPfeTKQfv
JjOsIhjSl1s8j40YcGFoxyQJfmupn14urCdweCupzZjwjVvN8SyJnVNnluYlVHAj
+fiFXPmu+7gb1wcPJz3kXWg0GB+vQ38bnRZgYMmyJyN3eARxe2i6lziV9L5GAWyy
e6bFtrQmV+WqceQPSju97FmUaf729sQHsIWdOsHyFr06N35Pxide0xjIsI5IScDN
O3dEqag60K+QslnhI1WX9CeziIUar4dqqbjKSUWMVz0DXX6CkUph/U7mpqQD1plc
R20q77ocK1II9m3kJTRYUTPIYoQeOV7tQNFFCm5DBb89SnMCGFxg0nhUHIXsg0Kk
p36fig2OZ2ihv34YIifZEOCjv0UeJ9AsrcSdkQe+D4Xh1x/hedvp+kX0IcD1ypqX
yIJU1/lTFJF/GPfLi+ddQI9Q7mXbZTqq3ieivL7svkT+FSQVRxPGG36V2xg2Ofon
LtNWLOzk00cRCbkyvb1EabQtGpQAwfl5IrpC10NCVFal8jDLcoe2Kzc3zluGsjMo
MzrCt52OX6Iq8rDwxBJEIUqyo/JqOomDAe4hd99AZcmnr0rxFIs=
=sHyD
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
