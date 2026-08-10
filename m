Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435D3BD22E
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359344; cv=pass; b=q4/o/QyG9L0tmtflOOqiCgUAozY/reKvFg2pUioIwtmAPzfAfN10dmxKpVnxhXE9DO3BMhJo0v+Wcp125r3iXoSZYhpnnayMZc2exAaMlHru4RE6KeShFBNm2iQhOFSf9bdbe1Zjta4UWehX0HUt/UhM+oz6g48DmuxoKZzH9CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359344; c=relaxed/simple;
	bh=whp17tHwzK4LQg7Nc9ShOMIrpcTZjYnNPpwNE+2pyaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0ul+xbjAiv5hu3hCmX+hr2UVA7C8T0o+gChu4bhLUXXpPwHlcFCxkohS3W1A3c7L3PLl63muZDOCAhmvoKsoFDTocCuS2lbBvBf5395gjh9KRk00RckMWjMt9ZJIqXh6/SJZTZmWDmjzbRQ1dhe/bk2RqwL7VGI7bMg/NfktsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qf0K5z/w; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf0K5z/w"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f186025973so15877576d6.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 03:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786359341; cv=none;
        d=google.com; s=arc-20260327;
        b=C6LFA1r6IYlMJBmVtEiHg/Qci9YwqvDXoam3FiVeG+/ZYwit4KcfEz9eswVgyCP+22
         fBBmg3dHobIPKPa/B/2xdZrk4xoDKwl5ZJcaAIusGGJVTo2pk4vg7jz5ugOGK7JTdfd1
         FcCAoQXMc20YvHhQk4qzZxLCKJpZdY2HlP0HGeCBexSebYFZwjBaN0mK5T4AsTBaDlsd
         G5WuzNfZsnvj4gH5mR3wmXAiF1CxzJwaxMrzdrKj6y32AUiJk5O4YAzjHypECTNBl7R1
         Lbx5E45p3Ukrw5m/CAoioGK+pIfFpq8tUi6VBtI8+SOn2V40VrKA95VRRKrHbKqXzOPN
         2vpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=whp17tHwzK4LQg7Nc9ShOMIrpcTZjYnNPpwNE+2pyaw=;
        fh=N6VImbXMp7ifA6WeGUCxk+btV1uQ3lYN+1XlxQs+Sks=;
        b=Hk6LGX2VQvmdpRgzGDJJTMaKCkOTjcujgtwFtQm8ySitzmdJBu1VYMuMsvsDzubLrX
         5tR5LhIXqE10MbWuQBqqiusxIzCAuyYFFmOay7mGQcyBbSfdTYmSNXjIQXAgVYNR+r4G
         vhkisKR3YPQYKJ5dnEM9sCRkC562M0C5f+QsCwUwxoF1GXSuBIXIu9/8pjVKqc8aixSf
         M/ls+5NrK4IyiXMOLo2Ov8HOVsP0Igji1J8csT7K9wLlkvQEQv0lNflTMssWMrPAZbFB
         pOM20nHRSAz8gV6Qe7QeflBqoA70upmcyYKxkDNB5nRRPPRNPKJBHybXGAxNhpkFNXFg
         sBDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786359341; x=1786964141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=whp17tHwzK4LQg7Nc9ShOMIrpcTZjYnNPpwNE+2pyaw=;
        b=qf0K5z/wmI0MGkjG9LElKPMAChuA5q8ZuxKNcWtevm/xbFl820k3gvzWEuiKjHW0IU
         CJC8jtunxe8hWmvIXsfhUEDcKb1KFbJhNCnME9LDa4WLrLEzCq+t8Xp4S4wr0OtTegaz
         DF9lUOS8pi+oQUp2RKxmNnzUnAP7KczfjQu/2FL2vqGhqAVnNzbXzOERNNKI2kw3uOp7
         JkjbQ6fgYu4Jur+oYhYmEJrupUBZnfhkKb2sDo3yY5JiTqt1QQm7bqZ2SDBJeNbOg4I5
         sw9sNu6ik/nssQ5EqyjaKmsYDj/IZrZIkEKtqrJXcPXwTMzyIiSE89Ewq9sUundTJx0j
         HfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786359341; x=1786964141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=whp17tHwzK4LQg7Nc9ShOMIrpcTZjYnNPpwNE+2pyaw=;
        b=s3GFkavtCd+DDP9DLlAEQE8rVXVsJTjybBe3gQWO1osjF/GAR4hOisU6kh+W/NPucR
         yNW7/BkqpKLs500L3pklG8Pt0eWEVl/GqEjiaVN0O0NoA5EszT2hp51iR6MXuQgnaCTA
         2D2CrhU8DTbsiabFgLREPmEtB1LhI8aySdCuUJ+W1NSZtw2kKv1pwSZTg1VMl/sFFMW/
         6XPdpXityzejdo+8fQr5f8RDkvIusR4y39lt3qI8g9E9a5CEbObw6bNks/2y8y77jN10
         sUwI5vzpvOeMzZ000w3SqcGoPuMZHaM575w8fzZbdW8Q1279agMC6l+rfItdQ03i8s3u
         W20A==
