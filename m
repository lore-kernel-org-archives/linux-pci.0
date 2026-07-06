Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F66389115;
	Mon,  6 Jul 2026 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334003; cv=none; b=f5MoedQrcyzfYvN8ZhyXCy1W6T60cW19w1PG0QyU60OT6Ns4gMS4RryDROeMN9XQqvzYJTtX4AH/suEPPqgn8Uz2rum6KHOE27rwLFSwZLG24QwgVdYHjqU/H1Y0Wa/F0e86NxplT4Tu0C8UkOuGeXDxp6PXUkc/2CzZR9OeHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334003; c=relaxed/simple;
	bh=aUmAMuZshk/vGhRHPkoY5uIQ21ykG3+oFzJ6+qzChF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TejxG/q2HSHrx515Mc43a2v4hsgWyLfyU6wHnOAGzI96IR6cwBgQ07u/jPRO2Wu0Bck25JzkFYz7TX1XUUR1IZXwIPhH3Kim54RDO74QxNRL7K4+F3ZT4PFlS7ntexxXLcyILX6x9VlE5hCKkr7tFy0SgfhJuihhWKn5nPeWyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV4wPO/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV4wPO/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171271F000E9;
	Mon,  6 Jul 2026 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783334002;
	bh=t25qHMlDNnh6C/Tw3ZIkerSb4sQ88yhV2t+isWLtyXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KV4wPO/lIdDhMMx2OeP7Xzyjo5h9OK+KGeqmHhjWNyu4fzwZHizgtfIO0cjKljdHf
	 /TlmkQ9qj+7sY4jGW5K6ZgyhZRPW/h+TQwp9g2atGUUHViYjblUBzp9kZz+WEfDgrx
	 WQ9WPFg7IKO6mvchG+PhCRqh4A1EdtZs8Gq6pTy49p4gYt09wMiyG9+6TO3HdjcAa3
	 7mDXwztjEJDR2yVXURvjMnthYqtWp3LWYpllC35ikLa1nhCmQIRteO+j//Yyz5GjS/
	 7/zA1sSyF43HIEyBCEi6zbMgSRXOAOYV7BhYTjdRD41SWe3A4yO4FoS0VW+2d4Y6CF
	 b0saWgmDI96og==
Date: Mon, 6 Jul 2026 12:33:07 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
Message-ID: <pdzsy4vlwayotjqawcu5b6atf3g6hs6o7knttvxpyefufggs5z@tavxdidtjscy>
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
 <20260703-eliza_evk-v1-2-7624440bd76d@oss.qualcomm.com>
 <7ce4844c-8025-48e5-a1fc-4d1cf9f7917d@oss.qualcomm.com>
 <b5a6a0a4-4c7e-4fcd-96eb-54041c29ccba@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5a6a0a4-4c7e-4fcd-96eb-54041c29ccba@oss.qualcomm.com>

On Mon, Jul 06, 2026 at 10:52:27AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/3/2026 8:39 PM, Konrad Dybcio wrote:
> > On 7/3/26 2:38 PM, Krishna Chaitanya Chundru wrote:
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
> > [...]
> >
> >> +&pcie1 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pcie1_default_state>;
> > flipped order
> >
> > [...]
> >
> >> +&pcie1port0 {
> > This port should also get the compatible
> for pcie1 it is not required, only for m.2 connector we need the compatible.
> 

There is no harm in adding the compatible property, even though it is not
strictly required. As konrad mentioned, if someone creates a board that makes
use of this instance, then we'd need a separate patch for adding the compatible.

Let's make sure we add the compatible for all Root Port nodes in SoC dtsi.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
