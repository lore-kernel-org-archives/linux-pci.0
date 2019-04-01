Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A77C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 14:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01785208E4
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 14:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyuQ49Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDAObo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:31:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44341 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfDAObo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 10:31:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so12323326wrn.11;
        Mon, 01 Apr 2019 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U/q01l5vsvehwpmlob5kHfgyBNtxue64DZYs+uSy0Qs=;
        b=qyuQ49EhKyQOlL3w7Xcj88P0/5Y0RnNiB/+pz4leiHl8NyRNGuq94L9DEgWy0hsMzR
         Kz1HnzFyboUSOcKcy9veRa/QHEK3pqGMl0K0dH0wWu3OJT1LUEeAwA93yowKZmMeLr15
         9Lq+66o1m9a683ylEQr3AgrB7epvOuBWrvPViQ3ZJB10lg5dLk0AOOnGDufj2rcM8nK6
         +T1bzG4sHDFzSqG9pF1Cg9809Vn02eTJTLtD4vLbnrbC5KYheZga+Y33K8sONfckB1ex
         nA/LG3IIEYXHH/CwcLPubrCvrRsqC497Bhtw5iG4JjtaCwfsXyvX72YQSvp0yCtZb9IV
         YdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/q01l5vsvehwpmlob5kHfgyBNtxue64DZYs+uSy0Qs=;
        b=CSkDsUK3SVOZG1tOXY9pUmCZu0zIHy2CfhW319XZuRiQJKXauCmjtceQBae/yG6MyJ
         hY7FdO5BMxWsAlSQ6nHIMADFW+NaaOJquoysWvdmcvXH6nCPx+j6rxu6iuJAlV16NxAH
         JdV/T3xNl6rcXBDvvX88n7cYMUEQB9b7FOnvc0vOtBQKId8a5CZNuMiViECKv5xrwHzZ
         sNhwEx1ioEMNYJu68s75QdWwKtViYShw5HkZmcBc5/6pHNzcibztRb9VMC+zHv+SQYz8
         lj/EG8H/c5BF5m4YglV91hJwv1Pbx/tT1z5U6B5sFOxIWlUlu7r4nXlfa6JLZHzGkFVq
         WuMg==
X-Gm-Message-State: APjAAAV+Vx2FTZ+wfw+YgfutCqPNtNRP+RRcPrPLAwga2TrDyV0zsueV
        vvAp4k8lY3yI7l31TMKUWUM=
X-Google-Smtp-Source: APXvYqyTP3DjPqk3TYjEH1LCs1HQ59IxqJW/h6TnlRmjimmhiKB5D1xWGbWyuOA6KQX3k4hT+9f7vw==
X-Received: by 2002:a5d:6b05:: with SMTP id v5mr34267070wrw.314.1554129100666;
        Mon, 01 Apr 2019 07:31:40 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id u2sm10507972wmc.45.2019.04.01.07.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 07:31:39 -0700 (PDT)
Date:   Mon, 1 Apr 2019 16:31:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Rob Herring <robh@kernel.org>, bhelgaas@google.com,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        tiwai@suse.de, spujar@nvidia.com, skomatineni@nvidia.com,
        liviu.dudau@arm.com, krzk@kernel.org, heiko@sntech.de,
        horms+renesas@verge.net.au, olof@lixom.net,
        maxime.ripard@bootlin.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        enric.balletbo@collabora.com, ezequiel@collabora.com,
        stefan.wahren@i2se.com, marc.w.gonzalez@free.fr,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        hayashi.kunihiko@socionext.com, yue.wang@amlogic.com,
        shawn.lin@rock-chips.com, xiaowei.bao@nxp.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
Message-ID: <20190401143138.GA4874@ulmo>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
 <5ca06149.1c69fb81.720fd.79e1@mx.google.com>
 <5ef50168-2476-1088-7156-8a4488d7a2e1@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <5ef50168-2476-1088-7156-8a4488d7a2e1@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 04:48:42PM +0530, Vidya Sagar wrote:
