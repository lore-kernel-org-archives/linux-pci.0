Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856092E8B8A
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773033890; cv=pass; b=YcNy0xDVz1YbqfSwaz0VIgWrNZvGauB+/H8m+/bQJz9q4BhTZSWL4G/1aSHjC/E6QYNFE8XyIt5op/aWvE76dBT7WHspUhBd6KRD3dhOKaE8K0qm0ACB9VkGPE0bMfF43FbekoVKQkXSlKp3vcOI7YptHvZdTUX/GK2gW3Iof48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773033890; c=relaxed/simple;
	bh=xg1Re59eyJ38oBrXaXOS8ISUZkY99uzGK7NJzO9q9xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+70PWQAthtE+STNXE48GnLgyGgBmGoLJDse6GhcIjW7RNkHIIxvGhIRwKLYDv10Ki6mKWWmk19EQoVQqpQW04ohmNMwJpFzadlNm97obPWYVwBA+cM84wRBZecrTFrgoX04Xmt5dESBG2GkyIns8xwLzcFFXyDypzCARVqScdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kWwuZ6WI; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kWwuZ6WI"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a13a06fc85so3161199e87.1
        for <linux-pci@vger.kernel.org>; Sun, 08 Mar 2026 22:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773033886; cv=none;
        d=google.com; s=arc-20240605;
        b=VtzHUWBUHeJGpd9MS4rWwi+zfitdxWH7H4AdnOoitBNX/4vJf56ZRKkugpmUxTJOeO
         X86tmVlttSH/MdBuGKX1+CVPGF1E5j3jR9P/oDbu7mbsRMdBMqKQtJhGLH5rLyXRjCwW
         KPVxLqguG1ZqHRlk5x9Hk6EmmK+861wBbiHHqAzc2msmg5o8ZT7o0MDLswZn/M6KuqwR
         lKq9xFDP5OPFWFOLuCmrg5jlKGazIoVwabY7AmqwXl3U6cb+S2l3AO7Pf/uXrdjUkxrK
         Svzftvg+30GbXro5nZYOQGMPyp/2vqhtHOwq/jQP7ZzgjWPJ9Sq3AxaAwV2393jD3HEl
         9QVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t6MX+Bp2JNCTwROUTw8A695ABKKQRVttaWhnTocY/i0=;
        fh=tQEBTuuTdBmTEz3Mw5qy626HSZyh3aoyLQoTNlpo0hM=;
        b=Nz1omf/75DMNJGa+BCiv3sjSC9vP/OPC6Ta0u/j2V2hI7aKxku7zB0dD/SYjEVqggk
         RJRdlzmMgbQUR1Bm0hkP32IEvGc/gu6vvcqlK0RcIoY7enTICopDO4EUR4NOc4zq8fBC
         j/9b8CbqGY3bcvPXgGHrVGOjBb/vEAHJkBbGGo8viXvt1sKPeE1EuMSNZT/CrPb3S3EU
         XvHyIeqecFpt4+46/y6jTQkUgGEr0XA2pOtRiQMXUTDABuBVThba1WHnDxkud5R5zECT
         QXCYWgSrN5JkMFEB6cXwKFjCKA0aAyvnugjsNWaRW3HThThpsrwwXxBv7T3jyRRtP52L
         341Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773033886; x=1773638686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6MX+Bp2JNCTwROUTw8A695ABKKQRVttaWhnTocY/i0=;
        b=kWwuZ6WIAArpPwrqBNZLnnRU/fSSlj7XrZJHQWJve1RkSYc+3yCwyDWhmoySp7B8VX
         1PkiLEk9zaHMPJK4mgF4oPMrxOYPdJeEXzQJbwv6jkm1IrBrB47qKjLOXXQ7aepQIGdy
         YtOx7lBWLQTFdqoDD55DhYXHPbdpoPaO84Afs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773033886; x=1773638686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t6MX+Bp2JNCTwROUTw8A695ABKKQRVttaWhnTocY/i0=;
        b=Wjn5dJ8uEAOHraqClNH+8XFvLe6ORuC0u/2OD9eX6uFgXjmyFRKAX4PlsxDvU+iPwg
         6qfnr8ky8/jBIaiDjUZI5t5SjqJIiqqjPz02648zxC18UtTN2lZbJ5SrSxZyz9pgpPYJ
         LiraQA1l9lkqF2BcZdGWFSS6QIUsYO5zVT0sA40OB+/WqSx3Z3Vla+J2E4jaOAwmQNal
         QKpBs/UIhP4VYSBuTaJ/PliOrnIQ7e1jYTmh7kVhm/hclUKZ621Pyx3hqum07Z+AE82Q
         u4BR6XHjFWcOMmAlp1NBj3D65ygY64wDICuNVH350RiQx5JKnmr9OUyfWCxS+pzmAILr
         +8pg==
