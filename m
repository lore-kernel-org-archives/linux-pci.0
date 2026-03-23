Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2168397E72;
	Mon, 23 Mar 2026 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266272; cv=none; b=dF7DicLXkm+Txw0jYShAT0tmGnKK75JzpV22AbQL3/DEfvOuE9ZUnB7Hqbi4Om/pWNH/iwNqPGg8nLnrOCgBziZjw1p3U9oX+ri/050yr7l5IzUGsxx+8WUtQkE+Kag73Nlrdlq6eobrgUOjwVkdQUtJahRW8dVA6whspjqvVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266272; c=relaxed/simple;
	bh=bJxSisiXuWMcG5nLHHjqGfA2WWzN2tb5HfUBt+qPwX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVbNQD+MabuC74uqpNb+/8n70cgZpBkemmehGrMCEzILAoXw2kQijxg5aeIFjmR8ZxQ/446IobDgilh7ZveXhCtZGm36/q5WhkpYdmFxG25CbQNiSdy2RpUOErIsA1mIR8Xtt6X6mVFTm2Vk/gHcmn/zPvotWC7M8vC5V59vQmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjnt8gVF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjnt8gVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4F5C2BC9E;
	Mon, 23 Mar 2026 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774266272;
	bh=bJxSisiXuWMcG5nLHHjqGfA2WWzN2tb5HfUBt+qPwX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sjnt8gVFrr7BsmNjuaOoNvDQGfWU+3gylk73mA4BHHYFOxweU+Qyi48LUFGHgge5d
	 XxLsO/UCJSIkcVAR7xQA+RTuypne90DtxUbAybj+AEYaZ9px0tVs6bKAUIGFn8LlN7
	 gGcooe9cm4r4n1Rw6aIBiOwbv1h/GXBko7NjorC/bVOpzO1mm5TnqRg5JKLM5+iC6L
	 /Kwo+ToKYyjrKH4aNHV3YOw2LMru+tiouTQUhfWTXHAudLNkvLJ0xW7zquxqLwOyFW
	 hbEGq/+JArZfCD8lQhK7xh5ntpTHjZeWc6frtSxRKFJflUcYlrsirlwml1mgU1ty3I
	 y5zIAE2ByiVOg==
Date: Mon, 23 Mar 2026 17:14:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2] PCI/pwrctrl: Do not power off on pwrctrl device
 removal
Message-ID: <afooo5uvdaohuarsqnkdql4ommdnhebwdhmgqs4ysq6schsijk@yplqsx6zrkb2>
References: <20260226092234.3859740-1-wenst@chromium.org>
 <yvvkujtpo5fxca7yzw6w7afi64zdwuq4kdd6hdvnpqomazd62o@luhjytailsow>
 <CAGXv+5EtkYTS==X1dUTpEyC39k11Peb0jUbUB4ojcVcFDee-PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EtkYTS==X1dUTpEyC39k11Peb0jUbUB4ojcVcFDee-PQ@mail.gmail.com>

On Mon, Mar 23, 2026 at 07:41:17PM +0800, Chen-Yu Tsai wrote:
> Ping?
> 
> What's going on with this patch? The slot driver got renamed and this
> fix is still not merged.
> 

Bjorn, can you please pick this up for v7.0-rcS?

- Mani

> On Thu, Feb 26, 2026 at 5:30 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Thu, Feb 26, 2026 at 05:22:33PM +0800, Chen-Yu Tsai wrote:
> > > With the move to explicit pwrctrl power on/off APIs, the caller, i.e.
> > > the PCI driver should manage the power state. The pwrctrl drivers should
> > > not try to clean up or power off when they are removed, as this might
> > > end up disabling an already disabled regulator, causing a big warning.
> > > This can be triggered if a PCI controller driver's .remove() callback
> > > calls pci_pwrctrl_destroy_devices() after pci_pwrctrl_power_off_devices().
> > >
> > > Drop the devm cleanup parts that turn off regulators from the pwrctrl
> > > drivers.
> > >
> > > Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> >
> > - Mani
> >
> > > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > >
> > > ---
> > > Changes since v1:
> > > - Keep the release function for the PCI slot driver to free the
> > >   regulators
> > >
> > > I ran into this while integrating the new pci_pwrctrl_*() API into the
> > > MediaTek driver. I am sending this separately since this change is
> > > unrelated and does not conflict with or depend on the other changes for
> > > the driver itself.
> > >
> > > I think this should be merged for fixes.
> > >
> > > ---
> > >  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 12 ------------
> > >  drivers/pci/pwrctrl/slot.c               |  1 -
> > >  2 files changed, 13 deletions(-)
> > >
> > > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> > > index 0d0377283c37..c7e4beec160a 100644
> > > --- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> > > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> > > @@ -68,13 +68,6 @@ static int pwrseq_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
> > >       return pwrseq_power_off(pwrseq->pwrseq);
> > >  }
> > >
> > > -static void devm_pwrseq_pwrctrl_power_off(void *data)
> > > -{
> > > -     struct pwrseq_pwrctrl *pwrseq = data;
> > > -
> > > -     pwrseq_pwrctrl_power_off(&pwrseq->pwrctrl);
> > > -}
> > > -
> > >  static int pwrseq_pwrctrl_probe(struct platform_device *pdev)
> > >  {
> > >       const struct pwrseq_pwrctrl_pdata *pdata;
> > > @@ -101,11 +94,6 @@ static int pwrseq_pwrctrl_probe(struct platform_device *pdev)
> > >               return dev_err_probe(dev, PTR_ERR(pwrseq->pwrseq),
> > >                                    "Failed to get the power sequencer\n");
> > >
> > > -     ret = devm_add_action_or_reset(dev, devm_pwrseq_pwrctrl_power_off,
> > > -                                    pwrseq);
> > > -     if (ret)
> > > -             return ret;
> > > -
> > >       pwrseq->pwrctrl.power_on = pwrseq_pwrctrl_power_on;
> > >       pwrseq->pwrctrl.power_off = pwrseq_pwrctrl_power_off;
> > >
> > > diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> > > index 082af81efe25..b87639253ae2 100644
> > > --- a/drivers/pci/pwrctrl/slot.c
> > > +++ b/drivers/pci/pwrctrl/slot.c
> > > @@ -63,7 +63,6 @@ static void devm_slot_pwrctrl_release(void *data)
> > >  {
> > >       struct slot_pwrctrl *slot = data;
> > >
> > > -     slot_pwrctrl_power_off(&slot->pwrctrl);
> > >       regulator_bulk_free(slot->num_supplies, slot->supplies);
> > >  }
> > >
> > > --
> > > 2.53.0.414.gf7e9f6c205-goog
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
