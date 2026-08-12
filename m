Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1AD3A9872
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521593; cv=pass; b=cJymeRmaDQMaI8ig1DggKIZiGNPCjHRx5BKv/R70eNyMDOUlYECWVx2kSvdUWn373ThnEyIr4PndQb8KvBtWanK1HMJ12Lp67+ZlK5NfNuh+MRR4mlwyq2tsvmIDWB1wVi3e5gXVyLgazhap2eHSb149sIJstdLdoCzyWixpoHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521593; c=relaxed/simple;
	bh=M4OHjlr/xc0r4k48X0MOpzF2/uMIRWtYmbD232seXJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elOUGObF49JiQcEDTS/0UqyEhP8em05kPLtXrCs/ZqNKveCw31sqRVUXrFe2PN5T3Bl6CyKhnvYg1jvcGpKdgqiI0JegC2RVhS8vQgle1F4gFVlePsScx3KaUcLt6/JRwW2Le9o39wyKOwZ3iRn+QtO60GMAKhpmr+xp51ogb6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jfPZnw68; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfPZnw68"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b01562adbdso400488eaf.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 00:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786521590; cv=none;
        d=google.com; s=arc-20260327;
        b=OPQuD8PUz7KEo/0blPWqdLOGeAXnGnIH47f2CZxg9zKqJsqKdUjMupGWBY2jV20hvn
         e4WyljlndDMtCf+D7FQEeP5+GQyx/gpi0DTzeaeps9QAuahanUd/jb2oF0kfw5hWgDTO
         FSmoh69mA6wHeqFew90iwTCxqPN0IepyO5PgmxPmTIDGW4gLeefS/KefG6X9h5RrWgoc
         zCw9GCyqtr47tlCdLXfX5r9OnIaqQy0Zvb8ynqQbU/gLYGWLqyU2P4aw+1xZqm8jcc/I
         Tt8JEKGmW7nfOoZ0tDiWb882hx1SxKY9pE9ArdkKNN0vRcE7Bdp+EY+dchxlhcJSRMNi
         nVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M4OHjlr/xc0r4k48X0MOpzF2/uMIRWtYmbD232seXJo=;
        fh=2JR//sHzKg9BDj995s1RLycRQa7pz+VFtzjKHeAGzKI=;
        b=jT3DCUiVTkj3My/HqrTEw1qdhL78gJcPiTt2vwi84QDXypmxoqiKANDynZaCYUJwnl
         DiGUFXbpb0jGw3ptQvTTpg9VvySLme757WvN3BWCoZVFYOBvWKY68imb+WAv2xsXiM3+
         6iNkTCVKwz/p9l7yhbbzWWu+AGPPSYSEBrvtD+PmE0N18MP4j/H2RqBB/20njn1xoJ+D
         fxrrY4HZrqCFDUYnvflA3pPnSjI0aSAtG74VrDtgogVw+KApvIdV/oeL3uMtd47HIDsR
         yZBysEYIUaMpPsvIcwuXSQ+gAwNsatbfoB1Il1qMjL5tdQ16rBUVaipKQyLpuQnDBpuq
         CmXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786521590; x=1787126390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M4OHjlr/xc0r4k48X0MOpzF2/uMIRWtYmbD232seXJo=;
        b=jfPZnw68kx2sxkxXr6G+gZs2qx0E8xznN1mdTTavENrrbgBEXMfTl5Qk4ASd0gaFDE
         kCcllftVWXdo+2zCFr8aYMV2tOR4AKrlH3XI7E72l42+4N4DBjT10ps749gR16qbRTRK
         0hjRX1I4rW0wMXfSv5cDCwx4I8EBzD1Y5DkEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521590; x=1787126390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4OHjlr/xc0r4k48X0MOpzF2/uMIRWtYmbD232seXJo=;
        b=hpEzIMyU6+5DRh7xGnZXaRq2KIsE1kfYQZf5GshhP3XTK2xqdcmdS64wlkqGjhmFN1
         jKN9fP5Rx4jNvVrWCK5KRqsjSCnKwVknYdOTYJvB5RUe1mQYDMzjEdbZt06OB34G42pj
         beEJfYY3qYFsSqSTVqlxD5cDiLAzqJW79W5chllyXvNvdFVS8Y63XJgGDqf67ZN8s8Qn
         7nm77ugMmCnaR2M8Bqupj7N6brehWgvCd9eNPnSlqF/zNQVQQekufjf70xBghX35hMam
         A6CKBRPAtKf83kFmBRmTKjw0h+9iamZcYmxRG3TB1M6B7OvqKOqRjztwr5JVkwUEWqPE
         EdBA==
