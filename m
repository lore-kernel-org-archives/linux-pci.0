Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C913D8127
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746363; cv=pass; b=sYM9mN0ic/ACXr5qYXXRZCQD6NQ736Xeje2/iASo7BWOr8Hj6qi0FcFDOR1iw2GyFP/HvdH+apnnulNBVgUwOUoDac6xJKH2Q1U3FLGT2zulfgrRGmxL4aGg4j3YzUP4eGmNUx9p9sfdvQ878z+rlTvrCyxCn4x6Uo9P8jEbmn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746363; c=relaxed/simple;
	bh=oHbtBEkbphFQUW5rUMf/hP/W7ZvDzmG6TKzaeOsCIxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5BaqqhrFjll4sVg+04Epe0yIXQ7XNd67/qP1yMwXb57SK2vw4WigfNkQ7JRRaE6q/iXnFTlgMxmanHKak+H/+M6oDyPwiFlApc5sPXI/gZPo+vPTrDrwaVvDeOTtRP2RyZXYnUEPfSqktZuT3MQMeusydYW9Dm+UsdblwoOWcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mPoipTW2; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPoipTW2"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so6742906e87.3
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 01:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778746360; cv=none;
        d=google.com; s=arc-20240605;
        b=NTrlysyDk9v23ZSLicAeJmbKSHzdD8r2up5tz7WuJwvroPRctR4fS+JpMkxz52HKYN
         zl9O07+eO/od0eDI+EM+/9Wjvf77dC5+LrmnuDFFtebFm3ZIOODxKEILO5ShX3HrAvND
         x+SZ6hTVabpHsDBKwL8uwEMgTfx1cdSmrQumydqr2rre7Y18ZRSOTj0Of81ODuWpqh7G
         p5xdOWv9GODRVZS0LGq4MY/iLKVcoj14+83zXpXSKMOieJfDdNGT4feSizcAH1hmzBOE
         N6sbtE9fz5n7hQC8TPmdRprKGAGZkXttag2cAOj0SIH8jTkL790jbCrf/n6nDTMJOmWg
         A5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mfi3vmziZCkgZK4Pj66Mr9HPjc3VrKkwC6hLHO+X+Ns=;
        fh=jDNwL6cPhfTisUwmi2u74GpED8DmSUAkXsFLNZX0W/0=;
        b=SZGVMFGg5DP6WcaimESBBFtQSt3OUIcfkRoQWRncUfBvI9LTXHXotu0rhYNS1U5EZI
         gyExZYYd6iCwLP2fvRVGv7F1SyBg0ncOSJH2CnKvHkJwZryJG1Dj8XrUxMflxq2JGdv4
         nkTYDxL+UzVdcjFzIGu5/I9rOuoRt/w/MVjXZtuD0689l2eRXRmMCWFB+ZH5qrHflFGT
         Upnj40lAh2YA8r/5D6ixV6b3YsOIXjBXgVn6zHq9NIyL6VhHnE3SQXJXdzsW2d0A08U/
         hwIMO/Z6dVmh8bX8tTy2CYA1/s1uSuVR4u0FSHerbOtnx/TuQ1ZDceSpMjcM6ugVRKDO
         +MXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778746360; x=1779351160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mfi3vmziZCkgZK4Pj66Mr9HPjc3VrKkwC6hLHO+X+Ns=;
        b=mPoipTW2Vfl3UjoZ+E+GFWAwG0OvRL0NPi+dibxCCfHyhpfU62UhPsDSD1w/a8ZvHl
         wz50LII6c+JvEpiP1yTq2JwqilciYMCX7RI1p1Oq3h5AmYoGe3BKtFoPR5vsT4d22/bm
         VuGQFFzPVqZWkg7i5aPTZQLO91Vd6D13jvOsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778746360; x=1779351160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mfi3vmziZCkgZK4Pj66Mr9HPjc3VrKkwC6hLHO+X+Ns=;
        b=KyQqrPPcUPk1TYmYm22T8PBMTqa3mu7Py4BC9/FQd9idjL4QtU5iifnjVKeHTbdD1O
         Na1lj+VM2Ofj/5ypBNr2Vismo/WhRXbc/aWt/k2YCBiNdXGb+TMc9RIe35paV2VR3M9x
         DVheeGvpSdO5WqcpbKuePscXU3hG5K3W+6piwHcWTlmrt2hwbjK8sfNyCGW4zvgC0ZeJ
         RB+D22LZByF0HmMQZy5DCPTFtPtC9k1DChaOFslPDHg8CC5M/DQK4WKkFpqI5zr+u9gw
         VG6aVJiNCRs9OCIfazioRiny0FjCb8I5tmZJwnSpDxyP7jtlIB4SDNRKpudU856tlYAO
         ezNA==
