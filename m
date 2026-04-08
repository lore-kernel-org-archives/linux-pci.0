Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9483D75C9
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674511; cv=pass; b=BIcCYnP6VOrtFqkprTydhAli8r6gCB0qeLNWetQwJRj5KqSCw4tYc4zj6ZKO5EJ0QPnn6oDJ7BADKWTf/A/pi9bTzndHoncD4IjGctenHoXgDM/NZVxEwasM9FTeS7H1Iact47awhIrm8fLYlbJNXqb8hDHY13H/qnV6GecKMtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674511; c=relaxed/simple;
	bh=cbHheetpVVdSiC5nwYLY9Y4ggJ90feKOZM6q3wsD+q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiXpZcHyIHwW1UOypMTAMM/bf3mzAYtvrtmtFr4i3x73a08l6NahuciSzsikhvESpGKSKLYrKzSiu5c35p0nF1A3MU0jbKnu2drQyDDlUa/3p0aNoPHvC0AYY3UfWag13T+ndm+2BrrC1aLBc2iA1VPp/3IQEBaOsR6L/qiK3DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg/Lqc6i; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg/Lqc6i"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf7683a28so32590f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2026 11:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775674508; cv=none;
        d=google.com; s=arc-20240605;
        b=d0Gp6YqErrtlwDZWgvukNhSjQ4LZq58k0QB1nW7D6urGF6MTFQwR91YMHVm8eYLYHr
         5ljn7uqqMft/eBlG3QqXtqv8vIFCnkWxcac0p10CfNhaBC/rZkZzjRmgQWRI3qvQZT++
         7mZbBNqL5f93F3MoSzh2LUfw8IwonqvhE1YuoiWwGPL+bEMPn5AD0y+cGVJlDVZNpEp6
         QdrqXvwpo03mycuJLSlg8iD0NVi4J1787KCTiu2/Vf7hxiI0grb4wkauYzUppuEZIIHW
         HxRmu0KAeRKJBbESpE/nbYuDNDSJc3nhmQ0TfQqhQaKQsN0ceLL25qDcJjKjVVrIG6ro
         pgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OmQpWX/IJfLVa4peELtc8B2oG/bwkKVLP9eXsbWoqvU=;
        fh=0yFmAklPeAA4SwaJnVg+34lBq/it7RSJDOe2oN//diY=;
        b=i+krMrV9iWBijpF+WkWcdyfmDR3TD4rlEB+/1ZkVJHy9uBr4Fehq6d2CXUZIwYa/pS
         xwxSRaDFlnZ4rSxd81tFKDkmtZGBEVYI7QqB1b3mlat9xsxX6HOwYI7Y4FNSYGES0DUi
         iVJdihmmX5AnJ1JbBzFZZQinRsuFWdnUYc0Ms8wj5Ehw+M1FPrgRDj4104l+Ji2/9Nud
         sbGUq1/5qbA5LbvcykFAR5+iqlNV+HfYtZmJhdwyBvnN3HWGcmHW4VyAD9Td1MUvrktv
         UNYJRHYT751kn8g+w8a3FzUMfGP3SYEfxjHCO6hKA9VvqaFYIiUJvhUh1c69F+5lyVbG
         ov/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674508; x=1776279308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmQpWX/IJfLVa4peELtc8B2oG/bwkKVLP9eXsbWoqvU=;
        b=Hg/Lqc6itriGWQ1KXrXBxZTpSiLYNnwnaytfZF4aNNa1RUMBr7VK+mQ757rh5ix+D6
         l6bzdURA1EfuxbO6yp7GXxeziHTUfQ9EeIU49188zCsjAy4GmQuEaStQtKHAMPP3YE5i
         6yMAUmiH6MENqEy08h/qWsMwdzN3KzudjADMunuHsebkISmaVBKjH5oF/IxjOo2aayHn
         8h3HGYWFRA/Xth5QI5/cOQBFXv47TTLxN8dXUi3KrLgN0uoZaMH4mPFOleF2RueU2G7H
         wjOqvUy/v4P+4W6Yk6AyMzAL8VOzRlIHkap8+4O/UGOY4b1jVSONsEJEzjm5RD3Td1UA
         hckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674508; x=1776279308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OmQpWX/IJfLVa4peELtc8B2oG/bwkKVLP9eXsbWoqvU=;
        b=aN8fW1cnir4LjbysUrbnCJF/O3DSKNDakQJkD19yLD1Zbu1yLQF219I11LRs2358SN
         If8hzH+16aR+swVYq74bPfSiS9I/uBRIpFZCD+qaUzS6FeytNmm6lXKQDpnYV7Yri6Wn
         rMDY/GsrwWyK1gBM64tXSRRnkwRX4VhSNa5gMqLpqJbHByp7tuKVnKnl0nxI5mxztB05
         cLTm74DwRFyiIiwKm8g92tAj9FnX767wgROZhxJ9RtSIde65ZP30MSGvDm4a7LWjcxD/
         B5SW04m6T2oBV12T8nWD8FrPmMN1NOh73qe6WWOMLZhTWBLSWYpAOt8al7aeazkFRgFI
         foPw==
