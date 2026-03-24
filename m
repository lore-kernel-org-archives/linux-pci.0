Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97183BB5A
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774328514; cv=pass; b=r5mwFha8lzvlkDr8YS4YSQwpMJ7Uu3JjhrUdr8uBxaJytaiETy4U/GYmZZ5B61zvlB7k224QVcIJSoSH2xvrUV3GDquTeB3yDmMfo2w+z5xev/63nWwiTRMlhKP2xLD6MEltQAYmqTuU1Os1TvT7Femzsq5CsdnK0kanqeEvM/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774328514; c=relaxed/simple;
	bh=7LmWv3pVbz9iXVCyG+B4VymIDP0DV3UuRAgABixPLe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E85Ycnevi0MyS1lz7l0sTz4NVgbGMCZePz+TmVGxhA85LqQBYQtWJ9ibtid7Hkv5uMIm/mrrqYvUzFszkjBVk5LjJSP55u9i14AK2VCb89K+4oSNr5Dkg8Y+RA+TpHu16spgorSbYEKnyJAobhUqPeR4IisV29qNjxC9eq1L7fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BJfnNHU8; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJfnNHU8"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a10d130b37so3918047e87.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 22:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774328511; cv=none;
        d=google.com; s=arc-20240605;
        b=Elml86qjDFnKaozkbJbU4k4E8oUluK+AXTeG5zqNwj4F6RHaj0LExEVF467/Teqw12
         Z7rpZ4VWvKJ3fDydtS4KmpolOjsQAfEa+hA7EMbq4CqcXboBt+DJjSi8kMjGuR6uE5I+
         dQo5jw+KeqLhp5R6zRGd2HrW+mur/8FePd4OHw1FSTolLHC+w9iALltCVPyy2r5t9pCh
         x77iWo2H41yN928FQ+Aslh25QizOJghfSkt4dUla1Ni5vatsoErhHJxcMn8mFlQvNWic
         ylywf3+G3bqpQtPPeC8AHs1EGNMOKR9wsFetfoAihr7nUyAfdmYwGH8r4648yp5EoJ16
         kL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IDH9hxeAznPRg0ItOMrUgqU6w6T+oHEnIIMvh1Q2C4c=;
        fh=uxaWUYbHV63/P+Jlx/RYHNuAfweil/AcQ+4tIx4MHe0=;
        b=bTNn52Eapmipxdp/C11eFqi0ZqhgPkwWQURN3a0X4/hacdKFGc2nmGrd39hfwkdLZY
         qQTLMXrZY01iRol/x1W50OlZlQieQnyYv60DOlrQUio39t1aFK4FlXeMSmZXvkPrPnFt
         iMpliWv83q+KP6H4yPW12Dda+iq+pFQ8xuSgZG1DzOuJuac6SBbh4zreowsRm2Z9G7ny
         zAwSGYvBjGbU17aiBDlDsPHI9Nsb4+xDdbIc1VAWsmGV3fqVc+RmPlLY4XFOVV/86HFa
         /LVZv1m3gjOx2c/aa7clrTux9P7LnbZRkBUpWPu4L/mlpJW+s7MMdG9kDzL+wK4tmEMG
         gx5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774328511; x=1774933311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDH9hxeAznPRg0ItOMrUgqU6w6T+oHEnIIMvh1Q2C4c=;
        b=BJfnNHU8YUdfTKDXldeE7jxmWLrcDxbI0dilq6uSFutxwMowXe+pIFLH1E9XcPVq1E
         yaDdPHdxI5WbpJfoMTXsqsRU4MjWkN0y6NtRWYZgf0jwVcDSRl0etT00ZizoToIH7alz
         WvVwa+MmIC7kw3vIULxlwBWNZ2JNLCCrnDr+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774328511; x=1774933311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IDH9hxeAznPRg0ItOMrUgqU6w6T+oHEnIIMvh1Q2C4c=;
        b=HVTIvFX8Ylb+IOWBw1nRCgjl+osnErldUee+NmzdWWDIs0krapXumC3dyGRJPRFkEY
         1Td+VOImR/SagsnqD1Gb/fmjRMtjhb35T2OdUy7/ij5eRUee3++J7inQVw2ZLx6wbvjG
         NUWlJen0b5KhRyFiQIE+5YQQmhs4sJLUklR9E4/nVH25V74j6KKrQjIkh18G5pv/IaEz
         YwQGFhUqEFE6M7Xgi0ycmJ7bg/6Gz7fF4u3RfVjDb+tkhEi1AX6T13wWGVpMPkF4lQSH
         PgxXyter6iIP1rR5Gpi+o+Zg8QhHeAk8Csl9F8w3OfGav7A5WwZGYMBa+7YuvBjMQCU3
         yL+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGdVCAj8X6+30VjDPQwKyed4Em5BNHE1C2BABvG/Bb5PTdqPoCJMXyi8HLySWSTFcrRAGEEkJQWjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWho5kPLx+Zage+pUaEWXAytkzgnbCSTDw+fFAcOkQmLSU9+dK
	52XgvALbTRpdZFLJq8s6ZcnePJV4ff81Y1js1v/spCfKcFJRrDVCBu2QPeBJlq6fgtJ1pYFfjHo
	w1NHyf/57vOhqJfbInHPTtZZzsEwdy+cE7PM4hQQg
X-Gm-Gg: ATEYQzzFyAVry+uW73R5dZn0Jk3wgMYtTEmvhz9NSW7kMbxzR8OWqPfpnZ0osoqcdnM
	OuoRv88NvOUMs/RgwyI8ojVmMPlDqzr1aBi0LJbzxb4pjgKSVGU7HT/5OKpZiMnWsKfhLHvN2z3
	TX7crwc+3GN7Guq0e8nGr8cQrOHI+OPr6tIFbod88JVMi7TpgZQqe1UKJIB33e54fNGeKykIPTs
	h7yuUu7NC9xpGpJT0vmEc9tpqizRAd6SOUNfjkPlwnpfuUxQPmQRnVwHNpd6VgKKGWR33ezADW1
	lwbde3gaLMv/6UuNs0AX9DErSwFZ3K9KC56roA==
