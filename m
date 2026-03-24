Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615B322533
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338777; cv=pass; b=clbkaJW3nExK/OFjYel8Hink6vR+5g6OWLhQG7+ZdbD6vEzK4LiLsLZIruNKbKEt8TfoIxqlrEh5/hHAkKVI80h5Af4/EbloedI99RGLcghi01VgUBW8RN5QHfbUxW2CrP7b+MO4Sd2pSFbNka9ewkTzBbsVFVvaz93QgZ6sfBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338777; c=relaxed/simple;
	bh=USBh+tVheLxmbx53BLl5BUi7fvlJIIwzAaAzfKH9GYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=us8xPVTkRACdcmD6lS4hEc0M7IjSjGDU7/rDRpPvTXuEYedwD4oNo5lhXTdFoo8+O8eS4WRoKfKSCmaGx0Wu5zsJCDoZ1GJ0BVITxZNAVRQ5E2BRnSTWAvVfsxxj2u1lgB9gFvqbeUf41lYAQ3npq+mrndgjeFoZNMhb3q+YhpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iRY9wiXL; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRY9wiXL"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dea72099eso4560958e87.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 00:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774338764; cv=none;
        d=google.com; s=arc-20240605;
        b=KOAZ1GtCSrl2zkPBxtw1RX4GwsNnrYm73i0pGjBQ6snj1RSOkxevBEcancue12azPL
         ngb6V4TuZn4g9FIlXhljVF3IoW+a3FFO58MoHxEEBOCMLiGtMr9GSEduTZrs41AkbHrd
         omKWAyKXXmBGM2b4d2IRB9B5c5W/XMJxWCxBo9MXyV7ktNYi92X5OEaCcX1TAo/o7UHV
         1DIPTo4Q/IWy5QAhqfigw4aSjqio6RlS2QR6KlzJ3emqcO2K2aa/Q+Jx1X+P2Dnx1luy
         /5YdlMFewE8KIu079WBRQQ2YBMsqNXD7PaN8NdR9fH+YVjMTjYTzAIciYcCqeXoiyBFG
         9uyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tdt0USiBYnG3KyHcZx8kRYdTQ0jrISnlapnNZB8jd5g=;
        fh=imaI9M9h/Dz5ibXviN7Owb3vavFghcNORR4nNrZpgG8=;
        b=JmXhfObibYtS76x1a10vu7SRiu1NfNReg1PHzStEDEVM7mObIfY6bFfuiHl8baeMBi
         l+N82IP08FHoS7lXfZ0k/Q/sjQdlidKgBxtgUB3fl1jfD7E3KOA0dbfetlN4sjGGCcL1
         DwvZZC2tvYZS+r4eGLJgaaTexJeCcouWvIyOIQTaCvVNnNdXdhth6C5NFQfhxi2DkxRt
         Qhhu37eJYPTrP5TjhbM7J++FV4Uwe8VbmxDP8HaiiUxqYg0XUSuSFO3XClyIfX+WO3PZ
         ppp7LQIKjJAUBFqjvXzdycIfvpspi5DzbH+108Yiz8uXT6iUEV1PV62UxwFbk09uSc6Q
         sOdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774338764; x=1774943564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tdt0USiBYnG3KyHcZx8kRYdTQ0jrISnlapnNZB8jd5g=;
        b=iRY9wiXL/qG+ILoZm/GL9d69b7QDCkxBs/Ob+UZrDbdf9KiMgIIFOVrgjqU0DXM5oT
         9Acn4Y0abE6SW+c3A8TAyNMHoFC2wwV+3PqaF0R7WCo6bZKaWV7FQGAuFTKSxMrz+q2f
         gFLffwoTmvHTCwLT3KRRPh1OV+TjhRlXdwHyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774338764; x=1774943564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tdt0USiBYnG3KyHcZx8kRYdTQ0jrISnlapnNZB8jd5g=;
        b=RHtHmmnXZ9Fvi5qBaVTGoAClOZhBRRpPmX/0V3pwMCtGg7Gf9IiwbzNrxRgQi5bxIc
         QEx8Zz2dO0FXQ5AfS+tleqPfAMfb064hqVVAk+a8+a1PLxWaauR9Os6QccWN+j4guKxZ
         OxbeW7Qs4aqoP2belof600gxQVhhNUjNVSXNeXkHdLWgxD9ObPC52+mqeIaDAro6ODkn
         d7Zl+6pWZjEbcajFYQg4w4jdJq2VennfORBu4v91bVfif2zAwFOx1zz9aTNwBA8noBCK
         1MnIUUDjR4K7vU9/wWHmNTgqNxUaw3R/nkP9vD//5DHjM2wS4FD4u2nEjjnqcONz2iK4
         k3qA==
