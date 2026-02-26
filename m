Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC22BE056
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772086353; cv=pass; b=crhgrD9EgYMp/r+7bbjnnZL8gr7zWkiY/2HMcpAbXRDkmnyb53tryDCSUig7Cl/eAoVXN2ws1tVTQE/Vi53QmJy0lQY9eTzZgC2G5c6XaW/J0IaBV5S2X5NyChXgi97xnrPT1KL6NGTI0TM0tloey2hJRU0dPi5uhqLE5w7JfYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772086353; c=relaxed/simple;
	bh=B3h3A+ILv8Ce7qs+OmsKL4MvbpGMHVNKe5cTLkyB8Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uf1faV0eI+dMhazeF5GzG5IdiqkCR31vMDjDzv6dYPfQHuOBpT/yr3Bn34C19OsVXbhmK/aOUgbAtGeWw7LmQk+VF9GUAFKwQLtFWCTHFpU7VLn4m9J+P4kr0lmDEI/5PeAnTZand9RV5/orzBTjoXTSiAJLSO5vrwq0rXof8ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oA63JqoS; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oA63JqoS"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso598236e87.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:12:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772086351; cv=none;
        d=google.com; s=arc-20240605;
        b=bBZUT26HdCsqtEwKBoPxkaBpXgPS4+9JQY1wsUb1ZexlborpyeXW+7kCKWBkpZ9aSY
         kG31a7R7qCxfwJtCJtzW8+nBdMmw/glAPxEpkgBueGL1AuK9omL12e16wLOUuJjq1iut
         2wqYtx+zXxp8ACSTh/2E9sVWKW/VBCUs8tu87NU8wgmROcWfReI4zieaAE9roMA/qTpn
         n3Q9DpLAfqNK0gh6i4KSItY4bfGCEgkuPdcbDJG2UhDJDLZVNAz2oM/yDXgnad5FuZJI
         DgeTR3DyDpEj+gmPlqol+1Ou8+GYUE2AyJBk66AaecvOf4xh+MBR4oQXofDf+MPINC1Y
         OAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SZr1Ou6tY3TudV/DCBYFuPdgoLpFgmS9h0sv4mAVKrk=;
        fh=vUIIhibesZQiSnRCNqj66QQPej4by0bi5KZDlXvnmzA=;
        b=PJWtRjELoXPjnLeQijm/I+etJ7RYqGrGmdtzAvyEjQQpE+LNg1PzSkHTTEra1K5Tl3
         ZeG66FyINl0kP2B2l90UK2ve4coyWkdB/qqrYVJdzwC+KJ9p9S/+pDVCRkXVhmfCf61p
         9xKa2eu+t+jn3AtMf67xdYhA5TcPZNl6xscf4mKf5xVHGyF9MB26pL9JhwraG/L2FvNe
         6heDfJzzGzTYLNRJwrd3C8KiI6gkffTury9sWTgbGZLB4Mt+xJINRwfoih8PXhJgElPL
         d/1SEDcpn9qSKzg1AypXwgxaRccfFiERKrosyMsdotYUg9u2nkx03g7gSANDdks+lFlq
         5APg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772086351; x=1772691151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZr1Ou6tY3TudV/DCBYFuPdgoLpFgmS9h0sv4mAVKrk=;
        b=oA63JqoSM3piPkS10rncpoPF2Zv8Vq/Gpw/w41Vox/9JNckfQkufXpnx+8nKH3z25S
         9IPkgbzvd+Q36OIrdOxgcjGXV8BFWdZMpC/f3WKbiXSPlC24nhrQSXO+XEU2H9ZRjn1Y
         eBOwSmqKpejs4SP1NxSAxeGKDuASSfiz15KXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772086351; x=1772691151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SZr1Ou6tY3TudV/DCBYFuPdgoLpFgmS9h0sv4mAVKrk=;
        b=e9LAYwhu4fYWfkrmlOk2UWgUngSOmRE0vkFQNc3s2IrdrogFIVVcxwBKroRRx/cNuZ
         cGbsBFAHBz7vfxxFVlaWAgzjnNTrn9aTNBp86cZDO7Ae8r8eqHHVd0TtmNMQJVffbhwo
         33+X2B2KXws7t3aWEyy4BGYqzxbnrZ7ShT2hiiuxEBsegAN17bZSKhFNt74QOrtsOOkI
         H7pHpwOkLr9uLsqtwhNbIpLA0Di6U+AJ3TaqtrPd/h7wURsJ4lL81l7bqdva98W3JFBC
         bklQzfxVy2oHoaBW9nA3kNATV6ejAuzV0ZMoXl7xm1h+sJqqMPRKe1EVzbPzAjys9iNr
         YwDA==
