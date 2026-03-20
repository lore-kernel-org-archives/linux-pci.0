Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B33327A92E
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773987017; cv=pass; b=ukjgua9MjXg/H/R1uUGHenSsCarHPTgWYpB2T0dupOkli1SIhksMsFWxAb8VlSB3kxRsQbIA5LpXWk3YFGfI+lVRvXgrcRinqZC5dTTRUB6CJLmHPSl1KqEgJQCFazcPmgWe849m7tkuRqaknNwHV2gWWhCsMkF5TzaJehPS9S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773987017; c=relaxed/simple;
	bh=SGmEs7Ku77hqWxLNgXD5fjrsuOXi2m/2pxfSILCsCxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euqL6cX1/Xw1FSJs9Usa4cm2J1bdMQe2RVerQBe9n6m/VIuzYZWpMlrEVj9QYrsXcy2ZA/W9vFgI3SbybIUCSHKPYgkKLgTJ1V0e83lDd6iAIAm35oA5bX3KNloYio0fXqss7jQc0p1pTqNcX3pVo8Mi4PRopLt3v6QtAuGExO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gqwJPoWg; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqwJPoWg"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so1659509e87.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 23:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773987014; cv=none;
        d=google.com; s=arc-20240605;
        b=LhgKuWWqu84oPDTo8J/gks6zSPcQxT9Ed+/KJQkMA06Za1Yl5RyJMGU9KZxDH6wJjr
         E7A1QInJtgfMG072xQY6MzvhGF6pRYOYjP8h8CxQ7AmdceF61j9J3LHiv0fmCvOCSAPv
         huW+5TvTos166jabnoZMvXfDuV2FUXL663gg/ndypk07w92fAt1g9PFAv19sqL2rIFNs
         h2pYJZ0TE72TOTsgW4B5TjO0pIkqx+pOhKsYiyuT+V5s8GQ3cEoDT2B7iOUzamWClDTL
         TFzw4WnZiHVawbbw9toaCaWsY5hal3hvLjtfUtz2pom0lqtNanqX463HKN/DYv/IP24u
         7GCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+pCA0Y9k1ALYtSvBXX1rMagce1N/PUIuFCZYmZlM/qY=;
        fh=4X3AplHBQDVsuXHBKiFOFcl/CJBFTrHprrSEknoctdI=;
        b=FeT7Ae1ze6FqgsL/fSfqbxTKE5E91i+U/wwxoRMJYkD+HW8LIAt5CzH5iNWqm3xkvu
         lYbdLw6fe+bqZjdsJS4J4Z4ZOoVStWAITriJLxEEQYJH0a6sr+HasyveaMetVTJvFXlR
         FbFc/rDFkSImg7wCTF1XiJfkYLNBojxtOJ+fXDNxKnv/kNorcceYEyrdYQhobhhMiRPC
         Kwh9IRpsrg+nmilU/0Fn/q4bfPgNVqasHZCwFV8s71JFi2ctp4iTP2fW/r6dsb+W1yCI
         20+VxlRUhDNj9WVbXLBoo8eTZtCsCUooe5WJ1Hd75SJUP3I0WyUGfMZycjLjNc0JUXN1
         nBow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773987014; x=1774591814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pCA0Y9k1ALYtSvBXX1rMagce1N/PUIuFCZYmZlM/qY=;
        b=gqwJPoWgh7pks7Ii1l+U59ojOv9tdt3WCt4WtulbkiorBlE1O+Od49MCLDqWBBlHMa
         9CDUUhFnsxlKoaoL2rgYAuBsLRfk0S80N1YHNtvfEp1DDihcVRDGyzNuibDelog10sNj
         Gm6+iKLBwpkS//sgOOUAcuSt24V6Qc3HwPQ3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773987014; x=1774591814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+pCA0Y9k1ALYtSvBXX1rMagce1N/PUIuFCZYmZlM/qY=;
        b=hVh5nx4kOisjmyUnv/j38HOqygefaOTfC96svbkDmyRZcOZTUwm3mrpUz8TAIlX+Ii
         x/uNEz0FxSliyPxa0AeFP5S4oVnOU47eSscjWLJY4bMmMkMRi4fiEw36BMmlQOx9vYzP
         vfACvd+/fqIi+gEd5+b8q7n9qK/y4Vwoox5gPUNYH/9lqdslVaFZOlo/CxKMO01zoUk5
         AyR/04tRuk+prDYWWL2xwivaPT3tJjA3JgTLo5hhWLIcRW7DCKwQIKYEL64PWsQ1EGoV
         zTwnYfIWTG2okNpi//yAZX1IWFJX9Uy3MAIw0rU1ICu6oIixUVyDCPzGWrMmKZpHGkGi
         BhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVcDDHDGnjbU8kRJyY8+SL37R9ij0mxGt9TxqcdMfdK7AG8kspxWeaqy1BxuRlDjaB3PQxe3/WR0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9G2MPLJ6b/hk906pTiUwoaYP98jXCEaJvgrNOHr6npGERMs4f
	FAUwml+7CFsgoXCI8UpL9TkMZ1/qU5YFYig51u513Do/hbSmFOv/imacayjfb5dC75AT1pyIlrD
	qPTLvsBRT1TlflTAw3tN+30CqgQxUlGQ24mJNwpJD