X-Forwarded-Encrypted: i=1; AJvYcCVN2sLUTMPS6nNJQ3sGO+ES6FD9yknp9W/JShdd1XNLr4d1mAzXytjuNZpXDReSmfpbVWE12NHSugY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAp1Q66UM//GaGb+w4eKC8sh/tKjf9mDg6mydhFT30i4drh0Da
	+0fQq2GHs1e5EB84xAEIKUt37LO37aFvwmZ0W0MDSHXm1kcb4BsJ0s5P6TYZvyPjwsopaZsbknL
	QerZtw+wCRyPQwUj3XC/iKqKjIQubkFJKYmm+rGmq
X-Gm-Gg: ATEYQzzJytVkoEz1IBaaaYoCEF3e4pBzaL09q0GW3E4tZ7TUTTaGR1Ac15sZG52aIcZ
	Tx9gJWLXHMa/K+5xGxJ2gYOZRx/Y6qCGy2tkbe2yedghRl+X5IgJZZFrdZtEOkWwpNbpE5+K2Ct
	szbTDuODG4DbuyTMMYGbG++WCFDOE4jKMtogZfTUhZN+sy9gYrRxeui09/xuCdFxIUAZgvBhb6o
	BjG5Oks6pPWQnVbz/lC+e7/nRbbbTa4YZMvcPsDIAU0OgY5SPZP4fnlMaj7KSRBfr6nAu7ytejH
	KYRoE9LimtoPqkCKmuyjHoAyQ3gXQKQnWtFlFg==
X-Received: by 2002:a05:6512:31c1:b0:5a1:2f0d:f31b with SMTP id
 2adb3069b0e04-5a285b54193mr4742075e87.21.1774338764160; Tue, 24 Mar 2026
 00:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324052002.4072430-1-wenst@chromium.org> <ojgwqrosft5x75y3yxdawrb72k4z3chc3m6uh4mkdv7dhta3ef@qcvotm36w3ly>
