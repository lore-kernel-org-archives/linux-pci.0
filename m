Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B37346E70;
	Tue,  7 Jul 2026 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401951; cv=none; b=cwNVJqR7TKk8FEZzAkGrjHVmIBdd/y3deEttR5WD1z+SN5LVuq1c+A43VF2xiMO8koRCflMb9Z5umwHPoiDfwXTUFOlItGGE67VOvvC95cxyrZgEXMAO5/atiVgWNfc1kM9DBq5BuKRT0k9QJ9C51STPCQhP9Q909rWMtSbg7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401951; c=relaxed/simple;
	bh=F6mQwoCMTuu/uH9xmUViwfaimMjet4pXHonTlyZ4nyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQ4rYPkc5U7JjVPyshQlPvrBi3TdbWIrEJtLz6GYeS9nbWDLeyXaSZfpKCKcyF92KXDQmMJIIMw+DeSSf6xKXQyLW85g8+j1GLZmUmG7OUv6FcTEtxnidkMUL6rzAiqAI+OlpnAKl8XdO2XXjouWqTTVggPlyLsyvRQDNTHCF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCM/CimA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCM/CimA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4534B1F000E9;
	Tue,  7 Jul 2026 05:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783401950;
	bh=O95+EHVsSrm2b2PDAVwRTrIesXs0v3qc0/UAGmjBuaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nCM/CimA1tdGj+3M6ZoWwc/THkObfuq2JjyZCdXZ+qQgZSGB2/1XppufL7dfE6IDY
	 hB5nS50/v0bSifJLAn9y78lbASg0bNYg5GuB8vrEO+MuhT0aiT18dJfeoaSDhHwyiL
	 Ea1rcLbtsx7CfvMYS6dBdfgkgO9udRgdDT2mnFkKgs9OE4q82bhgFuaK7TA6U2bJck
	 JUIWbRMfy94cF+XiywNsiGP69JDJH+W9CK1A9N+idviGZfi/hEjwR5+f6h6qTC3XTM
	 ng/TXd0hevBAN8LQOkIYH/0GP75fuyi44plKdeqHXm3eO4+Sk36usvThYiusoggdCN
	 eopr4y5Fcc0Ww==
Date: Tue, 7 Jul 2026 07:25:41 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pci: qcom,hawi-pcie: Add Maili PCIe
 compatible
Message-ID: <kkymhc4k5jvtw7kmevvpsiuhwxvtzow4o6ha4b5orzf3x7ptmg@lx5uzkknrykn>
References: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
 <20260703-vdev_maili_dt_bindings-v1-1-c9df0916cd5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703-vdev_maili_dt_bindings-v1-1-c9df0916cd5e@oss.qualcomm.com>

On Fri, Jul 03, 2026 at 05:38:40PM +0530, Vivek Pernamitta wrote:
> Add qcom,maili-pcie as a compatible string that falls back to
> qcom,hawi-pcie, as the Maili SoC reuses the Hawi PCIe controller IP.
> 
> The Maili SoC is a derivative of Hawi and shares the same PCIe
> controller architecture, allowing reuse of the existing Hawi PCIe
> DT bindings.
> 
> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> ---
> Dependencies:
> - PCI: qcom: Add PCIe support for upcoming Hawi SoC
>   https://lore.kernel.org/all/20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com/

Squashed with the Hawi patch, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