X-Forwarded-Encrypted: i=1; AJvYcCWzl5JjaNE2qX8baFWYrh/T3oVx1wjQiSkLQO0Qc8EAnGTsBt6I7cMaPsn9Ac5fnFHm60gIF919CWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VZhiaqCA/2bO71EJizftQNP4cpLJu3KQQ8B/N68WF3xPkVHD
	XrA1rfZcGdp4/h5LWfOq2zZvBGytfb/B6exJAB2r+4Em7lRksRk3VZcHn3qpDOz5aivjM53hFUM
	1JWGYXrfO0bJJ5dxVtkk3fGOfFK/Nk7B3xaTGkty/
X-Gm-Gg: ATEYQzyjhlmU4cZksJy/N7iZ8cOUOw9iqLxPIJww2QBr+9LSTQFWsf9igCMViMiBiBV
	EYWjQT5YvWvZS9JBAIjRj47rprnz6NP8pCNzV9eHcM4koM1WSqbg0mG1htpNwUnxxSAnpNh6Yfy
	a+BSLjLdH9nI8/K8wn94XZyIqc6L8ZxRnk29nABIIrDmOz9jNm28cVFnfO4zzNyOq+TxSXLvSzU
	1BFkBfXhm2jBz1QG10nseOh7WueBn7i4p/AqhPpg/y87dtxDL3MryEh33otcVJcZBswgbxcuvgO
	5sA8PxV4baIhyPgptfnS/O7zoK3/KiYntPU84g==
X-Received: by 2002:a05:6512:3c9f:b0:59e:1a32:376f with SMTP id
 2adb3069b0e04-5a0ed88c5a1mr6027586e87.22.1772086350568; Wed, 25 Feb 2026
 22:12:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072225.3345307-1-wenst@chromium.org> <knddbvl6qti4pyaphudrmhbx7jm245tsmpa37snk4frtphcuz2@am6aatvc6hbr>
In-Reply-To: <knddbvl6qti4pyaphudrmhbx7jm245tsmpa37snk4frtphcuz2@am6aatvc6hbr>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 26 Feb 2026 14:12:19 +0800
X-Gm-Features: AaiRm51hju21fa_yFDX4K_BlO1UHUo4C27fJmxo88iheU3vUI_evoR4nfNhfQUA
Message-ID: <CAGXv+5FXZPviNSVmrM7-CEkwCQOsYy9PkguBgnzzTrk4wwCqnw@mail.gmail.com>
Subject: Re: [PATCH 0/7] PCI: mediatek-gen3: add power control support
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 9:25=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Feb 25, 2026 at 03:22:17PM +0800, Chen-Yu Tsai wrote:
> > Hi folks,
> >
> > This series adds power control support to the MediaTek PCIe gen3
> > controller driver. This allows proper modeling of WiFi and NVMe
> > adapters in the device tree and control over their power supplies.
> >
> > Patch 1 through 4 are cleanups and minor improvements to the driver.
> >
> > Patch 5 adds power control support using the new pwrctrl API to the
> > PCIe controller driver.
> >
> > Patch 6 adds the WiFi and BT power supplies for the MT8195 Cherry desig=
n.
> > This is actually a M.2 E-key slot, but support for that is still WIP [1=
].
> > And even with it merged, support for the USB side still needs to be
> > figured out.
> >
> > We can either merge this as is for now, and do another conversion later=
,
> > or just keep this one out. However this is still an improvement over
> > the current device tree, in which the power for the slot is always on
> > using a pinctrl setting.
> >
> > Patch 7 adds the M.2 M-key NVMe slot found on MT8195 Dojo Chromebooks.
> > This change actually makes use of the M.2 pwrseq driver.
> >
>
> Thanks a lot for doing this! I'll also try to get the Key E support for v=
7.1.

Ack. I'll try to look into how to hook up USB for Key E.

> For the whole series,
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>
> - Mani
>
> >
> > Please have a look.
> >
> >
> > Thanks
> > ChenYu
> >
> > [1] https://lore.kernel.org/linux-pci/20260224-pci-m2-e-v5-0-dd9b9501d3=
3c@oss.qualcomm.com/
> >
> > Chen-Yu Tsai (7):
> >   PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with
> >     dev_err_probe()
> >   PCI: mediatek-gen3: Add error path for probe and resume driver
> >     callbacks
> >   PCI: mediatek-gen3: Split out device power helpers
> >   PCI: mediatek-gen3: Disable device if further setup fails
> >   PCI: mediatek-gen3: Integrate new pwrctrl API
> >   arm64: dts: mediatek: mt8195-cherry: add WiFi PCIe and BT USB power
> >     supplies
> >   arm64: dts: mediatek: mt8195-cherry-dojo: Describe M.2 M-key NVMe slo=
t
> >
> >  .../dts/mediatek/mt8195-cherry-dojo-r1.dts    |  38 ++++
> >  .../boot/dts/mediatek/mt8195-cherry.dtsi      |  47 +++--
> >  drivers/pci/controller/pcie-mediatek-gen3.c   | 185 +++++++++++-------
> >  3 files changed, 183 insertions(+), 87 deletions(-)
> >
> > --
> > 2.53.0.414.gf7e9f6c205-goog
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
