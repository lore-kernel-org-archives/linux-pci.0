Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2582AC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 15:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACFD21019
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 15:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFddil39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfDAPHs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:07:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42687 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfDAPHq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 11:07:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so12505807wrx.9;
        Mon, 01 Apr 2019 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1nmyqRnvojPo37RZ4JHmca6D5SpL/VeEu2Xa9WAM08=;
        b=AFddil393tLDoZWUokmfNs7nFhDVpG4/cdJ95+r24OYoz9s4uG96Fa4iFaUrP9eD83
         UPIehdsemW0tMydc20OdbAqMpUphZUgDK8tpOWtKxXy95sSSjvhbLAaaLTTWF+vpEjYe
         jyhgvqAmCrnUdNOcIdnrb605lnV40UAp34HUe6upY+JGcYu6Cgw76EV4XGxyDu/VWTMp
         tOXNV2iAOSLBzfnrYbgyS5mpuNFJTg5Vofw5L7ErURwL9Pz2uH0AwO5+Dj6xXJuJT3xu
         rbh/AwqpE0+1368tCATPx42/2hURTaUp58K/buR4WaKvUAV4Nbo5YhwxDfmKHjIR/dY+
         o+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1nmyqRnvojPo37RZ4JHmca6D5SpL/VeEu2Xa9WAM08=;
        b=DG+RrQGIVXoCptId+Pu/flpuahvepU+RoI2yxapN9VOFRUYlhYXu35AWmbK+/RK/Yl
         QYo07d3pC/+ZvTbRlUFP4rdBJ6iFZNBGlH7zSfHThYXuvBn2Dpe0IXa54k/kCYMn1nTC
         3VfGzPjGUy3wU/MX63fQi1WF0pOkTQt1ATJyq+JSbsf0UkoLYNf9AIvaXdocoeMChNQj
         yorwJVMERe4/dqGtmGscu9+Gmrb7CSx4gdQYV8sHFZlaUZmT314LOPeOWP0Us9zikOaB
         UJhxhF5Aj9hEJk3uX14Tb1zXClWfizTQPAywH10ViqeWsz/hphrxDU+XFKQLIi0Z18r1
         NQ9g==
X-Gm-Message-State: APjAAAWGHnFaMlHSNNqV/Zl7fKgwtZk4qggDnJbWkz9M/GQMnnTK43FG
        Ef7UutTADsHsArbDU9mYbUc=
X-Google-Smtp-Source: APXvYqw8Jbfi1ItBfDTsZZAWpTf14WFqVidOT15QVentD5xF4OPoU8ixZr/NHZ+kNk3WI55ulaxKhQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr38726133wru.266.1554131263179;
        Mon, 01 Apr 2019 08:07:43 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id i28sm33143160wrc.32.2019.04.01.08.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 08:07:41 -0700 (PDT)
Date:   Mon, 1 Apr 2019 17:07:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, tiwai@suse.de, spujar@nvidia.com,
        skomatineni@nvidia.com, liviu.dudau@arm.com, krzk@kernel.org,
        heiko@sntech.de, horms+renesas@verge.net.au, olof@lixom.net,
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
Message-ID: <20190401150740.GB4874@ulmo>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
 <20190328131508.GB5518@ulmo>
 <e5a12742-2dfa-e8c8-2a29-24838f4fa939@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <e5a12742-2dfa-e8c8-2a29-24838f4fa939@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 03:31:54PM +0530, Vidya Sagar wrote:
> On 3/28/2019 6:45 PM, Thierry Reding wrote:
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
> > > +  "config": As per the definition in designware-pcie.txt
> >=20
> > I see that you set this to a 256 KiB region for all controllers. Since
> > each function can have up to 4 KiB of extended configuration space, that
> > means you have space to address:
> >=20
> >      256 KiB =3D 4 KiB * 8 functions * 8 devices
> >=20
> > Each bus can have up to 32 devices (including the root port) and there
> > can be 256 busses, so I wonder how this is supposed to work. How does
> > the mapping work for configuration space? Does the controller allow
> > moving this 256 KiB window around so that more devices' configuration
> > space can be accessed?
> We are not using ECAM here instead only pick 4KB region from this 256 KB =
region
> and program iATU (internal Address Translation Unit) of PCIe with the B:D=
:F of
> the configuration space that is of interest to be able to view the respec=
tive
> config space in that 4KB space. It is a hardware requirement to reserve 2=
56KB of
> space (though we use only 4K to access configuration space of any downstr=
eam B:D:F)

