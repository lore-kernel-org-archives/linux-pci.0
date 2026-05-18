Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6366C3E0754
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094947; cv=pass; b=CyzMnQTD7z3KNGqM5fyUbJ4Aiv2slKzzAK1d7gMWpW7GAM+5e+qI/6Xb1H3psFLY75H8iai2zgfvoK85P3o0pS7QT5u0JM/WVR+g5omAj41W3+CIqnhSqFZQfBVpo31TllsvIeUDQs262emeK11ljxtXIvvqumrhPJf3NLt0pLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094947; c=relaxed/simple;
	bh=71TFbEcoqimFGHlNd4y6mv6WLtF6nLvR79xMgngVEgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSaGUXTKt9bb5s1h4Crwyz/g2hWT8Zs7fKf61Jw1aMtpvcADFRHM7BjdTjN5uhe0mVnwsKn1wVioopekXjGNATkbcg8UsznMSsmz3cuEB5GRHW4w4pHDDgln4yq63HYRpQ/qjAn4I2Z/uoMu6u8mywrceWtDYnRyVMCK9NFTTgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BLMi+r7z; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLMi+r7z"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3942e9977a5so31036471fa.1
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 02:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779094944; cv=none;
        d=google.com; s=arc-20240605;
        b=EvR5mSMizAPILJJilTXokbR6EXpcB1dEE6odMTILIiO2Wyu9xjfd+2OQl6VhN/JlQV
         6IZecFR/ZtnpnzlN8D7FrY5h3QCo9w5nMkFIlDL3wdBQNhH9MCI0eO9uazuVZsCH29dc
         3MSd+IWTebacxWwZySVb8HJLNG6L/09veRNa0FDtkmYd2FC6HcoWlKB17vh5O91TZUoj
         m2JbB6aZLWgEVln1NwB3FHkv0mjF6F24D/ZA4Lt6/c4lam/bzqIMBJFmPJO1DRZDAzp7
         BtHvTRttoDje/Vww+CtSVvjeF1FgF/JpiUfQFns9LddAzi2bWe5c3I17VfXxmpeK9Pjl
         YcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1QyVBBy2NYd9YmCiR8B33Ktaal8632/eUsbO1iGJ1A=;
        fh=8aGj840CymBsWW/FhQo6u7xwP0CpL9ZeisSk0JolcOI=;
        b=NHpbTl0diyKnjzTuAImSjVj+iLuw2ArSwpD9tcW5t7Z0As4t5wKrucBlAZ88J4jB03
         eI3GqBb/+yyOsGuWZEGYi5cW1th5QGBv7zJjZJUGilabhzZtfhTGVkW5esoZlIqGNePq
         HYMEAPFZIy0mk7koX/1U/SV65/MK3rgb64ibR1rl006GUIl2E2982CBryEaDVNqnJKh6
         wtotJVKcsoytPH3uEeAPM8o75LWFO1KBYfvUqjtntV73J11AnCSGfuKM1hKZn53Tsa8V
         cCUOYohdePvINCZBYGgjep9S/m1esSBdGVs8FfjTTIgfED1klF51oLZwmxgitr7t/dcM
         h8EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779094944; x=1779699744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1QyVBBy2NYd9YmCiR8B33Ktaal8632/eUsbO1iGJ1A=;
        b=BLMi+r7zrqq1VTM1aA43BLE2Q1YFCW6NqxZhHWhMfVWfh90sNJtViUKaxs4bT2ewUC
         9efSEmAPpVroqcc+BsYcOvr+foNVod7tHMkCQIvLf28sijhEijBBSADOXpojvD7OK/6E
         DkqyJ3YNkhvEi1dj2Wxjnl55FePlm2exnwD40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779094944; x=1779699744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1QyVBBy2NYd9YmCiR8B33Ktaal8632/eUsbO1iGJ1A=;
        b=X8ApdGqT8C7PB9zEWo8O1q314CiFlvxLSwvZSfgqUwIn9JCBILZXbHPBf86KXtLjzb
         /DFq0pEDFa0zdTbimZrE2uSA3FTHexDsWpv0TWlAiJAiZvyiUJIC4V5CdPImvnFQ9H7N
         8N8XOIi81z6zvPnSH23TxPyvPdcXfVvqM+dnlLJl3oZ5LQmo6mm6ofqvexbbSV7rzxQU
         JYlI9rCjx8WfuJostVJclmOW2/nMtxxJRF2AJq1Cb8lRC2ZONn5lQbnowWCEesy7w3ZT
         1gaqj52S2Az9ETSPPHrBr5VG1Uu9UWMeeiBxE6uiQbYFeBGNcz2DdFSvQP4C4N0eHh00
         0pdg==
