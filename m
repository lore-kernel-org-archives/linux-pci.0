Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3603976A0;
	Thu, 15 Oct 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085190; cv=none; b=hTMAdky1tmhZ/jpnysyGzjvlkgqVS9tpqPLF1obatkbhQFPP0CdCWPbZQIsk5fyP2yoJCJhkHGq9NEIOwfaBECy3xEU9Mbf8lBR88aB6S2REf1DLv281N+uLOIz7PjduaHv5eXYgIR1B4doqhFde8Qd9GssdZw/QfPWhY4qgsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085190; c=relaxed/simple;
	bh=859LorO3SVH4IgfO0pOkgamEY7F8RMrNrKlxN7k7zDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QerQlWtJT3sazmddBDZseE2j0MlyWT3/+CpbwgpfZzLHkGgBcGFMIrrQGcZJYRyk7mRTNmECoTWKvkDDQmBjuf18CqsV4+SaeNpNjs/Tqh16FdtnqLZi+aYWZCZPdC8dwBQKar3Bzxa/y0CoSSFsFpRynqWDbUGHYVfwKKwBCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0/YUD6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0/YUD6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321541F000C4;
	Thu, 15 Oct 2026 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792085181;
	bh=IIx15jWixW1G5hCloVZvojxE5NrsNdtOMqxGhVbshIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=j0/YUD6LjZQO/2u4eKtWC6nhDyKXqFhuiQDq4dC8iOJYY4R2sTxFG+yUbLxRMMJeh
	 31e+58DUuLCPAWxsVPln7jERinc3iw0pJYu8o00/qOsWerrVtq/CaxiwGqQsfxcqas
	 VPeEJx13H28a6Rggt69gWpWzMiQhcPqIxUM0n2sGjMx0I+3Gd0QzhJm3C674NmbT7q
	 R2rbznKWKO0ABwXBkxE9gF26iRKE0OZ3o2F4+xKZYbSlWW5Szu8HwtezKPC0pLEfZH
	 rZH6vN21yt4wdUkAKGEgdE6JauVMTL3dQ157ks+Akoa5oLp0YOZP/MHmYX/CFau6/E
	 M9ppo8eO/pupQ==
Date: Thu, 15 Oct 2026 12:26:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
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
	Konrad Dybcio <konradybcio@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563
 embedded GPIO controller
Message-ID: <20261015172620.GA1780580@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-pci-tc9563-aux-v5-5-c9b33f56c8d3@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 04:55:57PM +0200, Lorenzo Bianconi wrote:
> The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines. The controller is registered as an auxiliary device by the TC9563
> power controller driver and accessed through the same i2c device.
> 
> Describe the switch node itself as the embedded GPIO controller and us
> it to drive the PERST# reset lines of the two external downstream port
> (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
> switching to the GPIO descriptor API for per-port resets.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Bjorn A, I first applied this arch/arm64 DTS patch to the PCI tree
along with the rest of this series, but that was a mistake because 
those changes should go through your tree instead.

I dropped it from pci/pwrctrl.  Do you want to pick it up?

> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index a13315bf0fb0..4da7342ca90d 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -867,7 +867,7 @@ &pcie1_phy {
>  &pcie1_port0 {
>  	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>  
> -	pcie@0,0 {
> +	tc9563: pcie@0,0 {
>  		compatible = "pci1179,0623";
>  		reg = <0x10000 0x0 0x0 0x0 0x0>;
>  		#address-cells = <3>;
> @@ -891,6 +891,9 @@ pcie@0,0 {
>  		pinctrl-0 = <&tc9563_resx_n>;
>  		pinctrl-names = "default";
>  
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
>  		pcie1_switch0_dsp1: pcie@1,0 {
>  			reg = <0x20800 0x0 0x0 0x0 0x0>;
>  			#address-cells = <3>;
> @@ -899,6 +902,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
>  			device_type = "pci";
>  			ranges;
>  			bus-range = <0x3 0xff>;
> +			reset-gpios = <&tc9563 2 GPIO_ACTIVE_LOW>;
>  		};
>  
>  		pcie@2,0 {
> @@ -909,6 +913,7 @@ pcie@2,0 {
>  			device_type = "pci";
>  			ranges;
>  			bus-range = <0x4 0xff>;
> +			reset-gpios = <&tc9563 3 GPIO_ACTIVE_LOW>;
>  
>  			/* Renesas μPD720201 PCIe USB3.0 Host Controller */
>  			usb-controller@0,0 {
> 
> -- 
> 2.55.0
> 