X-Forwarded-Encrypted: i=1; AHgh+RoUupsfA53E7MjsiphQVYppVh9a7x4/QUFIuy36ZXPg7bS5BZhyKR9u7Ifrd+2bjHoBiOZnhy8VXtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZUnxJz5liIjFCPbORAhjuCSr/BK8Ijm8GHeAS+wSXaUvIdsl
	lr7qANj867qpopkrtoHlYKkVhU4WrSRyj7lEKLqRczneWleLFPhAYZzP87z3s+u0D0pgyBqNxO+
	sHVf5YXJnsxO7vmLJpNbf/OrWAX3G4pN5O4ADJ1X1
X-Gm-Gg: AR+sD13MIyQfyJli4lt5Ef9kAo3p5qoQ6rGT/PGDm2NTkqyTDO5DAZepdiTbVsZbrXQ
	u4jUqhbBouiFgao7UHaqLYMbfg5qDW3YeA/cOC+2vBH+oylXtES+IZiALsJso2lDb8EdlAitZeT
	uRT74aWZvLPzy243SfGKO53ZquZu0N2IYA2argf7cKQCuqqkDt9DMWXO1lZU8kuTDPxjioGQRRR
	CL/Epp7vMT71tM8DtlEE9tiaGX2ZfrqS9YkW9Z0B7l/D26tC+Bi06ncifoUvWVwRlqTzcl9zWfg
	AbXJ0cUlC+nJskT3ftgPceWkKVgAmgs84L/9Hzd86TnxkP0SjaqELwGGnoQnspaZSSEBsYIR
X-Received: by 2002:a05:6820:60a:b0:6aa:f172:3094 with SMTP id
 006d021491bc7-6b0b2519ad4mr2258206eaf.10.1786521589902; Wed, 12 Aug 2026
 00:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXv+5HrDw8GWb9zp1AaQU9UW+0FGcr7jOV2jt_zi_2KgfgBqA@mail.gmail.com>
 <20260807152059.GA39821@bhelgaas> <CAGXv+5GNvV0yfX2v7E9HxvFpm0xwhGMQLjec=_xV_6YipXFcbw@mail.gmail.com>
 <CA+_ehUxa6U+0FEFuptJXQZ0kwbthYjshZftx32CmwkisAyo=+A@mail.gmail.com>
In-Reply-To: <CA+_ehUxa6U+0FEFuptJXQZ0kwbthYjshZftx32CmwkisAyo=+A@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 12 Aug 2026 15:59:38 +0800
X-Gm-Features: AUfX_mwExU67hb1lHMqkJS8Gq5qmKGn_UqJ4btHUkFbIphThQrjAQvPqvBvAUwk
Message-ID: <CAGXv+5G=XDXSeyQww_ihogpPLyv2K0ofK3Ym1W+Jdzs9h176=A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support + clock
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
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

