Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96A4B2028;
	Thu,  3 Sep 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443780; cv=none; b=nWH0kQenDzAKmZSznRzm0d/1nWEdhFORno7gmiF28kw6Ss3mkxBqbP0SJa7fuxyd9OOY3W46v2VQXLUpuDjYkQSploq/+sjcue41ni6XGjC7FTZ/ubhfvfBLaJNqZvzwVYSVtkmM/fQuIdRghU13GqpLwFnaaPurPfX/2c3laZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443780; c=relaxed/simple;
	bh=EDgP3RS3hiis8hB96HF69Zs5WENUMffLoVsK0zLhS4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxUvsnv8SPy4xYW8zLiyQXUKvgeihQfb4i1JNwg4fMX25ILAi71CjIkgRW2B/aNz2/4m1BAe06Hs0EhzQ15P7I+RhgmPgVYBq96DV0Hnt4RvHrD7Prpk65lIVQIrEpgkBwwmwauvHB0Rx83Jmyo8foFIeZof8SuTy6PICP8bPws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwneuwNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwneuwNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0C91F00A3D;
	Thu,  3 Sep 2026 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443763;
	bh=9ZX3aaMUKIltR4y+50OFfjXSQmlC643e9GFSZoj+oGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lwneuwNLWS7hbIFHfu6/IKbBCpPa5aUmLW5z4R8nPjZVVuS3Rl/iVe8kS6QH0eOjO
	 ePI4XqbDlsFYzwBE2D3f9En5X5fwej8EOLeZWzqZ52odBhZeK7vLkjEak7zyBJWf4t
	 /oBsvkntzYWWRDORT0tR9Q/G8uH7mxviw5lfsBCyZ1K4Xway6C+AOV6LcqakTKlPn0
	 rzXOe/u5TSNoSRvZY50my1M5S1PzTJjpAIjVuXN0NWDs4zvJEFPoeQo4dh7eQRL8xQ
	 o/GyI1H1OhjT5ZeaxKT6+EQwXnrLsXQCWhX10phpMJhsPV8WmVFqxNBB+TChMCl2mn
	 GSw5+RLzG72hA==
Date: Thu, 3 Sep 2026 15:55:43 +0200
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
Subject: Re: [PATCH v2 2/5] gpio: tc9563: add support for the embedded GPIO
 controller
Message-ID: <dji3nel5fuk6yjzep4agruen3zbxcousojpbjmizlk5d5fy5cg@2dfm2qmcmoxs>
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
 <20260903-pci-tc9563-aux-v2-2-34c625b542c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903-pci-tc9563-aux-v2-2-34c625b542c1@oss.qualcomm.com>

On Thu, Sep 03, 2026 at 09:52:58AM +0200, Lorenzo Bianconi wrote:
> From: Alex Elder <elder@riscstar.com>
> 
> Add a driver for the GPIO controller embedded in the Toshiba TC9563
> PCIe switch (and the Qualcomm QPS615). The device implements 35
> GPIOs using two register banks: three registers control the first 32
> GPIOs (20 and 21 are reserved) and three more control GPIOs 32-36.
> GPIOs 22-24, 27-28, 31, and 34 are input-only.
> 
> The driver is registered as an auxiliary device driver; the TC9563
> power controller creates the auxiliary device and provides a regmap
> that gives access to the GPIO registers, so the gpio-regmap helpers
> are used to implement the GPIO chip.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
