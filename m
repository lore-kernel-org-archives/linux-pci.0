Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C203451CC
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974885; cv=pass; b=Z7x1DQV2mqhl3BD4KRy5JD1l9L/RI42ojr0+5/Hw6hofoiiDxy7GMcvyswIsxeE4vXdp9xvwiL/E5ILh+wAHjiKQG5gueeA7pIuX6dWbECICknU8H57y5p+BAEx7N5FMVA6nQOEHlXz9N92Ibq1ouUL/4jqSdCye8kB4Po3Bo38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974885; c=relaxed/simple;
	bh=E35b9v/9N86s+jnlEC41wZVsmhcr4qcpURavxyfZD9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=us85BxNf6qD+w0WDSSm2cfPaCiEiUZXIo8N9Z7/kF7CFK7tlipI4ZZuy/A+1iLupRrGxTaG2FGQCNMzjAnMdpMU+xeIdpOkQIpSfjw6I/oQTNPcEIdqd2B9XJvZ7+j7rVTPDU27UvEDu4l9teUTnEsejfzHU7ghhAwtRbZoBQlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEHsKYha; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEHsKYha"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d146705b4so8970475e9.3
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2026 02:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777974882; cv=none;
        d=google.com; s=arc-20240605;
        b=GdG9X73j5MKejPWX/DYlDoAcZJthtPK/VKA8Ags3hY+ZALOjq8ezWOXoIk+OoJeID7
         +D//Sbxc0ufhSy5ZUpy3A9PXhUgd5N7IZs9fdoGI9uMIFB8/jXY4O1Su7f8Z4xc6rZGB
         +yxePbP84ZQG5yJXrubJCTu5387qB6plGexgWqjrwAyljsvdkJJJgp/dXHzRyFi13qqY
         dzq/gfRkb6P86ILDLrYtvgQuxc4PqzPkWoD5x2urnFg9pUnGgR0E8OgOz1axqduC/v5+
         xxpU3dCENsPnYrt+XAd0rBwk+OQBDyzZqFPMBqds/A6J7rAsjLi52q0SY3Ev+xeHEaYr
         OAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/OFVXXRgPbKb/k/EVNaXDuuccfuOclNAixih9iVgxqg=;
        fh=LGpv5ddclBSNPXd4DQXFq7X7P6V6RqNuql3pWptuVSE=;
        b=DhpP18NlfwE/p0APQi25O17LFHqDl2ppzxPSWpPkMVzFXgBKQQu9RdILFG3Bo7MUz9
         2noGfguT9eoS5Q69+DNYhJmToER0y2e8UhpdjMUsL+FkN8O6T21kSdcwZPrJrYBRMtqf
         hWhFNy0mkA7V/8NSoL3RDq9SP7wzX7jRTMk/rfwGdYcv7Kb1whHte0TcS4xpiJku5yot
         2ZdefvmtlSzOs6UbT74NQTKw0LzzeYX+9lIN+j6eZ23maor0tJlZglHj0eT9cKRrGTPm
         YG04CB5SYIg7duRwAna+3hUFRNu6ndVb6IrKF9wq48xpmbEbhJ4XBls/sJbHbwbVFlRK
         7UqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777974882; x=1778579682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OFVXXRgPbKb/k/EVNaXDuuccfuOclNAixih9iVgxqg=;
        b=ZEHsKYha81Il5yhbFlSBZdApQeIN0/u+vgCZx7aHUilChCBH9AGMZflSPaNQimVOQY
         88cYh887Jm9nWH3PzwP0UMY/M3Zecx9lmweanyrS319w6o8AZ9P7jg8acXRRyLhjClUE
         VAVuKwroK74wgcA61/JWu6dWI3R0oB8oLCzxgB+dQfSDgF4+1xbMN/bENUw8qolOCRrM
         NkmuHLsJYZMi9YtW01gRlrkREYQg+knJq/HDrP8TIcs6NirW5hxhSUMZrhsT44sl8XCa
         4noUOHrRdLp93S5/q4LpNfnphQ/icZGjITewT0u9jN0Va3It9ZLx83zIVVzS/brrQhxJ
         eShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777974882; x=1778579682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/OFVXXRgPbKb/k/EVNaXDuuccfuOclNAixih9iVgxqg=;
        b=MTgAI1xjI3azZK5fvnma2KQor+7vocnjK/OwjugirqTGe6i1EGBA3saFb/FsUoEBk/
         L85GU0fzqV+9Eymz/+ADcYGALj3hmkjSrPM/zkcxTJAq1Gs0l7CPKQ1NSmKvsbOg+q7q
         tg8uxS2vaJBt/vk48M0hcATgLVLTzxfoACdq+r1Ku9KJy65khUqwP3t4JUaZ5kAO0mVS
         ++Vqi424Vz4/t0AqiFZKrEjBr6Y8p2nQYCJkOEtFwsrquFa4691Eo+/CF5yRZRLDFyqB
         SFNhOwGMnHTjIl4WkONBQmaYCY0JJgASpT0y6UcRXNjh1MJ7rHn0MBfKW2dVsrthxAzI
         Bg8A==
