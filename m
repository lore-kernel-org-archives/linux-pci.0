Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0BF395DA8
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096296; cv=pass; b=AjCo27Lo3WxCN23FCIm2DYoTsRAT/bp543a21kbf1syaaPn7L/5aq71WgT26OYyuqSGMmqbBRlaUs3KwBmO6W0IXnu4GgRKRFgMqtPSyxUMxxrBAOvz66joiPc7dtk9eM2j7VkWDP0Bv9wOqq1Upo/mDfTs2X8hSA84bCyEPVy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096296; c=relaxed/simple;
	bh=mUkMtW1QJSv/+Pa8xbiNoYmRLQCaKuH6j0DcqCwim5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqXfxFjAnHKv68weeJJRgs1ME+TtTRmGnzYgJQZ6sAYKCb5eWt+rEL7Tf/fmZti/pcLYhfgIyN6bY7xyuEaZ7hGB/HvTuvM+4ytX2BPhSxFlKBvFmFW4LfgG1O0A4efr9EWI9syU3Jr4MFz6kcWhBt2YiM5pHCZhEFXh2gRwl0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A6E3Zwm4; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6E3Zwm4"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59f855fd0d9so776090e87.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 00:58:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772096291; cv=none;
        d=google.com; s=arc-20240605;
        b=K8dFvCGPoSytl/WowVUOqNESekIfDleb2zllWH4azg1ml1CiIDOjnE+c/lUUm/h04W
         2UdLHydvDvAMujtFRngosPOh76QyIs+4FnV6DMiS9lGF1RxtW9P03yFC0cGFYVMkUgZe
         vA8A287BgLE0MwL6Z9MZ+IQhTnHpOhz2be4tt8s+oM44aa5p62xyU0PCE0C/rgtP1yBU
         WX5PTL6IeJNQnz2ROlhoxhJnmxX2YHeK+pe4qonol1HyZ21a0lC8qweuF7XEb22AKSd+
         Mp/NdXHWb8RCXyzahw50SB1MWo/acaRZs4q/Zxdn0Eeysq7bNexiENBKUkVy+Pv/w0GR
         xxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0FuSUNTC0M/ufiA4n/Qlp45Pjpgfa2w7XohWGktWQY8=;
        fh=fMIB9a0P4iN1h9w4mLg2aDFBFkN7nWbXqI7vTiLR1gY=;
        b=LwUvskhbSGAUhUm2HUMRfSF8ZfFRzueZa7xlG5ypeTD8RNYWQyDYqyFrk8Rh6N3o+o
         0B1YZvJCtAtrxc65hA623rnAj5gZ37AQUU/XrFw6EJuVv8tGvWmfX9pNjgYbVJsQChP+
         dNSOrL7qkFJ6pAA93JOYK8LwKlnhBCO6bm+ZyCt0CL7To75mtQh4BpQJnj3crDwcEG5Z
         QFpWZH66Gb9Mwyyn/nbH8+2dnWxb7fAF2e51Nj0yKYM+yvYBBdztiV8WMbu5XBd1z0Yx
         Ws/gXHn0peyMREp4VrR3YcwdMzi8Its5ouRP8vW6AbOkFe2UKfX5NPfnWq4xAIIuFxwv
         1OZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772096291; x=1772701091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FuSUNTC0M/ufiA4n/Qlp45Pjpgfa2w7XohWGktWQY8=;
        b=A6E3Zwm4K0MO6PL5d8JE92FXDdSJaAxRdQwpDJhjNjVQ/6T+qG+fkdwPb0qcwGK4g7
         dqqW8a+ClkU8rB6A+DEhoajwju+YJargT7Z7NZyP5cEh6s97hLFo4Uy2lAS+iUc7NKRj
         k/SzILYY6Wi9K372240Htb2G/XKcoKaEgNyeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772096291; x=1772701091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0FuSUNTC0M/ufiA4n/Qlp45Pjpgfa2w7XohWGktWQY8=;
        b=PLKPrT7X/8nhD+ewAyTmqs/eSMXiAqoWJ3disL+lfvcyNCKeHb9KaJA34vSovaF+rW
         +x86XsXg1Fs7ZRNcnqT6kWiNJxR3hpqLlh/Ubem05bCptIO6lUANb1IlrWUfEJugxk4v
         32/Wuj+ukQIo2w/OXfYsyl1odMIchMqQ8QyMTEqx6d5nG7uUQkMELXpfs4fHJpYkOj8u
         X0GKNskeRsmn4RQEhPmZAKzsx/Go0vLhcBDapmeHNIWG0wYgV0acCDtHGVVTN0muJFGh
         gEjNu7C+RWmfxYcK7yAF2hMOf+nrH2r525LAQCdhbc2pX3lGon5s+TXIOlKoAQf6H/2S
         wwqw==
