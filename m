Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989E397E95
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266092; cv=pass; b=hMoIyWxy3l5RIh3TCNCul1fVFlMLgKcJxvkIibXNaQgeg6hdUbG1GfxPVKKieg6bayUdoX23Pv0ZHA8Vbv8MotS3CKq4aLXw2pQziSuAogM+7DRjym4s/ZcyKt5KFmotSHbBpPI2RUyt/LIE09ErsS+xUTMIrODswCrlk8XVId0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266092; c=relaxed/simple;
	bh=sj6ktFY8rGvb7MnpkIOBpJYVELEIasXN0XLZjKqtYbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRx4pqxBdzlg6f7+sE2gs6oG+ud3LOIjPmFOB+Kz1wPox/HkTjRZUm3A6N5QPyCnCRS+0HMxHNWAJmJ8RNbFroXhvaIq9LJ6sJoTdjJmtUCSfupQFnSO8M2/NGLeasnDuA/vuVgz+YuOKxPrq9Vg5A2NXaIY8xjF8AhYgddmIpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SZnvIsLK; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SZnvIsLK"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a27a90a7b6so7310e87.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 04:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774266088; cv=none;
        d=google.com; s=arc-20240605;
        b=WkRUMT8XUY5I+emXEq0f/vS5Y5XiQy1SWeMdM3QOehOWD8Kn+IVQJEoa8ijeJBRdiH
         fll4QX40UL35/lDp/ZXtroNTeWSDNSg+80BSBRQVYLNJuRpqjpgrM2+sKQcuH6j9gVlY
         JGSLVz//VkNnaYhZurgdQ8Hn0+gM82jwz6gZ1HVLjv4gayUAI90B36Kr/XofRQBhX2+d
         gxK6dR2hdVAa65AUpY62Hf7GrzNT9jhMIMZBAsf5ScfRbBj78rWAzi6KPakFboDDEydy
         C0rkSo3woy4icAqSH9NCTqfCsITyQDCzecxq2gkUsH+ClyNQ4Jv8gonO07aUm0D0tDFo
         urGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6qaas9JqtGbwzhDv8dAGHkzZXIP7w+k14X0YonK0wTQ=;
        fh=qJh0KOmuou6X19i3KZnQqbSAtMITuqsUmw+sBPcgs0w=;
        b=Ip6TRVYG1FdcfyRXKtTDlW8Ea1/ZH7sXRpitPE8MtpTdBrMk10mg9wr/n/SNjqDGhP
         ItU/P1bjB9rmAwGuVgicYYZ7tqGx03fsqqUu++RL0e1VM0o0eOmYLZj3Az7OwC4Nr3Cy
         bZAo3p4kWZfqu9qR8iNSz1U7gAy/su7V72o88K317XJriS6EGGspLeDXQL+0AqqfrCHl
         2F6wydktqfFDlo+/EbDItsccd4Vl03Si8JkP4wLTlDjr+5nNYQANNOEjNpWLNYgjcQiy
         XpKkYFX6fqdmaetA07lPX+3NRDfxTObDaB4pQ+h5U3JTHSwFV3XIjNGVGCO724R+FC2d
         a6kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774266088; x=1774870888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qaas9JqtGbwzhDv8dAGHkzZXIP7w+k14X0YonK0wTQ=;
        b=SZnvIsLKjlDsITdy+9Hpf5OGiZO8ocA+u9mW9RApNLDLYDUt5k/s8PoFG8+DEkER2D
         fu438svTBxlS1YFQseg0tz4L1pPsYS9hVzfs3EGV+XKSuRweeQ+wLikzlHBKYe9rlrKm
         riu+FL/FdhkifHv/pcnE2qLmd/k0iwehYMIcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266088; x=1774870888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6qaas9JqtGbwzhDv8dAGHkzZXIP7w+k14X0YonK0wTQ=;
        b=gAI8QHphVtVvb87uSn2nm7V7S2Er+TvzeRNcrWAjkWcVEk/iSIAcJBr8gAZTrhpmeo
         4IW2xC7hEl5LLKw5tpFigAto9w9qzBgi6iRLXlgKkIJXy4f1zlRKEqgi/o4LWMs6X3js
         Mm28ijRFMX16vzPBlq8DTbYxaVO9deaKVzWsAGrkpa5tFV0+PSvtvV6Gxnv8dSqFWyJA
         njc031nYw5/BuoOJxCrr+dNEjsJdKKrdHKCQXohL/qJz38z1W8EQH0p+I/tDQ5WRlC6r
         T0Gdfaem7QToGgh3a/sSc2s2R1vu6F8cD8nsAqChC3JEIFKTeC3reMxkRSuGfpBScKRT
         sjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn705+djEnYBHYNoApxHjpmhj6M2VIyKmEr6+9uq9jDaCgAdYO1xLaTYHRQWu3PEmsSyZr4fNfIDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweuZflyPuQsF6+pFdcGOK9WGd6gr7WFYMiKEPhg2YsMq2qxvvY
	BGSydz9lPxbeYK5ImPfS6+PcS8DiDw3LRl8kht11sjPXBpMd9XLB18rjBDealb1622VQWpMJkCI
	R8XWsmk7ijWa9ABHrrPyeFk+kJnKWxmE+PlcrmJ/5
