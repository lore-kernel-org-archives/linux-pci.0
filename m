Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B6387571;
	Thu, 26 Feb 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097757; cv=none; b=NzeyLIZdILZIyI1y1ynUlk30kf+Z/CL/PjfxCf9ZdrTwtjg3A0OKQZSg5gk0K8Xx+7bQsTlOQCL3dPSYJJGb9mElYA80E1RpSDkLtHvMBm1BiUautkkhu61QWZ8JXlBg7YkzzdxdnTNwowq9AEbw1ttoyf2WU+YKEf9ZXv2+s5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097757; c=relaxed/simple;
	bh=lTviYClUxN/Jy/GEH3hHKw2Bo7FZdJvHg/GokOuKFtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke7qHOZelfodX7BJEJ5y9J+2J1pNSLyRxZ/zpXvyCMNoxpQbdu1WpWYmOA7vN2fNrOonJ2VZ3LDDw03Ra9CkpYsrd/WUkqPL6+DsLSDpzCKgi9aZcFZInJdtKH55yEtA7VuxLDiZqNz6Eiyr/5b5n2vnRDlcjQrx80hJFcw7hbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNryg4PW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNryg4PW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24D3C19422;
	Thu, 26 Feb 2026 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772097757;
	bh=lTviYClUxN/Jy/GEH3hHKw2Bo7FZdJvHg/GokOuKFtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNryg4PWTAuvORVuHnvt5kZc5X4tAy0uAKyhHWedPbqvTRTmJK9GeV+YqDv1OvbwD
	 t65rRZEWIQPzU0+uFtN7pJCYZyo2bKCPNqRuVajKebqgdXxQBauVYJRw15Cl4keyvG
	 hd/nHVJtdaFsk57IurP46ICAlQIuLkIF8+wdTr+sRYDXZrAW1/VH1ZkuIwM59wgQyR
	 /CN3/KiMp4nNqI/9ED4z7OrZTWQoTDLQLgpAX+p7KPZOSjq2jOikp5eB48HuumwSf5
	 6CXcVk0yF/spNQWd11os5JH14EZOj5hpIgsVlepmNzhNPwjv6OMzK/eSIPh02x+Yqz
	 z0IRaxmlG9UPw==
Date: Thu, 26 Feb 2026 14:52:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] PCI/pwrctrl: Do not power off on pwrctrl device removal
Message-ID: <3xz5crqb5ez3n2tvz3lkj2f3lpvgwfiiwdk5qtwzsxsegro345@l4gpn3wdr32j>
References: <20260224071258.2654521-1-wenst@chromium.org>
 <sgxqu7oz7zoytjk6mtfnlrvyqjqjtk4w7jy2jb4iowfzxv7kly@2k2kgfsjcfdy>
 <CAGXv+5GGv-+UK458GU1wc3RuyOesRPi7LGWDXoU2S4yfoOtbVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5GGv-+UK458GU1wc3RuyOesRPi7LGWDXoU2S4yfoOtbVg@mail.gmail.com>

On Thu, Feb 26, 2026 at 04:57:59PM +0800, Chen-Yu Tsai wrote:
> On Thu, Feb 26, 2026 at 4:23 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Tue, Feb 24, 2026 at 03:12:56PM +0800, Chen-Yu Tsai wrote:
> > > With the move to explicit pwrctrl power on/off APIs, the caller, i.e.
> > > the PCI driver should manage the power state. The pwrctrl drivers should
> > > not try to clean up or power off when they are removed, as this might
> > > end up disabling an already disabled regulator, causing a big warning.
> > > This can be triggered if a PCI controller driver's .remove() callback
> > > calls pci_pwrctrl_destroy_devices() after pci_pwrctrl_power_off_devices().
> > >
> >
> > Also, we should add the devlink dependency as below so that the pwrctrl driver
> > becomes the supplier of the controller driver. This will prevent the pwrctrl
> > driver from being removed before the controller driver.
> >
> > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > index 6f7dea6746e0..0c1cc9599b41 100644
> > --- a/drivers/pci/pwrctrl/core.c
> > +++ b/drivers/pci/pwrctrl/core.c
> > @@ -311,6 +311,12 @@ static int pci_pwrctrl_create_device(struct device_node *np,
> >                 return -EINVAL;
> >         }
> >
> > +       if (device_link_add(parent, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
> > +               dev_info(parent, "Failed to add device link\n");
> > +               of_platform_device_destroy(&pdev->dev, NULL);
> > +               return -EINVAL;
> > +       }
> > +
> >         return 0;
> >  }
> >
> >
> > Even so, the pwrctrl drivers should not power off the resources on their own.
> > So this patch is valid on its own. I just have one comment below.
> >
> > > Drop the devm cleanup parts that turn off regulators from the pwrctrl
> > > drivers.
> > >
> > > Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > > Hi,
> > >
> > > I ran into this while integrating the new pci_pwrctrl_*() API into the
> > > MediaTek driver. I am sending this separately since this change is
> > > unrelated and does not conflict with or depend on the other changes for
> > > the driver itself.
> > >
> > > I think this should be merged for fixes.
> > >
> > >  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 12 ------------
> > >  drivers/pci/pwrctrl/slot.c               | 12 ------------
> > >  2 files changed, 24 deletions(-)
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
> > > index 082af81efe25..0ad920d8596d 100644
> > > --- a/drivers/pci/pwrctrl/slot.c
> > > +++ b/drivers/pci/pwrctrl/slot.c
> > > @@ -59,14 +59,6 @@ static int slot_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
> > >       return 0;
> > >  }
> > >
> > > -static void devm_slot_pwrctrl_release(void *data)
> > > -{
> > > -     struct slot_pwrctrl *slot = data;
> > > -
> > > -     slot_pwrctrl_power_off(&slot->pwrctrl);
> > > -     regulator_bulk_free(slot->num_supplies, slot->supplies);
> >
> > Here you are leaking the regulators as they will never get freed.
> 
> Oops. You're right. I guess we should just add a devres version of
> of_regulator_bulk_get_all(), but that ends up being a cross-tree
> dependency.

I'm not sure if Mark will accept it as he was not happy with bulk_get_all()
version first of all.

> For the immediate fix I would keep the release function
> to free the regulators, and then do the rework for -next.
> 

Sounds good to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
