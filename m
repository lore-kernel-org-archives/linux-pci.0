Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C63546F0
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383765; cv=pass; b=qgvctsQRzIumyfKXq14szcf5hj/YRKp1K4OpmO0j5U1rvq90zeZBI075kfeVMF+FgS7gIV/T0W0fsHVGitBbg2jYUQsYy3SMwH0PXcYO3c4nBqyPGc/eSCpbi9qQUD1fNVolG9c1J2czSn0N70ebHLoo8abD2o/hfhbC0jMt0Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383765; c=relaxed/simple;
	bh=dc3hxz1Z6ts5aP80soJ2hBJ6WJFOrS2+h2Wacc7ErT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRJMZPfuBFtw6XjVMcVggOmdo7S4QdTCgt5b5mJ4ws7hMKBOIt6KxTGRFAWbI7eSTy7A3grdYkQzUZt6MSG576dSDnAodCGd2P+JUeiQ1hLFbM6Ne9JTiBHk+/B5u3WQeMPrvxPTYJcTXL8LxpBKuoTxzsdG5h9yGYudJMsh64o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gcKHJH0l; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcKHJH0l"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3967738c801so23610211fa.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 00:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780383762; cv=none;
        d=google.com; s=arc-20240605;
        b=GuV2EEHLSfxRJ5ctnlbsSDjZPVKnbh+vCrkVJ1jhK6YvEpx3ZTm5uAIPDmbmisjk69
         Up5B2EWEFIa0y/Zttjh0mID6V6FNBZycKVizxMTBz56rqYY5OlGTV4MYTaXI3LxiKi/C
         XIWIQkDCuYLWM01d1E8bG9PIpEzrqYOxqrQcAz9/xn7yViCwLvlgSObylrzjtL2SVhFx
         YfOjwGR0xB7kzlp9lJzEjdUAFIl/bph4e2kHs4BwZDesDvTtw8DMl/nPQVnRYNMrdNvJ
         yZlQFbOXzC6tSizLgbveI0sri+GmiSLc+QnC8ePDIyqTllnqsaQoE2c49QK7bmO8u5Ua
         Ajog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WnHlV7MCTn9bw9xJxluLtxJpmyxU7LZpuXHn1Oyo8MM=;
        fh=IFqiFeEPWl/i0l3nuaY5x8BhE+H4mLbtyC2RfYgfo84=;
        b=Iip4Sshn+BSKTQpdCYPdhT4z5H9UD8FaFTTzWj13wh1jY3mTsnl6Qow2CGwMgkPGqq
         g+ylGJL1qAez93X1z11e/LK/frIQftZlioeRzmA+o+PZhdoWgxBH8rAiTS2pZxZw5kky
         3Rzf+MkGOQor/iTDEx+RMCAbyX9kJvsODis/uTsKOt2sXuiIJE9wJrh1KjHOgw8IHYPr
         /LJ+7PsfevDZIoxl7O6uYo/VbZsI5oBqTxcrmaxWdfe2rOZEcL6J+PpTvRo2ro5KYTBE
         ZQnbhZAIC/WdHM5FTci3VPtJOUYYmVw4FXSGTbYZCEbYYPErnc63OftVBZAzp6+bkQ0l
         Iv/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780383762; x=1780988562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnHlV7MCTn9bw9xJxluLtxJpmyxU7LZpuXHn1Oyo8MM=;
        b=gcKHJH0lkC266v2H2vZybnksZ5YHP65poH+Sx2ZKrDLy6WlhFu1UyPJ5DDXfdkSidX
         JIMcoriyI3Y0XZgyxGClKxeGCe3gjFSdAfon5YbAiZZWI5zI7p0Bu7xJvxs3A7WzBauZ
         Ktg4SwTWNS9+PMfPF11M/MsPrs+glOuuoEAFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780383762; x=1780988562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WnHlV7MCTn9bw9xJxluLtxJpmyxU7LZpuXHn1Oyo8MM=;
        b=pRjV+a643RDDqYG1c/wfvh26GFTVtygtO38jxEupNzvXV7co2QtriScx3h/XPmu2Wx
         vymHKVQZhWdQRwwTMkm9dT3K5X6nMDd4QLGxRjG7WsK0iXOO66ebVLda0gd10mxEo1Y6
         ZiNfi0gLmtDoN9387nQRQdR3nZDSzQQLcXFW3mu1P6/HpOXWkgwW2JV44H3VYa2P3sGx
         CvPKYQ8qfdGNvlerkynqqSQoKwQQm4W0SkW/8dXz/709zWf/vW1wxRakI8275XU6CX0h
         Bn/R8l1gQEmjo3fqOO/sKHshoqtKm+0ObaOnI4Hxw6eG0eg0WGPaPvI9bSLh5kN6q0/r
         0G+A==