X-Gm-Gg: ATEYQzzZi8QBxHuKmUbtsXVBbZuXZrQaojzqRK64mSdem0ANTE0yaWBdaHhljCRdnAd
	wxifU/wBXbAchzQ9+V0zEJC7CGTTndL4ibLtsAHHxQ6/FnoA2B4jdTOJ+DyGe2Nwv7M6+H+2q31
	pSIJ1UiglbP2UyLJ096TBnnaFo0PbBC/3ep9X4kxD7ieuWiNNpCh1z5sR0/6J90UuC4Njswc/WI
	QlpCNx3veN3OaZ9HbEgZuoKoPOdvoUbvE9QS9NmqtXB+ScOVFIhEzuzctZq6XjpQGcooYzCWebn
	dSwl++jlN8NbsOn+b1VvpUW+cgTicuQz9Bjq6A==
X-Received: by 2002:a05:6512:318d:b0:5a1:3437:84ac with SMTP id
 2adb3069b0e04-5a285b876c9mr4805460e87.31.1774266087955; Mon, 23 Mar 2026
 04:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226092234.3859740-1-wenst@chromium.org> <yvvkujtpo5fxca7yzw6w7afi64zdwuq4kdd6hdvnpqomazd62o@luhjytailsow>
In-Reply-To: <yvvkujtpo5fxca7yzw6w7afi64zdwuq4kdd6hdvnpqomazd62o@luhjytailsow>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 23 Mar 2026 19:41:17 +0800
X-Gm-Features: AQROBzDDC_YsgLPutSPicNkJG8O9a13GIhwfkf2HoJ_f9zwoBBGyNxuho0ax_ek
Message-ID: <CAGXv+5EtkYTS==X1dUTpEyC39k11Peb0jUbUB4ojcVcFDee-PQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/pwrctrl: Do not power off on pwrctrl device removal
To: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

What's going on with this patch? The slot driver got renamed and this
fix is still not merged.

On Thu, Feb 26, 2026 at 5:30=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Thu, Feb 26, 2026 at 05:22:33PM +0800, Chen-Yu Tsai wrote:
> > With the move to explicit pwrctrl power on/off APIs, the caller, i.e.
> > the PCI driver should manage the power state. The pwrctrl drivers shoul=
d
> > not try to clean up or power off when they are removed, as this might
> > end up disabling an already disabled regulator, causing a big warning.
> > This can be triggered if a PCI controller driver's .remove() callback
> > calls pci_pwrctrl_destroy_devices() after pci_pwrctrl_power_off_devices=
().
> >
> > Drop the devm cleanup parts that turn off regulators from the pwrctrl
> > drivers.
> >
> > Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/o=
ff, destroy APIs")
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>
> - Mani
>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >
> > ---
> > Changes since v1:
> > - Keep the release function for the PCI slot driver to free the
> >   regulators
> >
> > I ran into this while integrating the new pci_pwrctrl_*() API into the
> > MediaTek driver. I am sending this separately since this change is
> > unrelated and does not conflict with or depend on the other changes for
> > the driver itself.
> >
> > I think this should be merged for fixes.
> >
> > ---
> >  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 12 ------------
> >  drivers/pci/pwrctrl/slot.c               |  1 -
> >  2 files changed, 13 deletions(-)
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
> > index 082af81efe25..b87639253ae2 100644
> > --- a/drivers/pci/pwrctrl/slot.c
> > +++ b/drivers/pci/pwrctrl/slot.c
> > @@ -63,7 +63,6 @@ static void devm_slot_pwrctrl_release(void *data)
> >  {
> >       struct slot_pwrctrl *slot =3D data;
> >
> > -     slot_pwrctrl_power_off(&slot->pwrctrl);
> >       regulator_bulk_free(slot->num_supplies, slot->supplies);
> >  }
> >
> > --
> > 2.53.0.414.gf7e9f6c205-goog
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