X-Forwarded-Encrypted: i=1; AHgh+RqIxtO6wJC91UXeVzzXBsXkCwdevDsP8d59jvA4nC5wvuFJgHUEYQUj3YB5bm5Py+PR/5oebrjM5Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDGDRmbO4rmOhJQz3sSnEAg6fRp/VvhMcml4NCnNoOW/XDuPa
	mISo3mDARaQtXzpK/KwHGi35Dff4AW3WeZLY/DsOCwOPNVDo5IncKQYpWlFT2EsNoYLa2Q+Pj5I
	DQQBDpOh0kfJAT3f3freh639KYHFRLkU=
X-Gm-Gg: AR+sD13avQe+9Ll6D9/tg4rZ09oU2/WfW1SuizwMApw+muvNcqZpj3iNnPZTeHrBBJX
	vpY/uVr1bVbzpNe9v3qgGMFXFB+k65V4oFzRENTFPFTldqzO3wgI2ZKT/90iIehAfJYGtGqV/3V
	ORhIs0PYirUMBJlaXoeDJQPGfkaguzyp9jzW/WoSEfwioBVtize1VGQmqsjnIPo6qtkji6k8eKL
	kdxfeVpbsCf5mCFA0/3ezsphsxghj/eR6NDbhwR87DE1CZ0p66dJ4Q9cetmY+1boP4+HCDH6IMC
	Evu0KSMACk+co5LBX4Hf48RcA2PgI8aoYc/g3Rfw9w==
X-Received: by 2002:a05:6214:2684:b0:908:9fd5:ed42 with SMTP id
 6a1803df08f44-90a34707604mr228548096d6.28.1786359341307; Mon, 10 Aug 2026
 03:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXv+5HrDw8GWb9zp1AaQU9UW+0FGcr7jOV2jt_zi_2KgfgBqA@mail.gmail.com>
 <20260807152059.GA39821@bhelgaas> <CAGXv+5GNvV0yfX2v7E9HxvFpm0xwhGMQLjec=_xV_6YipXFcbw@mail.gmail.com>
In-Reply-To: <CAGXv+5GNvV0yfX2v7E9HxvFpm0xwhGMQLjec=_xV_6YipXFcbw@mail.gmail.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Mon, 10 Aug 2026 12:55:28 +0200
X-Gm-Features: AUfX_mybRPX8_wU1Vtkqf_AyjNZAKV0N0JAhtDmUF1bKQ7p9IPinpVnjULwvpq0
Message-ID: <CA+_ehUxa6U+0FEFuptJXQZ0kwbthYjshZftx32CmwkisAyo=+A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support + clock
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il giorno lun 10 ago 2026 alle ore 12:33 Chen-Yu Tsai
<wenst@chromium.org> ha scritto:
>
> On Fri, Aug 7, 2026 at 11:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > On Fri, Aug 07, 2026 at 11:24:09AM +0800, Chen-Yu Tsai wrote:
> > > On Fri, Aug 7, 2026 at 12:53=E2=80=AFAM Christian Marangi <ansuelsmth=
@gmail.com> wrote:
> > > > This small series introduce support for 2-lanes mode for Airoha AN7=
581
> > >
> > > Just a nitpick, but I would probably name this something else, like
> > > "cross-controller lane-bonding mode" or "lane stealing"? PCIe already
> > > has 2x lanes as a standard feature, so this naming is a bit confusing=
.
> > > It's not like dual-LVDS display in which LVDS is only a single lane.
> >
> > I suggested the "2-lane" and "x2" terminology because I assumed the
> > result is what the PCIe spec would describe as a "x2 Link" consisting
> > of two Lanes.
> >
> > If that's not the case, maybe "cross-controller lane-bonding mode" or
> > "lane stealing" would be more accurate, but I don't know what those
> > mean, so if we use them I would also like to know what the result
> > looks like in standard PCIe terms.
>
> Benjamin pointed out later in the thread that it is just bifurcation.
>

