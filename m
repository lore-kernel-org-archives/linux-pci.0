Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED03AFD1E
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358006; cv=pass; b=anQmgw+2rtHjAr2ibt+Tdlu6luy6e2tc1sJxGU1xzcISpp+R2vFm7t7O0e6uS4lbJ1SVQ2aL0MDSY/Jhtj737yZV/U4qKHRBCcRyr8kM9GQPMI3oCLFQxsXRSAN0jYWcb3OV9FPvuDnnWUUQBD9uhka6dY1noM+EK11UgrMmrPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358006; c=relaxed/simple;
	bh=zDZgGtDZA2SodhjUYL0QDlYRHGpmrmtit/UzUDZv+M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LV0JwA5TdkF2dhghbzD/t2/gojStrRnbSJ8tmF2MbGNUU/oScyCBGaIpoalVDw3RBSR2s4oORq5Ha4RbZfDZZFFV2TZXldpUi4J8DMovG4o41nR1CqGOQpIk7hhZrRRBzcOD1g3r0PGRM0p6fQB6f+KFWptzIheA2XYSjXmpb98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NHmWkar2; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NHmWkar2"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-664e3ed58bcso6159607d50.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 03:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786358004; cv=none;
        d=google.com; s=arc-20260327;
        b=bFNkJBdElFEjpGo/7bMQ+NbgZ9slqOyQXYVxKuUhjXUxGT7X82aTJvA+StaGlndzIH
         jCgKbE/ZQro8bSVo8dImt/eA4/IxKfQlnvUq4h1cQ9KUXT2Wu2BSeg8WYzQ5hEBDOiiw
         AUezF+zUxFGGaPJeUfC9WjoDVVZr+p2HogCOLeeBSuOYFfV/B8+CTpdah4taik+9Aj3n
         nCAZPTFkJaSX4Vl9s1ExJa0BmDoCc4F+3Rlryx0n8sJZ6fz0178bcCc1bX6UiAAYAJKV
         /vUE9Th5b7q3mg6zLe1rbNECL7cuJna09IsEYjQDwRcIS8H+EJW8xDJ2FVuQIYDFgky5
         mJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zDZgGtDZA2SodhjUYL0QDlYRHGpmrmtit/UzUDZv+M8=;
        fh=CbqkC8e9UWjOE2kVXaaZJzuVSGvj9WJHMza3QCt6+PU=;
        b=C7JFH/EosAt2/WDrDk2u4vczqI6CELbXSm2LPwGBhqvw8vwVsundlOz008yqK6rXQA
         Nb4q4OUoIdYqFO3Anhl2mUnmQ2jR2K/9sXiSALmKPCbkGYJLd0T/2LEU07q3ONplL3C/
         5Bbg2C4vctyXPRT/4nb0yahtT3+rgNRl9zsfLCQ7iLgbSKUqYOk0pDJLyjiEcsyGPh38
         KMrOMGaUaFEdm3tzWmCjAUOEX1pyzs9yjevwwfr2tRb5osTKpa5p0h5Ytp+Cfmq5r58D
         mLhKFCZCTNe6m6pK1WOH4DOOMz4Bcfw/4h3TvawTvwRNTnyGmZoDJT8+nGnvg2Mrq/ru
         s9NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786358004; x=1786962804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zDZgGtDZA2SodhjUYL0QDlYRHGpmrmtit/UzUDZv+M8=;
        b=NHmWkar2TDJGLoP5nF7FPqt/P5hhoYuW0myeMoLI+fAw9HSTdxpvWgXHLZ3L5ysMqa
         0yQo0zrzuvHOHm+dNQ3sCXgZiE8DHSJSO+f0ZyXENdX1LINduBo11/t7Lsb2AMxIXhZe
         PiJ7Ks7hDEptIA78yZpn8nbvZZQzMxcZmlpVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786358004; x=1786962804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zDZgGtDZA2SodhjUYL0QDlYRHGpmrmtit/UzUDZv+M8=;
        b=DmCJct6bBjUV8XNdvqHWeUZn3JedYamz78ZihwOGFMBZ1WtiAeTJbv0gq86xRpQrFv
         yxRg1cydtdmmhO/HI4DNquWZOGw8TXjQqqHUx4XTGsxG0iPSV+dNtShf+5rpyMdsWfIv
         W+Ipc105M0E/bVzut1tkRFTgUN2otjTMXoWWWo4KLjshoTWNPiRUws3FTepUCWXDIWUq
         sHRwhSy4vnR7eD3z/qv44up37r+EI+bcKwEu9DMEiXe3povH7jiyUOfjDsLy7OAScIdd
         VravCstCltDBP3YGKeL8P7kPQ/i9k3uuNmmxrwswGQpaHFwEE7xZUPqhTywfLb6OEzOc
         DZHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZQICSDo+LOab5gNcXbTp1GOX2D9RdCibPbR0VNujEPMdudp764Jyg64TlA3pfoc9aLfJVTzAUxOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3PA2ZSmphG6UWGv2MS/FEbo4oiCMxbnqbb1qrdXy25KVTrSq
	l4LHIeehGMZ8VKqz3DhxEjQeF4RaaAg1PO9mXW85RW+GFt9vY7G39kIuAxfoelJznUtmgIHAsmg
	n6bLGcYwTprrAU+DTeC1MUsLjnFYT9X3Hd4ZH7G5lDWuuVIKLrz3EYg==
