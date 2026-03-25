Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C326F476;
	Wed, 25 Mar 2026 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774401894; cv=none; b=YEcQJOnhnbBJWOsJqSX4Y8FqCLZ1lT3Ng/1MJgqyF8wVBIjsfYcL9ensjzxyERJSoYXi4DwHr9hKrAoWpoyf3xvmGjcXT86PmX6XUQrfBvr7tnpswwSZ/1sq3g683OqMOJPby85IvaAIT9lrAxyHX2zPRLirRnerlLUMovtBV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774401894; c=relaxed/simple;
	bh=WtH6jejJPTSPrq9rLpaDxloisIgclTk0Shm03kvs/ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXX3WyoMUlGq4M2d110sB5zz3ixYLwY0+c+gRqgJlMiUWPUOyLZealzAjs2KhKcuT7Mqf7WvM4tKM4VV0rT+UYKcKc030xwhNtlxxytECBLgI426dlpEtQkovg1FlVtl1J3T4S0xu04mH/R2JRH8HhvaGxvTuLpMlF+6IBefQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsOwB6Pl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsOwB6Pl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51013C19424;
	Wed, 25 Mar 2026 01:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774401894;
	bh=WtH6jejJPTSPrq9rLpaDxloisIgclTk0Shm03kvs/ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsOwB6PlE3u/GyyMJBJrnWjKoWIdBuvbozn46aQfR0NbXVEv0SRKQ1Lwl6Zd24Snp
	 UT98DwbnFyiheVqnAkCvdtkwoW6xoVjU2VJb71y63dZ5mbNNqSNGxe3V/yZ7hzP6WB
	 QigaA3AEUZZUz7ZdhvAw0iJg81W4rmowY1XRvdGmlZgcX2WRTI1sAYoa5jgw6oyBkz
	 6BtpTlV4C96HbL9DcFEGuvxV+i6U0McxGI+E0jX76kS3+rgxZnRg7k4U1ToXmV11GP
	 jn640QHRjXH1GYTfUkoK5yKsI4b2hr96Hv3/km9bsnkTlFpI7Le0a1k0eL5NjAVkjJ
	 WNQNi0BzVBTAQ==
Date: Tue, 24 Mar 2026 20:24:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: pci: Document the NVIDIA Tegra264
 PCIe controller
Message-ID: <177440189257.2451552.18196101830235626115.robh@kernel.org>
References: <20260320225443.2571920-1-thierry.reding@kernel.org>
 <20260320225443.2571920-4-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320225443.2571920-4-thierry.reding@kernel.org>


On Fri, 20 Mar 2026 23:54:35 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The six PCIe controllers found on Tegra264 are of two types: one is used
> for the internal GPU and therefore is not connected to a UPHY and the
> remaining five controllers are typically routed to a PCI slot and have
> additional controls for the physical link.
> 
> While these controllers can be switched into endpoint mode, this binding
> describes the root complex mode only.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - move ECAM region first and unify C0 vs. C1-C5
> - move unevaluatedProperties to right before the examples
> - add description to clarify the two types of controllers
> - add examples for C0 and C1-C5
> 
>  .../bindings/pci/nvidia,tegra264-pcie.yaml    | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