Okay, sounds good. I'm wondering if we should maybe note here that
window1 needs to be a 256 KiB window if that's what the hardware
requires.

> > > +  "atu_dma": iATU and DMA register. This is where the iATU (internal=
 Address
> > > +             Translation Unit) registers of the PCIe core are made a=
vailable
> > > +             fow SW access.
> > > +  "dbi": The aperture where root port's own configuration registers =
are
> > > +         available
> >=20
> > This is slightly confusing because you already said in the description
> > of "window1" that it is used to access the configuration space of the
> > root port itself.
> >=20
> > Is the root port configuration space available via the regular
> > configuration space registers?
> Root port configuration space is hidden by default and 'dbi' property tel=
ls us
> where we would like to *view* it. For this, we use a portion of window-1 =
aperture
> and use it as 'dbi' base to *view* the config space of root port.
> Basically Window-1 and window-2 are the umbrella entries (which I added b=
ased on
> suggestion from Stephen Warren <swarren@nvidia.com> ) to give a complete =
picture of
> number of apertures available and what they are used for. The windows 1 &=
 2 as such
> are not used by the driver directly.

So I'm not exactly sure I understand how this works. Does the "dbi"
entry contain a physical address and size of the aperture that we want
to map into a subregion of "window-1"? Is this part of a region where
similar subregions exist for all of the controllers? Could the offset
into such a region be derived from the controller ID?

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
> >=20
> > It's redundant to name a clock _clk. Is this already required by the
> > standard Designware bindings or is this new?
> This is a new entry and not a standard Designware binding. I'll remove _c=
lk
> from the name in the next patch series.
>=20
> >=20
> > > +- resets: Must contain an entry for each entry in reset-names.
> > > +  See ../reset/reset.txt for details.
> > > +- reset-names: Must include the following entries:
> > > +  - core_apb_rst
> > > +  - core_rst
> >=20
> > Same comment as for clock-names.
> I'll take of it in the next patch series
>=20
> >=20
> > > +- phys: Must contain a phandle to P2U PHY for each entry in phy-name=
s.
> > > +- phy-names: Must include an entry for each active lane.
> > > +  "pcie-p2u-N": where N ranges from 0 to one less than the total num=
ber of lanes
> >=20
> > I'd leave away the "pcie-" prefix since the surrounding context already
> > makes it clear that this is for PCIe.
> I'll take of it in the next patch series
>=20
> >=20
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
> >=20
> > It's redundant to have both a controller ID and parameterized register
> > offsets based on that controller ID. I would recommend keeping the
> > controller ID and then moving the register offsets to the driver and
> > decide based on the controller ID.
> Ok. I'll take of it in the next patch series
>=20
> >=20
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
> > > +- nvidia,disable-aspm-states : controls advertisement of ASPM states
> > > +    bit-0 to '1' : disables advertisement of ASPM-L0s
> > > +    bit-1 to '1' : disables advertisement of ASPM-L1. This also disa=
bles
> > > +                 advertisement of ASPM-L1.1 and ASPM-L1.2
> > > +    bit-2 to '1' : disables advertisement of ASPM-L1.1
> > > +    bit-3 to '1' : disables advertisement of ASPM-L1.2
> >=20
> > These seem more like configuration options rather than hardware
> > description.
> Yes. Since the platforms like Jetson-Xavier based on T194 are going to go=
 in
> open market, we are providing these configuration options and hence they =
are
> optional

Under what circumstances would we want to disable certain ASPM states?
My understanding is that PCI device drivers can already disable
individual ASPM states if they don't support them, so why would we ever
want to disable advertisement of certain ASPM states?

> > > +- nvidia,disable-clock-request : gives a hint to driver that there i=
s no
> > > +    CLKREQ signal routing on board