X-Received: by 2002:a05:6512:3501:b0:5a0:ecb2:c0c2 with SMTP id
 2adb3069b0e04-5a2961f5c4bmr671100e87.4.1774328510840; Mon, 23 Mar 2026
 22:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXv+5HQY9nTCacUbNZL1XggiHqomhgiQH_gdFtXLra+_ut4fQ@mail.gmail.com>
 <20260323190829.GA887140@bhelgaas>
In-Reply-To: <20260323190829.GA887140@bhelgaas>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Mar 2026 13:01:39 +0800
X-Gm-Features: AQROBzAZ6nu5jMyCQgGtQyyo85d_doglkl0nVE2DGZIM-UwStvtJT2NFKNs1DsE
Message-ID: <CAGXv+5FYC-7BBC0gPJvbtM6hnmYt8ywhLigKLDEu2WYNRS6XeQ@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 3:08=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Mar 20, 2026 at 02:10:03PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Mar 10, 2026 at 12:49=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.o=
rg> wrote:
> > > On Tue, Mar 10, 2026 at 5:50=E2=80=AFAM Bjorn Helgaas <helgaas@kernel=
.org> wrote:
> > > > On Mon, Mar 09, 2026 at 01:24:34PM +0800, Chen-Yu Tsai wrote:
> > > > > On Sat, Mar 7, 2026 at 4:59=E2=80=AFAM Bjorn Helgaas <helgaas@ker=
nel.org> wrote:
> > > > > > On Mon, Mar 02, 2026 at 01:31:05PM +0800, Chen-Yu Tsai wrote:
> > > > > > > With the new PCI pwrctrl API and PCI slot binding and power d=
rivers, we
> > > > > > > now have a way to describe and power up WiFi/BT adapters conn=
ected
> > > > > > > through a PCIe or M.2 slot, or exploded onto the mainboard it=
self.
> > > > > ...
> > > >
> > > > > > So now we have:
> > > > > >
> > > > > >   mtk_pcie_probe
> > > > > >     mtk_pcie_setup
> > > > > >       mtk_pcie_startup_port
> > > > > >         mtk_pcie_device_power_up      <-- power up
> > > > > >         mtk_pcie_device_power_down    # error path
> > > > > >       mtk_pcie_setup_irq              # set up controller IRQ
> > > > > >       mtk_pcie_device_power_down      # if mtk_pcie_setup_irq()=
 failed
> > > > > >     pci_host_probe                    # enumerate downstream de=
vices
> > > > > >     mtk_pcie_device_power_down        # if pci_host_probe() fai=
led
> > > > > >
> > > > > > I think this is kind of a mess because mtk_pcie_device_power_do=
wn() is
> > > > > > called from so many places, and some of them aren't connected t=
o the
> > > > > > mtk_pcie_device_power_up().
> > > > > >
> > > > > > In mtk_pcie_setup(), mtk_pcie_setup_irq() only deals with the
> > > > > > *controller* IRQ and has nothing to do with the downstream devi=
ces.  I
> > > > > > think mtk_pcie_setup_irq() should be done before
> > > > > > mtk_pcie_startup_port() so we can abort before even powering up=
 those
> > > > > > devices.
> > > > >
> > > > > Makes sense to me. I think it can even be moved outside of mtk_pc=
ie_setup()?
> > > > > That way we don't have mtk_pcie_irq_teardown() in two error paths=
?
> > > > >
> > > > > I can send a follow up patch for that.
> > > >
> > > > What if we do those cleanups first?  That would make this patch qui=
te
> > > > a bit simpler and we wouldn't have to undo things.  It would be a
> > > > shame to have a complicated patch to add this stuff, then another
> > > > complicated patch to clean it up.
> > >
> > > Sure.
> > >
> > > > > > In mtk_pcie_startup_port(), mtk_pcie_enable_msi() and the PCIe
> > > > > > translation window setup also don't have anything to do with th=
e
> > > > > > downstream devices, so I think they should be done before
> > > > > > calling mtk_pcie_device_power_up().  The only thing there that =
needs
> > > > > > the downstream devices powered up is waiting for the link to co=
me up.
> > > > >
> > > > > My guess is that if the link up fails, then mtk_pcie_startup_port=
() is
> > > > > going to error out anyway, so it maybe made sense to make sure a =
device
> > > > > is actually present before doing any more work.
> > > >
> > > > Doesn't sound very convincing to me.  mtk_pcie_set_trans_table() an=
d
> > > > the window setup are local things with no timeouts or anything.  I
> > > > think the logical structure is way more important than some kind of
> > > > hand-crafted work avoidance.
> > >
> > > I understand. I merely meant that I have no actual knowledge of why i=
t
> > > happened, or if there are any concerns from the hardware side.
> > >
> > > > Separating the PCIe controller setup from things related to the lin=
k
> > > > and downstream devices is pretty high on my list.
> > >
> > > Makes sense to me.
> > >
> > > I'll send an updated version.
> >
> > I'm confused. I see this version in -next with the minor fixups from
> > Bjorn. Do you want me to do the cleanups on top of them?
>
> I had intended to defer merging pci/controller/mediatek-gen3 to
> pci/next and wait for your updated version.  But I see that I forgot
> about that and included the original version.  I rebuilt pci/next
> without pci/controller/mediatek-gen3.

I'll send v6 with the slot driver symbol name fixed.


ChenYu
