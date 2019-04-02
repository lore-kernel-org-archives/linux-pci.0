Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B9C4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA7420882
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzfOVQyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfDBOgD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:36:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39953 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfDBOgD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 10:36:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so16947718wre.7;
        Tue, 02 Apr 2019 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JxDv0woxBYIfgDgYV+Ct6AnycGf6dYHHpUdke4SoZNA=;
        b=SzfOVQygPb9NV/nXXEsKXz3trMEIE7NRHndSPsBBF//2AuBOxH2dQq5aWGJIPkJjeO
         xXGdTASfFQ4abwacg/d+rrraDfek4/lsX8KbjpIyqXz//qwomSv/xLIudOmxdZCcP5vN
         fwcVFTIhgyY9OTFaJwyWKpCEi787NYnatfc0IQ3kFP1VTZmXfRd1N+5Ef3PBvwmuBBP7
         5SMcuvMgh+DfVdmYUQHSFQ7ExJb12vaclJW6M+SU4o3qIOOOovfw9suegcGfTAzQfbT1
         Cwo8Wg7/BJchGgn/tgNu65MAkTfLBx969zMCoSPvK/AFGS0GjFzJmtgbNt8yX9uySKsG
         ll9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JxDv0woxBYIfgDgYV+Ct6AnycGf6dYHHpUdke4SoZNA=;
        b=cfnZbDz+7/SRRW6Tx8Pa0hSgsULpSCnO/gfAI9qANNmPI7AhwZcYduTqmUgQKTaNpL
         cbRRXHojlrewo9izaG3gHfsL4IgB+mpQ1EM0i0eQComi+K3cAZHEQhM3rO5mwbfLxBbK
         R5L+PF9C5H8CMrlQM+VygmDzHSqcNyUSwhJQPMaYFIoO0oeNDg0HENiIDpAzLx6cEB9J
         Os3bxx52M7+6DpWKaZcz6bFz1yIR88uXsr+lBAYo4EcsGHNcUz85WsKlxcaiW8Y9xY2L
         SGISPwXacoo4M5dd0vQtLS8jzRQ/gAcKDppScHVqjVkkR6MWm2IdjE/ize92qt8JEvY0
         AL+w==
X-Gm-Message-State: APjAAAVDnWlPiIvUwZx5RHN/xRBWYypz/qqysmnywkMmFzlgi6KKnPjl
        Wm45AU9ZU6WKdJ7L/RyPNT8=
X-Google-Smtp-Source: APXvYqza3KqxR+5GHYrOVuklP/9ivNN6rVHM6RKuElhkhZwqFS7EfhG877xW3oxf0ceYaIvZwQpHmA==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr40686104wrv.163.1554215760166;
        Tue, 02 Apr 2019 07:36:00 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id o17sm14521001wrw.73.2019.04.02.07.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 07:35:59 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:35:58 +0200
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
Message-ID: <20190402143558.GD8017@ulmo>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
 <20190328131508.GB5518@ulmo>
 <e5a12742-2dfa-e8c8-2a29-24838f4fa939@nvidia.com>
 <20190401150740.GB4874@ulmo>
 <c3190fbe-d197-a810-6bd4-d53c6e375bc5@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <c3190fbe-d197-a810-6bd4-d53c6e375bc5@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 05:11:25PM +0530, Vidya Sagar wrote:
> On 4/1/2019 8:37 PM, Thierry Reding wrote:
> > On Mon, Apr 01, 2019 at 03:31:54PM +0530, Vidya Sagar wrote:
> > > On 3/28/2019 6:45 PM, Thierry Reding wrote:
> > > > On Tue, Mar 26, 2019 at 08:43:22PM +0530, Vidya Sagar wrote:
> > > > > Add support for Tegra194 PCIe controllers. These controllers are =
based
> > > > > on Synopsys DesignWare core IP.
> > > > >=20
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > ---
> > > > >    .../bindings/pci/nvidia,tegra194-pcie.txt          | 209 +++++=
++++++++++++++++
> > > > >    .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |  34 ++++
> > > > >    2 files changed, 243 insertions(+)
> > > > >    create mode 100644 Documentation/devicetree/bindings/pci/nvidi=
a,tegra194-pcie.txt
> > > > >    create mode 100644 Documentation/devicetree/bindings/phy/phy-t=
egra194-p2u.txt
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra19=
4-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> > > > > new file mode 100644
> > > > > index 000000000000..31527283a0cd
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.=
txt
> > > > > @@ -0,0 +1,209 @@
> > > > > +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
> > > > > +
> > > > > +This PCIe host controller is based on the Synopsis Designware PC=
Ie IP
> > > > > +and thus inherits all the common properties defined in designwar=
e-pcie.txt.
> > > > > +
> > > > > +Required properties:
> > > > > +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> > > > > +- device_type: Must be "pci"
> > > > > +- reg: A list of physical base address and length for each set o=
f controller
> > > > > +  registers. Must contain an entry for each entry in the reg-nam=
es property.
> > > > > +- reg-names: Must include the following entries:
> > > > > +  "appl": Controller's application logic registers
> > > > > +  "window1": This is the aperture of controller available under =
4GB boundary
> > > > > +             (i.e. within 32-bit space). This aperture is typica=
lly used for
> > > > > +             accessing config space of root port itself and also=
 the connected