X-Forwarded-Encrypted: i=1; AFNElJ/Izlp/v8ejnoLauCXz/u9w2I0ZpljR8hTeduEmUZBKOs2FJKcEf4QUkggVBwvbsghvtKWFHg8qVEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4v+Nw4TtGhiHApRvZ40C1CdSWpFuPlXD5jg7fU7MPjHo9ttIN
	Kv4wZndfZxm3kHmk0wUEVGs+mdbWoFcEY5xnneadF9oHHyDs0MqFESL9HnBtanb9p44JmPoEk06
	wuTSQETOrbAmua6wwOspiFNJytQ3rL7k=
X-Gm-Gg: AeBDievQbyESf7sHR1BNzhc/EDOYrDL209avEKjqPtEJBsjEGv2W5YIZUiz8X24sryr
	gbMsTCPCAh8/fNeVJO3hZvVBf7jWM5VB6+soaCSbNi43ycamhjOII5BpKTFVwEgKSSqgH0zKhfe
	/4GVrzgLXI6F+WoPkRCrIgGomzo3gcFI5S1L523/wHn7TJu3Jo3lGJ/sqSXZS4/PvTlz3+9b3G2
	MUqLFlrLK94Y1tuG6YFdWhqCFIS/FL4TxZloqaGza4wVac89713/d7JsZw+5Sob9rGyO0HckNCJ
	HPHBRyfLg3V8gHi1nbDT6x+v2zcHU4W/srWjj9XaL+aeQhNnZCSDquP3DqtGOdhLdBlTNern+rs
	PObbiCAblWsygnA==
X-Received: by 2002:a05:600c:8b58:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-48d18be5b32mr36270575e9.14.1777974881868; Tue, 05 May 2026
 02:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <605e8d4c-09e7-4d11-acdb-7829a85eacc3@tuxon.dev> <CA+V-a8srS9g2WDMARDJn98K=nL9v1LiZYxqM8evsVrzR-s5ZMA@mail.gmail.com>
 <CAMuHMdXRtAOZrQbebng5pLXNENUeZenA1Hng1kER+1vbSwaj0Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXRtAOZrQbebng5pLXNENUeZenA1Hng1kER+1vbSwaj0Q@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 5 May 2026 10:54:15 +0100
X-Gm-Features: AVHnY4LoB9VhkRhCHgWKDjlqC7kBQg0p7x7zE8Yn05GYW88TH9I1loXaSoAIan0
Message-ID: <CA+V-a8t2HhtMWT6v489PZbi+-Yzc0ybgYXFuPd2QeEndn-x+TQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
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

Hi Geert,

