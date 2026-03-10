Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923617C211
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 04:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773118200; cv=pass; b=qXgjurJiwHwAVYjoG9LLPOVfoHe10IOwauiMoB1N8kI6GvreUrFZEn2heKPdjj0WR4Bh4gFpb9su9v6innfQzPJTLQPXQyunKWNcPykEAc4dzRh9OwlGYpxZn1kEx5EhPHk/p6PXHdwaQF5d8kolIcWuu9PC4GbN61JbpHelf/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773118200; c=relaxed/simple;
	bh=MAJSsc8lNNvP/iPdy/xEkZJMM//XNwusgNiGyobk9XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elCR2J+skbeXB2+C1OakN83gDVuQ6pw4/0LMF2Z+Q3mvK9tYUdsV3MPG6IV65DkivGTljNprGtVQedi1DECFh2PcXuA9KUy6OQoD61BkeKzkaJ+ZB2dMGhhUJIy0Svf3mQKoU5Z0ah4ctov2bnvyofaO1WeC/6aKSr/9JyFP4wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V/c3Mghw; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V/c3Mghw"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a13d40c760so3756265e87.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Mar 2026 21:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773118197; cv=none;
        d=google.com; s=arc-20240605;
        b=bO7ELTZVBLMXFQbpBZyi23kB2Q/LeegrqnJYpU7MmYenFPD9SXHtmEjwiNnBk3dwPI
         io3g9C0HRswBMHrcCnwW5AU7dHwBNrjFkq7h82123Kn7ad2AY+5u1KlUg27ADlDkzdeX
         KA3gcVS9YjTXOiBfKQZ/bSmLwPU/VG8lmZbQhnz0cMlIdn5jJ+mM/8fW5toLSppAkatp
         ydwB9l3nYzNW23YueJYR6uutf4hjr8Sh+kzMgT96FX7Uj3Xo6SfHllw1F6Usjcrk0QmZ
         iNr5SS8ZJrcyScQpZVnbaYIgm/vj/K8CdLmI4OwDIbvLFbK6mGtZzBtSo8L6/540t2w2
         7S2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TEKfTgbEhZq5Nx64xwP1FBHJw6oBbygo97C/fty+4xg=;
        fh=W85eEadcM02OUMpxNrWea+SKQWY37Hjenc3pUQm+Ql4=;
        b=KiaMIsdHupKx/40qwKPKQC0ZOH/Bm9vannL+MoXBJfRcHGxpaQi24evK6e2a9OcYUW
         3c7ZvZsgYHrgAYlM4SOtK2RMLDp6cg79BkCSGNJHSsGa+h5M91e/rROd4yW7IQmuWxMP
         6LgPeJgTy1qSXO+0aFXbOzNJ/avA1+hauTEGYYkd8imlsFASVZKSrN0rvSxCc90x9HHE
         J7vJEtUOShAgECF/XpGQ6zybtO1JMIzGFDomAUrUONT0hQV1Y0MxDMi79SMjE10GmVjg
         MWjN70dJYVD7NKDa0vlZTKGWw+l9f2dib83Fi5PAYLYBSt3LA2WrBF6FsiPbmcuOOtIq
         4exg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773118197; x=1773722997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEKfTgbEhZq5Nx64xwP1FBHJw6oBbygo97C/fty+4xg=;
        b=V/c3MghwWNv6UGOVjDmIe/wFGBjSqbA41UOfdkNuQ9sdGekq0VLiB2hc332bM+44bc
         Fo3yNBaKQeuOaFCWCDzAtU3ryT1djJBuw0CoSzF6HL5KqmS/Fm8oqK6iwYWVFInNuiU8
         WR1K6kvUjwSHb3+8JBFxOtiOT1llY7psmnjjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773118197; x=1773722997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TEKfTgbEhZq5Nx64xwP1FBHJw6oBbygo97C/fty+4xg=;
        b=sn10way++lU6HSnXbtFwNeS7f1RT5/6CXn+M8ir2ifBeVQBAGRSF6htPQXLWB8cP1v
         pSkoQpGv5AoC+fjUOyDGtkuZHlm+ftoOlWIOR6FqtBWS0qWfxfJauEkowLlQaspWENmR
         yMAM1BziNiqIN4GGd4psHhbSvhsXkhVLgcjlFpfcPUH45VAkxnoMykDsy7NjGRohMSEM
         rAZVcvTMh74YY+Rjh1hjheZ0ID/VfpbqXh6lzCilIF1c3WR/2ZjnZZ+XeZYqGIr3n46i
         bjX9LY4wSlyT3dUY6BCcJPDMkyjYZXoedQP7gJyq0jXxs/uExIpTguluHyi2/g/E1dPC
         /DeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0T44Bc8J/bU/g5V5kHK1DOjqMIX0KQGHHBt915wZEqL9PQeMjdu1Z0iEUqz5E4bxfDpSOyBR/n78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIV4gGCSYkwzhlX0w8crXt2YukNDAgFagIyQJH3vQJ8Ci1lkI
	GNw8fNsn2fDz4ugJi27T6W1mGx4TzxRXBHKjv15IcQ0CN2/wwhl5Hkc+trgHhefTjjw6+LVZ7Wf
	j6pZD6RuircPQGD72kM/haPM7Q7t0UGVIN5lzcKEH
