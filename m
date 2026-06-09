Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5315377EC7
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976022; cv=pass; b=P/UMS4lMmYbvx6xGzQUvhO8vTXfQWkoiJdZbaBo/1fi/I28vtfbiK36VXBE7xRCrMS0oTdV+Me0YJEOJRNEsQfX7xTiHcyWrt2jeGIfBck8Z8wEPMsBak0PuiPZJKtbxctkuxHE2DmmW6VtE+XObD+gp6B+WT6+LdrGJF4/bF6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976022; c=relaxed/simple;
	bh=6/fP80sttTz7ttlvprLcNNbhgm18y4V+UknELgO6vMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8gStEdmdQc57eESRhBb6szec6hwdIjELBcj38JZWDmZIpMJMHq4ROSo5TcDnCOuFweK/90sLIni9P2ZAhd5fqaGvchvwCvdf1iKFmyLbqgQM9ZY6TjW2wyyPzYK4yVDU7s+BaUmER++ycEpAAge9Wyjrf/AenCzGkFpU5ZEw+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N+VHCwY6; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+VHCwY6"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66062a414fcso5559707d50.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 20:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780976015; cv=none;
        d=google.com; s=arc-20240605;
        b=R1DBCcN40Jk/nPyQKlEKrz5Ts1RhjueRen0+oO1ifaZHjy03Lk2AYMRVcZnhFm3x0j
         VvKhzb3XY5RugujqgGXk3CX/OFIRCRF01893ydn1QfHQqoD2GFx/Q5qR15cddTSvPtkW
         8hMoSppdFpvkBGr8ClMRP4PuHrcOP7v8CYx5pBNEGqtQrhV/mhXHFtvGNc2oQC4U4i45
         BtXcRs/6rbO6iB1GuLAAEWoJcX9jQNawXaPYtgKP8tfb06dECCFC4WYE03hXbSUa7b87
         naDzTA0XWJk+cqpCf+/bvrQzoN2A2QN7k0bv088Uqj+owRJQ0ySvUCs86rcEdEBd8ryh
         Khkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hixbBeN+LnFZDqMAJQTmddcBbOURIwdsQKHtq7EqZas=;
        fh=eRwTchG1FqKLhsZ6qIQbPf2KTZUmdRaCMMZ1IvVWoOQ=;
        b=jzOE+FRLBfbBWgnHelAKT8UyuyPsXgHWtVazJhMYkdeX9/5ZlhZdykZv/r3oi4WXvf
         mQrezCZog9fkB0VBeqMGbCyEDEnaCOvrjoFPnEJ1hwlmOjRWR4M2WhMHIH11foB7WGIl
         6c65gwlwE9p6+foAFn8M100aPBt3Gg1DhKMbiPHUCSUUuADRM7vMFvuCggV72v9+NqLd
         1bdGkHxE6sNJUrzT034pZIFlt9ycpkINz+pzF9NTLBLGDKY61m2w2QFrehjgKU3A5tzp
         V5karZp/Cj6keufnPVTvsekY+2iUk1iuqySqpwL/bT6hut5Vto0CK6MrLzMyGoSLWgmO
         q/3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780976015; x=1781580815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hixbBeN+LnFZDqMAJQTmddcBbOURIwdsQKHtq7EqZas=;
        b=N+VHCwY6g/CVhwVl+6N/Oh/mthb3cZeiHG0+4ygb77J61glyMdsHBjVnG1PNaHcToK
         fYZXoWvGuFsFZ4uyBI4FLfpfmSJyNX6qMKkdcEqwGZEvqfH63uXz3wvGz0lz43I3Jnc8
         7ry22fbCQcGV8Oh+j28r/ZpkX551CQTrXmutc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780976015; x=1781580815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hixbBeN+LnFZDqMAJQTmddcBbOURIwdsQKHtq7EqZas=;
        b=XfLfRpnuy72dMPHx5/yfTnFXrUP5FBIhCLkMtIxINPMVRL4hyMQ/UrGOiknIKTalMR
         uuT6CnPx3yDEemH6D9XlRUP2fVGp6QK/PJTD113QxNA7tcmuBpPc1J2RPC5mg7T+ILKp
         /J8QrrTv58SiB4yQRN2wS7uN75BBN+jTAjucQzKCqIMtGXGrgr/fHVP8fSnQ5K8p7lJW
         qn+rU7t5y/PWx8Ots90BAO7QgaMXQpY4/KwpZMjmkMbPH4FIrwlYeDNcbg6ZEmeDinN7
         rEj1w+q5d2kDr1ZgDcAw1LSHneyFPX83HWJWAfi2hH3fuQFND3l874U3kJt2rdc3bgJh
         8Hjg==