X-Gm-Gg: ATEYQzzQYsk1pSp+BrwKBxza6+15vx2UEq0IaC/jXu52vXSiMQ9tYj3B0cjTLxB1sDm
	3VVQaos06jsumXXQTPQ9kytnbrlCXdUwJ9vjciMhKIB6cvOR932v56QhN2e9OjQQZpm8zdmIbsH
	cxDp+XG3y/QNvxlolf3FxSgSu/amOlPjD+yBlmxDpmlaODuTvXr25jh2Ved+iu8aBwYpSerOfvM
	2VKFlI6gPxc+o7goBWAlP1O9VZfHzPnJgFJRRf+xw241y/PzawKMz1t93DY745vYHCikbEzDzDt
	jrFSdYkzGr/nqLwzDPyLV1Tm+v273nC7JMUrIQ==
X-Received: by 2002:a05:6512:33ce:b0:5a1:2e14:134b with SMTP id
 2adb3069b0e04-5a285ae3410mr590453e87.4.1773987014439; Thu, 19 Mar 2026
 23:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXv+5FhSO=+AUaeDSXgM9Je9uTVYq-EW43z9PAuvVKumK6oMg@mail.gmail.com>
 <20260309215056.GA603013@bhelgaas> <CAGXv+5HHm6Tdis7s5ZNd9ErNrCHv73U7fFxsN3z+DS+q=pxK0w@mail.gmail.com>
In-Reply-To: <CAGXv+5HHm6Tdis7s5ZNd9ErNrCHv73U7fFxsN3z+DS+q=pxK0w@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 20 Mar 2026 14:10:03 +0800
X-Gm-Features: AaiRm52IuEwlj2YQb5Sz6HwgUbNaTD0PesNM08MExt-MYdM6k4KSEpkm7Hbd12Y
Message-ID: <CAGXv+5HQY9nTCacUbNZL1XggiHqomhgiQH_gdFtXLra+_ut4fQ@mail.gmail.com>
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

On Tue, Mar 10, 2026 at 12:49=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Tue, Mar 10, 2026 at 5:50=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > On Mon, Mar 09, 2026 at 01:24:34PM +0800, Chen-Yu Tsai wrote:
> > > On Sat, Mar 7, 2026 at 4:59=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > > On Mon, Mar 02, 2026 at 01:31:05PM +0800, Chen-Yu Tsai wrote:
> > > > > With the new PCI pwrctrl API and PCI slot binding and power drive=
rs, we
> > > > > now have a way to describe and power up WiFi/BT adapters connecte=
d
> > > > > through a PCIe or M.2 slot, or exploded onto the mainboard itself=
.
> > > ...
> >
> > > > So now we have:
> > > >
> > > >   mtk_pcie_probe
> > > >     mtk_pcie_setup
> > > >       mtk_pcie_startup_port
> > > >         mtk_pcie_device_power_up      <-- power up
> > > >         mtk_pcie_device_power_down    # error path
> > > >       mtk_pcie_setup_irq              # set up controller IRQ
> > > >       mtk_pcie_device_power_down      # if mtk_pcie_setup_irq() fai=
led
> > > >     pci_host_probe                    # enumerate downstream device=
s
> > > >     mtk_pcie_device_power_down        # if pci_host_probe() failed
> > > >
> > > > I think this is kind of a mess because mtk_pcie_device_power_down()=
 is
> > > > called from so many places, and some of them aren't connected to th=
e
> > > > mtk_pcie_device_power_up().
> > > >
> > > > In mtk_pcie_setup(), mtk_pcie_setup_irq() only deals with the
> > > > *controller* IRQ and has nothing to do with the downstream devices.=
  I
> > > > think mtk_pcie_setup_irq() should be done before
> > > > mtk_pcie_startup_port() so we can abort before even powering up tho=
se
> > > > devices.
> > >
> > > Makes sense to me. I think it can even be moved outside of mtk_pcie_s=
etup()?
> > > That way we don't have mtk_pcie_irq_teardown() in two error paths?
> > >
> > > I can send a follow up patch for that.
> >
> > What if we do those cleanups first?  That would make this patch quite
> > a bit simpler and we wouldn't have to undo things.  It would be a
> > shame to have a complicated patch to add this stuff, then another
> > complicated patch to clean it up.
>
> Sure.
>
> > > > In mtk_pcie_startup_port(), mtk_pcie_enable_msi() and the PCIe
> > > > translation window setup also don't have anything to do with the
> > > > downstream devices, so I think they should be done before
> > > > calling mtk_pcie_device_power_up().  The only thing there that need=
s
> > > > the downstream devices powered up is waiting for the link to come u=
p.
> > >
> > > My guess is that if the link up fails, then mtk_pcie_startup_port() i=
s
> > > going to error out anyway, so it maybe made sense to make sure a devi=
ce
> > > is actually present before doing any more work.
> >
> > Doesn't sound very convincing to me.  mtk_pcie_set_trans_table() and
> > the window setup are local things with no timeouts or anything.  I
> > think the logical structure is way more important than some kind of
> > hand-crafted work avoidance.
>
> I understand. I merely meant that I have no actual knowledge of why it
> happened, or if there are any concerns from the hardware side.
>
> > Separating the PCIe controller setup from things related to the link
> > and downstream devices is pretty high on my list.
>
> Makes sense to me.
>
> I'll send an updated version.

I'm confused. I see this version in -next with the minor fixups from
Bjorn. Do you want me to do the cleanups on top of them?


ChenYu
