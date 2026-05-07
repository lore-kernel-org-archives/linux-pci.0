Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F43A759E;
	Thu,  7 May 2026 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181025; cv=none; b=hX5xA5zCOg5HOri0+HtgDfhI/UyfOpZnJzX+71RxIX5g2Pj6u7KJWBTyyVltFfLWFP9iDWQ4e60k8kM4Km823fGk2jFc6PHGPx9gb2F/JM7UR0pUw6UOwWHPiwTiyNnf5vMADojQlvIATzJuhtLIX+nodZZh6bd8WLCzikPYEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181025; c=relaxed/simple;
	bh=92a47Yrm0EFCck+SA8MtVTLouVrXOvrFH0ZlXbIjit8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njzHR/b1aqOTRJboejqZIGXJonLAycsA/nw3i3Z2LR739vKVkQMpn+NAtCmj0ynd5Uh75wJ8lcUR1JvpCE3MsX3YI4eqiU1RRWLN1G8HDlbmyCa65hqYrn5ivJnEvdsd9y886KHKXNPcTj0B25roag+wqMtDYbSi62tBcsbLvFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4DKPYLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4DKPYLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10866C2BCB2;
	Thu,  7 May 2026 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181025;
	bh=92a47Yrm0EFCck+SA8MtVTLouVrXOvrFH0ZlXbIjit8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4DKPYLmJ/jQ7aliCUbzhR1JVZz0l5rcfAXa/RsvG9Vd3hO6HNV6eOFqYyqx7NNkE
	 InypQbEUJPkOeu/Ls3p56nDrHiCMX5qUFVavSMAxkZ767pgSnG8vk1K1gK838IIjUg
	 gy7Z/O8GezNjsS10VZAwyJXF/6/6bpR26G9VsPzFRwwvhbMwo7J8TBOzlh1jzrskIw
	 AiMg3DPmNQwippJdQ0PaKwQUo73ZyJeNgPRgubQA0Ggz+n32YG5LM44IfGh9yIyDYS
	 fgogalTyZsKSebJDe0p4rFK3Q9bXXuGJvKsNcuCKur+ePGF5q2MD3k/YED708PdPkD
	 a7MD6ORoL3z7A==
Date: Thu, 7 May 2026 14:10:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Yixun Lan <dlan@gentoo.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Alex Elder <elder@riscstar.com>,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Yixun Lan <dlan@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Paul Walmsley <pjw@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	spacemit@lists.linux.dev, Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: PCI: snps,dw-pcie: Add msi-parent for
 msi handle check
Message-ID: <177818102236.2282368.7598186704669849987.robh@kernel.org>
References: <20260502101319.2364052-1-inochiama@gmail.com>
 <20260502101319.2364052-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502101319.2364052-4-inochiama@gmail.com>


On Sat, 02 May 2026 18:13:16 +0800, Inochi Amaoto wrote:
> The IMSIC device on RISC-V based system does not require ID
> remapping for MSI. So this device only needs "msi-parent"
> property for IMSIC-based SoC, and the "msi-map" is not a
> necessary property.
> 
> Add new condition for msi handling on IMSIC based SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