X-Forwarded-Encrypted: i=1; AJvYcCWP+E9eKJv+PsiWuuXWVzJEDoOYe5rghNDHNAXHx6daV7bVp97vJe/1UXJdYfyvxrCbvWTQMVaCP04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUJKs8saAGNlIB4zZJVUAJk4RvoiMKmn89g8ZL6cr9P+NyXOA
	2CIJVbZ+DMWRnTaly63WEGJSqcveiSiajFjK8Ow4FG8P0/MYsxlrJFCn/MVOBK1zIWHiLzt+Vt4
	TSZg+4fd7UCk2FBKmAv0rRqjTkDMSn32AofMtQOaj
X-Gm-Gg: ATEYQzzk8pI/DX8KuiMEXu7P9mDZGWcaTZ4aDyHsrF/uhmAI713im7EzJhroWel9vEr
	8rD/9mdQX3ajYSnFQU4UXleVlTrrfSwPZR5q3Po2JlpJxrWS4FzHZ5Px9dPFOwdwDUqEm9Aykyv
	5gm66ccZ09EfF0dAPvIYvtDgBDBZgly0uMaiBNdUANihaonEzpx7zFicDf+V2gbbvHDgk0hLlAW
	8l/CI9y8UFaa5DOOf1mHmPoJ/BtxXdXOhnm6LlRvFLbtM9iiIrwj6v5Zasm3ptXNjawig+5URh6
	IVnIVgk1EVUzOpN8hTvsyD54+K9bLYcBqKvTag==
X-Received: by 2002:a05:6512:63c8:20b0:5a1:3fe7:44c9 with SMTP id
 2adb3069b0e04-5a13fe74657mr1589460e87.22.1773033885695; Sun, 08 Mar 2026
 22:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302053109.1117091-6-wenst@chromium.org> <20260306205952.GA180227@bhelgaas>
In-Reply-To: <20260306205952.GA180227@bhelgaas>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 9 Mar 2026 13:24:34 +0800
X-Gm-Features: AaiRm506wH4t2_mNHmYnu-zj8l0448KLlmjh55sM8J6Y-WYHRCds6FWuvIkp5BI
Message-ID: <CAGXv+5FhSO=+AUaeDSXgM9Je9uTVYq-EW43z9PAuvVKumK6oMg@mail.gmail.com>
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

On Sat, Mar 7, 2026 at 4:59=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Mon, Mar 02, 2026 at 01:31:05PM +0800, Chen-Yu Tsai wrote:
> > With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> > now have a way to describe and power up WiFi/BT adapters connected
> > through a PCIe or M.2 slot, or exploded onto the mainboard itself.
> >
> > Integrate the PCI pwrctrl API into the PCIe driver, so that power is
> > properly enabled before PCIe link training is done, allowing the
> > card to successfully be detected.
> >
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2
> > - Added "select PCI_PWRCTRL_SLOT" to Kconfig to fix kernel test robot
> >   compilation error
> >
> > I'm wondering why the two existing uses select PCI_PWRCTRL_SLOT and not
> > PCI_PWRCTRL though.
> > ---
> >  drivers/pci/controller/Kconfig              |  1 +
> >  drivers/pci/controller/pcie-mediatek-gen3.c | 38 ++++++++++++++++-----
> >  2 files changed, 31 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index 5aaed8ac6e44..e72ac6934379 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -222,6 +222,7 @@ config PCIE_MEDIATEK_GEN3
> >       depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
> >       depends on PCI_MSI
> >       select IRQ_MSI_LIB
> > +     select PCI_PWRCTRL_SLOT
> >       help
> >         Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
> >         This PCIe controller is compatible with Gen3, Gen2 and Gen1 spe=
ed,
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/=
controller/pcie-mediatek-gen3.c
> > index 7459e1c1899d..93e591f788f7 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-pwrctrl.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> > @@ -421,15 +422,23 @@ static int mtk_pcie_device_power_up(struct mtk_ge=
n3_pcie *pcie)
> >               val |=3D PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
> >                      PCIE_PE_RSTB;
> >               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> > +     }
> > +
> > +     err =3D pci_pwrctrl_power_on_devices(pcie->dev);
> > +     if (err) {
> > +             dev_err(pcie->dev, "Failed to power on devices: %pe\n", E=
RR_PTR(err));
> > +             return err;
> > +     }
> >
> > -             /*
> > -              * Described in PCIe CEM specification revision 6.0.
> > -              *
> > -              * The deassertion of PERST# should be delayed 100ms (TPV=
PERL)
> > -              * for the power and clock to become stable.
> > -              */
> > -             msleep(PCIE_T_PVPERL_MS);
> > +     /*
> > +      * Described in PCIe CEM specification revision 6.0.
> > +      *
> > +      * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> > +      * for the power and clock to become stable.
> > +      */
> > +     msleep(PCIE_T_PVPERL_MS);
> >
> > +     if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
> >               /* De-assert reset signals */
> >               val &=3D ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB =
|
> >                        PCIE_PE_RSTB);
> > @@ -449,6 +458,8 @@ static void mtk_pcie_device_power_down(struct mtk_g=
en3_pcie *pcie)
> >               val |=3D PCIE_PE_RSTB;
> >               writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
> >       }
> > +
> > +     pci_pwrctrl_power_off_devices(pcie->dev);
> >  }
> >
> >  static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
> > @@ -1211,9 +1222,13 @@ static int mtk_pcie_probe(struct platform_device=
 *pdev)