X-Forwarded-Encrypted: i=1; AFNElJ8Rj+rn4z/fwUxcgXVVNzSj+eJsBSvuOX0HMWoUistiZtrR6JBt8Ki9lUEt8Mw1dDbojpqQyQvwHmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlROst+fezXwWRXpKVn+91RprjWvShKYEX0bQWWC6kRir5Ux2
	BAbaj5eICB8teYdtgOEmzF8CzNGsta452FPgeWjFroB8qMpWRWdP815r999UE6pYnwmTcq7Mye8
	lGX/12FIQizsU7QHFeA+Qb7sba9B/TO2ZrDIQrMmT
X-Gm-Gg: Acq92OFAR/ewXqAdVVdepBjpvWQbwKPqd6ON1Zzzwo7DwnekY5SGPvs6lcx2vdcfwB1
	YPr2aALQyOOzsvGnT2J21PaPtVmpwyVfdOGF0CezLeVgqmCGw9Y1bRYBNjnE6mMUg/5LvgLzXlb
	u0iq/L6gxn3JxJuuFcplFww3lskIuTnL/Yr51Q4CZraPAFlwfq0Wxofk8+pqjGLj7v813KXOb+d
	k04eVkr2G74bf7TROmTlOVI503nrMI6stCZ27rFjOVzJmXi0jzF9zP5m+C/dHi6Q5UVp7m5lE9/
	NxdfmUOgy40RiylSKGdFSmNTIndpZfNcgYFW44+OfDmm6PpPEYKzy02h2A==
X-Received: by 2002:a05:6512:1149:b0:5aa:6c90:283f with SMTP id
 2adb3069b0e04-5aa6c902a77mr2153865e87.20.1780383761782; Tue, 02 Jun 2026
 00:02:41 -0700 (PDT)
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
 <rphuqwucr2r6gsgrkzkpzy7fn4qa7q4afzbwtzae53dtudmush@kxtzdoq426uz> <20260601214836.GA37779-robh@kernel.org>
In-Reply-To: <20260601214836.GA37779-robh@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 2 Jun 2026 15:02:28 +0800
X-Gm-Features: AVHnY4JxBAhKzuOj5WlSWhMTG9y7geprKoaK3gn9MaHW8gIuPbxvEk-tzLbY0lY
Message-ID: <CAGXv+5GK6+X3-eY8PbrLTsSwK2Uk2URiQti_Gd_9C=RwRaJ44Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 5:48=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 19, 2026 at 12:51:49PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, May 18, 2026 at 05:02:11PM +0800, Chen-Yu Tsai wrote:
> > > On Fri, May 15, 2026 at 8:34=E2=80=AFPM Manivannan Sadhasivam <mani@k=
ernel.org> wrote:
> > > >
> > > > On Fri, May 15, 2026 at 05:16:19PM +0800, Chen-Yu Tsai wrote:
> > > > > On Thu, May 14, 2026 at 7:48=E2=80=AFPM Manivannan Sadhasivam <ma=
ni@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, May 14, 2026 at 03:54:29PM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Thu, May 14, 2026 at 1:23=E2=80=AFPM Manivannan Sadhasivam=
 <mani@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrot=
e:
> > > > > > > > > On some SoCs without an IOMMU behind the PCIe controller,=
 the PCIe
