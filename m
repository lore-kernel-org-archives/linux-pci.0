Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2839B4B8
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634066; cv=pass; b=qfueRuHkyH4eXzYTLwi+Gh5UbpC48rrO6OrK922oDs2QU9ttY/VfmjbuljIDsdwygF7Hok6tte6QBqZFxKSTFvz29NdXm7dPkE4WorkQu5NgJLUGX6Pgrc4OQDYWy3qK0nXwWcrO8FVYMrqjQs8qF3lenG3fQ/obTKXxPRz+zhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634066; c=relaxed/simple;
	bh=amzQLH9a7l5X3HtjNoS0vYiDRBkqF7DhfSZuVRXwufw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwRpq+0bKuT0Oib5YuD8+EL7YoSiPHdWpvzhTc06G21uvh133R6UPpMLnpL/8yiK5lmuaagcxBmdaF3j0YhXKF9NhUpXRgRhfsBwDtkHFOPXbT7Q7/uRSshgLpQ2v6x3/j5puVhiBeBWJtGwk1pMdqrCx/0vbJqtb0E0ApBzFlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axIijkgI; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axIijkgI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891b0786beso12480905e9.1
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 04:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777634063; cv=none;
        d=google.com; s=arc-20240605;
        b=UoU2Rwf8FfMLOcWCK6+8UJA0zgf22B4PZVr9/zKVoygfYu3hOOc2YBJqnwaOfxWPZm
         VTwA0TzDCqkjk5TDU59jRkH40Q5czhka0Nr/RzKC/+0my6MPk/G3Sn5A6yJOPPm8ZbLB
         Cz3cPF9oDihPoYNARmvlol+7LpMSUoPxQviRJ0U6dmONwSsgVuF8XsOSP/lCti5XZyk7
         Wt0LdyOZY3BRV35TTQG3YlskZwEfJB5aEw9wJTzxmZ06Erxf4jtv8TA+d8oEeetn0NTU
         atgfxbxPizbWRtGCiIK2GXGxAPQMuHA3kt/9IOxiNrGSub+Vjyvt3OPEGDoMb9ePyyiE
         cr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Koqn950l1gySxE0fMmqFZj9e/r7BOpcLy/k7MMhQ7Aw=;
        fh=ytbIKZLCI5/4i1eoTIop6WSQ603ukyDsEZkIKg0lcuk=;
        b=MsMmUYiPLwkq6zQwD0l9jWnBJ2cZc4zfl68oDvQtuXN6rOyEYbCwRZKCXIQwc7q2rt
         z/uwNnvf0vMgnbxmWe6b29wQbZCmHS2HyJ8SlZZPlZABwx4OCbgjuK3YaiVtKhyr06Es
         cihD5xGwY11zG3Q1g8T29UjhlyephlZDwA1w9AzBHgVLH7O3bch+lS73iGZWR+g+BByJ
         /1Art6shqcziQte2aimNAcs+38iAZ2OUmcUBUD6+nvgchRiSmyOZcpn5qWx5Tqb5m7YK
         e7wd3Lc5tlPp64UpBOWCwFYj3C07tyzarGWj2XK5mIW8AmNd3f747IA/kni1aqv+p9KR
         DePw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777634063; x=1778238863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Koqn950l1gySxE0fMmqFZj9e/r7BOpcLy/k7MMhQ7Aw=;
        b=axIijkgI8qYh6KES+esGquTjrZh4KWxebgLpqXZcMkHYIceooGul6jafXCvWQmu9O4
         URMQQseZdbrTiXdKMFRSpMgDOUPLMtGUMSd/Ad00OSKJitCa4aMdhhmycvTwrr0iOUPf
         ne4sPP0GlQ+zr6cUU9DurnRPkqLkZDKlOnRvULy+amncVc5b+V7hrgLB83Eovy8upntI
         Ufy6TF/3bDGFoyDuDI6ZyilMK3KBIgX+ivXWLw8nSq1E5M8H7yqNTp5QZmeFUBF2UlQR
         eZn6st/5+jJLT+0UFwqREMTS1BbtgzLmTJBIppxovqE/NgI5ZR/9RJLaEiHncxM4xl8N
         Esxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634063; x=1778238863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Koqn950l1gySxE0fMmqFZj9e/r7BOpcLy/k7MMhQ7Aw=;
        b=KjTC/1xTr+8JrXdXwIu1HaVnTsphvg7YGBmpJELjgdlZxdp9Vjrgni6NjKBem4SlNv
         UselHLZdYY8ceHVh8fi2qesyebCPVpaJhslOeJjQvCGxkmgp9QmlUgi7IimDl9tfhHfd
         B9+UOgHKkZZ61pMFzqZyV/V6FNQSVn6x5AU7jsdBkv7cGxVglTt62nrTvR7N5vTods7D
         hWQmjozbYDHOxGp4Qul+yLTkFstIhjnFRBxDwMGlPV2Qio6czURWta5rTtGj3RMC7TD/
         E5+wm/ZrXMYqTovcvqKLt+x49QXRlE3Hxs+jfWScMImztBUvd0f+GHNDNotIYWw8gxrk
         pjxA==