> On 3/31/2019 12:12 PM, Rob Herring wrote:
> > On Tue, Mar 26, 2019 at 08:43:22PM +0530, Vidya Sagar wrote:
> > > Add support for Tegra194 PCIe controllers. These controllers are based
> > > on Synopsys DesignWare core IP.
> > >=20
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > >   .../bindings/pci/nvidia,tegra194-pcie.txt          | 209 ++++++++++=
+++++++++++
> > >   .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |  34 ++++
> > >   2 files changed, 243 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,teg=
ra194-pcie.txt
> > >   create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra1=
94-p2u.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pc=
ie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> > > new file mode 100644
> > > index 000000000000..31527283a0cd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> > > @@ -0,0 +1,209 @@
> > > +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
> > > +
> > > +This PCIe host controller is based on the Synopsis Designware PCIe IP
> > > +and thus inherits all the common properties defined in designware-pc=
ie.txt.
> > > +
> > > +Required properties:
> > > +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> > > +- device_type: Must be "pci"
> > > +- reg: A list of physical base address and length for each set of co=
ntroller
> > > +  registers. Must contain an entry for each entry in the reg-names p=
roperty.
> > > +- reg-names: Must include the following entries:
> > > +  "appl": Controller's application logic registers
> > > +  "window1": This is the aperture of controller available under 4GB =
boundary
> > > +             (i.e. within 32-bit space). This aperture is typically =
used for
> > > +             accessing config space of root port itself and also the=
 connected
