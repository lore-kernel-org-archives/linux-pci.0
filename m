Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB284AEBE7;
	Thu,  3 Sep 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444466; cv=none; b=Dn0Mi/QLE0eFgligg3I9j3yPtOq17Aix8emTnNpCGpRXM1Gw0X67j4ed0UyY7qs7L5/7IF2HZlFxNcSf7tGPAlj0rZ0LZDeUPQljN6ISAhi2+keCXmmf13Ptg10WY/Bg807bKIwrQWj7TFcwZHrvQQdDuWeldmw7CGKgz59wh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444466; c=relaxed/simple;
	bh=/LpHT2zmoT4//1qZDNWf1+DnuWQRp+3WfPPJsqO7gHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJJzvAUGsacGsp/Hn8COAqWfzU4TGTgDgFjD1wqdbu6SH1g3npMFvvYN1ndyszlqbqHRwCBWaW7tNeEzRzPQubsX86rKUs/MJ2mzNz6cvyCrxGuOWVQh9ClLYgxluj7ZyUWUPQhwGNhP6io9otojHrxqIUtSOUgHm6sMy3E0mWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZReVIyXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZReVIyXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382081F00ACA;
	Thu,  3 Sep 2026 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444456;
	bh=l4417KZYCzRGEjypQLbziUWRJSUtpY3h5z31xem7hMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZReVIyXfq2VmJ7sHc0fzWUvjIOCpkBFpj1NrM+4drjICkPmZOV0VtkOTmfjJc2w+G
	 qFwgA+8NEQGLlRlwKtuiUxmZL7ZZiSyVAGaRaBS8ekHe/NYnkouNAeS54qB2N3YIX/
	 LvndlliYXT7eHzGEGrrY1YG54ks1MSGgc9krKm/sp1jZ4T35XSJWmX8JQcDGnsaZkY
	 v8FO2fwty0ccb68xrD1Pkyr27yQextp6UihA8/SG9OxBG4iOEKOf+3aQEl9AD1P/1g
	 jhQcbwynuYJWAOP2/RuKfWI44NUhRiiZWHSZoT3lKgsIc8VlCtalY9xVCf/GKLdYQ1
	 72Al5fXQMQTsQ==
Date: Thu, 3 Sep 2026 16:07:21 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Daniel Thompson <daniel@riscstar.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI/pwrctrl: tc9563: switch per-port reset to
 GPIO descriptor API
Message-ID: <fwwhyein3ydor6do7amdgckgvjelck7lqc7kdrx6qmyxajwqay@nly3dqryjmnd>
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
 <20260903-pci-tc9563-aux-v2-4-34c625b542c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903-pci-tc9563-aux-v2-4-34c625b542c1@oss.qualcomm.com>

On Thu, Sep 03, 2026 at 09:53:00AM +0200, Lorenzo Bianconi wrote:
> Remove the local TC9563_GPIO_MASK and TC9563_GPIO_DEASSERT_BITS
> definitions, which are no longer used after switching to the GPIO
> descriptor API.
> 
> Replace the direct regmap-based per-port reset logic in
> assert_deassert_reset() with gpiod_direction_output() calls, falling
> back to the legacy regmap approach only when no reset-gpios DT
> property is present for a given port.
> 
> Add the reset GPIO pointer to struct tc9563_pwrctrl_cfg and introduce
> tc9563_pwrctrl_parse_reset_line() to look up reset-gpios from each
> PCI downstream port child node. The lookup is done lazily at the
> beginning of power_on(), returning -EPROBE_DEFER until the GPIO chip
> is registered.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