X-Gm-Gg: AR+sD10U4XZW2ppF0LyBfQnP6wGKWQIDuIUbyA326YCEEmK1SpXSDzQAYqlIXqXm3aE
	Y5d+4kkUMR6Q3/WDwslQs4okxljetarEnmJ2G6q/X1PG6QQ8s/urqBYc8wUSrr0+5wECEWjCf3R
	26m4VVMZqaSrSrc+cQa2gv5SZ0dt7SKiWc68kfWQAReQRm6Evlpdb4Iv3Z+9g4qgO+5jgHGjvY2
	ijsDGF0jHSmmS5E5f+2ABzZ3avpsZOJnAC1jBYOYNlqsw4c4LkG2A0YvilITPVtg/LMwG+PjFEl
	K+09QmaEHneVtCGKgOvfnvW+/hqsXZNjzqEYwsvK8nj6BTPZOtqofRyO9pGYmDhiQdINdwG+Z7E
	=
X-Received: by 2002:a05:690e:244b:b0:667:ef7f:c37e with SMTP id
 956f58d0204a3-66ada8434d8mr7210260d50.8.1786358003849; Mon, 10 Aug 2026
 03:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXv+5HrDw8GWb9zp1AaQU9UW+0FGcr7jOV2jt_zi_2KgfgBqA@mail.gmail.com>
 <20260807152059.GA39821@bhelgaas>
In-Reply-To: <20260807152059.GA39821@bhelgaas>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 10 Aug 2026 18:33:12 +0800
X-Gm-Features: AUfX_mxe5L1RZVyMRQ0Vt-LD7TRaHThgwqJqmmrQKlLCig1wrp3paWSMXqZXYyM
Message-ID: <CAGXv+5GNvV0yfX2v7E9HxvFpm0xwhGMQLjec=_xV_6YipXFcbw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support + clock
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
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

On Fri, Aug 7, 2026 at 11:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Aug 07, 2026 at 11:24:09AM +0800, Chen-Yu Tsai wrote:
> > On Fri, Aug 7, 2026 at 12:53=E2=80=AFAM Christian Marangi <ansuelsmth@g=
mail.com> wrote:
> > > This small series introduce support for 2-lanes mode for Airoha AN758=
1
> >
> > Just a nitpick, but I would probably name this something else, like
> > "cross-controller lane-bonding mode" or "lane stealing"? PCIe already
> > has 2x lanes as a standard feature, so this naming is a bit confusing.
> > It's not like dual-LVDS display in which LVDS is only a single lane.
>
> I suggested the "2-lane" and "x2" terminology because I assumed the
> result is what the PCIe spec would describe as a "x2 Link" consisting
> of two Lanes.
>
> If that's not the case, maybe "cross-controller lane-bonding mode" or
> "lane stealing" would be more accurate, but I don't know what those
> mean, so if we use them I would also like to know what the result
> looks like in standard PCIe terms.

Benjamin pointed out later in the thread that it is just bifurcation.

I would assume "PCIe bifurcation" is a standard term, so maybe we could
call this "Support un-bifurcated 2-lane operation"?

On the implementation side, having to reach into the second PCIe controller
is a bit messy :(


ChenYu

> > > SoC. This is needed for correctly functionality of Eagle WiFi Card
> > > normally attached to this SoC that require a 2-line PCIe card to
> > > correctly work (and give the proper performance)
> > >
> > > The first 2 patch address a limitation of the PCIe implementation
> > > where the PERSTOUT reset were indirectly asserted and deasserted
> > > all at the same time (for all the 3 PCIe card) with PCIe
> > > enable and disable.
> > > The 2 patch address this and introduce correct reset to control
> > > reset line for the relevant PCIe line.
> > >
> > > The last 2 patch add additional logic and support to assert
> > > and deassert the PERSTOUT and also apply the required configuration
> > > for 2-lanes mode.
> > >
> > > 2-lanes mode is implemented in DT by adding the required property
> > > and by defining the "num-lanes" to 2.
