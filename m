Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61B2D7DEA;
	Thu,  3 Sep 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468493; cv=none; b=pfViCs6+UxAxUcn+2qjuZqavbrs7AHnoW3dbPmjhQ4nUGiPiYi2fv7jYLNRoMO3WVhU0r180INZcjCq21/YrpnABdszTbSNQqrx1iNn4aNpUiX54DtbXYMeZ41ZPPCqy2VXESABLg2bxxX0Z9kbjB78a3a65qv9Q8NcEkV8ACrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468493; c=relaxed/simple;
	bh=EKirA1GfKN9oAPtucJVunXWWMSW4gY0r/1/CeAdcjrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nsBtRL5EMD82eTtSA/UNPSStXWuOzJTc0ofle1T3hHpaSUG6d5n+IBdAJar/Zp1SxwTdnqIkXuG0LKN85QU8Fuhn7CTloebUps5levcYrBlPqckS5sE27gYnCAE9yql2t/f6hD097RaoM6vaNj/p4qenWTHd/Gh9smuY1+YfTpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJfOBXaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJfOBXaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BF41F000E9;
	Thu,  3 Sep 2026 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468484;
	bh=uw6M+Azz9kgXk2yJeaS4WajyqjXMKOKDk/rPU9QB5Lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LJfOBXawep1Q4y00zLVyYKWDymGTOSCA+2VyHTJUPhtgb6C173/oNbToRjmglVAZ5
	 f3fLNCkekPFZKfFrA26xtEP7u4kuZ4Cu+3ei/6gp/ukPlyenKIERVwZVuJrzJTCT/6
	 TEATMy7vvcSfxQKkKqV3OyNLiFzu0adQ/EtRNwHiF1xCGbCYz86YbyA0xlkoyRKtcD
	 lEIVIWTpHw7ryrcJ+EycQZL1bjDSVU+FBTSU4YkfWIeMYylIxHzWU81Ic+UZTTwFAD
	 9e4DiXcaSk6/FdkgSCzOXcAVge5yYfU4KipR3H5KByNGIiu/ZKrEBwxA5PUz7xGjII
	 8QCI4EyFpdnOw==
Date: Thu, 3 Sep 2026 15:48:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() for
 RESX
Message-ID: <20260903204800.GA2243889@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-v1-1-0dbe7cfd8200@oss.qualcomm.com>

On Tue, Aug 25, 2026 at 02:41:31PM +0300, Abel Vesa wrote:
> The RESX GPIO may be provided by a sleeping GPIO controller, such as an
> I2C or SPI I/O expander. Calling gpiod_set_value() for such a GPIO
> triggers the following warning:
> 
>   WARNING: ... drivers/gpio/gpiolib.c:4030 at gpiod_set_value()
> 
> The TC9563 power-on and power-off callbacks already sleep while enabling
> or disabling regulators and while waiting for oscillator stabilization.
> Use gpiod_set_value_cansleep() for RESX so it can be driven without
> triggering the warning.
> 
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Applied to pci/pwrctrl for v7.4 with subject line:

  PCI/pwrctrl: tc9563: Allow RESX reset assertion to sleep

to focus on the behavioral change.  Let me know if this doesn't
capture it correctly.

> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index fd53a7db9875..1b7718d07d15 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -481,7 +481,7 @@ static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
>  	struct tc9563_pwrctrl *tc9563 = container_of(pwrctrl,
>  					    struct tc9563_pwrctrl, pwrctrl);
>  
> -	gpiod_set_value(tc9563->reset_gpio, 1);
> +	gpiod_set_value_cansleep(tc9563->reset_gpio, 1);
>  
>  	regulator_bulk_disable(ARRAY_SIZE(tc9563->supplies), tc9563->supplies);
>  
> @@ -501,7 +501,7 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "cannot enable regulators\n");
>  
> -	gpiod_set_value(tc9563->reset_gpio, 0);
> +	gpiod_set_value_cansleep(tc9563->reset_gpio, 0);
>  
>  	fsleep(TC9563_OSC_STAB_DELAY_US);
>  
> 
> ---
> base-commit: 4b18edbd8e70f7e6860d56370f13244896d0f95c
> change-id: 20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-f6e1f65547fc
> 
> Best regards,
> --  
> Abel Vesa <abel.vesa@oss.qualcomm.com>
> 