> >       pcie->soc =3D device_get_match_data(dev);
> >       platform_set_drvdata(pdev, pcie);
> >
> > +     err =3D pci_pwrctrl_create_devices(pcie->dev);
> > +     if (err)
> > +             return dev_err_probe(dev, err, "failed to create pwrctrl =
devices\n");
> > +
> >       err =3D mtk_pcie_setup(pcie);
> >       if (err)
> > -             return err;
> > +             goto err_destroy_pwrctrl;
> >
> >       host->ops =3D &mtk_pcie_ops;
> >       host->sysdata =3D pcie;
> > @@ -1226,7 +1241,12 @@ static int mtk_pcie_probe(struct platform_device=
 *pdev)
> >
> >  err_teardown_irq_and_power_down:
> >       mtk_pcie_irq_teardown(pcie);
> > +     mtk_pcie_device_power_down(pcie);
>
> So now we have:
>
>   mtk_pcie_probe
>     mtk_pcie_setup
>       mtk_pcie_startup_port
>         mtk_pcie_device_power_up      <-- power up
>         mtk_pcie_device_power_down    # error path
>       mtk_pcie_setup_irq              # set up controller IRQ
>       mtk_pcie_device_power_down      # if mtk_pcie_setup_irq() failed
>     pci_host_probe                    # enumerate downstream devices
>     mtk_pcie_device_power_down        # if pci_host_probe() failed
>
> I think this is kind of a mess because mtk_pcie_device_power_down() is
> called from so many places, and some of them aren't connected to the
> mtk_pcie_device_power_up().
>
> In mtk_pcie_setup(), mtk_pcie_setup_irq() only deals with the
> *controller* IRQ and has nothing to do with the downstream devices.  I
> think mtk_pcie_setup_irq() should be done before
> mtk_pcie_startup_port() so we can abort before even powering up those
> devices.

Makes sense to me. I think it can even be moved outside of mtk_pcie_setup()=
?
That way we don't have mtk_pcie_irq_teardown() in two error paths?

I can send a follow up patch for that.

> In mtk_pcie_startup_port(), mtk_pcie_enable_msi() and the PCIe
> translation window setup also don't have anything to do with the
> downstream devices, so I think they should be done before
> calling mtk_pcie_device_power_up().  The only thing there that needs
> the downstream devices powered up is waiting for the link to come up.

My guess is that if the link up fails, then mtk_pcie_startup_port() is
going to error out anyway, so it maybe made sense to make sure a device
is actually present before doing any more work.

We will probably have to ask MediaTek what the original intent was.


ChenYu

> >       mtk_pcie_power_down(pcie);
> > +err_destroy_pwrctrl:
> > +     if (err !=3D -EPROBE_DEFER)
> > +             pci_pwrctrl_destroy_devices(pcie->dev);
> > +
> >       return err;
> >  }
> >
> > @@ -1241,7 +1261,9 @@ static void mtk_pcie_remove(struct platform_devic=
e *pdev)
> >       pci_unlock_rescan_remove();
> >
> >       mtk_pcie_irq_teardown(pcie);
> > +     pci_pwrctrl_power_off_devices(pcie->dev);
> >       mtk_pcie_power_down(pcie);
> > +     pci_pwrctrl_destroy_devices(pcie->dev);
> >  }
> >
> >  static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