Sounds like this could be useful for designs other than Tegra, so maybe
remove the "nvidia," prefix? The name also doesn't match the description
very well. "disable" kind of implies that we want to disable this
feature despite it being available. However, what we really want to
express here is that there's no CLKREQ signal on a design at all. So
perhaps it would be better to invert this and add a property named
"supports-clock-request" on boards where we have a CLKREQ signal.

> > > +- nvidia,update-fc-fixup : needs it to improve perf when a platform =
is designed
> > > +    in such a way that it satisfies at least one of the following co=
nditions
> > > +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed a=
nd MPS)
> > > +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link wid=
ths and
> > > +       a) speed is Gen-2 and MPS is 256B
> > > +       b) speed is >=3D Gen-3 with any MPS
> >=20
> > If we know these conditions, can we not determine that the fixup is
> > needed at runtime?
> Not really. The programming that should take place based on these flags n=
eed to
> happen before PCIe link up and if we were to find them during run time, w=
e can do
> that only after the link is up. So, to avoid this chicken and egg situati=
on, these
> are passed as DT options

Might be worth explaining what FC is in this context. Also, perhaps
explain how and why setting this would improve performance. You're also
not explicit here what the type of the property is. From the context it
sounds like it's just a boolean, but you may want to spell that out.

> > > +- nvidia,cdm-check : Enables CDM checking. For more information, ref=
er Synopsis
> > > +    DesignWare Cores  PCI Express Controller Databook r4.90a Chapter=
 S.4

If this is documented in the DesignWare documentation, why not make this
a generic property that applies to all DesignWare instantiations? Might
also be worth giving a one or two sentence description of what this is
so that people don't have to go look at the databook.

> > Why should this be configurable through device tree?
> This is a hardware feature for safety and can be enabled if required. So,=
 I made it
> as an optional feature that can be controlled through DT.
>=20
> >=20
> > > +- nvidia,enable-power-down : Enables power down of respective contro=
ller and
> > > +    corresponding PLLs if they are not shared by any other entity
> >=20
> > Wouldn't we want this to be the default? Why keep things powered up if
> > they are not needed?
> There could be platforms (automotive based), where it is not required to =
power down
> controllers and hence needed a flag to control powering down of controlle=
rs

Is it harmful to power down the controllers on such platforms? It
strikes me as odd to leave something enabled if it isn't needed,
independent of the platform.

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
> > For power supplies we usually use the regulator bindings. Are there any
> > other cases where we'd need this?
> Enabling power supplies is just one example, but there could be platforms=
 where
> programming of some GPIOs should happen (to configure muxes properly on P=
CB etc...)
> before going for enumeration. All such GPIOs can be passed through this D=
T option.

As explained in the other subthread, I think it's better to model these
properly to make sure we have the flexibility that we need. One mux may
be controlled by a GPIO, another may be connected to I2C.

> > > +- "nvidia,aspm-cmrt" : Common Mode Restore time for proper operation=
 of ASPM to
> > > +   be specified in microseconds
> > > +- "nvidia,aspm-pwr-on-t" : Power On time for proper operation of ASP=
M to be
> > > +   specified in microseconds
> > > +- "nvidia,aspm-l0s-entrance-latency" : ASPM L0s entrance latency to =
be specified
> > > +   in microseconds
> > > +
> > > +Examples:
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Tegra194:
> > > +--------
> > > +
> > > +SoC DTSI:
> > > +
> > > +	pcie@14180000 {
> > > +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> >=20
> > It doesn't seem to me like claiming compatibility with "snps,dw-pcie" is
> > correct. There's a bunch of NVIDIA- or Tegra-specific properties below
> > and code in the driver. Would this device be able to function if no
> > driver was binding against the "nvidia,tegra194-pcie" compatible string?
> > Would it work if you left that out? I don't think so, so we should also
> > not list it here.
> It is required for designware specific code to work properly. It is speci=
fied
> by ../designware-pcie.txt file

That sounds like a bug to me. Why does the driver need that? I mean the
Tegra instantiation clearly isn't going to work if the driver matches on
that compatible string, so by definition it is not compatible.

Rob, was this intentional? Seems like all other users of the DesignWare
PCIe core use the same scheme, so perhaps I'm missing something?

> > > +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
> > > +		reg =3D <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)=
      */
