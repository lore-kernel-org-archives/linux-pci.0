Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A2387347
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340802; cv=pass; b=O7Jv8RtQbmdRmM+GqMjvveWKMQq5Z+u27mb/dLT7HfOKE0iZOqMMuv1dpxQqlnDpxl2MHtcxP3mY8TLGmSudpVorXmaocHEerndI8P7GH+EFTFKbwmWCUr6ixm4zFyOii7KIM/4vVI2HnZK48WrceDKc/rD2rigVqZGfku84kqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340802; c=relaxed/simple;
	bh=94bk+RX23wjGN7VtefTczkJJ5K4UJ1xlqZuQgsqLUJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/FhqhWnKugkKIPMHdFZDS+AnfSwmZy6E6cODPiYc0XE44jX0IO1WlxnE54hni9tI0/iZqvidbVKeVxJhjOwxld2SfhAVckf3ms/19yI2f/Wi8EWvz7pRCgD5UcO/kQ8t30NdwurbhQbafQtYDN8h5DPvURlwvMHfoeSaef/ehE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kjDl4hle; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kjDl4hle"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so9240015ad.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 01:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774340795; cv=none;
        d=google.com; s=arc-20240605;
        b=dVAe+9Yco953UC9DCBVh0r4OQty2aw0G1IXhxNt5nCqUdv8OWw6dPXV5il5fe5jhwJ
         IHNN2h6Plo9rJlTxmGByG7/NmwhjUhj2CmFpH41KWnya/Ge9fq+98+VwQ9iXQllf98wc
         13DMH4cyFYkG9owOD53LNWHFjG+qkguoCYsfB1p4/ZPsu84i9apZLK2f983Z1RbzeNmM
         TD40sPpB2MRTHUrR1bCcRxBSF2SF7kmb5md8Tud02psyyeozmYom2Cey1JlxyYuynidD
         vZnuh3Sw7csaxUpkJbWkEcTdNcur/ddr1IQ78pJOwqvEeCLz3TxIl2N9c5D7qO8I/ldv
         phEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iGgmaJxj2IZXFux6HiJZXoAsX/3q5eAbJg/qUyr5Vmg=;
        fh=bSZJd6Xg+1KaDV0KScIAqisCUNoWd4d32Cmz0hEv7A8=;
        b=NCXYuVH7k5ZHZ7kCRqsqRXyfAzG7lR8aqfIY2YmVG3mBTXNTmS7GTQ2Zcmp5+vAkjA
         5hinnDLqfiDq6qDl2bgjtOjFG+KFZe/woZln/Ukv3Sw2L5IUB+zOC7lBgEW51NVraQsg
         HsxsxzR9VdCQDxR4o6LkX9m17OyXNL3U71dh96E+k1dAJ12L9MJdyhWiGh4C9NTbYq4h
         Sbxi8o4uawM86IDC6mm3hLpb/fYeQglniJ2U4W+zgwwDwgba7+0JJzWcGPRMIPFGMicq
         wjJ8vzRawzWvSq5YHW5qfG95EM1loDyhDc80pI34eSZpLys5FDN+qEQE/TQtrVYIJl4j
         9BXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774340795; x=1774945595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGgmaJxj2IZXFux6HiJZXoAsX/3q5eAbJg/qUyr5Vmg=;
        b=kjDl4hlePBv6Go6081HGpNOFdjyJpR90LLD3AsOA296KwNiPWjMs9QHaVr5TNrykF+
         BiDsV5pX0KN3+7PM58gUZQ4XjNxhrbkWbX/zKqT9ASe5GSGvieU7L7eXR0zTODXJ38rl
         /5Dd44s2N+wLzFQZsqu8DTmaTbH3BbSdgRMFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774340795; x=1774945595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iGgmaJxj2IZXFux6HiJZXoAsX/3q5eAbJg/qUyr5Vmg=;
        b=WHZID5kmF0OK4TznjO00+jBO7fib5625JjLcZt0FnR1BIN1lWxSbG+bPD0NiSIbJ1q
         BViwHo9BVeDmQG8qO4AWcSvRj0SifoTeoEWaV+c7teeabOS314ccuA9UA90uNSWuCvV8
         O2UWafLYDOi6X8WDcnsXoSJkznitowjleqJQsM13Fh36VI677cpo7+XZkLTFVKQ/tfDv
         vKhrZLkoQI/bfnWLgjyYyOdKN3SLw1bcQ3ZvKySfZhwWS9I4wcAC9zeU3E/GFXkcXFKa
         QPvz6zOOD7vwcs/WGs8V/a0lONDbkItYMIiEfmPhiUrUmE1Sc/Tw+CSeF4bAmP0Daivl
         L6tA==
X-Forwarded-Encrypted: i=1; AJvYcCVBH7kMeguZjde/kX98GZnHqE7kz6YDuReCn6w5vvg2nRiR/psAUwagAjAdMqM2Ql+MvwfUKMhEkTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtTstuSq2KTbeB2t9Jr12fW8kluYgkgYhESiRnyfvzchmdO5G
	2OKji3u7fgzPCbfT4Gkj/Fnoh6mAUysUoRZuBdI6xCOr1Oktom4pMsAXikzTM3nwwPM5us2dwJG
	fTEFybgszIT1VWG0YfuxL53cDgxEjAoUc7Rt7DFqx