X-Forwarded-Encrypted: i=1; AJvYcCX0pPVK4Q+fGsPakqP1ANCmfjaxRmXgZsbGn4xP1mdXbykBDDwHx/SaCGqp9mDdkqgtTowYFuWem9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVcKbup1m99xzvXv5zsLhI4h74oZ5wcpuw1Ance1Ks12ZKvw8
	MBu/Q9+4hjtRMINCJKIJdcN93FnfZ4BpfkSxiMQf/kBzs5Ff16SLRLpWlDdYCD5blPyyYJ3z4i8
	0zHRT/K2BA34BYHX76ri4nnytG0qbl/4=
X-Gm-Gg: AeBDies8yQCDppKHAk+nY7TXcSnH4f7ouNkbCM1RZIm4bF6WFtavw/VuHNoYzY8QzN7
	DmuQFeE2QhknMjftpIgJJ3P0lXH5ZjwPcplR8l7T5BeZV2ZqRK0b/atLwCpPAR+YK3g9iH8B/qF
	vTqy8jR4Q/SEQ7Oi4MHCaYVqgKMF+xteuTSvqHcI2NEp7dnAVUh4jHYF7ZxAyDs9JU2O9Xlhnrd
	Ji7e0SwmmtI0aBxZr5ALcR7NFEr4OmbK0lyjgrV4UHD1ua8xSkFrMU7th8IWeqMu08Mc9w4IrRE
	uiJ6AtNLAZ6razAL2gCEUDoAmSQqUHkBQe1xRiIGYLeGo+qCZflTRtUqgp2qoquSScV4/A==
X-Received: by 2002:adf:ec4c:0:b0:43d:30d1:857c with SMTP id
 ffacd0b85a97d-43d30d1859bmr20096655f8f.7.1775674507678; Wed, 08 Apr 2026
 11:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <605e8d4c-09e7-4d11-acdb-7829a85eacc3@tuxon.dev>
In-Reply-To: <605e8d4c-09e7-4d11-acdb-7829a85eacc3@tuxon.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 8 Apr 2026 19:54:41 +0100
X-Gm-Features: AQROBzDr87Qzy0mqlZSdEAmIW08-1n_rQMiTx4fUpVUhSnbJkQMQoeSIC73X2dA
Message-ID: <CA+V-a8srS9g2WDMARDJn98K=nL9v1LiZYxqM8evsVrzR-s5ZMA@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