X-Forwarded-Encrypted: i=1; AJvYcCVnh5xNH/G6Pg3DRd7sT5pqVNHg9TwlF2kv4UD8ED4pVrN5xZKW66eU3ZPS6qG9NdjW0Da/ty68y8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xzQKged7MhldipvKpEfwwnV3GRIa+z3P4kw3+E5vFWqMgMzf
	1k4Xf18JiPOHDkng+mhuUd4vIqxBeL5Tb2pI1ER8jwvZIny/DsrbD/h4OfWhQR3ZBqh2rTfdAbs
	3kuzox99LCnFKOxo3BKQuWIV858mluWWnZCR1TADg
X-Gm-Gg: ATEYQzz0oI4U8x4+qhe1hw+cDpiOCCJf54PPzk+5QWHJTSBsWzoNAXpay0Dt3pQlHs7
	eKTO4bpwTouWqTMMJF+qQinQwyo6IgjotqQSE3DkexBnt/kWccMjVCw1NrBXAfhWvdlw5sZ9hOw
	FKKhpjxHH6XW3BkeNTQHJ6NcXfm4ovFHwPDzaZFI1tAEoms+mBx96vHY3+/rgVSfWrdcRsjZX5N
	G7Uz4s83GStn6Jbaogx1WfTJkf4w1LFy685KXyXhuSYQJobrGnPIHlin/lOU67VwnJ+Tfd9UMHf
	HmO5dzgXOI9yym5oIXVnoBcpEzAWWQlaqbNJ4Q==
X-Received: by 2002:ac2:51ca:0:b0:5a1:c51:dcde with SMTP id
 2adb3069b0e04-5a10d0ea377mr233109e87.45.1772096291164; Thu, 26 Feb 2026
 00:58:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224071258.2654521-1-wenst@chromium.org> <sgxqu7oz7zoytjk6mtfnlrvyqjqjtk4w7jy2jb4iowfzxv7kly@2k2kgfsjcfdy>