X-Gm-Gg: ATEYQzwc/mndTc4e9ZYJNcc0/IagncFvl1gXKsgAW8g55qP2V5aXs/X71ZNqdtqQXT7
	SUkv7oaR+ZqLmW1RBTfM181r+mfnd4GEuKKncSn7JbcgKeg8Q7g26hqZj1igYnFGfTW2TtoqeaJ
	QBmaupvM/h25HTjRYMmWxgrtwkqtEQrGkFSTiJpxZUD7rWXN7BbV6NB1hfT6yIrfwZADAfI8SEZ
	90pl5pRY346gWcFd1j3CIW1LnFfczIqZJuue4Mn+iqxCBKw3gFDRSIQU7lbltQSNvIEI3mvzwYY
	4eyc/HpMrHoxSyPJUG3x91sAPe7frzX9GsCGjw==
X-Received: by 2002:a17:902:f64f:b0:2b0:ac1e:9720 with SMTP id
 d9443c01a7336-2b0ac1e9aabmr3301315ad.23.1774340795512; Tue, 24 Mar 2026
 01:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324052002.4072430-1-wenst@chromium.org> <ojgwqrosft5x75y3yxdawrb72k4z3chc3m6uh4mkdv7dhta3ef@qcvotm36w3ly>
 <CAGXv+5E4V-zC8hfzZgXLL+Wbnw4jFfs0pvovU0xKeDmN17mwUw@mail.gmail.com> <jduc7ozg27bvrfxwpmswhxg4savnrkjcj5tqlluvmq5s6qiqnd@nrq6b36g25wq>
In-Reply-To: <jduc7ozg27bvrfxwpmswhxg4savnrkjcj5tqlluvmq5s6qiqnd@nrq6b36g25wq>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Mar 2026 16:26:22 +0800
X-Gm-Features: AaiRm53L7-tohEy9tkTEmWIGpQ_r6cXSvnDVT5CV84nam-7MkSk5kPI4V-F5z1Y
Message-ID: <CAGXv+5ExO7h9VpXC=oV=bnb6k+vRA_OJH3tmPWVpxqs_hy=QJg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] PCI: mediatek-gen3: add power control support
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:01=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Tue, Mar 24, 2026 at 03:52:33PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Mar 24, 2026 at 3:44=E2=80=AFPM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Tue, Mar 24, 2026 at 01:19:52PM +0800, Chen-Yu Tsai wrote:
> > > > Hi folks,
> > > >
> > > > This is v6 of my MediaTek PCIe gen3 controller driver power control
> > > > support series. This series is based on next-20260323, with the
> > > > commit a2b2ca0c2477 ("Merge branch 'pci/controller/mediatek-gen3'")
> > > > reverted to drop the older version.
> > > >
> > > > This series is ready to be merged. Please drop the older version an=
d use
> > > > this one instead.
> > > >
> > > > Changes since v5:
> > > > - Link to v5: https://lore.kernel.org/all/20260311075223.3303497-1-=
wenst@chromium.org/
> > > > - Adapt to PCI_PWRCTRL_SLOT -> PCI_PWRCTRL_GENERIC Kconfig symbol n=
ame change
> > > >
> > > > Changes since v4:
> > > > - Link to v4: https://lore.kernel.org/all/20260310091947.2742004-1-=
wenst@chromium.org/
> > > > - Patch 1
> > > >   - Expanded tabs in commit message
> > > > - Patch 5
> > > >   - s/mtk_pcie_device_power_(up|down)/mtk_pcie_devices_power_(up|do=
wn)/
> > > > - Patch 6
> > > >   - Adapted to mtk_pcie_devices_power_down() name change
> > > > - Patch 7
> > > >   - Fixed label typo causing build break
> > > >   - Replaced "exploded" with "populated" in commit message, and add=
ed
> > > >     more explanation about what "populated onto the mainboard" mean=
s.
> > > >
> > > > Changes since v3:
> > > > - Link to v3: https://lore.kernel.org/all/20260302053109.1117091-1-=
wenst@chromium.org/
> > > > - Added two patches to move kernel setup code before controller set=
up
> > > >   code, and controller setup code before device setup code, as requ=
ested
> > > >   by Bjorn
> > > > - Dropped dts patches as they are already merged
> > > >
> > > > I kept all the existing reviewed-by tags, since the changes to the
> > > > existing patches aren't that big.
> > > >
> > > > Changes since v2:
> > > > - Link to v2: https://lore.kernel.org/all/20260226092234.3859740-1-=
wenst@chromium.org/
> > > > - Made PCIE_MEDIATEK_GEN3 select PCI_PWRCTRL_SLOT, following existi=
ng
> > > >   examples
> > > >
> > > > I do wonder why the existing ones don't select PCI_PWRCTRL instead.
> > > > As there are multiple providers, and now even the M.2 power sequenc=
ing
> > > > driver, I think either we enable the common ones by default, or let
> > > > the user pick and choose.
> > > >
> > >
> > > I agree with you. I've sent a patch [1] to select these drivers in de=
fconfig to
> > > make the users life easier. But in the meantime, let's have this depe=
ndency
> > > as-is, otherwise, until my defconfig patch lands, there is no guarant=
ee that
> > > these drivers will get selected by default.
> >
> > I would probably just make PCI_PWRCTRL_GENERIC default m or y.
> >
> > Or make CONFIG_PCI (and probably CONFIG_USB later on) imply
> > CONFIG_POWER_SEQUENCING_PCIE_M2.
> >
>
> The problem is, these drivers are mostly targeted for DT systems as of no=
w. If
> we select it by default for all archs, it will bloat the image size for o=
ther
> archs that don't need these drivers. That's why I wanted to enable these =
in arch
> defconfig.

How about

    imply CONFIG_POWER_SEQUENCING_PCIE_M2 if OF