X-Forwarded-Encrypted: i=1; AFNElJ/tAKkpC5RnRfvAZl+7pnFyeIDVTVNizEV9/G4MGylPs37wivI4yM/jrEn9UlDqNmr80wQ7c5vNB3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHTl55ZbDG2M/Hfqu1dwDAJynjZyI8rylmVaUmF3GfseNdG2C
	o5nbvsn9mpQp3MqM7EEKwT3WUSduQr0trHJm/qQLHrt/jWxX4E9hO0vWfluP7DHLEWRdxo/MDi1
	ZbxPlNThxTRFQQ/e3q42xF7IJPRFpqf4gQ4nivhEd
X-Gm-Gg: Acq92OHWTmopNCe2mXGUFpYstoK4gTTG6BTnuxorfpVo1RYPKpK08NaA+EIKwQ1HH9Z
	T535mmz825Ub85VZRblgNf9IwNH1FqDbIUop9JDzGz108RiwAAOSQ2WYm+Rtg2xhdQ1cJAy1ajh
	XQEw4OSaUfYBkWPrAQ/dA8Vx6MbjwibZNgNg3xQSuBLKprn46RD1f4N71PdnnJ6hdb7b8OYtVI2
	nSVXiRr0sMcevD4pmXNHZ/YdM+Wen+GGoU3nKyucVZMf4alIwzWcGOuyDHxB6VnXrnodfqJ9WLt
	irgow7xVecvsMaVd/TJoKcB0c0jw4PVo+PUG+akDLUdLe5qt
X-Received: by 2002:ac2:55a2:0:b0:5aa:e35:2270 with SMTP id
 2adb3069b0e04-5aa0e35232fmr2660585e87.0.1779094943454; Mon, 18 May 2026
 02:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508063633.3894348-1-wenst@chromium.org> <locoul5wdzuvvmm7mqpuntjqu4o75gmyd5npgfqrw3zuwsrse6@dhrjggs4cihh>
 <CAGXv+5GAaMQbaoUVr5zcwtHaofyXwHz03TxBe-QyWj_sNoQZsg@mail.gmail.com>
 <qnikqcqoiw7z2yh5wruqcli3rk56yomyymghzivlcmekp2blwc@dfhsfl3sqcla>
 <CAGXv+5GBraoTrQatQdrM5b+dOteL_Y5K7_UQBUt-2L1x=c94KA@mail.gmail.com> <2tq4zy3zhcrz25rl2qhdsxvoedcry4z3v2lmmropesxqgzhtlp@fn6htdl74ogu>
In-Reply-To: <2tq4zy3zhcrz25rl2qhdsxvoedcry4z3v2lmmropesxqgzhtlp@fn6htdl74ogu>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 18 May 2026 17:02:11 +0800
X-Gm-Features: AVHnY4JIsiwOadahU_wI7dsAovNkMx3scRvxNCSxVAoQqeyJFwBSe39bN7su8rY
Message-ID: <CAGXv+5GRBv8+pLbb-AyFW0cAx=c45JhWd-odzJGDdWABKQLaqg@mail.gmail.com>
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