X-Gm-Gg: ATEYQzw3uMaHdsxQMIuqImkl5l1MN/z15xPlQV5I0o4lFAl6tKUs2YVkrg4Rh3YtTVR
	xp1XL4JGj6ls74ZCrmWYkwiBhE+JWPX8tCVg4w3PvWOy3gty6D9Fp2FQ9UjEam5QIaqDOjmCSpH
	1/sdhPp934D2Z+S68mmfXGds1KToM4KYMIFCwkEzN2hofnhl8PRMHgZyGXh+sCKJ5vm/MyJ65MM
	KJL8LmMeDN8M/FO2zuE7Yyx2qLST+ZRxvqSrfVpqJ3fCldTwhsG5yBMYgQOW5ufXhyxA7H06BiJ
	p7ydIMj2BGvbDm6tB6oZcsXTPVZkJ63qGQDMNkHLvd/FARVU
X-Received: by 2002:a05:6512:682:b0:5a1:30b2:f2c with SMTP id
 2adb3069b0e04-5a13cd5e33bmr4296147e87.42.1773118197277; Mon, 09 Mar 2026
 21:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXv+5FhSO=+AUaeDSXgM9Je9uTVYq-EW43z9PAuvVKumK6oMg@mail.gmail.com>
 <20260309215056.GA603013@bhelgaas>
In-Reply-To: <20260309215056.GA603013@bhelgaas>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 10 Mar 2026 12:49:45 +0800
X-Gm-Features: AaiRm52BnH_hbfy2T5LoFoBuz9-oVGOul1adbuGmfRTlnBvnGQgJ2RzpGs8zhxc
Message-ID: <CAGXv+5HHm6Tdis7s5ZNd9ErNrCHv73U7fFxsN3z+DS+q=pxK0w@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 5:50=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Mar 09, 2026 at 01:24:34PM +0800, Chen-Yu Tsai wrote:
> > On Sat, Mar 7, 2026 at 4:59=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Mon, Mar 02, 2026 at 01:31:05PM +0800, Chen-Yu Tsai wrote:
> > > > With the new PCI pwrctrl API and PCI slot binding and power drivers=
, we
> > > > now have a way to describe and power up WiFi/BT adapters connected
> > > > through a PCIe or M.2 slot, or exploded onto the mainboard itself.
> > ...
>
> > > So now we have:
> > >
> > >   mtk_pcie_probe
> > >     mtk_pcie_setup
> > >       mtk_pcie_startup_port
> > >         mtk_pcie_device_power_up      <-- power up
> > >         mtk_pcie_device_power_down    # error path
> > >       mtk_pcie_setup_irq              # set up controller IRQ
> > >       mtk_pcie_device_power_down      # if mtk_pcie_setup_irq() faile=
d
> > >     pci_host_probe                    # enumerate downstream devices
> > >     mtk_pcie_device_power_down        # if pci_host_probe() failed
> > >
> > > I think this is kind of a mess because mtk_pcie_device_power_down() i=
s
> > > called from so many places, and some of them aren't connected to the
> > > mtk_pcie_device_power_up().
> > >
> > > In mtk_pcie_setup(), mtk_pcie_setup_irq() only deals with the
> > > *controller* IRQ and has nothing to do with the downstream devices.  =
I
> > > think mtk_pcie_setup_irq() should be done before
> > > mtk_pcie_startup_port() so we can abort before even powering up those
> > > devices.
> >
> > Makes sense to me. I think it can even be moved outside of mtk_pcie_set=
up()?
> > That way we don't have mtk_pcie_irq_teardown() in two error paths?
> >
> > I can send a follow up patch for that.
>
> What if we do those cleanups first?  That would make this patch quite
> a bit simpler and we wouldn't have to undo things.  It would be a
> shame to have a complicated patch to add this stuff, then another
> complicated patch to clean it up.

Sure.

> > > In mtk_pcie_startup_port(), mtk_pcie_enable_msi() and the PCIe
> > > translation window setup also don't have anything to do with the
> > > downstream devices, so I think they should be done before
> > > calling mtk_pcie_device_power_up().  The only thing there that needs
> > > the downstream devices powered up is waiting for the link to come up.
> >
> > My guess is that if the link up fails, then mtk_pcie_startup_port() is
> > going to error out anyway, so it maybe made sense to make sure a device
> > is actually present before doing any more work.
>
> Doesn't sound very convincing to me.  mtk_pcie_set_trans_table() and
> the window setup are local things with no timeouts or anything.  I
> think the logical structure is way more important than some kind of
> hand-crafted work avoidance.

I understand. I merely meant that I have no actual knowledge of why it
happened, or if there are any concerns from the hardware side.

> Separating the PCIe controller setup from things related to the link
> and downstream devices is pretty high on my list.

Makes sense to me.

I'll send an updated version.


Thanks
ChenYu