> > > +             endpoints (by appropriately programming internal Address
> > > +             Translation Unit's (iATU) out bound region) and also to=
 map
> > > +             prefetchable/non-prefetchable BARs.
> >=20
> > This is usually represented in 'ranges' for BARs.
> I added window1 and window2 as the umbrella apertures that each PCIe cont=
roller has
> and gave a description of how each aperture *can* be used. This is an ove=
rview and as
> such these two entries are not directly used by the driver.
> 'ranges' property gives us the information as to how exactly are window1 =
and window2
> apertures used.
> Thierry Reding also gave few comments about these entries. If this is con=
fusing,
> I'm ok to remove them as well. Please let me know.

If all you want to do is document how these are used, it may be better
to enhance the device tree bindings for the ranges property if it does
not describe this fully enough yet, or add comments in the DT nodes to
clarify.

> > > +  "config": As per the definition in designware-pcie.txt
> > > +  "atu_dma": iATU and DMA register. This is where the iATU (internal=
 Address
> > > +             Translation Unit) registers of the PCIe core are made a=
vailable
> > > +             fow SW access.
> > > +  "dbi": The aperture where root port's own configuration registers =
are
> > > +         available
> > > +  "window2": This is the larger (compared to window1) aperture avail=
able above
> > > +             4GB boundary (i.e. in 64-bit space). This is typically =
used for
> > > +             mapping prefetchable/non-prefetchable BARs of endpoints
> > > +- interrupts: A list of interrupt outputs of the controller. Must co=
ntain an
> > > +  entry for each entry in the interrupt-names property.
> > > +- interrupt-names: Must include the following entries:
> > > +  "intr": The Tegra interrupt that is asserted for controller interr=
upts
> > > +  "msi": The Tegra interrupt that is asserted when an MSI is received
> > > +- bus-range: Range of bus numbers associated with this controller
> > > +- #address-cells: Address representation for root ports (must be 3)
> > > +  - cell 0 specifies the bus and device numbers of the root port:
> > > +    [23:16]: bus number
> > > +    [15:11]: device number
> > > +  - cell 1 denotes the upper 32 address bits and should be 0
> > > +  - cell 2 contains the lower 32 address bits and is used to transla=
te to the
> > > +    CPU address space
> > > +- #size-cells: Size representation for root ports (must be 2)
> > > +- ranges: Describes the translation of addresses for root ports and =
standard
> > > +  PCI regions. The entries must be 7 cells each, where the first thr=
ee cells
> > > +  correspond to the address as described for the #address-cells prop=
erty
> > > +  above, the fourth and fifth cells are for the physical CPU address=
 to
> > > +  translate to and the sixth and seventh cells are as described for =
the
> > > +  #size-cells property above.
> > > +  - Entries setup the mapping for the standard I/O, memory and
> > > +    prefetchable PCI regions. The first cell determines the type of =
region
> > > +    that is setup:
> > > +    - 0x81000000: I/O memory region
> > > +    - 0x82000000: non-prefetchable memory region
> > > +    - 0xc2000000: prefetchable memory region
> > > +  Please refer to the standard PCI bus binding document for a more d=
etailed
> > > +  explanation.
> > > +- #interrupt-cells: Size representation for interrupts (must be 1)
> > > +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping pro=
perties
> > > +  Please refer to the standard PCI bus binding document for a more d=
etailed
> > > +  explanation.
> > > +- clocks: Must contain an entry for each entry in clock-names.
> > > +  See ../clocks/clock-bindings.txt for details.
> > > +- clock-names: Must include the following entries:
> > > +  - core_clk
> > > +- resets: Must contain an entry for each entry in reset-names.
> > > +  See ../reset/reset.txt for details.
> > > +- reset-names: Must include the following entries:
> > > +  - core_apb_rst
> > > +  - core_rst
> > > +- phys: Must contain a phandle to P2U PHY for each entry in phy-name=
s.
> > > +- phy-names: Must include an entry for each active lane.
> > > +  "pcie-p2u-N": where N ranges from 0 to one less than the total num=
ber of lanes
> > > +- Controller dependent register offsets
> > > +  - nvidia,event-cntr-ctrl: EVENT_COUNTER_CONTROL reg offset
> > > +      0x168 - FPGA
> > > +      0x1a8 - C1, C2 and C3
> > > +      0x1c4 - C4
> > > +      0x1d8 - C0 and C5
> > > +  - nvidia,event-cntr-data: EVENT_COUNTER_DATA reg offset
> > > +      0x16c - FPGA
> > > +      0x1ac - C1, C2 and C3
> > > +      0x1c8 - C4
> > > +      0x1dc - C0 and C5
> > > +- nvidia,controller-id : Controller specific ID
> > > +      0x0 - C0
> > > +      0x1 - C1
> > > +      0x2 - C2
> > > +      0x3 - C3
> > > +      0x4 - C4
> > > +      0x5 - C5
> > > +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
> > > +
> > > +Optional properties:
> > > +- nvidia,max-speed: limits controllers max speed to this value.
> > > +    1 - Gen-1 (2.5 GT/s)
> > > +    2 - Gen-2 (5 GT/s)
> > > +    3 - Gen-3 (8 GT/s)
> > > +    4 - Gen-4 (16 GT/s)
> > > +- nvidia,init-speed: limits controllers init speed to this value.
> > > +    1 - Gen-1 (2. 5 GT/s)
> > > +    2 - Gen-2 (5 GT/s)
> > > +    3 - Gen-3 (8 GT/s)
> > > +    4 - Gen-4 (16 GT/s)
> >=20
> > Don't we have standard speed properties?
> Not that I'm aware of. If you come across any, please do let me know and
> I'll change these.

See Documentation/devicetree/bindings/pci/pci.txt, max-link-speed.
There's a standard of_pci_get_max_link_speed() property that reads it
=66rom device tree.

> > Why do we need 2 values?
> max-speed configures the controller to advertise the speed mentioned thro=
ugh
> this flag, whereas, init-speed gets the link up at this speed and software
> can further take the link speed to a different speed by retraining the li=
nk.
> This is to give flexibility to developers depending on the platform.

This seems to me like overcomplicating things. Couldn't we do something
like start in the slowest mode by default and then upgrade if endpoints
support higher speeds?

I'm assuming that the maximum speed is already fixed by the IP hardware
instantiation, so why would we want to limit it additionally? Similarly,
what's the use-case for setting the initial link speed to something
other than the lowest speed?

> > > +- nvidia,disable-aspm-states : controls advertisement of ASPM states
> > > +    bit-0 to '1' : disables advertisement of ASPM-L0s
> > > +    bit-1 to '1' : disables advertisement of ASPM-L1. This also disa=
bles
> > > +                 advertisement of ASPM-L1.1 and ASPM-L1.2
> > > +    bit-2 to '1' : disables advertisement of ASPM-L1.1
> > > +    bit-3 to '1' : disables advertisement of ASPM-L1.2
> >=20
> > Seems like these too should be common.
> This flag controls the advertisement of different ASPM states by root por=
t.
> Again, I'm not aware of any common method for this.

rockchip-pcie-host.txt documents an "aspm-no-l0s" property that prevents
the root complex from advertising L0s. Sounds like maybe following a
similar scheme would be best for consistency. I think we'll also want
these to be non-NVIDIA specific, so drop the "nvidia," prefix and maybe
document them in pci.txt so that they can be more broadly used.

> > > +- nvidia,disable-clock-request : gives a hint to driver that there i=
s no
> > > +    CLKREQ signal routing on board
> > > +- nvidia,update-fc-fixup : needs it to improve perf when a platform =
is designed
> > > +    in such a way that it satisfies at least one of the following co=
nditions
> > > +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed a=
nd MPS)
> > > +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link wid=
ths and
> >=20
> > What is Cx?
> Cx is the Controller with its ID.
>=20
> >=20
> > > +       a) speed is Gen-2 and MPS is 256B
> > > +       b) speed is >=3D Gen-3 with any MPS
> > > +- nvidia,cdm-check : Enables CDM checking. For more information, ref=
er Synopsis
> > > +    DesignWare Cores  PCI Express Controller Databook r4.90a Chapter=
 S.4