> > > > > +             endpoints (by appropriately programming internal Ad=
dress
> > > > > +             Translation Unit's (iATU) out bound region) and als=
o to map
> > > > > +             prefetchable/non-prefetchable BARs.
> > > > > +  "config": As per the definition in designware-pcie.txt
> > > >=20
> > > > I see that you set this to a 256 KiB region for all controllers. Si=
nce
> > > > each function can have up to 4 KiB of extended configuration space,=
 that
> > > > means you have space to address:
> > > >=20
> > > >       256 KiB =3D 4 KiB * 8 functions * 8 devices
> > > >=20
> > > > Each bus can have up to 32 devices (including the root port) and th=
ere
> > > > can be 256 busses, so I wonder how this is supposed to work. How do=
es
> > > > the mapping work for configuration space? Does the controller allow
> > > > moving this 256 KiB window around so that more devices' configurati=
on
> > > > space can be accessed?
> > > We are not using ECAM here instead only pick 4KB region from this 256=
 KB region
> > > and program iATU (internal Address Translation Unit) of PCIe with the=
 B:D:F of
> > > the configuration space that is of interest to be able to view the re=
spective
> > > config space in that 4KB space. It is a hardware requirement to reser=
ve 256KB of
> > > space (though we use only 4K to access configuration space of any dow=
nstream B:D:F)
> >=20
> > Okay, sounds good. I'm wondering if we should maybe note here that
> > window1 needs to be a 256 KiB window if that's what the hardware
> > requires.
> I'll be removing window1 and window2 as they seem to cause unnecessary co=
nfusion
>=20
> >=20
> > > > > +  "atu_dma": iATU and DMA register. This is where the iATU (inte=
rnal Address
> > > > > +             Translation Unit) registers of the PCIe core are ma=
de available
> > > > > +             fow SW access.
> > > > > +  "dbi": The aperture where root port's own configuration regist=
ers are
> > > > > +         available
> > > >=20
> > > > This is slightly confusing because you already said in the descript=
ion
> > > > of "window1" that it is used to access the configuration space of t=
he
> > > > root port itself.
> > > >=20
> > > > Is the root port configuration space available via the regular
> > > > configuration space registers?
> > > Root port configuration space is hidden by default and 'dbi' property=
 tells us
> > > where we would like to *view* it. For this, we use a portion of windo=
w-1 aperture
> > > and use it as 'dbi' base to *view* the config space of root port.
> > > Basically Window-1 and window-2 are the umbrella entries (which I add=
ed based on
> > > suggestion from Stephen Warren <swarren@nvidia.com> ) to give a compl=
ete picture of
> > > number of apertures available and what they are used for. The windows=
 1 & 2 as such
> > > are not used by the driver directly.
> >=20
> > So I'm not exactly sure I understand how this works. Does the "dbi"
> > entry contain a physical address and size of the aperture that we want
> > to map into a subregion of "window-1"? Is this part of a region where
> > similar subregions exist for all of the controllers? Could the offset
> > into such a region be derived from the controller ID?
> DBI region is not available for SW immediately after power on. Address wh=
ere we would
> like to see 'dbi' needs to be programmed in one of the APPL registers. Si=
nce window1
> is one of the apertures (under 4GB boundary) available for each controlle=
r (one window1
> aperture per controller), we are reserving some portion of window1 to vie=
w DBI registers.
> Provided 'window1' is available in DT, 'dbi' can be derived run time also=
=2E I added it
> explicitly to so give more clarity on where it is being reserved (just li=
ke how window2
> aperture usage is explicitly mentioned through 'ranges'). If the correct =
approach
> is to have only 'window1' and derive 'dbi' in the code, I'll change it to=
 that way.
> Please let me know.

If there are no other requirements other than being in window1, then I
think it's fine to drop "dbi" here. From what you say elsewhere the
window1 aperture is 256 KiB and we can partition it as we like, right?
If so, I don't think there's a need to expose it in a more fine-grained
way.

One exception may be if other values in DT depend on the value. In that
case it would be good to have them all in DT so that they can be
validated.

Having this information in two places technically would require us to
check that the data is consistent. If we allocate from window1 at
runtime, things become much easier.

[...]
> > > > > +- vddio-pex-ctl-supply: Regulator supply for PCIe side band sign=
als
> > > > > +
> > > > > +Optional properties:
> > > > > +- nvidia,max-speed: limits controllers max speed to this value.
> > > > > +    1 - Gen-1 (2.5 GT/s)
> > > > > +    2 - Gen-2 (5 GT/s)
> > > > > +    3 - Gen-3 (8 GT/s)
> > > > > +    4 - Gen-4 (16 GT/s)
> > > > > +- nvidia,init-speed: limits controllers init speed to this value.
> > > > > +    1 - Gen-1 (2. 5 GT/s)
> > > > > +    2 - Gen-2 (5 GT/s)
> > > > > +    3 - Gen-3 (8 GT/s)
> > > > > +    4 - Gen-4 (16 GT/s)
> > > > > +- nvidia,disable-aspm-states : controls advertisement of ASPM st=
ates
> > > > > +    bit-0 to '1' : disables advertisement of ASPM-L0s
> > > > > +    bit-1 to '1' : disables advertisement of ASPM-L1. This also =
disables
> > > > > +                 advertisement of ASPM-L1.1 and ASPM-L1.2
> > > > > +    bit-2 to '1' : disables advertisement of ASPM-L1.1
> > > > > +    bit-3 to '1' : disables advertisement of ASPM-L1.2
> > > >=20
> > > > These seem more like configuration options rather than hardware
> > > > description.
> > > Yes. Since the platforms like Jetson-Xavier based on T194 are going t=
o go in
> > > open market, we are providing these configuration options and hence t=
hey are
> > > optional
> >=20
> > Under what circumstances would we want to disable certain ASPM states?
> > My understanding is that PCI device drivers can already disable
> > individual ASPM states if they don't support them, so why would we ever
> > want to disable advertisement of certain ASPM states?
> Well, this is given to give more flexibility while debugging and given th=
at there is going
> to be only one config for different platforms in future, it may be possib=
le to have ASPM
> config enabled by default and having this DT option would give more contr=
olled enablement
> of ASPM states by controlling the advertisement of ASPM states by root po=
rt.

Again, I think if this is primarily for debugging purposes I think there
are better ways. If you need to modify and reflash the DTB in order to
debug, that's suboptimal. Ideally you'd want something that you can just
enable at runtime (via a module parameter, or a kernel command-line
option, for example). That will allow you to do some debugging without
having to rebuild and reflash.

> > > > > +- nvidia,enable-power-down : Enables power down of respective co=
ntroller and
> > > > > +    corresponding PLLs if they are not shared by any other entity
> > > >=20
> > > > Wouldn't we want this to be the default? Why keep things powered up=
 if
> > > > they are not needed?
> > > There could be platforms (automotive based), where it is not required=
 to power down
> > > controllers and hence needed a flag to control powering down of contr=
ollers
> >=20
> > Is it harmful to power down the controllers on such platforms? It
> > strikes me as odd to leave something enabled if it isn't needed,
> > independent of the platform.
> It is not harmful as such. This is just a flexibility. Also, this might b=
e required for
> hot-plug feature.
> Are you saying that we should have controller getting powered down as def=
ault and a flag
> to stop that happening? i.e. something like 'nvidia,disable-power-down' ?

Yeah, I think by default we should always power down hardware if it
isn't needed. But I don't see why we would need to disable power down.
What's the use-case? You say this "might be required for hotplug", so
it sounds like this is not something that has currently been tested? I
prefer not to have bindings that are based on guesses, because that is
likely to result in bindings that don't actually meet the real
requirements and that becomes nasty to maintain in the long run. So if
we don't currently have a case where we need to keep the controller
powered on, let's just disable them by default and drop this from the
bindings. We can always add this back in a backwards-compatible manner
if it turns out that we do need it. At that point we'll also have more
data about the context, so we can design better bindings.

> > > > > +Tegra194:
> > > > > +--------
> > > > > +
> > > > > +SoC DTSI:
> > > > > +
> > > > > +	pcie@14180000 {
> > > > > +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> > > >=20
> > > > It doesn't seem to me like claiming compatibility with "snps,dw-pci=
e" is
> > > > correct. There's a bunch of NVIDIA- or Tegra-specific properties be=
low
> > > > and code in the driver. Would this device be able to function if no
> > > > driver was binding against the "nvidia,tegra194-pcie" compatible st=
ring?
> > > > Would it work if you left that out? I don't think so, so we should =
also
> > > > not list it here.
> > > It is required for designware specific code to work properly. It is s=
pecified
> > > by ../designware-pcie.txt file
> >=20
> > That sounds like a bug to me. Why does the driver need that? I mean the
> > Tegra instantiation clearly isn't going to work if the driver matches on
> > that compatible string, so by definition it is not compatible.
> >=20
> > Rob, was this intentional? Seems like all other users of the DesignWare
> > PCIe core use the same scheme, so perhaps I'm missing something?
> This is the standard usage procedure across all Designware based implemen=
tations.
> Probably Rob can give more info on this.

If everyone does this, I suppose it's fine. Maybe Rob can confirm that
this is really the way it was meant to be, or whether we should take
action now before propagating this any further.

Thierry

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyjc0sACgkQ3SOs138+
s6FIdg//cMAkMaPne37Cxe0/scyORcpF2gHlhneRFFXb8fuDxwLY2DeTFXdF5NJc
bjcsDzSkqqKZFXz4tKWiEO8Ow6Y29hdNrhNJLuLMOG33hg+zD5qMi5s18JtYVytt
j6eCpZAls7+YoLx6B3J9L73ZxzzhOZRJGK2vfP+yxyN9CRZm873bqiaYEF2mudOk
b5YLcBHj1W1VmhUqqexMgHVZ3cRPJZKG9n/jIBSQXstjnIgD+wf9luT7DhlM5K6h
3/ctasTq46uP3uYHCxkI4gRMUxzLj2hRO/fA6tsXtS8kSAiQXLyGbX0gMVioaPPH
BLKGBv2ABAT52jwjfCZrLi1hR2HEPRcwSkaR94MW2Wy345AVP52zQAscClqwdURH
/hC5IxvyX+avPmpxK7FZJvSpsEQQh9bUCz7pZ1Thlm9Pd+8O3vC/w4yZRO1ys5wi
6ssmTnO7ulTmTxvPBbK3Z9IkNShIMWXQgz1XXEsjsGb0WvGXJcf2fCSVjDpLAhCS
gb7yGat8HVOPiMtYbAaR+T+TtnTLvVn4yi0ePNVYfHN0jeyYx1Kc7w3CP/oeAJF4
H4uDy5ykjRX6ztrhjNb19UgvtiFSarSuCy7l/2a9WJuvlg7YlpkMV2R/JNXgqsw9
gX4PLjF5ko04u9gw6Z1GOXhKGXadEnO1zzNTbO4b+qEfbUZCOoM=
=osYe
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
