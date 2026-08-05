Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3E37419B;
	Wed,  5 Aug 2026 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942758; cv=none; b=GYG44qJcjTxyV9ADi1JebW5DvbnLzGeFCQAwmel6YMF/r3AnJHIrf7ruRR4yYwyVusLJg4Ee2XhzEzJlWslBhxKm+yR9USw7TDdlVDDYzu3LomE0KjJD+1gcdVorq7KGZ+OK7YQa8r5nEn2S5D925SwHWNRTfBQRoT/7CRjpxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942758; c=relaxed/simple;
	bh=qQSoMLNmUhAGAHnxqw72qblBUVk/KXHOPqexXki7XOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL0vJKYD8CnfHYKJ3mS0gIBD0TlLWwCDuxkK4VriseG12cgQcSJSysLN8z7rhkMeyCMXXNbm3MoU15v+LfdELbF+RMgu4xFOwSEm85eMRe0SurYdtE410hhmEH3uqMmt32OJ+FSEhiVITHcBryQitr1x39/g4XISwf3yMhei5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIRWqDKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIRWqDKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DEA1F000E9;
	Wed,  5 Aug 2026 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942757;
	bh=v6/3AIsV0xmrcsPgox9hI/bX0NsF+88akMIAPY+OL1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CIRWqDKs0v0CODE0erL+54zLK9/Diq2Vr1LLPIO6/8wCQeFZ/g9z5vAcmz5e/t9ed
	 s1KwfVKSck6MzD15mSHs0Unn5Rdr/CpgfVfbeCzeR/7WOCJ2kNEcsv+49R8h1Tw1lH
	 8HNyCEVi2KKOGVmxbQMgKtmowPlie50r058KgvIi+A8+sNcqEhWWXWES87KfmPWrLS
	 5Uu9f66QZwC1WoD1s91ph2xCzuddPNnGUrCthul3qJc4fCdp+hR5gqkESWUqF6Tom8
	 LZ059vymSRfXXUrQSxOjqpKzYhzOprcMv3CYKhIHCh1mSHGKBwg47BLbEyLRzZX6Te
	 MkgvcU7ToKNzA==
Date: Wed, 5 Aug 2026 10:12:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Aksh Garg <a-garg7@ti.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	linux-arm-kernel@lists.infradead.org,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v9 2/5] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
Message-ID: <178594272722.905042.3804777775947567354.robh@kernel.org>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-2-fa2ed7350ae1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-tegra264-pcie-v9-2-fa2ed7350ae1@nvidia.com>


On Wed, 05 Aug 2026 13:57:21 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Switch to using the PCIe root port bindings in preparation for using the
> standard WAKE# handling.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/pci/nvidia,tegra264-pcie.yaml         | 40 +++++++++++++++++-----
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 

You missed my R-by...

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

