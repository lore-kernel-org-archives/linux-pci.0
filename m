Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447273;
	b=loOjbE5ta+/kl0MxJSuSwZOqTfkN1ybf/Odwdq28X2HInxg8ZeWu7MzhMRBK6V5myDxn
	 5cIPd2pH5bNZ/I7jzPluwoCqPT18pa9dfT5DaDvw4wlfAd2d1Hy0NXlPefRE+v1Gjvc4r
	 wy73yCg6buRTbufEbWrE1dfDfIpCRmltxaIfGGslog57yfRy/9y1WeFxTcqdGDV/LApJ5
	 6/3emJeoe4wI8dMwAY99AeOtWxBYiAQw3xFZcktNfwW682QQPAL+JpUOPrSpPIml1QUjS
	 0NzsVdB9PHNdNS88rebcE/ciopy/fbhF+x2XqXPynIQ6XEH6M/pJg9eBvdV/R4L38lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447273;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=bV0OPKtBUUI374C0IPHESWFunzS2ApGPBYB92il2cME=;
	b=lpXWqJAXWfUMIjlJ49hGW+rDDn01CL0IbfbXfCjsrgKi+YtyNB6eURjlDbKBA40yAumW
	 jyoYf7TWw4dshmr6iQiwajq3QD9SndTMaQoG2XUB83qAy20YIOoM0kUXPoCUIm0KRCYby
	 RdulKxPJX6ragT5jJCPz5WhKBUiCZ3/4UGUCgDi/z+kZiuKwDavP2EEJbkT+6na6fFeAG
	 VNpHySrKcu5XzTIbKos9NFcuMFiwDspPBwj3ZosI7odBgPykOUyZ3TR9c3OuAkCWbZhw5
	 dGi3irQ10rifUpvFOOX5slI4sdhPQMFw5rKvX1UbFx41RG/oMtpQDiWqFn9P76z7qoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfkdXr2W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C460606A31A;
	Mon, 19 Oct 2026 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfkdXr2W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6984F1F000C5;
	Mon, 19 Oct 2026 22:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792447272;
	bh=bV0OPKtBUUI374C0IPHESWFunzS2ApGPBYB92il2cME=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZfkdXr2Wx/dPio8PnbGRT0u83V4fo5Cvg9y3bnl08Q6htx5aSAm4IAYI3xhJ99931
	 nuzDO/3Ta1/zJpkvp2/+piPM+YzD26RedDsB60/rj5aRXI4vMZiX4TNDJmewkoy/o+
	 qMkJZCUyQPxdnSti+4ZP70d5dFuFcz6GZCwT1ves88FisAZ0K+qjam7MO8RzGnhz/O
	 D7pWg5T58WEVaJlxyE64jA271HLMj38vajEeqBSrfUTdRWSnaFkJXncmb4+0ohVOfL
	 QaxTR16aGIlCiaO81EOE4f3T/aQboHXBSwmpu/XYj2ZVlvaFn1bb2lrgoKMrh5h732
	 rzrAq265t5oKQ==
Date: Mon, 19 Oct 2026 17:01:11 -0500
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
Message-ID: <20261019220111.GA2271378@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015172620.GA1780580@bhelgaas>

On Thu, Oct 15, 2026 at 12:26:21PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 09, 2026 at 04:55:57PM +0200, Lorenzo Bianconi wrote:
> > The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> > lines. The controller is registered as an auxiliary device by the TC9563
> > power controller driver and accessed through the same i2c device.
> > 
> > Describe the switch node itself as the embedded GPIO controller and us
> > it to drive the PERST# reset lines of the two external downstream port
> > (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
> > switching to the GPIO descriptor API for per-port resets.
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > Reviewed-by: Alex Elder <elder@riscstar.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> 
> Bjorn A, I first applied this arch/arm64 DTS patch to the PCI tree
> along with the rest of this series, but that was a mistake because 
> those changes should go through your tree instead.
> 
> I dropped it from pci/pwrctrl.  Do you want to pick it up?

Just following up to make sure this DTS patch gets merged somewhere...

> > ---
> >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > index a13315bf0fb0..4da7342ca90d 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > @@ -867,7 +867,7 @@ &pcie1_phy {
> >  &pcie1_port0 {
> >  	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> >  
> > -	pcie@0,0 {
> > +	tc9563: pcie@0,0 {
> >  		compatible = "pci1179,0623";
> >  		reg = <0x10000 0x0 0x0 0x0 0x0>;
> >  		#address-cells = <3>;
> > @@ -891,6 +891,9 @@ pcie@0,0 {
> >  		pinctrl-0 = <&tc9563_resx_n>;
> >  		pinctrl-names = "default";
> >  
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +
> >  		pcie1_switch0_dsp1: pcie@1,0 {
> >  			reg = <0x20800 0x0 0x0 0x0 0x0>;
> >  			#address-cells = <3>;
> > @@ -899,6 +902,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
> >  			device_type = "pci";
> >  			ranges;
> >  			bus-range = <0x3 0xff>;
> > +			reset-gpios = <&tc9563 2 GPIO_ACTIVE_LOW>;
> >  		};
> >  
> >  		pcie@2,0 {
> > @@ -909,6 +913,7 @@ pcie@2,0 {
> >  			device_type = "pci";
> >  			ranges;
> >  			bus-range = <0x4 0xff>;
> > +			reset-gpios = <&tc9563 3 GPIO_ACTIVE_LOW>;
> >  
> >  			/* Renesas μPD720201 PCIe USB3.0 Host Controller */
> >  			usb-controller@0,0 {
> > 
> > -- 
> > 2.55.0
> > 