> > > +- nvidia,enable-power-down : Enables power down of respective contro=
ller and
> > > +    corresponding PLLs if they are not shared by any other entity
> > > +- "nvidia,pex-wake" : Add PEX_WAKE gpio number to provide wake suppo=
rt.
> > > +- "nvidia,plat-gpios" : Add gpio number that needs to be configured =
before
> > > +   system goes for enumeration. There could be platforms where enabl=
ing 3.3V and
> > > +   12V power supplies are done through GPIOs, in which case, list of=
 all such
> > > +   GPIOs can be specified through this property.
> >=20
> > These should be split out to their specific function.
> Enabling Power rails is just an example and depending on the platform, th=
ere could be
> some on-board muxes which are controlled through GPIOs and all such platf=
orm specific
> configuration can be handled through this flag.

Doing this via a "generic" GPIO binding is bound to break at some point.
What if at some point one of those muxes needs additional power, perhaps
controlled through an I2C regulator? Or if the mux requires multiple
GPIOs for the correct configuration? How do you allow the mux to be
reconfigured to one of the other options?

If all you have is a generic GPIO consumer of GPIOs there's not enough
context for the driver to do anything with these GPIOs other than
perhaps setting them to a specific value at probe time. In that case you
could achieve the same thing using a gpio-hog.

I think we need to identify what the various uses for these can be and
then find the right bindings (or come up with new ones) to properly
describe the actual hardware. Otherwise we're going to paint ourselves
into a corner.

Are there any use-cases besides regulators and muxes? For regulators we
already have fixed and GPIO regulators, and for muxes there are a number
of bindings defined in Documentation/devicetree/bindings/mux.

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyiIMgACgkQ3SOs138+
s6G4Ow//c2ouN9/TfXsOspnWYHVLNgOXbBG5o3mniAJLXQlGxXQVFS3jQK3ADjuu
xwNAa7KzyQ1GrlCuYdl62yGkCee1RoVRWCL9GluNl6H1eh+g3MXByQlcbyyp14iI
H1f37dFiW+2m+HZ5SG+sY4yGAzlMOmN4noYcBZ8NILyABayD3NnO4qiYBZhYKXBq
w4X33Lm5VcTe/GlXCURFAI6snpu7Hav2Qw7LNmsnOj8OJ2FpqQfpbD+ggFT9w3Lg
aeBJ8ceyMSGIztcM5+AGKo21p2Ai1Gg1MyFpEvR091/rjQ9wM+D0xWvb1YrBUxNo
iHd3F0jH0Z24xKEc3lByRf5nGf/ndqQhPmxJ1wbakAGhLhGlz3WDw1/Bv8mvojiy
we4oEPFey9cn4PeJRPYwH6tuUnSXGbwP0fQgAqpzXr74l+rqO4Jh4mKoyyajwuJD
+K+3EaGZNhZkRdmFAnZjb0Hi2lKDHBBFP4y0mBmHfeNnOuyvcp8B2LMIdtGLunVl
JQKMusmQD70kfhw1qX3BysQYviCKF4ibpw/H9g8fwbpw+dMHUx4TLIo7cpz/dm/f
kr6hLKbuAAeI4Po/w2MCKso4MdkSW8IQ4RR9M9QS9qUnMU3VqEO7LTrudEk8Tr89
mMEZVRH9cCZrVqIrbivxtE6iCwwJRemxyQSGJsu29G6d9BPwUic=
=RGoc
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
