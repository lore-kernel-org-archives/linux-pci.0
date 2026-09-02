Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4347D474;
	Wed,  2 Sep 2026 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358142; cv=none; b=laROnTv9TgefEMKCbHccmF1d1dHupVJqRN5K6N2VxqlKbDmt/h6/ADVYmIxj57TtYAouIlstR85WxC94kIzBl3+XBBHiPQdz4aHtw49IPPFd1Gp4ptsd3P5rE0BJ1Y/dZ2JsAS4mnEHOnSWTS4GKIz5HpFp4Fb+fbBsnd/YLhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358142; c=relaxed/simple;
	bh=dVw6X77PBRRBbMXYpWK6XtetfDRq1TfILbEFrh3Pue0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHTZriuVpiCY8MBGxocacbtv5X+/9Ed8FOGZwyUlZT0STvytSRKn/XdglLc+D6u43eYdOyRH5w8x0MN6FRoDTh64cA/x0uXp5C43V8DhfM7HSYk6KnVAG3kX1KOdkOKZxEX35/wbbHVUieN7i2tG3/CL2rl5vv5uErjMAnThZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkMxStK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkMxStK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348D71F000E9;
	Wed,  2 Sep 2026 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358141;
	bh=jvbsIa1C1CD9YEd7c6+Yhz/TnoBEzHpDFUgyLGLQ/00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WkMxStK39RW2NF0CTX2JHSZa+bNFDBPn2ilVPJkHrOOshLQjshW1LTqzFP/Izvml4
	 EcMhGGyGqs060hezfyWXjvVc+clSMUBZfRntbL+WUUt3JXr5JANP8VBnS0kekeqFXE
	 FDix/Cf9xU+ZpCqlJFj+HgdXRIoQB7JZmdq2DkboM8XhTqp5e4nq9osDrrXQay6oN6
	 hOpUOcI6qegaJ0kEIsW9aG87VLvqpA6gWNq/CJljwgWoC9CsF0XGeaxWqUgHyq1tFj
	 1NshR6nT92YqEMWaweaG/ay8/jKqxreDTbszVetTOMSrCue9j12f+MiZpsD8MI2QJl
	 TWo9D4De3mTYQ==
Date: Wed, 2 Sep 2026 16:08:49 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() for
 RESX
Message-ID: <v4wm3n2onavyxe2ud52hctuff7iozekwxzek3w56acqfyhjxfi@ide5zrz6b5qw>
References: <20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-v1-1-0dbe7cfd8200@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