> > > +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (25=
6K) */
> > > +		       0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256=
K)  */
> > > +		reg-names =3D "appl", "config", "atu_dma";
> > > +
> > > +		status =3D "disabled";
> > > +
> > > +		#address-cells =3D <3>;
> > > +		#size-cells =3D <2>;
> > > +		device_type =3D "pci";
> > > +		num-lanes =3D <8>;
> > > +		linux,pci-domain =3D <0>;
> > > +
> > > +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
> > > +		clock-names =3D "core_clk";
> > > +
> > > +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> > > +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> > > +		reset-names =3D "core_apb_rst", "core_rst";
> > > +
> > > +		interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller int=
errupt */
> > > +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> > > +		interrupt-names =3D "intr", "msi";
> > > +
> > > +		#interrupt-cells =3D <1>;
> > > +		interrupt-map-mask =3D <0 0 0 0>;
> > > +		interrupt-map =3D <0 0 0 0 &gic 0 72 0x04>;
> > > +
> > > +		nvidia,bpmp =3D <&bpmp>;
> > > +
> > > +		nvidia,max-speed =3D <4>;
> > > +		nvidia,disable-aspm-states =3D <0xf>;
> > > +		nvidia,controller-id =3D <&bpmp 0x0>;
> >=20
> > Why is there a reference to the BPMP in this propert?
> Ultimately Controller-ID is passed to BPMP-FW and a BPMP handle is requir=
ed for that
> which gets derived from this BPMP phandle.

The binding doesn't say that the nvidia,controller-id is a (phandle, ID)
pair. Also, you already have the nvidia,bpmp property that contains the
phandle, although you don't describe that property in the binding above.
I think you need to either get rid of the nvidia,bpmp property or drop
the &bpmp phandle from the nvidia,controller-id property.

My preference is the latter because the controller ID is really
independent of the BPMP firmware, even if it may be used as part of a
call to the BPMP firmware.

> > > +		nvidia,aux-clk-freq =3D <0x13>;
> > > +		nvidia,preset-init =3D <0x5>;
> >=20
> > aux-clk-freq and preset-init are not defined in the binding above.
> Ok. I'll take of it in the next patch series
>=20
> >=20
> > > +		nvidia,aspm-cmrt =3D <0x3C>;
> > > +		nvidia,aspm-pwr-on-t =3D <0x14>;
> > > +		nvidia,aspm-l0s-entrance-latency =3D <0x3>;
> >=20
> > These should be in decimal notation to make them easier to deal with. I
> > don't usually read time in hexadecimal.
> Ok. I'll take of it in the next patch series
>=20
> >=20
> > > +
> > > +		bus-range =3D <0x0 0xff>;
> > > +		ranges =3D <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x0010000=
0      /* downstream I/O (1MB) */
> > > +			  0x82000000 0x0 0x38200000 0x0 0x38200000 0x0 0x01E00000      /*=
 non-prefetchable memory (30MB) */
> > > +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /*=
 prefetchable memory (16GB) */
> > > +
> > > +		nvidia,cfg-link-cap-l1sub =3D <0x1c4>;
> > > +		nvidia,cap-pl16g-status =3D <0x174>;
> > > +		nvidia,cap-pl16g-cap-off =3D <0x188>;
> > > +		nvidia,event-cntr-ctrl =3D <0x1d8>;
> > > +		nvidia,event-cntr-data =3D <0x1dc>;
> > > +		nvidia,dl-feature-cap =3D <0x30c>;
> >=20
> > These are not defined in the binding above.
> Ok. I'll take of it in the next patch series
>=20
> >=20
> > > +	};
> > > +
> > > +Board DTS:
> > > +
> > > +	pcie@14180000 {
> > > +		status =3D "okay";
> > > +
> > > +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> > > +
> > > +		phys =3D <&p2u_2>,
> > > +		       <&p2u_3>,
> > > +		       <&p2u_4>,
> > > +		       <&p2u_5>;
> > > +		phy-names =3D "pcie-p2u-0", "pcie-p2u-1", "pcie-p2u-2",
> > > +			    "pcie-p2u-3";
> > > +	};
> > > diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.t=
xt b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> >=20
> > Might be better to split this into a separate patch.
> Done.
>=20
> >=20
> > > new file mode 100644
> > > index 000000000000..cc0de8e8e8db
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> > > @@ -0,0 +1,34 @@
> > > +NVIDIA Tegra194 P2U binding
> > > +
> > > +Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NV=
IDIA High
> > > +Speed) each interfacing with 12 and 8 P2U instances respectively.
> > > +A P2U instance is a glue logic between Synopsys DesignWare Core PCIe=
 IP's PIPE