On Wed, Mar 25, 2026 at 10:18=E2=80=AFAM Claudiu Beznea
<claudiu.beznea@tuxon.dev> wrote:
>
> Hi, Prabhakar,
>
> On 3/18/26 14:44, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add support for the RZ/V2H(P) SoC PCIe controller to the rzg3s-host
> > driver.
> >
> > The RZ/V2H(P) SoC features two independent PCIe channels that share
> > physical lanes. The hardware supports two configuration modes: single
> > x4 mode where one controller uses all four lanes, or dual x2 mode
> > where both controllers use two lanes each.
> >
> > Introduce configure_lanes() function pointer to configure the PCIe
> > lanes based on the number of channels enabled. Implement
> > rzv2h_pcie_configure_lanes() to detect the active PCIe channels at
> > boot time and program the lane mode via the system controller using
> > the new RZG3S_SYSC_FUNC_ID_LINK_MASTER function ID.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >   drivers/pci/controller/pcie-rzg3s-host.c | 142 ++++++++++++++++++++++=
+
> >   1 file changed, 142 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/con=
troller/pcie-rzg3s-host.c
> > index a629e861bbd0..d1bf1e750d9b 100644
> > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > @@ -179,6 +179,16 @@
> >   /* Timeouts experimentally determined */
> >   #define RZG3S_REQ_ISSUE_TIMEOUT_US          2500
> >
> > +/**
> > + * enum rzg3s_sysc_link_mode - PCIe link configuration modes
> > + * @RZG3S_SYSC_LINK_MODE_SINGLE_X4: Single port with x4 lanes
> > + * @RZG3S_SYSC_LINK_MODE_DUAL_X2: Dual ports with x2 lanes each
> > + */
> > +enum rzg3s_sysc_link_mode {
> > +     RZG3S_SYSC_LINK_MODE_SINGLE_X4 =3D 1,
> > +     RZG3S_SYSC_LINK_MODE_DUAL_X2 =3D 3,
> > +};
> > +
> >   /**
> >    * struct rzg3s_sysc_function - System Controller function descriptor
> >    * @offset: Register offset from the System Controller base address
> > @@ -194,12 +204,14 @@ struct rzg3s_sysc_function {
> >    * @RZG3S_SYSC_FUNC_ID_RST_RSM_B: RST_RSM_B SYSC function ID
> >    * @RZG3S_SYSC_FUNC_ID_L1_ALLOW: L1 allow SYSC function ID
> >    * @RZG3S_SYSC_FUNC_ID_MODE: Mode SYSC function ID
> > + * @RZG3S_SYSC_FUNC_ID_LINK_MASTER: Link master SYSC function ID
> >    * @RZG3S_SYSC_FUNC_ID_MAX: Max SYSC function ID
> >    */
> >   enum rzg3s_sysc_func_id {
> >       RZG3S_SYSC_FUNC_ID_RST_RSM_B,
> >       RZG3S_SYSC_FUNC_ID_L1_ALLOW,
> >       RZG3S_SYSC_FUNC_ID_MODE,
> > +     RZG3S_SYSC_FUNC_ID_LINK_MASTER,
> >       RZG3S_SYSC_FUNC_ID_MAX,
> >   };
> >
> > @@ -261,6 +273,7 @@ struct rzg3s_pcie_host;
> >    * @config_pre_init: Optional callback for SoC-specific pre-configura=
tion
> >    * @config_post_init: Callback for SoC-specific post-configuration
> >    * @config_deinit: Callback for SoC-specific de-initialization
> > + * @setup_lanes: Callback for setting up the number of lanes
> >    * @power_resets: array with the resets that need to be de-asserted a=
fter
> >    *                power-on
> >    * @cfg_resets: array with the resets that need to be de-asserted aft=
er
> > @@ -268,17 +281,20 @@ struct rzg3s_pcie_host;
> >    * @sysc_info: System Controller info for each PCIe channel
> >    * @num_power_resets: number of power resets
> >    * @num_cfg_resets: number of configuration resets
> > + * @num_channels: number of PCIe channels
> >    */
> >   struct rzg3s_pcie_soc_data {
> >       int (*init_phy)(struct rzg3s_pcie_host *host);
> >       void (*config_pre_init)(struct rzg3s_pcie_host *host);
> >       int (*config_post_init)(struct rzg3s_pcie_host *host);
> >       int (*config_deinit)(struct rzg3s_pcie_host *host);
> > +     int (*setup_lanes)(struct rzg3s_pcie_host *host);
> >       const char * const *power_resets;
> >       const char * const *cfg_resets;
> >       struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CHANNEL_ID_MAX];
> >       u8 num_power_resets;
> >       u8 num_cfg_resets;
> > +     u8 num_channels;
> >   };
> >
> >   /**
> > @@ -309,6 +325,7 @@ struct rzg3s_pcie_port {
> >    * @intx_irqs: INTx interrupts
> >    * @max_link_speed: maximum supported link speed
> >    * @channel_id: PCIe channel identifier, used for System Controller a=
ccess
> > + * @num_lanes: The number of lanes
> >    */
> >   struct rzg3s_pcie_host {
> >       void __iomem *axi;
> > @@ -325,6 +342,7 @@ struct rzg3s_pcie_host {
> >       int intx_irqs[PCI_NUM_INTX];
> >       int max_link_speed;
> >       enum rzg3s_pcie_channel_id channel_id;
> > +     u8 num_lanes;
> >   };
> >
> >   #define rzg3s_msi_to_host(_msi)     container_of(_msi, struct rzg3s_p=
cie_host, msi)
> > @@ -1155,6 +1173,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_p=
cie_host *host)
> >       rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
> >                              field_prep(mask, PCI_CLASS_BRIDGE_PCI_NORM=
AL));
> >
> > +     if (host->num_lanes) {
> > +             rzg3s_pcie_update_bits(host->pcie + RZG3S_PCI_CFG_PCIEC,
> > +                                    PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_MLW=
,
> > +                                    FIELD_PREP(PCI_EXP_LNKCAP_MLW,
> > +                                               host->num_lanes));
> > +     }
> > +
> >       /* Disable access control to the CFGU */
> >       writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> >
> > @@ -1687,6 +1712,63 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *ho=
st,
> >       return ret;
> >   }
> >
> > +static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
> > +{
> > +     struct device_node *np =3D host->dev->of_node;
> > +     u32 domain;
> > +     int ret;
> > +
> > +     if (host->data->num_channels =3D=3D 1)
> > +             return 0;
> > +
> > +     ret =3D of_property_read_u32(np, "linux,pci-domain", &domain);
>
> This introduces some limits in the systems with RZ/V2H(P) SoCs with regar=
ds to
> the usage of linux,pci-domain. I would like the PCIe maintainers take on =
this.
>
> As this is necessary to index in the system controller driver specific da=
ta (as
> there are different SYSC offsets for different PCIe controllers) I see th=
e
> following alternatives, if any:
>
> 1/ add a dedicated DT property for this, e.g. renesas,pcie-controller-id
> 2/ Add dedicated DT bindings for RZ/V2H(P) SoC that would be used to spec=
ify the
>     system controller register offset and mask for different functionalit=
ies.
>
>     E.g.:
>     renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
>     renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
>     renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
>
>     And use them in each controller DT node. E.g.:
>
>     pcie0: pcie@add1 {
>         // ...
>
>         renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
>         renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
>         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
>
>         // ...
>     };
>
>     pcie0: pcie@add1 {
>         // ...
>
>         renesas,sysc-l1-allow =3D <&sysc 0x1050 0x1>;
>         renesas,sysc-mode =3D <&sysc 0x1054 0x1>;
>         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
>
>         // ...
>     };
>
I'd like to get a clearer steer from the PCIe and DT maintainers
before investing further in either direction.

To recap the two approaches on the table:

  Option 1: A single renesas,pcie-controller-id property used to look up
            SYSC offsets in the driver.

  Option 2: Explicit per-controller DT properties carrying the SYSC
            phandle, register offset, and mask for each functionality
            (L1 allow, mode, link-master, etc.).

Both have trade-offs. Option 1 is simpler in the DT but moves hardware
knowledge into the driver, tightening the coupling. Option 2 is more
verbose but fully describes the hardware topology in the DT and avoids
a driver-internal lookup table.

Are there other approaches the maintainers would prefer that we
haven't considered?

Any guidance on the preferred direction or examples of similar solved
problems in the tree would be very appreciated.

Cheers,
Prabhakar