X-Forwarded-Encrypted: i=1; AFNElJ+tyPL+li44sGV9+ec6BeLfCBEHwy/qXIWCiC5QzHQ1+aXSRSOGCkjgAyrrEGQfEQHLtaznNNy0nX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiE2k1sRlSa5ed8IUf6sDMUvb6E6OH9x5igsZjZuvnSrJe2qLl
	JSsOrCwwF16kzSn2rEMD9NTHfYyXuj8zIlCmgOIZtQUZw2d1yiotu0NHgQ7KgMfdiZRp9z+hGuy
	7PXnOMkJ8CGZ2KZkjSRoo+MEIeI459INsfzbseYx7
X-Gm-Gg: Acq92OExjrBMHbbelv2ZUv6E1LQjcSoPfBKIfMIWhHXBuo8Er9ISU87KE+e7mXCd2i/
	KUuo++IwmaglEGWW40TOlzwTKaoY9KcBXBJKW5aHTOsGTHfkwMHc4rFo1zXEmbGUkNmV7IGzTpj
	MlgcL6Q73hdhhqG1YRsTGUsnjTgs/8KlJrxCB7qqMDmYMBihzWvRGpElMy+fQPomCAoKMWcMR0F
	N8XAjmIMvx2Ls1DdcHYG0twiJysdt/JO0Nc3PSlQaWYdaniuURwGD7RqUUlpxblXmKB9eW+puB5
	h3nE+PFNZvWANInE6gs=
X-Received: by 2002:a05:690c:4991:b0:7dc:61c7:5919 with SMTP id
 00721157ae682-7ed11384e09mr179186077b3.37.1780976015575; Mon, 08 Jun 2026
 20:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508063633.3894348-1-wenst@chromium.org> <locoul5wdzuvvmm7mqpuntjqu4o75gmyd5npgfqrw3zuwsrse6@dhrjggs4cihh>
 <CAGXv+5GAaMQbaoUVr5zcwtHaofyXwHz03TxBe-QyWj_sNoQZsg@mail.gmail.com>
 <qnikqcqoiw7z2yh5wruqcli3rk56yomyymghzivlcmekp2blwc@dfhsfl3sqcla>
 <CAGXv+5GBraoTrQatQdrM5b+dOteL_Y5K7_UQBUt-2L1x=c94KA@mail.gmail.com>
 <2tq4zy3zhcrz25rl2qhdsxvoedcry4z3v2lmmropesxqgzhtlp@fn6htdl74ogu>
 <CAGXv+5GRBv8+pLbb-AyFW0cAx=c45JhWd-odzJGDdWABKQLaqg@mail.gmail.com>
 <rphuqwucr2r6gsgrkzkpzy7fn4qa7q4afzbwtzae53dtudmush@kxtzdoq426uz>
 <20260601214836.GA37779-robh@kernel.org> <CAGXv+5GK6+X3-eY8PbrLTsSwK2Uk2URiQti_Gd_9C=RwRaJ44Q@mail.gmail.com>