> > > +interface and PHY of HSIO/NVHS bricks. Each P2U instance represents =
one PCIe
> > > +lane.
> > > +
> > > +Required properties:
> > > +- compatible: For Tegra19x, must contain "nvidia,tegra194-phy-p2u".
> >=20
> > Isn't the "phy-" implied by "p2u"? The name of the hardware block is
> > "Tegra194 P2U", so that "phy-" seems gratuitous to me.
> Done.
>=20
> >=20
> > > +- reg: Should be the physical address space and length of respective=
 each P2U
> > > +       instance.
> > > +- reg-names: Must include the entry "base".
> >=20
> > "base" is a bad name. Each of these entries will be a "base" of the
> > given region. The name should specify what region it is the base of.
> I'll change it to "reg_base"

Each of these entries will contain a "base" address for "registers" of
some sort. I'm thinking more along the lines of "ctl" if they are
control registers for the P2U, or perhaps just "p2u" if there is no
better name.

Thierry

> > > +Required properties for PHY port node:
> > > +- #phy-cells: Defined by generic PHY bindings.  Must be 0.
> > > +
> > > +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> > > +
> > > +Example:
> > > +
> > > +hsio-p2u {
> > > +	compatible =3D "simple-bus";
> > > +	#address-cells =3D <2>;
> > > +	#size-cells =3D <2>;
> > > +	ranges;
> > > +	p2u_0: p2u@03e10000 {
> > > +		compatible =3D "nvidia,tegra194-phy-p2u";
> > > +		reg =3D <0x0 0x03e10000 0x0 0x00010000>;
> > > +		reg-names =3D "base";
> > > +
> > > +		#phy-cells =3D <0>;
> > > +	};
> > > +}
> > > --=20
> > > 2.7.4
>=20

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyiKToACgkQ3SOs138+
s6HcFg/9FDirPn81vUdGug5i5Tl/kIK05UTNWJUoMF9QgHQkR2axrwVL+2SYFag3
xxNaXN22p8ZxItZOLh1PU8rCnzukrofIvP29Kz8/nOs0eK/hppG4Pn2FtwqTbV9J
l1yVbSwwcbxU2IFXMklQ4V4wBdJ02oWiHDaxgaYX5h38XjPvHdYPF9SZXnPMYzOF
y6XkMvtXL/Moh5+Tus/f1/b47YonnRL32H5P1gsfL9FswK7I+ztBR4fPjoXYco0u
NzFQGsbX5RcdtsMATIpXN3HKDPwNp5Thuw6hYrZjwIm3g0ukGoH4KpIJUX6pqjSn
by5dVLyLMfPkbnpGB6GCPng2jrhWSruK5EXj3v3+bdVzSzGbQbUxqiARY8ge/jUh
T5jzlpHdbi11JWeOYW8m/po+/BJRcM1lbkBpdiXsT8CnZ4+s9DNFhF144WdJsbAM
Mauwo00UX13QbKQMY/9QAbGEzVZCMVysklQ4df15AJcjfN6HM9m0/7jDV239QJcS
Al9VAgHqUc8ePu+1icOa8Jik7sOrdTvI6fQgKzznH6xuH1ma1aa1k/BJk361ajSk
LETf1pteY+6GIzpTcs0QHcUI8dzVSR1K9eXBAafjwvr5Mx7lKW9PmtVmwG0WB5Es
WFxe5xMjNkCCMYqslg/AomcJSWmUffXQ4cLcbtECgr4Yif7M4LE=
=d8Nr
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