Yes but as me, you, Benjamin and Bjorn people who weren't there with the HW
team at times the SoC was created, and given how the internal documentation
these are just assumption and observation... Everyone can be correct and wr=
ong.

> I would assume "PCIe bifurcation" is a standard term, so maybe we could
> call this "Support un-bifurcated 2-lane operation"?
>

And how coming from PCIe bifurcation to un-bifurcated 2-lane operation keep=
s
the standard meaning?

This terms is equally custom as the previous "cross-controller
lane-bonding mode"
and "lane stealing"

I want to be honest... I'm not following why we are trying in every
way possible to find
a standard meaning for an highly integrated PCIe controller for a vendor So=
C.
It's not like there are devices shipped with PCIe slot where you can
insert whatever
card you want. (there is only a single RFB board but that is really to
debug stuff and
develop)

The SoC is designed to have WiFi cards attached and only a subset of them.
And some of them require 2 lanes mode to work with this special configurati=
on.

Even the DT bindings are not that specific to the details... at the
end of the day
everything is modelled as simple as "num-lanes =3D <2>;"

And that is effectively what the HW gets configured to. If then a
robbery is done
internally to the HW to get the second lane with probably some criminal act=
 and
some murder then those are just details. But unless we have a correct polic=
e
report on that (Documentation) we can't assume someone got shot in the
process.
(sorry for the joke around the stealing thing)

> On the implementation side, having to reach into the second PCIe controll=
er
> is a bit messy :(
>

I can assure you vendor hide all kind of bad stuff behind single register..=
.
It's just Airoha that loves to expose godzillion registers and configure
everything clearly... Something that most of the time is better than hiding
everything behind ATF with SCM commands (or even configure stuff
in bootloader from HW strap)

A bonding solution where 2 controllers are configured and then bonded might
also be problematic as for 2 lanes mode the configuration needs to be done
in the same time segment. (and that would introduce lots of complexity in
both DT and driver for the sake of just having an additional reset and
an additional reg)

Aside from these 2 point... I'm open to any kind of naming and change
but it seems sad to me to delay this feature for these details that would
only affect the commit description and nothing else... This is currently ne=
eded
for Eagle WiFi card to correctly works... With the current code it works bu=
t
sometimes it doesn't as the reset and configuration phase is not well defin=
ed.
This series fix exactly that to have stable functionality (tested on OpenWr=
t
from at least half a year)

> > > > SoC. This is needed for correctly functionality of Eagle WiFi Card
> > > > normally attached to this SoC that require a 2-line PCIe card to
> > > > correctly work (and give the proper performance)
> > > >
> > > > The first 2 patch address a limitation of the PCIe implementation
> > > > where the PERSTOUT reset were indirectly asserted and deasserted
> > > > all at the same time (for all the 3 PCIe card) with PCIe
> > > > enable and disable.
> > > > The 2 patch address this and introduce correct reset to control
> > > > reset line for the relevant PCIe line.
> > > >
> > > > The last 2 patch add additional logic and support to assert
> > > > and deassert the PERSTOUT and also apply the required configuration
> > > > for 2-lanes mode.
> > > >
> > > > 2-lanes mode is implemented in DT by adding the required property
> > > > and by defining the "num-lanes" to 2.