In-Reply-To: <CAGXv+5GK6+X3-eY8PbrLTsSwK2Uk2URiQti_Gd_9C=RwRaJ44Q@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Jun 2026 12:33:24 +0900
X-Gm-Features: AVVi8CcLvfu3nmY0FgYyZD975IyBRElgoOX6HGLOEh9gnunhRFWsfhBJHTEFs2Q
Message-ID: <CAGXv+5F94K7JJz9pMg5=7-YoXjT_ux8SvBKP17BA36mXYTYo6w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
To: Rob Herring <robh@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:02=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> On Tue, Jun 2, 2026 at 5:48=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > On Tue, May 19, 2026 at 12:51:49PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, May 18, 2026 at 05:02:11PM +0800, Chen-Yu Tsai wrote:
> > > > On Fri, May 15, 2026 at 8:34=E2=80=AFPM Manivannan Sadhasivam <mani=
@kernel.org> wrote:
> > > > >
> > > > > On Fri, May 15, 2026 at 05:16:19PM +0800, Chen-Yu Tsai wrote:
> > > > > > On Thu, May 14, 2026 at 7:48=E2=80=AFPM Manivannan Sadhasivam <=
mani@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, May 14, 2026 at 03:54:29PM +0800, Chen-Yu Tsai wrote:
> > > > > > > > On Thu, May 14, 2026 at 1:23=E2=80=AFPM Manivannan Sadhasiv=
am <mani@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wr=
ote:
> > > > > > > > > > On some SoCs without an IOMMU behind the PCIe controlle=
r, the PCIe
> > > > > > > > > > controller memory access could be limited to a small re=
gion by the
> > > > > > > > > > firmware configuring a memory protection unit. This mem=
ory region
> > > > > > > > > > must be assigned to the PCIe controller so that the OS =
knows to
> > > > > > > > > > use that region. Otherwise PCIe devices would not work =
properly.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > So this means, the PCIe devices can only access a specifi=
c carveout memory
> > > > > > > > > configured by MPU for DMA? If so, you should use 'dma-ran=
ges' as suggested by
> > > > > > > > > Rob.
> > > > > > > > >
> > > > > > > > > 'memory-region' also serves the purpose, but for PCI, we =
have the dedicated
> > > > > > > > > 'dma-ranges' property.
> > > > > > > >
> > > > > > > > I think I need some sort of guide on writing the 'dma-range=
s' property,
> > > > > > > > because it is not working for me.
> > > > > > > >
> > > > > > > > I'm adding
> > > > > > > >
> > > > > > > >     dma-ranges =3D <0x42000000 0 0x00000000 0 0xc0000000 0 =
0x4000000>;
> > > > > > > >
> > > > > > >
> > > > > > > So the device DMA address start from 0x0? Isn't it a 1:1 mapp=
ing?
> > > > > >
> > > > > > I actually don't know. But
> > > > > >
> > > > > > >         dma-ranges =3D <0x42000000 0 0xc0000000 0 0xc0000000 =
0 0x4000000>;
> > > > > >
> > > > > > this didn't work either.
> > > > >
> > > > >
> > > > > Hmm. Can you print the DMA address programmed to the device? i.e.=
, the address
> > > > > returned by dma_map_single() in the driver.
> > > >
> > > > On a working system still using the restricted-dma-pool memory regi=
on,
> > > > it gives something like 0x00000000c0009000, so indeed it is 1:1 map=
ping?
> > >
> > > It has to be 1:1 mapping.
> > >
> > > > These are for the RX/TX descriptors [1][2].
> > > >
> > > > When using dma-ranges, the failure is from dma_alloc_coherent() [3]=
[4],
> > > > which is the descriptor ring. On a working system, this is somethin=
g
> > > > like 0x00000000c0c9d000, so again 1:1.
> > > >
> > > > [1] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wire=
less/realtek/rtw88/pci.c#L221
> > > > [2] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wire=
less/realtek/rtw88/pci.c#L829
> > > > [3] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wire=
less/realtek/rtw88/pci.c#L192
> > > > [4] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wire=
less/realtek/rtw88/pci.c#L265
> > > >
> > > > > Also, using prefetchable flag is not correct for DMA memory. You =
should use:
> > > > >
> > > > >         dma-ranges =3D <0x02000000 0 0xc0000000 0 0xc0000000 0 0x=
4000000>;
> > > >
> > > > This didn't work either. What exactly is supposed to handle dma-ran=
ges?
> > > > I see some code parsing it in the PCI core, but it just saves it to=
 a list.
> > > >
> > >
> > > I think the failure is due to marking the memory as 'reserved' in DT.=
 With
> > > 'dma-ranges', the allocator will only ensure that the allocated memor=
y stays
> > > within this limit. But the allocator itself will not use this propert=
y to
> > > allocate from the reserved region.
> >
> > So the region should not be reserved. Reserved generally means the OS
> > shouldn't use the region (though maybe a specific driver/device can). I=
t
> > should just be a CMA area I think.
>
> No. The whole reason for this is that we want an isolated piece of memory
> for PCIe so that PCIe transfers cannot corrupt memory used by other parts
> of the system. Normally the IOMMU provides the isolation. On this platfor=
m
> there is no IOMMU for the PCIe controller.
>
> System memory isolation as setup by the firmware already restricts the
> PCIe controller to only be able to use this region. And we absolutely do
> not want any other part of the system, be it kernel, DMA buffers, or
> userspace, to use it.
>
> And also, if it is not reserved, the kernel is free to put "other" reserv=
ed
> regions, such as the default CMA region or the software IO TLB region in
> this piece of memory.
>
> So I believe using memory-region is the way to go. The memory needs to be
> reserved, and assigned to just the PCIe controller.

Ping? We need this merged for the coming cycle.