In-Reply-To: <ojgwqrosft5x75y3yxdawrb72k4z3chc3m6uh4mkdv7dhta3ef@qcvotm36w3ly>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Mar 2026 15:52:33 +0800
X-Gm-Features: AQROBzBm128UvbPNSaArneOenUHOuQf6cRKv0b34bJ0-HKCYO262piej0nwDdag
Message-ID: <CAGXv+5E4V-zC8hfzZgXLL+Wbnw4jFfs0pvovU0xKeDmN17mwUw@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 3:44=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Tue, Mar 24, 2026 at 01:19:52PM +0800, Chen-Yu Tsai wrote:
> > Hi folks,
> >
> > This is v6 of my MediaTek PCIe gen3 controller driver power control
> > support series. This series is based on next-20260323, with the
> > commit a2b2ca0c2477 ("Merge branch 'pci/controller/mediatek-gen3'")
> > reverted to drop the older version.
> >
> > This series is ready to be merged. Please drop the older version and us=
e
> > this one instead.
> >
> > Changes since v5:
> > - Link to v5: https://lore.kernel.org/all/20260311075223.3303497-1-wens=
t@chromium.org/
> > - Adapt to PCI_PWRCTRL_SLOT -> PCI_PWRCTRL_GENERIC Kconfig symbol name =
change
> >
> > Changes since v4:
> > - Link to v4: https://lore.kernel.org/all/20260310091947.2742004-1-wens=
t@chromium.org/
> > - Patch 1
> >   - Expanded tabs in commit message
> > - Patch 5
> >   - s/mtk_pcie_device_power_(up|down)/mtk_pcie_devices_power_(up|down)/
> > - Patch 6
> >   - Adapted to mtk_pcie_devices_power_down() name change
> > - Patch 7
> >   - Fixed label typo causing build break
> >   - Replaced "exploded" with "populated" in commit message, and added
> >     more explanation about what "populated onto the mainboard" means.
> >
> > Changes since v3:
> > - Link to v3: https://lore.kernel.org/all/20260302053109.1117091-1-wens=
t@chromium.org/
> > - Added two patches to move kernel setup code before controller setup
> >   code, and controller setup code before device setup code, as requeste=
d
> >   by Bjorn
> > - Dropped dts patches as they are already merged
> >
> > I kept all the existing reviewed-by tags, since the changes to the
> > existing patches aren't that big.
> >
> > Changes since v2:
> > - Link to v2: https://lore.kernel.org/all/20260226092234.3859740-1-wens=
t@chromium.org/
> > - Made PCIE_MEDIATEK_GEN3 select PCI_PWRCTRL_SLOT, following existing
> >   examples
> >
> > I do wonder why the existing ones don't select PCI_PWRCTRL instead.
> > As there are multiple providers, and now even the M.2 power sequencing
> > driver, I think either we enable the common ones by default, or let
> > the user pick and choose.
> >
>
> I agree with you. I've sent a patch [1] to select these drivers in defcon=
fig to
> make the users life easier. But in the meantime, let's have this dependen=
cy
> as-is, otherwise, until my defconfig patch lands, there is no guarantee t=
hat
> these drivers will get selected by default.

I would probably just make PCI_PWRCTRL_GENERIC default m or y.

Or make CONFIG_PCI (and probably CONFIG_USB later on) imply
CONFIG_POWER_SEQUENCING_PCIE_M2.

ChenYu


> I'll change these dependencies after v7.1-rc1.
>
> - Mani
>
> [1] https://lore.kernel.org/linux-arm-msm/20260324073931.23739-1-manivann=
an.sadhasivam@oss.qualcomm.com
>
> > Changes since v1:
> > - Link to v1: https://lore.kernel.org/all/20260224071258.2654521-1-wens=
t@chromium.org/
> > - commit message for patch 3 was rewritten
> > Jianjun Wang was dropped from the recipients as the email was
> > bouncing.
> >
> > This series adds power control support to the MediaTek PCIe gen3
> > controller driver. This allows proper modeling of WiFi and NVMe
> > adapters in the device tree and control over their power supplies.
> >
> > Patch 1 through 6 are cleanups and minor improvements to the driver.
> >
> > Patch 7 adds power control support using the new pwrctrl API to the
> > PCIe controller driver.
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
> >   PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out of mtk_pcie_setup()
> >   PCI: mediatek-gen3: Move controller setup steps before PERST# control
> >   PCI: mediatek-gen3: Add error path for resume driver callbacks
> >   PCI: mediatek-gen3: Split out device power helpers
> >   PCI: mediatek-gen3: Disable device if further setup fails
> >   PCI: mediatek-gen3: Integrate new pwrctrl API
> >
> >  drivers/pci/controller/Kconfig              |   1 +
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 223 +++++++++++---------
> >  2 files changed, 129 insertions(+), 95 deletions(-)
> >
> > --
> > 2.53.0.983.g0bb29b3bc5-goog
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
