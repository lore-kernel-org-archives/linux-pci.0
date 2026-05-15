Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F453E51F2
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836594; cv=pass; b=gLFXT055Dcs7CrVTGRjChxp+ybGW199xQmGdSxUinX2L7TABQX+ktttBGvrWyifj1+ajxXmJdAJnGh1sRA+EVjsSLqbSXfvr+E58GUWoGPA+GqhGCZbwEfnt/G5gpxeI4raRVfFzNSFTD9z91OTdMUMXlMrjc7unBRhB1lZyun4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836594; c=relaxed/simple;
	bh=O1osj9DRGlh7LQXczkymCUHM69wwL6MiPTCJNt7k5Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvHkPAj2Gqyr74dunc3GLfFD2yvToW2QOX8ihwo5gNw1QPUi+5ZF5RnI3fefDqKxnbguA31Hr54KaEVpFSkGu4YSMB6OuyAclTGt/P+KtLU787KHKBPAFbmes0k0jpWLzG8ndyIw5gqKzltwvz306MVmcgSs4djrFxzR4/Mu0zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=daLT55mO; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="daLT55mO"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a8ee4b703fso2748668e87.0
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 02:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778836591; cv=none;
        d=google.com; s=arc-20240605;
        b=UllssEI+LxV4ztQzvjf41ncUtvvjaFAeGwDG2CrJZ8hxo1txHMfJnjfYWY9BG3Q5Q2
         cJ7AB2qLcka+sabYRqboC2BKH7dOs0AP54Ac7AJyoO9YdK7Juc4MSL2FF8btQS/sJD+g
         wD8bhz2HB9nPVlQjy5cTYDKtSIyVeEEhJKR93FAlY8b+tEhErDYyQCyTqhCzJ1BwIeDw
         ZVkFC6TuavMSbdze0U/U8RoSZ7BfXE7HLFByUb/FH94xN+yXSAEGUpY0LcktZiFsOiBW
         NfRyvND1Tww6iGrvjZnzEjgIl+ts48LC1VZeRolbv9R2VIMcZJ/94819jZZqE60+maKf
         UFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOPcS/H8/U6wPcyzeNn2Tnxkz+5P1nEugos5oRv4JHk=;
        fh=pQq+obxAZCUGhsqh52E4PYNWi5jCZZ+8dNuyrY8wpTo=;
        b=j2FxVWNbZ7L8ojTr5/q6Y4UKJ4qlTCvpuCoLAVMqbK9DhY28++Wiq86QuGub6vdKUG
         C0nuEX6qfivmRruahNSiBTd6vAbo2mWq3PMhqi+FJpMdUi77ZXzx5ZhL8Ph9gYvd55RL
         GUQ+8aXDpFv4Fc+rgXXNA6ECW0RoMO1pI4T7jZDb7VR+9eIdFVGwLSV3Wpn4QPPEhe34
         H6XCqo7xc1lCgJtIkNC3isLI/Td0eL4bMO+HMPwn9rFYwDM+FQJMu+PMDn3J56Lbwy4+
         ayKL7T/duL2vIKp/b4T44lPl/m6AQeSEOzngm3ETNRz2DYtA2Rs36x3M6tAz3DsqLQIK
         4kog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778836591; x=1779441391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOPcS/H8/U6wPcyzeNn2Tnxkz+5P1nEugos5oRv4JHk=;
        b=daLT55mOoeJ/6ZiYq0of3mLN1STCti1NRMqhacQG4vwStEjQgbhSvSjip0uUYd9T7J
         JGDghNUbdpipTj9z0zTjdtaB17o1p/4SdLcV8DqL4OMlV3Il3aNXvORGCpADSS3DHyGb
         PAapOkhfjcJt5NpuCVaf/M9TFdFlM8trUmk9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778836591; x=1779441391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOPcS/H8/U6wPcyzeNn2Tnxkz+5P1nEugos5oRv4JHk=;
        b=KBGBpNLwZPCWJn2FBKu5LNxqErGtzBTTTpMTTK+wqLcVUoFengMa8L/kNZXMUw2Pwa
         o1wAoY/Ghj5YHgZUPZa8uEvlJ/lO2wdQty41D3b+j8GYhTe4ej8JpGpn+AcSQ1Rb/PXy
         eJYQ5AOTfkVo8APSvqg581H/fSxrvImZ6Xeg3yh8N72CceSHD6hbozfjF94Dr/8SBo9Q
         icdkSBcyw9wIAIVpL3lEWjcCks0XK3X2VnVZZaiNcU2wFfV3Br/jmtUTyoWttZEefKTE
         3gDhmWbb3DwB+SxYMClHZdtvbI2UrpnijR5Nb5Hn4ZFCYRvXjp8/SptfYH5wT61Iu7bb
         VZPg==
