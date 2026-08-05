Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB547D476;
	Wed,  5 Aug 2026 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945335; cv=none; b=Iow43gGyQwgkODhiPHcsO+wPdArf6/Pb8cejV1SYnQIlvS4Et857kypShm/Cyk6dxd2tegPg20+gw+nff219ZpJRBeNahgvfOziNrT+wyEDbT4uIUsKfUXJVEncUHG6uV50GQm/q86vua4YQtvHReZr3POWaZQBOQOmCyY0BN3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945335; c=relaxed/simple;
	bh=rUGboeri6ktZTRV2oeqR5l37M6QCHKbQNKBeC4pEino=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcRl4AQbHd2lNUo3tNL4xOZs2rVp8MLxLfbOKXOnkYWtsAmXnknkMmmCg7XHirQygr7VurvlXqnTg8qN+QxJS5uz7UbdiMV2Ca1tHvXnX9ieWcNehZ8U6DvpjA4TmWGxaU/9j5h8Rzt5GQXHEcYga/vJ3xXG8xjWXqYrnLz+meM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfQdXRbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfQdXRbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB5E1F000E9;
	Wed,  5 Aug 2026 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785945334;
	bh=LFQGI06kexFLiZXhN70EcO5t/AU5IXTV7xLphoVtzPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cfQdXRbVh2zU0daL1aTm2PkOw3nd2jbX4SNmALPqeFqA9rbj49tHS0IgFRRBUa4K/
	 qDSyTt+0yRHzkEBqc+nC2lhJgL0ZsmbyC3M/SvuvPVhhwH6Q3OSjAwytBxRzxp2+3P
	 8iI+M+Z5GoGb4ch4C8JwGc+OM0aL1gmP4/8InTCLgEkDC7ZIvsKNe5JQtvrzWfvSlN
	 t8lgJTmom++iihD2H1K3JajA7h/ZSzE5Xkq1GMKT7jl3p8MmV1j1YAxyccQyI/MFSP
	 AUh+KkpiyL7psqQSkEjRVQL9HAYrNe8LcGlNBTAwxQHWQg/rZV/CuOGGlXhsJ/EQks
	 T/W2sx51PldwQ==
Date: Wed, 5 Aug 2026 17:55:11 +0200
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
Subject: Re: [PATCH v9 5/5] arm64: tegra: Add PCIe root ports on Tegra264
Message-ID: <y7bq45p7dmy7zoz3kpwqzr77kmjr6ce52vukjeec2yvpni4twc@ale6wgwp7eos>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-5-fa2ed7350ae1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805-tegra264-pcie-v9-5-fa2ed7350ae1@nvidia.com>

On Wed, Aug 05, 2026 at 01:57:24PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The bindings have been updated to use the PCIe root port bindings, so
> the nodes for the root ports must be added.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi | 66 +++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> index cf9760c681b1..31bd29df8e46 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3562,10 +3562,19 @@ pci@c000000 {
>  			ranges = <0x81000000 0x00 0x84000000 0xd0 0x84000000 0x00 0x00200000>, /* I/O */
>  				 <0x82000000 0x00 0x20000000 0x00 0x20000000 0x00 0x08000000>, /* non-prefetchable memory (128 MiB) */
>  				 <0xc3000000 0xd0 0xc0000000 0xd0 0xc0000000 0x07 0xc0000000>; /* prefetchable memory */
> -			bus-range = <0x0 0xff>;

bus-range for Host Bridge is still a valid property and the drivers are already
parsing it. Even though it usually pass the default values, I don't see a need
to remove it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