X-Forwarded-Encrypted: i=1; AFNElJ8NjvlaqbpvyZzggDVWH1ttLc//Xa4cz5bqlRBMNHtQFQZ06LBQgBdZiwDPvzGMQ6bvKc+x/nkZasg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6XLt8j8bJdVqtNALXiu9Tm7YbiPkLMapjTqak9TtwOkpGCNz
	meQ7pFejSPAmrY8BRi2gpWegvorAdlhstXw5wd+JSzmzPJKwsHS7lDWH/UEwoZRMw0Hq4NqZkV9
	FZrEGEnGcEjfEcqpKb2SDkqmTyil+VudNFS4rsCZG
X-Gm-Gg: Acq92OGW+jYSrvNvWpqu3Vdx3Uec1EJ6Ok/XtSQBZFsh4IFQTLLfIiKnxsdMAAuCUK/
	E2+R1mHZQaTSbYATwUilnqbdKRTWYWn44PDL2YSdyzv5bBsz+zGo7cUUOj5ByBfjdbqUABe1Xb6
	YF4N05F8Q5dt0JUuP/l0SRKhc0GS+jaDXXqTxRMOOBQyof3Jw6vceSaYVbrtn5pMb8tL4icHD7U
	vlWgipY0HrnjJifX8c7vPPNgy+OGEogKjPzMo5JDwYTSkU00iONSl0eBDN1/L8fl0Ch0Kcivb1h
	MBv7XAMdgkq7MaHWvq3MWNpAHDS61ctR9EDk4EgiS9mARsvc
X-Received: by 2002:a05:6512:2309:b0:5a7:42e2:db4 with SMTP id
 2adb3069b0e04-5a8f37c58abmr1953278e87.15.1778746359826; Thu, 14 May 2026
 01:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508063633.3894348-1-wenst@chromium.org> <20260513231550.GA2280946-robh@kernel.org>
In-Reply-To: <20260513231550.GA2280946-robh@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 14 May 2026 16:12:28 +0800
X-Gm-Features: AVHnY4KRPKUvW-Q_3NPzMqxJlma4P7nPyfNutA30R4nWp-TJgNSuE21IDg-csC8
Message-ID: <CAGXv+5EXw4rXD7URhXvotxsPG81EGhhk6wqnFuVWig=dTdNCXA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
To: Rob Herring <robh@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 7:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> > On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> > controller memory access could be limited to a small region by the
> > firmware configuring a memory protection unit. This memory region
> > must be assigned to the PCIe controller so that the OS knows to
> > use that region. Otherwise PCIe devices would not work properly.
> >
>
> What you are describing is dma-ranges. Why not use that?

Answer from yesterday:

I didn't know about it. I was just moving the property from the WiFi
controller node down to the PCIe controller in the other DT patch [1].

Answer from today:

Also, it doesn't work. See my reply to Mani.


ChenYu

> > Allow the memory-region property with one item pointing to a
> > restricted DMA buffer.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > This patch compliments another patch that moved the memory-region from
> > the PCIe device to the PCIe controller [1].
> >
> > [1] https://lore.kernel.org/all/20260430120725.241779-1-wenst@chromium.=
org/
> >
> >  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.y=
aml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > index 4db700fc36ba..4a9e41d01628 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -115,6 +115,10 @@ properties:
> >    power-domains:
> >      maxItems: 1
> >
> > +  memory-region:
> > +    maxItems: 1
> > +    description: phandle to restricted DMA buffer
> > +
> >    mediatek,pbus-csr:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> >      items:
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