X-Forwarded-Encrypted: i=1; AFNElJ/KLRZSVAMFrz0pCF2DGvNCQS4dXXpkpCHbS6Nly17R4hPIMdi2PbvZUUp4QNF1U8F6A3rQQe1xhkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEeZSPnmSp10PsVahpzYhKUsGHe+vtI6fgT/AS3lQcclJJDwm
	nUSWX3uuTAT4Ce9Osk8djJAMFUSnWMFxOLPfWzsDyjHRFlxO5PiQXj5BruuMsW/WIwUInyC6F1F
	MASvaa3q5yNj28WMYBd1xqOHI9IHz1zaXpd+iNfJj
X-Gm-Gg: Acq92OGHTMJEDXjMJGMT2aBJjz4udLDXXwr+4E7eHITRUXcC6WpTd7Rr58RO1xDsXpe
	X7i4PZWlIMb2WZmLxlmuhNMTSwo9G8ndrHExLuZdSPbJp+mAm1Z/etjF6GF6esmOSiBvHImEgbu
	tI9xO61eW+bNcrAsZBwVK98A2jGfMjU6hFXgrTqLzTFze3dBfbchoTv02RdPUhPN6DUCu7eNTYR
	s10aEpOpzoFhrpoMGWbuaK6CE7m1Sq9PgRF9p//1GLQu6/Igpb7HwUGdh4AXInoRMfqnFB0AcAd
	0vm+Lj+EWaWGDfl729Abn36gHu8ogvKgmx/Oqg==
X-Received: by 2002:a05:6512:3a87:b0:5a8:9d61:d89b with SMTP id
 2adb3069b0e04-5aa0e74cb3dmr743386e87.37.1778836591069; Fri, 15 May 2026
 02:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508063633.3894348-1-wenst@chromium.org> <locoul5wdzuvvmm7mqpuntjqu4o75gmyd5npgfqrw3zuwsrse6@dhrjggs4cihh>
 <CAGXv+5GAaMQbaoUVr5zcwtHaofyXwHz03TxBe-QyWj_sNoQZsg@mail.gmail.com> <qnikqcqoiw7z2yh5wruqcli3rk56yomyymghzivlcmekp2blwc@dfhsfl3sqcla>
In-Reply-To: <qnikqcqoiw7z2yh5wruqcli3rk56yomyymghzivlcmekp2blwc@dfhsfl3sqcla>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 May 2026 17:16:19 +0800
X-Gm-Features: AVHnY4IdOj2VyhMXhY8fbMZzGCWoX3mgZBp9t_yv23cB0YsfCPC7Ce9B5m4dook
Message-ID: <CAGXv+5GBraoTrQatQdrM5b+dOteL_Y5K7_UQBUt-2L1x=c94KA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 7:48=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Thu, May 14, 2026 at 03:54:29PM +0800, Chen-Yu Tsai wrote:
> > On Thu, May 14, 2026 at 1:23=E2=80=AFPM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> > > > On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> > > > controller memory access could be limited to a small region by the
> > > > firmware configuring a memory protection unit. This memory region
> > > > must be assigned to the PCIe controller so that the OS knows to
> > > > use that region. Otherwise PCIe devices would not work properly.
> > > >
> > >
> > > So this means, the PCIe devices can only access a specific carveout m=
emory
> > > configured by MPU for DMA? If so, you should use 'dma-ranges' as sugg=
ested by
> > > Rob.
> > >
> > > 'memory-region' also serves the purpose, but for PCI, we have the ded=
icated
> > > 'dma-ranges' property.
> >
> > I think I need some sort of guide on writing the 'dma-ranges' property,
> > because it is not working for me.
> >
> > I'm adding
> >
> >     dma-ranges =3D <0x42000000 0 0x00000000 0 0xc0000000 0 0x4000000>;
> >
>
> So the device DMA address start from 0x0? Isn't it a 1:1 mapping?

I actually don't know. But

>         dma-ranges =3D <0x42000000 0 0xc0000000 0 0xc0000000 0 0x4000000>=
;

this didn't work either.
