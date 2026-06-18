Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21C3C73E1;
	Thu, 18 Jun 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767687; cv=none; b=HpM8kCQSid5bKeMyHrbqn2QVDmV1LaaFHv98v8OP2xr7io7ng7yJb+N5LH3VlvulFvwsdBHJz9FZZjItmRwc49bOIHAOBhlKGAsG858yIfiuHC7D9n5kQrLOjx5bqpjB8nyIuhQ9HIWFbV5aNc6SWfFgQCNDay80Pcpi1FWXQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767687; c=relaxed/simple;
	bh=unODuAUehzWRx4KZ0/TxjerFzEJQXLOVGhb1Jf9CIpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzW8dQnRRk3uJbJ+hk8qkQOKwgt8lau2C8O8TbLF466R6jGXE2FDMq5XQZG5x6NhmAoSjxNMm1/bu7vaIa90POvDboIM8J0NopR725vc66rARAis6OlwX6q0ZEvN/ePtacbeH+cME4r8Oq+TA/vzLPf9KV0lJzDKK2RwHMVrznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiRohrDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiRohrDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814761F000E9;
	Thu, 18 Jun 2026 07:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781767686;
	bh=s52zJzQGwWGgRjTx6SfYo2lIVyEyoqKa4aBtzbVFtO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TiRohrDtdHsj1/63/7KZb5whyJiOdcjVPsXVZyQ+3CvhN0LnBkXRi8DgbxuMHzoqR
	 xAtKiSeoiRwqfraVNY+4TcLYPe0QWBTPlvSMVwh+eIQbIWJ4tiGGKy713DCQB4ZZkV
	 N2n7xnCW64Nb4xy3QVcKwOmtF3FE8mGjb5N/CDHe1fBtfClZw/5CTu0GcNbu6jr4Hp
	 zrE5T6o0fQLJ3So8hiyVT6q3vDLptskYtm5KTU3MLgyRFrL/8AbKUOZ/m8/KYxUQE3
	 M38fQttoEd04eYWLOGOFok+VdA+AzexZgD6ZsK9ejnB9KYLSQhu1KRkTdBdCfh1SeV
	 lraR+taNMLKjw==
Date: Thu, 18 Jun 2026 09:27:55 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v7 4/4] arm64: tegra: Reorder reg and reg-names to match
 bindings
Message-ID: <7nwyrchlc2rhlh3t6keaomwbcnhchurdbxkjhpintwyr6vd56o@c4dzhpo3vg7n>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-4-eae7ae964629@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617-tegra264-pcie-v7-4-eae7ae964629@nvidia.com>

