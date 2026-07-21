Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B92FF669;
	Tue, 21 Jul 2026 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784614970; cv=none; b=n9TU3DBdgi2UwUsxlKsUYVM9PJm7YhSOWoKdApTLVzyCtk1ZmDYxP38HW6Cq/MOJbdSncPmNfvkfdsCH4G184gofSWgpjsrL1bNv4ltCBxQTNhLgGfIy6dzj7Bcl2GaQTfEjOiIZzMvgteW44nqgAhNqrtNwSVf2vQwoaYa6RYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784614970; c=relaxed/simple;
	bh=ODTYBgX+jlUQruU0hAmr2ToaVlytLSDAW3uSvlZEu5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amixjbOGaF7T8DzdplM1LsABwaCPwfNTvjJ5dkleyiddjXMA0cPp+EPLAwXfx8ZpL3hRkZbQNMBOcFDgvJ/kGGSvuAP+xeryrNstBn/no1+dmJJTR57FmWFniBZy5lZGJzzWdQv7WIDKlr42WIdRpzaLO1PmSQ7XwswOItbR+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4dOmKZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4dOmKZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38671F000E9;
	Tue, 21 Jul 2026 06:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784614968;
	bh=rKeTPI5jqiUqG0TfM9U3+ay3JocBwanqGc8pIY1Ls6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D4dOmKZ40dY8rZvYJL5JGA0y0gudPIyswlU5MOLj6cHewkZRGT/SMvN5FNmqXGRFh
	 nZpJH8qkN71rdHH6y9T/f4BuxwSaBJVYq4YSHHwnLXKtZfzahb5uOwuJDCAKIuVC9I
	 aPALpsHCtW/COz/cFjXoct6t1UK2StIoyI6LbSVhpXuw0OaFXnQbbYU9xuOV2DnkGH
	 UIxLJNKPAOimQ/US/HGoCnrMoiNkb/kdjN4JIAEZ8tYM8wF+spOqVb89nulKtYER3U
	 UwFTLay1vaarF9zEMT8QPpE3aaCeSPJcAMb7xgROR95nsSkUt1rPFPmMXNmMigkYYE
	 fWk/KN2rS0U2g==
Date: Tue, 21 Jul 2026 08:22:40 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Message-ID: <2xz7madb3jkifwjwziozuudx3s57g25my3j6ucwjzbguacpgyn@btyrkbzqzh4a>
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
 <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
 <n4s25nftmn3ginddls4u3tpzabkgiotwzh4kws5s4jfppup36s@ccbfrrrqxihq>
 <76288f31-57ea-4a42-ad50-8504d8eccfa0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76288f31-57ea-4a42-ad50-8504d8eccfa0@oss.qualcomm.com>

On Tue, Jul 21, 2026 at 10:56:20AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/9/2026 6:37 PM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 08, 2026 at 11:47:17AM +0530, Krishna Chaitanya Chundru wrote:
> >> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> >> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> >>
> >> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> >>
> >> Override the base iommu-map with the expanded set covering all the
> >> switch's downstream ports (0x1400-0x1408 SID range).
> >>
> >> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> >> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> >> from the PCIe controller.
> >>
> >> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 112 ++++++++++++++++++++++++++++++++
> >>  arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
> >>  2 files changed, 113 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> >> index 6d76715ccffb..e099b7c8c371 100644
> >> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> >> @@ -12,6 +12,26 @@ chosen {
> >>  		stdout-path = "serial0:115200n8";
> >>  	};
> >>  
> >> +	vreg_0p9: regulator-0v9 {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "VREG_0P9";
> >> +
> >> +		regulator-min-microvolt = <900000>;
> >> +		regulator-max-microvolt = <900000>;
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +	};
> >> +
> >> +	vreg_1p8: regulator-1v8 {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "VREG_1P8";
> >> +
> >> +		regulator-min-microvolt = <1800000>;
> >> +		regulator-max-microvolt = <1800000>;
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +	};
> >> +
> >>  	vreg_pcie_m_3p3: regulator-3p3 {
> >>  		compatible = "regulator-fixed";
> >>  
> >> @@ -99,6 +119,98 @@ pcieport0_ep: endpoint {
> >>  	};
> >>  };
> >>  
> >> +&pcie1 {
> >> +	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
> >> +		    <0x100 &apps_smmu 0x1401 0x1>,
> >> +		    <0x208 &apps_smmu 0x1402 0x1>,
> >> +		    <0x210 &apps_smmu 0x1403 0x1>,
> >> +		    <0x218 &apps_smmu 0x1404 0x1>,
> >> +		    <0x300 &apps_smmu 0x1405 0x1>,
> >> +		    <0x400 &apps_smmu 0x1406 0x1>,
> >> +		    <0x500 &apps_smmu 0x1407 0x1>,
> >> +		    <0x501 &apps_smmu 0x1408 0x1>;
> >> +
> >> +	status = "okay";
> >> +};
> >> +
> >> +&pcie1_phy {
> >> +	vdda-phy-supply = <&vreg_l1k>;
> >> +	vdda-pll-supply = <&vreg_l3k>;
> >> +
> >> +	status = "okay";
> >> +};
> >> +
> >> +&pcie1port0 {
> >> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> > No reset-gpios?
> RESX & PERST are ORed in this platform, as we can declare at only
> one place we declared it in the tc9563 node as resx-gpios
> 

So this means, if both are defined, the assert/deassert sequence causes issue?
If so, this should be mentioned in the comment here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
