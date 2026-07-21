Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916703AEF46;
	Tue, 21 Jul 2026 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617108; cv=none; b=qui3rmgJpOPuj/WOnmdbkKhmCqzYyWfKr7DrE3FQVeRKuM5nkNXRhgxryAY+Do3Aq9EJamtOk3GG/29CyKNLTlXH1H9kS2Olkqz2rYfZ+Owlz2aidGFsWf0BFpvGEerMITPj3/KiNi6bDb+ypjj55oQ/QRQazwfAGGw/chCgU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617108; c=relaxed/simple;
	bh=HPCC10nodfhpEjc8Ujy/UFMiOfJ20pa0+JByl/JZbZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bELy8K0E+AqLY4CTMyxIS8uyvLImAE9OHZAUICB5Fc15gEVWLuozSh8TB/Ytk7lzkZx72c/7ysnHgDffooDMJ56fTrT0BNl5awyEfRgyd20Fe+e5GbQKupelqefbc6Q2ggPDfZumT2TaczAN39Q2HqUJGkG98Q30vRzKhd7G8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO/CaDTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO/CaDTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D811F00ADB;
	Tue, 21 Jul 2026 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784617107;
	bh=1n3w+VN/YOL3NfuBEMsVyb3/5Ot/N2PrvXduek4sYpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PO/CaDTkx/bLH88Kkacf2b9JZSyMVBHjU3FN/xif3+uqVvSKNYA9i30g41H0SEsRj
	 ZSwYSFp0RwFYx3VxgLjQyFI0qpBOfwOUn71mIH9gVxs/mhc4d7cG4KHzIOVPOb9uYN
	 WuzSaJgGqRp5VCuCmBqsnbMpuFcojXriamM+Cm5fDDup0DwjXOKCAAKqUEgmudEZZu
	 9o8cuc9Aw5km4ccD1LWsFwz7bsH9x1BSZ3UhwY7dmynxWaaMnRV8u2aUqLtLzscnYX
	 CQVoEuw5SJgLcwIKIXI6n9p+QPRLa/VogLRk39BDyd+RcELP8ah3tCWp361+mKG1mm
	 6ayr0p+xY5psQ==
Date: Tue, 21 Jul 2026 08:58:19 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Message-ID: <w4ttsrd3onnut3665te36qoh3avfca2mcp5hzowelb63sfvoof@cqxqvpg6ajge>
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
 <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
 <n4s25nftmn3ginddls4u3tpzabkgiotwzh4kws5s4jfppup36s@ccbfrrrqxihq>
 <76288f31-57ea-4a42-ad50-8504d8eccfa0@oss.qualcomm.com>
 <2xz7madb3jkifwjwziozuudx3s57g25my3j6ucwjzbguacpgyn@btyrkbzqzh4a>
 <3eb742e3-6381-47d9-9f16-c08915963748@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3eb742e3-6381-47d9-9f16-c08915963748@oss.qualcomm.com>

On Tue, Jul 21, 2026 at 12:15:17PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/21/2026 11:52 AM, Manivannan Sadhasivam wrote:
> > On Tue, Jul 21, 2026 at 10:56:20AM +0530, Krishna Chaitanya Chundru wrote:
> >>
> >> On 7/9/2026 6:37 PM, Manivannan Sadhasivam wrote:
> >>> On Wed, Jul 08, 2026 at 11:47:17AM +0530, Krishna Chaitanya Chundru wrote:
> >>>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> >>>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> >>>>
> >>>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> >>>>
> >>>> Override the base iommu-map with the expanded set covering all the
> >>>> switch's downstream ports (0x1400-0x1408 SID range).
> >>>>
> >>>> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> >>>> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> >>>> from the PCIe controller.
> >>>>
> >>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 112 ++++++++++++++++++++++++++++++++
> >>>>  arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
> >>>>  2 files changed, 113 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> >>>> index 6d76715ccffb..e099b7c8c371 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> >>>> @@ -12,6 +12,26 @@ chosen {
> >>>>  		stdout-path = "serial0:115200n8";
> >>>>  	};
> >>>>  
> >>>> +	vreg_0p9: regulator-0v9 {
> >>>> +		compatible = "regulator-fixed";
> >>>> +		regulator-name = "VREG_0P9";
> >>>> +
> >>>> +		regulator-min-microvolt = <900000>;
> >>>> +		regulator-max-microvolt = <900000>;
> >>>> +		regulator-always-on;
> >>>> +		regulator-boot-on;
> >>>> +	};
> >>>> +
> >>>> +	vreg_1p8: regulator-1v8 {
> >>>> +		compatible = "regulator-fixed";
> >>>> +		regulator-name = "VREG_1P8";
> >>>> +
> >>>> +		regulator-min-microvolt = <1800000>;
> >>>> +		regulator-max-microvolt = <1800000>;
> >>>> +		regulator-always-on;
> >>>> +		regulator-boot-on;
> >>>> +	};
> >>>> +
> >>>>  	vreg_pcie_m_3p3: regulator-3p3 {
> >>>>  		compatible = "regulator-fixed";
> >>>>  
> >>>> @@ -99,6 +119,98 @@ pcieport0_ep: endpoint {
> >>>>  	};
> >>>>  };
> >>>>  
> >>>> +&pcie1 {
> >>>> +	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
> >>>> +		    <0x100 &apps_smmu 0x1401 0x1>,
> >>>> +		    <0x208 &apps_smmu 0x1402 0x1>,
> >>>> +		    <0x210 &apps_smmu 0x1403 0x1>,
> >>>> +		    <0x218 &apps_smmu 0x1404 0x1>,
> >>>> +		    <0x300 &apps_smmu 0x1405 0x1>,
> >>>> +		    <0x400 &apps_smmu 0x1406 0x1>,
> >>>> +		    <0x500 &apps_smmu 0x1407 0x1>,
> >>>> +		    <0x501 &apps_smmu 0x1408 0x1>;
> >>>> +
> >>>> +	status = "okay";
> >>>> +};
> >>>> +
> >>>> +&pcie1_phy {
> >>>> +	vdda-phy-supply = <&vreg_l1k>;
> >>>> +	vdda-pll-supply = <&vreg_l3k>;
> >>>> +
> >>>> +	status = "okay";
> >>>> +};
> >>>> +
> >>>> +&pcie1port0 {
> >>>> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> >>> No reset-gpios?
> >> RESX & PERST are ORed in this platform, as we can declare at only
> >> one place we declared it in the tc9563 node as resx-gpios
> >>
> > So this means, if both are defined, the assert/deassert sequence causes issue?
> > If so, this should be mentioned in the comment here.
> we can't claim the same gpio in two different drivers. the probe of the driver
> probing
> 2nd will fail as the gpio is already requested by the first driver.
> 

Ah, 'ORed' doesn't imply that same GPIO was used. You can still OR 2 different
GPIOs. anyhow...

> I will update the commit text while re-spining.
> 

No. I asked you to mention this in the comment here. Like,

	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
	/* Same GPIO is used for both PERST# and resx-gpio */

- Mani

-- 
மணிவண்ணன் சதாசிவம்