> > > > > > > > > controller memory access could be limited to a small regi=
on by the
> > > > > > > > > firmware configuring a memory protection unit. This memor=
y region
> > > > > > > > > must be assigned to the PCIe controller so that the OS kn=
ows to
> > > > > > > > > use that region. Otherwise PCIe devices would not work pr=
operly.
> > > > > > > > >
> > > > > > > >
> > > > > > > > So this means, the PCIe devices can only access a specific =
carveout memory
> > > > > > > > configured by MPU for DMA? If so, you should use 'dma-range=
s' as suggested by
> > > > > > > > Rob.
> > > > > > > >
> > > > > > > > 'memory-region' also serves the purpose, but for PCI, we ha=
ve the dedicated
> > > > > > > > 'dma-ranges' property.
> > > > > > >
> > > > > > > I think I need some sort of guide on writing the 'dma-ranges'=
 property,
> > > > > > > because it is not working for me.
> > > > > > >
> > > > > > > I'm adding
> > > > > > >
> > > > > > >     dma-ranges =3D <0x42000000 0 0x00000000 0 0xc0000000 0 0x=
4000000>;
> > > > > > >
> > > > > >
> > > > > > So the device DMA address start from 0x0? Isn't it a 1:1 mappin=
g?
> > > > >
> > > > > I actually don't know. But
> > > > >
> > > > > >         dma-ranges =3D <0x42000000 0 0xc0000000 0 0xc0000000 0 =
0x4000000>;
> > > > >
> > > > > this didn't work either.
> > > >
> > > >
> > > > Hmm. Can you print the DMA address programmed to the device? i.e., =
the address
> > > > returned by dma_map_single() in the driver.
> > >
> > > On a working system still using the restricted-dma-pool memory region=
,
> > > it gives something like 0x00000000c0009000, so indeed it is 1:1 mappi=
ng?
> >
> > It has to be 1:1 mapping.
> >
> > > These are for the RX/TX descriptors [1][2].
> > >
> > > When using dma-ranges, the failure is from dma_alloc_coherent() [3][4=
],
> > > which is the descriptor ring. On a working system, this is something
> > > like 0x00000000c0c9d000, so again 1:1.
> > >
> > > [1] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wirele=
ss/realtek/rtw88/pci.c#L221
> > > [2] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wirele=
ss/realtek/rtw88/pci.c#L829
> > > [3] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wirele=
ss/realtek/rtw88/pci.c#L192
> > > [4] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wirele=
ss/realtek/rtw88/pci.c#L265
> > >
> > > > Also, using prefetchable flag is not correct for DMA memory. You sh=
ould use:
> > > >
> > > >         dma-ranges =3D <0x02000000 0 0xc0000000 0 0xc0000000 0 0x40=
00000>;
> > >
> > > This didn't work either. What exactly is supposed to handle dma-range=
s?
> > > I see some code parsing it in the PCI core, but it just saves it to a=
 list.
> > >
> >
> > I think the failure is due to marking the memory as 'reserved' in DT. W=
ith
> > 'dma-ranges', the allocator will only ensure that the allocated memory =
stays
> > within this limit. But the allocator itself will not use this property =
to
> > allocate from the reserved region.
>
> So the region should not be reserved. Reserved generally means the OS
> shouldn't use the region (though maybe a specific driver/device can). It
> should just be a CMA area I think.

No. The whole reason for this is that we want an isolated piece of memory
for PCIe so that PCIe transfers cannot corrupt memory used by other parts
of the system. Normally the IOMMU provides the isolation. On this platform
there is no IOMMU for the PCIe controller.

System memory isolation as setup by the firmware already restricts the
PCIe controller to only be able to use this region. And we absolutely do
not want any other part of the system, be it kernel, DMA buffers, or
userspace, to use it.

And also, if it is not reserved, the kernel is free to put "other" reserved
regions, such as the default CMA region or the software IO TLB region in
this piece of memory.

So I believe using memory-region is the way to go. The memory needs to be
reserved, and assigned to just the PCIe controller.


Thanks
ChenYu