X-Forwarded-Encrypted: i=1; AFNElJ/8F9ymA+ze0F91f0CAqZZ+CkSQNB6WMZratlpK4W/x5t1Wii2djxsxHNJM9ktwy0VVEuHYZxwN9Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidrGCYGG5NUJh8ybG3UCyBejc20ekRqH70hFZRq8wJ5SSHi5V
	UEUJjmLcATLcRvgpXDzWxB9uYkAK8GHXnD4iSFG/kBu3YjMfkJlkdFJ8McI7DhUk/jl4SVqY3NL
	fMm21YDwOVGZe6T9fRhEnAyJ0nxrJ7+c=
X-Gm-Gg: AeBDietkIMyNxa9RMF9MfOILqf8moe9/ovtgpefuWoxKpKun36UNpBhdD4iM4oS22iF
	WtcLcjyrSpN9mev8UJhOhWrlQ9ZAFyOjZj895aVZ8M7iT3gxWojW6abVG4qTmK6sgkwAjMbfk8D
	Wdyis5eGRDdWP5IZBXDmUXiHfRObppjDg4eKON3IQgCcF0vVuC3EQ0o7NOaH/eQYEtvXcRPWGof
	tejJ4zaF4pJGXCEynfuEzUusf45x5gWpN6o5QYt2+m00Rv6Tdg1lUXYpKVjpshHjhXm8l3Lv1pk
	NzbZMtS+GtVSI8+L3N9Zi5QZkFvlDKAJKNUCjD5Hpyay07Z/8JCRqviz2lBk6RWF9XmhmYfQGdB
	bRyPN
X-Received: by 2002:a05:6000:1445:b0:43d:309b:9c4f with SMTP id
 ffacd0b85a97d-4493cb42dfbmr12335940f8f.6.1777634062788; Fri, 01 May 2026
 04:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <605e8d4c-09e7-4d11-acdb-7829a85eacc3@tuxon.dev> <CA+V-a8srS9g2WDMARDJn98K=nL9v1LiZYxqM8evsVrzR-s5ZMA@mail.gmail.com>
 <lvix7p4e7c4dtchtdti3rwrs7jkda5iy7lthcffhqc7g6vgu2p@54qywklrspi7>
In-Reply-To: <lvix7p4e7c4dtchtdti3rwrs7jkda5iy7lthcffhqc7g6vgu2p@54qywklrspi7>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 1 May 2026 12:13:55 +0100
X-Gm-Features: AVHnY4JvYGy7lDhdnr1gOrUfRCtB0xtova51_6-0ql6JWYIskMQxloPDeXCK7c4
Message-ID: <CA+V-a8sd=dyTZmViLbDrCPYbx5ujWzjk74HxhP0aBEqxLuEqJA@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Bjorn Helgaas <bhelgaas@google.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Thu, Apr 30, 2026 at 4:26=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Apr 08, 2026 at 07:54:41PM +0100, Lad, Prabhakar wrote:
> > Hi All,
> >
> > On Wed, Mar 25, 2026 at 10:18=E2=80=AFAM Claudiu Beznea
> > <claudiu.beznea@tuxon.dev> wrote:
> > >
> > > Hi, Prabhakar,
> > >
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
> > > > ---
> > > >   drivers/pci/controller/pcie-rzg3s-host.c | 142 ++++++++++++++++++=
+++++
> > > >   1 file changed, 142 insertions(+)
> > > >
<snip>
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
>
> Can you explain what is the limitation with 'linux,pci-domain' property?
>
As sashiko pointed out.dev, The linux,pci-domain property is generally
an OS-specific logical property intended to assign a stable PCI domain
number across reboots. Restricting it to [0, 1] would prevent system
integrators from using non-conflicting domain numbers like 2 or 3 if
the board incorporates other PCIe controllers.

> >   Option 2: Explicit per-controller DT properties carrying the SYSC
> >             phandle, register offset, and mask for each functionality
> >             (L1 allow, mode, link-master, etc.).
> >
>
> Are the register offsets going to stay the same across controller instanc=
es?
>
> If they are not going to change and you can derive the offsets using the
> controller index, then there is no need to go for individual DT propertie=
s.
>
The offsets will remain the same across the controller instances. So
instead of using linux,pci-domain property we could use below is that
OK?

pcie0 {
  renesas,sysc =3D <&sysc 0>;
};

pcie1 {
  renesas,sysc =3D <&sysc 1>;
};

Where 0/1 are the controller instance IDs that the driver will use to
derive the correct offsets.

Cheers,
Prabhakar
