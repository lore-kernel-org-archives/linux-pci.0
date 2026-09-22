Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1455D88F;
	Tue, 22 Sep 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093945; cv=none; b=Dfq8dByX5z7VD39wavwjkBuojyGc18owUICMVLR1hAX1RCwSDor5unkm+cJaYAHrasTuNPmTwONLE8f9J2QjviOjg6CGugcFZhF/beuqN/ujgu1AYcIh9nMEEZBR+EcvNRgkaZ5vg3wKEXyi9qrxzt2oKU/bSS9KPR8fiElL1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093945; c=relaxed/simple;
	bh=a3LTGa3MhJXN2n2B8EPr5J17gLQO/MD/MCTXDGXbUIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+RKh9J8uAeXdcvEj+XnaT8OyJvRlfAQfSDE60lKVYFTKlPtOy+q3ug1agI6YIR2o17pNyfSUqc+lh9OXUy+kC8zGPezYCXbJCuIrTD/O3/KqNy78/XHShY+WLJN5YkHFrRX5zbOLwWJQE24IrkzOcP8wyD8Gin4KP9vwVMS+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCXsy/+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCXsy/+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B881E1F000FF;
	Tue, 22 Sep 2026 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093943;
	bh=iRBfCParkNtyS5c7cz2RRsQha1XxTa9n12NZaWfZ/24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nCXsy/+cTBsYjPQjb4ORn0ACY4eQUoAN2P5bKbR9ceOXSp6jsUQPKUJXidVsczQIj
	 qwHPHN9eerpgroSfwN/ExPSbYWv9VILJ2nhhC9C6InFra91fp2EnidSWiGcfuSc/jt
	 wDk7O3WasgdIZPgU3vgLgSLFaxTjtaC4moNELmtLi9sA4GIqd7pMNs9ON8v2puAbzK
	 1fqD06cxyVx39g0jgWkqrBETo4Mj20UBwmFybKvkpcidIP6ob3Wop+kLV84OMwHv8K
	 PfdvA+HMgs9+wQ75aIhH0foyLEapkhNo0ZrfYqX5727dKfBfPaR9g1Bruvy7CBELqH
	 xIfS/ziAn0g/Q==
Date: Tue, 22 Sep 2026 18:18:53 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Daniel Thompson <daniel@riscstar.com>, Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/5] gpio: tc9563: Add support for the embedded GPIO
 controller
Message-ID: <fratyclnf6t232dg5s2kvsysw3gbovkwnrzfhnlblsax3wb6qy@debn6qdpp7jh>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-2-c9b33f56c8d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-pci-tc9563-aux-v5-2-c9b33f56c8d3@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 04:55:54PM +0200, Lorenzo Bianconi wrote:
> From: Alex Elder <elder@riscstar.com>
> 
> Add a driver for the GPIO controller embedded in the Toshiba TC9563
> PCIe switch (and the Qualcomm QPS615). The device implements 35
> GPIOs using two register banks: three registers control the first 32
> GPIOs (20 and 21 are reserved) and three more control GPIOs 32-36.
> GPIOs 22-24, 27-28, 31, and 34 are input-only.
> 
> The driver is registered as an auxiliary device driver. The TC9563
> power controller creates the auxiliary device and provides a regmap
> that gives access to the GPIO registers, so the gpio-regmap helpers
> are used to implement the GPIO chip.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Linus, Bart, what is the merge strategy for this patch? Since Bart has Acked
this patch, can I assume that this along with pwrctrl patches can be merged
through PCI tree?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
