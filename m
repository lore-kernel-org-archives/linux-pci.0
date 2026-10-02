Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37539FCB4;
	Fri,  2 Oct 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963655; cv=none; b=f1+aFCF1t3RnQtTUiw+fd5xE41vuCi8duVw3yjIxjN1eZCT4fWj5PJDB5ocIyFtcUt2uU1eHN4y0qR57iBdi2/Xc7GjVL6g6BzT0pDvrnav81A/pqsTTwkVZBS2k1HCSMEJf91PCjOEfnMzXZx7DZEQfOQzvTsRfqhwTN26Bh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963655; c=relaxed/simple;
	bh=8DwmR3QPWq2aIx1EENnXmgaGS7X8c2DZC2/tGoJZFLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t64KeI9vHEorhusKlsbidegDQh8bpIjTOKKGjm/S64k6mKZFnfTo5Ts/QVBOF2uaFoyQbmHCLzEPPcNzF0gWNAyXlnwJ+PjZfHsZsOt7ABOPZ4b9AchGyfzfaBp7Y1DjeGfTYiZKGn0I8QZ6Tpydst0xdPqnOJoWbNIeoQSd9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaQX0v6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaQX0v6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69651F000FF;
	Fri,  2 Oct 2026 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790963647;
	bh=lJQ9Gplsx3lzpZf7hARcJLh1Lg+Xkv5pYVo4U6+hpjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OaQX0v6kxIrXswgXLZqXC0lUrFRhkiHIogk34PDzu5nFOj00eKMJYn06NUCD9B5AG
	 Jps6tCNjtzs5B4OO8V4Eu91DDQjlJl1wILQVuxzv+z3EZamIhcEbtThmCcUH6EU2bU
	 quXtkuydqXaRov9s0DYAvzRH3TtbGUmtM65U/llbRl15iJnzVTFOzc1tGWhC5l/ENS
	 ELi5Inl6wc7JPLbqaujVovKLZ6mBLX0hp3+M26gbjhixwybqvQNCFItpJIPuYeIGkA
	 /aOf0XGxQup/sExsOGmAbwkOcNg7rEz4JHIYewH9YsK+7zdpFR7FH400vx9HdAzGnb
	 83pE/6r5+VW1Q==
Date: Fri, 2 Oct 2026 12:54:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/5] PCI/pwrctrl: tc9563: Introduce support for
 embedded GPIO controller
Message-ID: <20261002175405.GA189401@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923204350.GA1939701@bhelgaas>

[cc->to: Bjorn A for arm64 DTS, Linus, Bart for immutable branch question]

On Wed, Sep 23, 2026 at 03:43:50PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 09, 2026 at 04:55:52PM +0200, Lorenzo Bianconi wrote:
> > The TC9563 embeds a GPIO controller currently used for per-port reset
> > signals.
> > Add a driver for the GPIO controller embedded in the Toshiba TC9563 PCIe
> > switch providing 37 GPIO lines. The controller is registered as an auxiliary
> > device by the TC9563 power controller driver and accessed through the same
> > i2c device.
> > Please note this series is based on pwrctrl upstream branch.
> ...

> > ---
> > Alex Elder (1):
> >       gpio: tc9563: Add support for the embedded GPIO controller
> > 
> > Lorenzo Bianconi (4):
> >       dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
> >       PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
> >       PCI/pwrctrl: tc9563: Switch per-port reset to GPIO descriptor API
> >       arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563 embedded GPIO controller
> > 
> >  .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  14 +-
> >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   7 +-
> >  drivers/gpio/Kconfig                               |  11 ++
> >  drivers/gpio/Makefile                              |   1 +
> >  drivers/gpio/gpio-tc9563.c                         |  99 +++++++++++++
> >  drivers/pci/pwrctrl/Kconfig                        |   1 +
> >  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 165 +++++++++++++++++++--
> >  include/linux/soc/qcom/tc9563.h                    |  19 +++
> >  8 files changed, 300 insertions(+), 17 deletions(-)
> > ---
> > base-commit: 028f86457e822ab9de5b0d6d23efddc1b8b54ae1
> > change-id: 20260731-pci-tc9563-aux-66a29d438f60
> 
> Applied on pci/pwrctrl for v7.4, thank you!

I had applied the arch/arm64 DTS change:

  arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563 embedded GPIO controller

on pci/pwrctrl, but I think that was a mistake because that should be
handled by Bjorn Andersson instead.

What I would *like* to do is rework the pci/pwrctrl branch to drop
patch 5/5 (the arch/arm64 DTS change) and reorder the Alex's new gpio
driver first so it's not in the middle of the tc9563 DT and driver
updates:

  gpio: tc9563: Add support for the embedded GPIO controller
  dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
  PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
  PCI/pwrctrl: tc9563: Switch per-port reset to GPIO descriptor API

But I don't want to break anybody who assumed pci/pwrctrl was
immutable and pulled it in already, e.g., to the GPIO tree.  Would
this rework break anybody?