On Wed, Jun 17, 2026 at 06:01:31PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The ECAM region cannot be the first entry in the "reg" property, because
> in that case the unit-address wouldn't match the first entry. The order
> of the nodes can also not be changed to match the ECAM entry because the
> ECAM region is global and outside of any of the control busses.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> Changes in v5:
> - rebase onto v7.1-rc1
> 
> Changes in v4:
> - revert ECAM "reg" entry order
> 
> Changes in v2:
> - order ECAM "reg" entry before others
> ---
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi | 48 ++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> index 8f4350c7793b..4c701abd25a8 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3513,11 +3513,11 @@ cmdqv4: cmdqv@b200000 {
>  
>  		pci@c000000 {
>  			compatible = "nvidia,tegra264-pcie";
> -			reg = <0xd0 0xb0000000 0x0 0x10000000>,
> -			      <0x00 0x0c000000 0x0 0x00004000>,
> +			reg = <0x00 0x0c000000 0x0 0x00004000>,
>  			      <0x00 0x0c004000 0x0 0x00001000>,
> -			      <0x00 0x0c005000 0x0 0x00001000>;
> -			reg-names = "ecam", "xal", "xtl", "xtl-pri";
> +			      <0x00 0x0c005000 0x0 0x00001000>,
> +			      <0xd0 0xb0000000 0x0 0x10000000>;
> +			reg-names = "xal", "xtl", "xtl-pri", "ecam";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -3893,12 +3893,12 @@ gpio_uphy: gpio@8300000 {
>  
>  		pci@8400000 {
>  			compatible = "nvidia,tegra264-pcie";
> -			reg = <0xa8 0xb0000000 0x0 0x10000000>,
> -			      <0x00 0x08400000 0x0 0x00004000>,
> +			reg = <0x00 0x08400000 0x0 0x00004000>,
>  			      <0x00 0x08404000 0x0 0x00001000>,
>  			      <0x00 0x08405000 0x0 0x00001000>,
> -			      <0x00 0x08410000 0x0 0x00010000>;
> -			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
> +			      <0x00 0x08410000 0x0 0x00010000>,
> +			      <0xa8 0xb0000000 0x0 0x10000000>;
> +			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -3925,12 +3925,12 @@ pci@8400000 {
>  
>  		pci@8420000 {
>  			compatible = "nvidia,tegra264-pcie";
> -			reg = <0xb0 0xb0000000 0x0 0x10000000>,
> -			      <0x00 0x08420000 0x0 0x00004000>,
> +			reg = <0x00 0x08420000 0x0 0x00004000>,
>  			      <0x00 0x08424000 0x0 0x00001000>,
>  			      <0x00 0x08425000 0x0 0x00001000>,
> -			      <0x00 0x08430000 0x0 0x00010000>;
> -			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
> +			      <0x00 0x08430000 0x0 0x00010000>,
> +			      <0xb0 0xb0000000 0x0 0x10000000>;
> +			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -3957,12 +3957,12 @@ pci@8420000 {
>  
>  		pci@8440000 {
>  			compatible = "nvidia,tegra264-pcie";
> -			reg = <0xb8 0xb0000000 0x0 0x10000000>,
> -			      <0x00 0x08440000 0x0 0x00004000>,
> +			reg = <0x00 0x08440000 0x0 0x00004000>,
>  			      <0x00 0x08444000 0x0 0x00001000>,
>  			      <0x00 0x08445000 0x0 0x00001000>,
> -			      <0x00 0x08450000 0x0 0x00010000>;
> -			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
> +			      <0x00 0x08450000 0x0 0x00010000>,
> +			      <0xb8 0xb0000000 0x0 0x10000000>;
> +			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -3989,12 +3989,12 @@ pci@8440000 {
>  
>  		pci@8460000 {
>  			compatible = "nvidia,tegra264-pcie";
> -			reg = <0xc0 0xb0000000 0x0 0x10000000>,
> -			      <0x00 0x08460000 0x0 0x00004000>,
> +			reg = <0x00 0x08460000 0x0 0x00004000>,
>  			      <0x00 0x08464000 0x0 0x00001000>,
>  			      <0x00 0x08465000 0x0 0x00001000>,
> -			      <0x00 0x08470000 0x0 0x00010000>;
> -			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
> +			      <0x00 0x08470000 0x0 0x00010000>,
> +			      <0xc0 0xb0000000 0x0 0x10000000>;
> +			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> @@ -4021,12 +4021,12 @@ pci@8460000 {
>  
>  		pci@8480000 {
>  			compatible = "nvidia,tegra264-pcie";
> -			reg = <0xc8 0xb0000000 0x0 0x10000000>,
> -			      <0x00 0x08480000 0x0 0x00004000>,
> +			reg = <0x00 0x08480000 0x0 0x00004000>,
>  			      <0x00 0x08484000 0x0 0x00001000>,
>  			      <0x00 0x08485000 0x0 0x00001000>,
> -			      <0x00 0x08490000 0x0 0x00010000>;
> -			reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
> +			      <0x00 0x08490000 0x0 0x00010000>,
> +			      <0xc8 0xb0000000 0x0 0x10000000>;
> +			reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> 
> -- 
> 2.54.0
> 

-- 
மணிவண்ணன் சதாசிவம்