In-Reply-To: <sgxqu7oz7zoytjk6mtfnlrvyqjqjtk4w7jy2jb4iowfzxv7kly@2k2kgfsjcfdy>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 26 Feb 2026 16:57:59 +0800
X-Gm-Features: AaiRm51V1uBkFNFCMX2MLHVdzPfjpijvu36GOs3l17JvmbQ0Jn4ZVAbaE1qpBcE
Message-ID: <CAGXv+5GGv-+UK458GU1wc3RuyOesRPi7LGWDXoU2S4yfoOtbVg@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Do not power off on pwrctrl device removal
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 4:23=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Tue, Feb 24, 2026 at 03:12:56PM +0800, Chen-Yu Tsai wrote:
> > With the move to explicit pwrctrl power on/off APIs, the caller, i.e.
> > the PCI driver should manage the power state. The pwrctrl drivers shoul=
d
> > not try to clean up or power off when they are removed, as this might
> > end up disabling an already disabled regulator, causing a big warning.
> > This can be triggered if a PCI controller driver's .remove() callback
> > calls pci_pwrctrl_destroy_devices() after pci_pwrctrl_power_off_devices=
().
> >
>
> Also, we should add the devlink dependency as below so that the pwrctrl d=
river
> becomes the supplier of the controller driver. This will prevent the pwrc=
trl
> driver from being removed before the controller driver.
>
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6f7dea6746e0..0c1cc9599b41 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -311,6 +311,12 @@ static int pci_pwrctrl_create_device(struct device_n=
ode *np,
>                 return -EINVAL;
>         }
>
> +       if (device_link_add(parent, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUM=
ER)) {
> +               dev_info(parent, "Failed to add device link\n");
> +               of_platform_device_destroy(&pdev->dev, NULL);
> +               return -EINVAL;
> +       }
> +
>         return 0;
>  }
>
>
> Even so, the pwrctrl drivers should not power off the resources on their =
own.
> So this patch is valid on its own. I just have one comment below.
>
> > Drop the devm cleanup parts that turn off regulators from the pwrctrl
> > drivers.
> >
> > Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/o=
ff, destroy APIs")
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Hi,
> >
> > I ran into this while integrating the new pci_pwrctrl_*() API into the
> > MediaTek driver. I am sending this separately since this change is
> > unrelated and does not conflict with or depend on the other changes for
> > the driver itself.
> >
> > I think this should be merged for fixes.
> >
> >  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 12 ------------
> >  drivers/pci/pwrctrl/slot.c               | 12 ------------
> >  2 files changed, 24 deletions(-)
> >
> > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwr=
ctrl/pci-pwrctrl-pwrseq.c
> > index 0d0377283c37..c7e4beec160a 100644
> > --- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> > @@ -68,13 +68,6 @@ static int pwrseq_pwrctrl_power_off(struct pci_pwrct=
rl *pwrctrl)
> >       return pwrseq_power_off(pwrseq->pwrseq);
> >  }
> >
> > -static void devm_pwrseq_pwrctrl_power_off(void *data)
> > -{
> > -     struct pwrseq_pwrctrl *pwrseq =3D data;
> > -
> > -     pwrseq_pwrctrl_power_off(&pwrseq->pwrctrl);
> > -}
> > -
> >  static int pwrseq_pwrctrl_probe(struct platform_device *pdev)
> >  {
> >       const struct pwrseq_pwrctrl_pdata *pdata;
> > @@ -101,11 +94,6 @@ static int pwrseq_pwrctrl_probe(struct platform_dev=
ice *pdev)
> >               return dev_err_probe(dev, PTR_ERR(pwrseq->pwrseq),
> >                                    "Failed to get the power sequencer\n=
");
> >
> > -     ret =3D devm_add_action_or_reset(dev, devm_pwrseq_pwrctrl_power_o=
ff,
> > -                                    pwrseq);
> > -     if (ret)
> > -             return ret;
> > -
> >       pwrseq->pwrctrl.power_on =3D pwrseq_pwrctrl_power_on;
> >       pwrseq->pwrctrl.power_off =3D pwrseq_pwrctrl_power_off;
> >
> > diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> > index 082af81efe25..0ad920d8596d 100644
> > --- a/drivers/pci/pwrctrl/slot.c
> > +++ b/drivers/pci/pwrctrl/slot.c
> > @@ -59,14 +59,6 @@ static int slot_pwrctrl_power_off(struct pci_pwrctrl=
 *pwrctrl)
> >       return 0;
> >  }
> >
> > -static void devm_slot_pwrctrl_release(void *data)
> > -{
> > -     struct slot_pwrctrl *slot =3D data;
> > -
> > -     slot_pwrctrl_power_off(&slot->pwrctrl);
> > -     regulator_bulk_free(slot->num_supplies, slot->supplies);
>
> Here you are leaking the regulators as they will never get freed.

Oops. You're right. I guess we should just add a devres version of
of_regulator_bulk_get_all(), but that ends up being a cross-tree
dependency. For the immediate fix I would keep the release function
to free the regulators, and then do the rework for -next.


ChenYu