On Mon, May 4, 2026 at 10:14=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, 8 Apr 2026 at 20:55, Lad, Prabhakar <prabhakar.csengg@gmail.com> =
wrote:
> > On Wed, Mar 25, 2026 at 10:18=E2=80=AFAM Claudiu Beznea
> > <claudiu.beznea@tuxon.dev> wrote:
> > > On 3/18/26 14:44, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Add support for the RZ/V2H(P) SoC PCIe controller to the rzg3s-host
> > > > driver.
> > > >
> > > > The RZ/V2H(P) SoC features two independent PCIe channels that share
> > > > physical lanes. The hardware supports two configuration modes: sing=
le
> > > > x4 mode where one controller uses all four lanes, or dual x2 mode
> > > > where both controllers use two lanes each.
> > > >
> > > > Introduce configure_lanes() function pointer to configure the PCIe
> > > > lanes based on the number of channels enabled. Implement
> > > > rzv2h_pcie_configure_lanes() to detect the active PCIe channels at
> > > > boot time and program the lane mode via the system controller using
> > > > the new RZG3S_SYSC_FUNC_ID_LINK_MASTER function ID.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
>
> > > > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > > > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > > > @@ -1687,6 +1712,63 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host=
 *host,
> > > >       return ret;
> > > >   }
> > > >
> > > > +static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *ho=
st)
> > > > +{
> > > > +     struct device_node *np =3D host->dev->of_node;
> > > > +     u32 domain;
> > > > +     int ret;
> > > > +
> > > > +     if (host->data->num_channels =3D=3D 1)
> > > > +             return 0;
> > > > +
> > > > +     ret =3D of_property_read_u32(np, "linux,pci-domain", &domain)=
;
> > >
> > > This introduces some limits in the systems with RZ/V2H(P) SoCs with r=
egards to
> > > the usage of linux,pci-domain. I would like the PCIe maintainers take=
 on this.
> > >
> > > As this is necessary to index in the system controller driver specifi=
c data (as
> > > there are different SYSC offsets for different PCIe controllers) I se=
e the
> > > following alternatives, if any:
> > >
> > > 1/ add a dedicated DT property for this, e.g. renesas,pcie-controller=
-id
> > > 2/ Add dedicated DT bindings for RZ/V2H(P) SoC that would be used to =
specify the
> > >     system controller register offset and mask for different function=
alities.
> > >
> > >     E.g.:
> > >     renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
> > >     renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
> > >     renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> > >
> > >     And use them in each controller DT node. E.g.:
> > >
> > >     pcie0: pcie@add1 {
> > >         // ...
> > >
> > >         renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
> > >         renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
> > >         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> > >
> > >         // ...
> > >     };
> > >
> > >     pcie0: pcie@add1 {
> > >         // ...
> > >
> > >         renesas,sysc-l1-allow =3D <&sysc 0x1050 0x1>;
> > >         renesas,sysc-mode =3D <&sysc 0x1054 0x1>;
> > >         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> > >
> > >         // ...
> > >     };
> > >
> > I'd like to get a clearer steer from the PCIe and DT maintainers
> > before investing further in either direction.
> >
> > To recap the two approaches on the table:
> >
> >   Option 1: A single renesas,pcie-controller-id property used to look u=
p
> >             SYSC offsets in the driver.
> >
> >   Option 2: Explicit per-controller DT properties carrying the SYSC
> >             phandle, register offset, and mask for each functionality
> >             (L1 allow, mode, link-master, etc.).
> >
> > Both have trade-offs. Option 1 is simpler in the DT but moves hardware
> > knowledge into the driver, tightening the coupling. Option 2 is more
> > verbose but fully describes the hardware topology in the DT and avoids
> > a driver-internal lookup table.
>
> As this is SoC integration description, I think it belongs in DT.
> But adding many properties is indeed cumbersome.
> Fortunately the two register blocks inside SYSC seem to have the same
> layout for both channels, so you can just use a single property to
> refer to the base offsets (0x1000 and 0x1030).  Even if a difference
> would pop up later, you could check for e.g. =3D=3D 0x1000 in the driver.
>
Okay, something like below?

&pcie0 {
  renesas,sysc =3D <&sysc 0x1000>;
};

&pcie1 {
  renesas,sysc =3D <&sysc 0x1030>;
};

> > Are there other approaches the maintainers would prefer that we
> > haven't considered?
>
> Option 3: Look at the unit address.
>
Indeed but this might be discouraged by DT maintainers ;)

Cheers,
Prabhakar
