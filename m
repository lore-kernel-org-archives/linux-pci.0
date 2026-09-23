Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3347A88C;
	Wed, 23 Sep 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196233; cv=none; b=QOJFdcaIc420DZ37P3Gi0CjbrfFH3mwp5pCEUqMBDXbAUBOAGLYePShIRm6KdBu0Nm17hrHa6FwORkOWX268VMmnBUP/uQbCjoJPoJkeGLEGrdHR6UqHEw/ADotaSSQ7Oj4DyH5wXt01gaA43eT4UlriemhfCFXzMUFmQofkfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196233; c=relaxed/simple;
	bh=dtvFI/vQCtkkMDo2BD7xIr64VrQgs++rTHfumxPrzbc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J/z+aQBR824RSBjr6DlOwm8Kyk4MtozMiKfykboe45rkZmUi0quTH+i6gxk5WgARF9aRJEBDR5aSdyuwSYFplMOj3xoC2QOvnI992ZOZzE+As+5wu8j5EUVOIsJ3xWK4cZZgG5c/jW2+FkHYtUZo91WPzHU0qzbKWjvOvEoCH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MshDnlrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MshDnlrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD851F000FF;
	Wed, 23 Sep 2026 20:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790196231;
	bh=voiUb6QnCZbO98VVdjWK/+608qybEmwTk7Sv7qhmSoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MshDnlrdTWGQZtR+3xeic5pWQYFP8zy6ssk4iMQFtHkWxGES/lLL+fbS2N0EhpT3R
	 XFuhOyg/q097LKANGXCK+kRrnNUhbr132DSiLFQCbyT6UoON+BA15uaYsGeTb7rkYk
	 /hdJ3ZhztA68pe3FAReG13dSaBaII4XsbUP0tl4bcIF3zlis/vtXYyhZtDnDyvkPhC
	 JTikZY8rzm/IiMk2RqJnINSNw7eWxCPOlvq9LWvHwVpzWcHSsVSXwSL50lgHQI+OZw
	 aTPds6jKb8I/aJAeOjj+omlIa6Oc/zsinMxRFONi7FqSavCE1dZal8zLdLKxpbAAjH
	 MV3wEkFcqt5DQ==
Date: Wed, 23 Sep 2026 15:43:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/5] PCI/pwrctrl: tc9563: Introduce support for
 embedded GPIO controller
Message-ID: <20260923204350.GA1939701@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 04:55:52PM +0200, Lorenzo Bianconi wrote:
> The TC9563 embeds a GPIO controller currently used for per-port reset
> signals.
> Add a driver for the GPIO controller embedded in the Toshiba TC9563 PCIe
> switch providing 37 GPIO lines. The controller is registered as an auxiliary
> device by the TC9563 power controller driver and accessed through the same
> i2c device.
> Please note this series is based on pwrctrl upstream branch.
> 
> ---
> Changes in v5:
> - Fix GPIO controller binding for Toshiba TC9563 PCIe switch.
> - Link to v4: https://lore.kernel.org/r/20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com
> 
> Changes in v4:
> - Do not always use 0 as aux device id.
> - Link to v3: https://lore.kernel.org/r/20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com
> 
> Changes in v3:
> - Describe gpio-controller support in TC9563 binding instead of defining
>   a gpio child node.
> - Link to v2: https://lore.kernel.org/r/20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com
> 
> Changes in v2:
> - Fix PCI_PWRCTRL_TC9563 Kconfig dependency
> - Move of_node refcounting management in tc9563_pwrctrl_adev_add().
> - Link to v1: https://lore.kernel.org/r/20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com
> 
> ---
> Alex Elder (1):
>       gpio: tc9563: Add support for the embedded GPIO controller
> 
> Lorenzo Bianconi (4):
>       dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller
>       PCI/pwrctrl: tc9563: Add GPIO auxiliary device support
>       PCI/pwrctrl: tc9563: Switch per-port reset to GPIO descriptor API
>       arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563 embedded GPIO controller
> 
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  14 +-
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   7 +-
>  drivers/gpio/Kconfig                               |  11 ++
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-tc9563.c                         |  99 +++++++++++++
>  drivers/pci/pwrctrl/Kconfig                        |   1 +
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 165 +++++++++++++++++++--
>  include/linux/soc/qcom/tc9563.h                    |  19 +++
>  8 files changed, 300 insertions(+), 17 deletions(-)
> ---
> base-commit: 028f86457e822ab9de5b0d6d23efddc1b8b54ae1
> change-id: 20260731-pci-tc9563-aux-66a29d438f60

Applied on pci/pwrctrl for v7.4, thank you!