On Mon, Aug 10, 2026 at 6:55=E2=80=AFPM Christian Marangi (Ansuel)
<ansuelsmth@gmail.com> wrote:
>
> Il giorno lun 10 ago 2026 alle ore 12:33 Chen-Yu Tsai
> <wenst@chromium.org> ha scritto:
> >
> > On Fri, Aug 7, 2026 at 11:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > >
> > > On Fri, Aug 07, 2026 at 11:24:09AM +0800, Chen-Yu Tsai wrote:
> > > > On Fri, Aug 7, 2026 at 12:53=E2=80=AFAM Christian Marangi <ansuelsm=
th@gmail.com> wrote:
> > > > > This small series introduce support for 2-lanes mode for Airoha A=
N7581
> > > >
> > > > Just a nitpick, but I would probably name this something else, like
> > > > "cross-controller lane-bonding mode" or "lane stealing"? PCIe alrea=
dy
> > > > has 2x lanes as a standard feature, so this naming is a bit confusi=
ng.
> > > > It's not like dual-LVDS display in which LVDS is only a single lane=
.
> > >
> > > I suggested the "2-lane" and "x2" terminology because I assumed the
> > > result is what the PCIe spec would describe as a "x2 Link" consisting
> > > of two Lanes.
> > >
> > > If that's not the case, maybe "cross-controller lane-bonding mode" or
> > > "lane stealing" would be more accurate, but I don't know what those
> > > mean, so if we use them I would also like to know what the result
> > > looks like in standard PCIe terms.
> >
> > Benjamin pointed out later in the thread that it is just bifurcation.
> >
>
> Yes but as me, you, Benjamin and Bjorn people who weren't there with the =
HW
> team at times the SoC was created, and given how the internal documentati=
on
> these are just assumption and observation... Everyone can be correct and =
wrong.
>
> > I would assume "PCIe bifurcation" is a standard term, so maybe we could
> > call this "Support un-bifurcated 2-lane operation"?
> >
>
> And how coming from PCIe bifurcation to un-bifurcated 2-lane operation ke=
eps
> the standard meaning?
>
> This terms is equally custom as the previous "cross-controller
> lane-bonding mode"
> and "lane stealing"
>
> I want to be honest... I'm not following why we are trying in every
> way possible to find
> a standard meaning for an highly integrated PCIe controller for a vendor =
SoC.
> It's not like there are devices shipped with PCIe slot where you can
> insert whatever
> card you want. (there is only a single RFB board but that is really to
> debug stuff and
> develop)
>
> The SoC is designed to have WiFi cards attached and only a subset of them=
.
> And some of them require 2 lanes mode to work with this special configura=
tion.
>
> Even the DT bindings are not that specific to the details... at the
> end of the day
> everything is modelled as simple as "num-lanes =3D <2>;"
>
> And that is effectively what the HW gets configured to. If then a
> robbery is done
> internally to the HW to get the second lane with probably some criminal a=
ct and
> some murder then those are just details. But unless we have a correct pol=
ice
> report on that (Documentation) we can't assume someone got shot in the
> process.
> (sorry for the joke around the stealing thing)
>
> > On the implementation side, having to reach into the second PCIe contro=
ller
> > is a bit messy :(
> >
>
> I can assure you vendor hide all kind of bad stuff behind single register=
...
> It's just Airoha that loves to expose godzillion registers and configure
> everything clearly... Something that most of the time is better than hidi=
ng
> everything behind ATF with SCM commands (or even configure stuff
> in bootloader from HW strap)
>
> A bonding solution where 2 controllers are configured and then bonded mig=
ht
> also be problematic as for 2 lanes mode the configuration needs to be don=
e
> in the same time segment. (and that would introduce lots of complexity in
> both DT and driver for the sake of just having an additional reset and
> an additional reg)
>
> Aside from these 2 point... I'm open to any kind of naming and change
> but it seems sad to me to delay this feature for these details that would
> only affect the commit description and nothing else... This is currently =
needed
> for Eagle WiFi card to correctly works... With the current code it works =
but
> sometimes it doesn't as the reset and configuration phase is not well def=
ined.
> This series fix exactly that to have stable functionality (tested on Open=
Wrt
> from at least half a year)

It was not my intention to block this. Having worked on other MediaTek
SoCs on which the PCIe gen4 controller, supported by the same driver,
can do up to 2 lanes natively, the subject of the cover letter was a bit
confusing for me.

Now that you've explained it, everything is clear.

> > > > > SoC. This is needed for correctly functionality of Eagle WiFi Car=
d
> > > > > normally attached to this SoC that require a 2-line PCIe card to
> > > > > correctly work (and give the proper performance)
> > > > >
> > > > > The first 2 patch address a limitation of the PCIe implementation
> > > > > where the PERSTOUT reset were indirectly asserted and deasserted
> > > > > all at the same time (for all the 3 PCIe card) with PCIe
> > > > > enable and disable.
> > > > > The 2 patch address this and introduce correct reset to control
> > > > > reset line for the relevant PCIe line.
> > > > >
> > > > > The last 2 patch add additional logic and support to assert
> > > > > and deassert the PERSTOUT and also apply the required configurati=
on
> > > > > for 2-lanes mode.
> > > > >
> > > > > 2-lanes mode is implemented in DT by adding the required property
> > > > > and by defining the "num-lanes" to 2.
