Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D24AA1DD
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375065; cv=none; b=egBOdrMuu/OkfAmMY47pflHup1bVIeqZ6WL3v2OMUYJ/FKjmt6NM4eXpaFsiElogDlQSDtuVdoVKBcKozWB1w9wkqAldo7IzKul8bQ+jl8PuSyM/r7pW75r+L77JqTXbC+UUrUIsWJTxZ/r17x4pGmMXZjeaBPVUKxXbMLtIV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375065; c=relaxed/simple;
	bh=ztti2r+fzKNtBYjDvDyqLKSRA+anQWIh+N2I4s57yUM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=oaeRkeORwkSmOzMBSxjn5fqw1V4b9tVEoMzZoyfa/yosKBZFoSDpmE2ZWS10zq9egZxKizObEvkLOjXjp202M6hu4rkrvyoOrSEOuZhL3JOb4tX/enTIgSxH1JJpaWzeVnahWXZjMa9Igg8UQxzUSuGu1kDoDqeRbFSu9UeoWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=b/1diCcm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="b/1diCcm"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c259e5c22ffso236185666b.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1788375061; x=1788979861; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rto/zkmddcXFKDuBMT5owfeFn2l4lHjmJnj+jxGDxQo=;
        b=b/1diCcmw7Xt3wxdoQkY9jhuUd34EKvxceX0cfeFwtxYh3/WSxO8f33wiuLluZcGN5
         6CHZoF/akE8kf0nG5Aj1nti2kpTAOVrO9mgwu/5OgffluRd5H0zFPYal5daDI1J73bfF
         kfbVLiG3IIYWD0t7bfqeFvMaRde2OaUwJQNO1YgMupT8GMVhQpVi/bxYryj1kGTCWNkI
         U4DMLIUsp3B5HUTjXtO7I1Kua2Mt6ZaDqmJZYk+1nnEQFaVU4Sx5VOw7GXPK4ui+TEij
         icQwEKm1kMT4vWIHrGJEZxYyTD5SUXyX7DTiQ2nepav4uJvKZxqCcpZ1IjajngwEMCey
         Wneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788375061; x=1788979861;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rto/zkmddcXFKDuBMT5owfeFn2l4lHjmJnj+jxGDxQo=;
        b=XtMcdEwdWgMNRpLpqt1oHQOy751aUv3N5Fx9AftHnxFyAxXFmeCVR8KJ0KsaVRU0lB
         OD3Gls05teZio05LekS8fxVurzoIeUIJiQjQfZ1YvBbIunAo7Uepl2z+K/31xXZNtDt2
         Kn0rSHGU1GVtLbstyhvrFJppcq77b40raxMQyNVvOcbJckC4TGTsv3tb9nw3HcFpPDqS
         1gKr0harfAF6pQ8uotBa81feIWoFg+tEtwMXzaYvJcx9zc4B+s8NsdW4wh3UR9RUw7d9
         NQnoPJkAmu/Vra/onKpn9YSfxv5NLaIV+p97wvxiisNO+lFSwAkhVJ2NKo9enxESAG3j
         Ip3w==
X-Gm-Message-State: AFuF++nF5DTOXCbtjgU85VBhx17iV8koC59oP6s41UAThDfAeFzba4es
	om9xKctN/PMj3NTZWDsE1zMx5cLTvEz4rtRhwhqIinLFGIb7+xleySzxL3nIQp+KPQ==
X-Gm-Gg: AYBFou1lY/KJ6rE3kYYKYPwPYj+Prv0eCi0xpGMCWcnq7mRL2hewKrBrWUNFXV7lEYw
	DYNzcbrKwj3xtZprOwG3XSJSAavGGoAAp/mQ1rRLMnuspwZhkgB3/eBgvmlbobgTa1WDjla1cZ4
	ZESWtkZuoeUeBZo2b2DK2nyN3qKth2tebSR0OI144us4K1j1lh7OPtyXuS17ln/RHLZs6WKpwP6
	z4vFxoWhZJvwuPDIkRsacSE7okJlFEC4Zv0Z86znISC7ZxKYxZLTpl6xea1f2a2XYOnVf0Y28zo
	7Yd25XOYISqGfUCBiN4rhq56LsfDFIFOTXidKJm1/8JHRtoj0Xh88jytO8Mb+XI/BxdYab83f3b
	8tAr+9H2AROR+LVOL3Z0awGoUwDf0u7NrufpDRfAxqUpGy55tf01mC0a32mQUWAsld4dmX92s3C
	PGlyc+VvlMNlbaVquWSMDLhEUnTU4sZDtWnPKEh3dnDxxCb6KuRp6qrNkjFpqXGbDu9MCRBp/pt
	b6e/Y2O0vXspPHMEETVYn6mjnEPrw==
X-Received: by 2002:a17:907:805:b0:c25:895c:62dc with SMTP id a640c23a62f3a-c25d5496a24mr425850266b.14.1788375060906;
        Wed, 02 Sep 2026 11:51:00 -0700 (PDT)
Received: from localhost (5073F89B.static.ziggozakelijk.nl. [80.115.248.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f4172e44sm200366b.20.2026.09.02.11.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 11:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 20:50:59 +0200
Message-Id: <DL521SM75B0T.1DGK1GVSH1G51@9elements.com>
Subject: Re: [PATCH RESEND v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is
 supported
From: "Michal Gorlas" <michal.gorlas@9elements.com>
To: "Manivannan Sadhasivam" <mani@kernel.org>, "Richard Zhu"
 <hongxing.zhu@nxp.com>, "Lucas Stach" <l.stach@pengutronix.de>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>
Cc: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
 <178835947957.88571.7553170178358028044.b4-ty@b4>
 <gayg4xafgxcog7f7jy2i2e3wctds3do2ytttgv74f3y6ed7qtg@mr3xfxugjfeh>
In-Reply-To: <gayg4xafgxcog7f7jy2i2e3wctds3do2ytttgv74f3y6ed7qtg@mr3xfxugjfeh>

On Wed Sep 2, 2026 at 5:36 PM CEST, Manivannan Sadhasivam wrote:
> On Wed, Sep 02, 2026 at 04:31:19PM +0200, Manivannan Sadhasivam wrote:
>>=20
>> On Thu, 27 Aug 2026 18:51:00 +0200, Michal Gorlas wrote:
>> > Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
>> > states for devicetree platforms"), ASPM states are force enabled
>> > on all devicetree platforms. This causes PCI devices on some i.MX SoCs
>> > (for e.g. i.MX 8M Plus Kontron SMARC eval carrier) to enter L1 even
>> > though CLKREQ# is not supported (and consequently supports-clkreq is
>> > not set in pcie controller node of their DT), which causes the device =
to
>> > never wake up from L1.
>> >=20
>> > [...]
>>=20
>> Applied, thanks!
>>=20
>> [1/1] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is supported
>>       commit: 94420d27973f567e5c10b631115ea8b9abc0172e
>>=20
>
> I dropped this patch now as I completely missed that this patch incorrect=
ly
> assumed that ASPM L1 is controlled by the 'supports-clkreq' property. Thi=
s
> property is supposed to be used only for ASPM L1ss where REFCLK would be =
cut
> off.
>
> As Krishna explained in v3 [1], you should use 'aspm,no-l1' property in D=
T and
> use it to disable ASPM L1.

Right, 'aspm,no-l1' solves the issue I had. Also forgot to answer
to Krishna's remark in v3 thread. Sorry.

Best,
Michal

>
> - Mani
>
> [1] https://lore.kernel.org/linux-pci/aabc3dbd-3e5b-4272-807f-f0743606e25=
a@oss.qualcomm.com/