On Fri, May 15, 2026 at 8:34=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, May 15, 2026 at 05:16:19PM +0800, Chen-Yu Tsai wrote:
> > On Thu, May 14, 2026 at 7:48=E2=80=AFPM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Thu, May 14, 2026 at 03:54:29PM +0800, Chen-Yu Tsai wrote:
> > > > On Thu, May 14, 2026 at 1:23=E2=80=AFPM Manivannan Sadhasivam <mani=
@kernel.org> wrote:
> > > > >
> > > > > On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> > > > > > On some SoCs without an IOMMU behind the PCIe controller, the P=
CIe
> > > > > > controller memory access could be limited to a small region by =
the
> > > > > > firmware configuring a memory protection unit. This memory regi=
on
> > > > > > must be assigned to the PCIe controller so that the OS knows to
> > > > > > use that region. Otherwise PCIe devices would not work properly=
.
> > > > > >
> > > > >
> > > > > So this means, the PCIe devices can only access a specific carveo=
ut memory
> > > > > configured by MPU for DMA? If so, you should use 'dma-ranges' as =
suggested by
> > > > > Rob.
> > > > >
> > > > > 'memory-region' also serves the purpose, but for PCI, we have the=
 dedicated
> > > > > 'dma-ranges' property.
> > > >
> > > > I think I need some sort of guide on writing the 'dma-ranges' prope=
rty,
> > > > because it is not working for me.
> > > >
> > > > I'm adding
> > > >
> > > >     dma-ranges =3D <0x42000000 0 0x00000000 0 0xc0000000 0 0x400000=
0>;
> > > >
> > >
> > > So the device DMA address start from 0x0? Isn't it a 1:1 mapping?
> >
> > I actually don't know. But
> >
> > >         dma-ranges =3D <0x42000000 0 0xc0000000 0 0xc0000000 0 0x4000=
000>;
> >
> > this didn't work either.
>
>
> Hmm. Can you print the DMA address programmed to the device? i.e., the ad=
dress
> returned by dma_map_single() in the driver.

On a working system still using the restricted-dma-pool memory region,
it gives something like 0x00000000c0009000, so indeed it is 1:1 mapping?
These are for the RX/TX descriptors [1][2].

When using dma-ranges, the failure is from dma_alloc_coherent() [3][4],
which is the descriptor ring. On a working system, this is something
like 0x00000000c0c9d000, so again 1:1.

[1] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wireless/rea=
ltek/rtw88/pci.c#L221
[2] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wireless/rea=
ltek/rtw88/pci.c#L829
[3] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wireless/rea=
ltek/rtw88/pci.c#L192
[4] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wireless/rea=
ltek/rtw88/pci.c#L265

> Also, using prefetchable flag is not correct for DMA memory. You should u=
se:
>
>         dma-ranges =3D <0x02000000 0 0xc0000000 0 0xc0000000 0 0x4000000>=
;

This didn't work either. What exactly is supposed to handle dma-ranges?
I see some code parsing it in the PCI core, but it just saves it to a list.


Here's a function graph trace for the dma_alloc_coherent() call:

funcgraph_entry:                   |  dma_alloc_attrs() {
funcgraph_entry:        6.538 us   |    dma_alloc_from_dev_coherent(); (ret=
=3D0x0)
funcgraph_entry:                   |    dma_direct_alloc() {
funcgraph_entry:                   |      __dma_direct_alloc_pages.isra.0()=
 {
funcgraph_entry:        4.846 us   |        dma_alloc_contiguous(); (ret=3D=
0x0)
funcgraph_entry:                   |        __alloc_pages_noprof() {
funcgraph_entry:                   |          __alloc_frozen_pages_noprof()=
 {
funcgraph_entry:        5.539 us   |            fs_reclaim_acquire();
(ret=3D0xffffff80c7dcd580)
funcgraph_entry:        5.077 us   |            fs_reclaim_release();
(ret=3D0xffffff80c7dcd580)
funcgraph_entry:                   |            __might_sleep() {
funcgraph_entry:        5.153 us   |              __might_resched(); (ret=
=3D0x0)
funcgraph_exit:       + 16.230 us  |            } (ret=3D0x0)
funcgraph_entry:        5.077 us   |
__next_zones_zonelist(); (ret=3D0xffffffd055d598e0)
funcgraph_entry:                   |            get_page_from_freelist() {
funcgraph_entry:                   |              _raw_spin_trylock() {
funcgraph_entry:        5.385 us   |
do_raw_spin_trylock(); (ret=3D0x1)
funcgraph_exit:       + 16.923 us  |              } (ret=3D0x1)
funcgraph_entry:                   |              _raw_spin_unlock() {
funcgraph_entry:        5.077 us   |
do_raw_spin_unlock(); (ret=3D0x1)
funcgraph_exit:       + 16.538 us  |              } (ret=3D0x100000001)
funcgraph_exit:       + 54.231 us  |            } (ret=3D0xfffffffec051c540=
)
funcgraph_exit:       ! 123.462 us |          } (ret=3D0xfffffffec051c540)
funcgraph_exit:       ! 134.692 us |        } (ret=3D0xfffffffec051c540)
funcgraph_entry:                   |        __free_pages() {
funcgraph_entry:                   |          ___free_pages() {
funcgraph_entry:                   |            __free_frozen_pages() {
funcgraph_entry:        5.538 us   |
__get_pfnblock_flags_mask.isra.0(); (ret=3D0x0)
funcgraph_entry:                   |              _raw_spin_trylock() {
funcgraph_entry:        5.077 us   |
do_raw_spin_trylock(); (ret=3D0x1)
funcgraph_exit:       + 16.538 us  |              } (ret=3D0x1)
funcgraph_entry:        5.385 us   |
free_frozen_page_commit(); (ret=3D0x1)
funcgraph_entry:                   |              _raw_spin_unlock() {
funcgraph_entry:        5.077 us   |
do_raw_spin_unlock(); (ret=3D0x1)
funcgraph_exit:       + 16.385 us  |              } (ret=3D0x100000001)
funcgraph_exit:       + 75.000 us  |            } (ret=3D0x0)
funcgraph_exit:       + 86.230 us  |          } (ret=3D0x0)
funcgraph_exit:       + 97.384 us  |        } (ret=3D0x0)
funcgraph_exit:       ! 262.846 us |      } (ret=3D0x0)
funcgraph_exit:       ! 274.538 us |    } (ret=3D0x0)
funcgraph_exit:       ! 309.077 us |  } (ret=3D0x0)


And here are kernel logs for all the system's memory regions:

Reserved memory: created DMA memory pool at 0x000000013ff00000, size 1 MiB
OF: reserved mem: initialized node audio-dma-pool, compatible id shared-dma=
-pool
OF: reserved mem: 0x000000013ff00000..0x000000013fffffff (1024 KiB)
nomap non-reusable audio-dma-pool
OF: reserved mem: 0x00000000ffe65000..0x00000000fff64fff (1024 KiB)
map non-reusable ramoops
Reserved memory: created DMA memory pool at 0x0000000050000000, size 41 MiB
OF: reserved mem: initialized node scp@50000000, compatible id shared-dma-p=
ool
OF: reserved mem: 0x0000000050000000..0x00000000528fffff (41984 KiB)
nomap non-reusable scp@50000000
cma: Reserved 16 MiB at 0x00000000c3000000

Zone ranges:
  DMA      [mem 0x0000000040000000-0x00000000c3ffffff]
  DMA32    [mem 0x00000000c4000000-0x00000000ffffffff]
  Normal   [mem 0x0000000100000000-0x000000013fffffff]

Early memory node ranges
  node   0: [mem 0x0000000040000000-0x000000004fffffff]
  node   0: [mem 0x0000000050000000-0x00000000528fffff]
  node   0: [mem 0x0000000052900000-0x00000000545fffff]
  node   0: [mem 0x0000000054700000-0x00000000ffdfffff]
  node   0: [mem 0x0000000100000000-0x000000013fefffff]
  node   0: [mem 0x000000013ff00000-0x000000013fffffff]

software IO TLB: area num 8.
software IO TLB: mapped [mem 0x00000000bf000000-0x00000000c3000000] (64MB)


So I think it could be that the usable memory has all been given away to
other bits? But then dma_alloc_contiguous() returned NULL.


ChenYu
