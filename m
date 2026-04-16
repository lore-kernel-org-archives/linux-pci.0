Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB223803C5;
	Thu, 16 Apr 2026 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329139; cv=none; b=MQ0a0PbMbRrY1oNmK0k/zNA2EJ1mbRVA+h6acpNVITT2vot28XQyoF2+dXkWYr/QebNRDfBohPyd6oAsSb30Ditm94OdLdvIhFFUNq2gGWurUENvRx9sQ1rUlo2qn9A0SZS/9PXvuyI8BXymvdVpzEy2YfEU7a374N6E/cPLMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329139; c=relaxed/simple;
	bh=TaoPdXb7fo2KgCWPj8CeI+oooRxf58FR1DvBmuvgJv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaRchcWtz3QUvuOlb5Okz15rO/3EKC+3VFQVzO2A/tNn1Ub6hoaB5QpCuJqlRJEkIEb0+DodJQgQ27Y0D+XIGRgbj+rNOjbCbXmNqgS0I6KOsK70f29sgDBU28iZIUaIR+r12Er8QhtW7ro4Z2rQh3TveYHuryMelmwe5p/lSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7Z+0Yf9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7Z+0Yf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47A8C2BCAF;
	Thu, 16 Apr 2026 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776329139;
	bh=TaoPdXb7fo2KgCWPj8CeI+oooRxf58FR1DvBmuvgJv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7Z+0Yf9age7mCvPKhi6JIX5mKtFxjPBYmtNuE5+fjCm9wfe0APcw4ZedpCeSHIde
	 f0M73lHdM4GlkQBKUkjsNnUqyBs5sI6D4VmVsEXacY7rmpUhxhnHpXW4FeCeDWGEc/
	 urp2PnQ7R9xjgBqWwQaOGOqC5+FL5xW8t5k6Fj4yXheHMiBL0oGdpPSO/7irWK+2Cv
	 Z0KVs4zOs30t0HLn99cTqNCaGoZGzFgVFXFhzoumGe/GjcE2UeB7AahNIPy+uzrkUa
	 loz1u9M37sAVaulwyKssray8vh6s0+1mFfJtsJr5Q4mXqeD9Cja7oPp25BjwlZcrOt
	 mvK8MoHr3vJDg==
Date: Thu, 16 Apr 2026 10:45:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: PCI: Add UltraRISC DP1000 PCIe
 controller
Message-ID: <20260416-pretty-rebel-bee-dfceba@quoll>
References: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
 <20260415-ultrarisc-pcie-v3-2-73f06e972616@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415-ultrarisc-pcie-v3-2-73f06e972616@ultrarisc.com>

On Wed, Apr 15, 2026 at 03:21:18PM +0800, Jia Wang wrote:
> Add UltraRISC DP1000 SoC PCIe controller devicetree bindings.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 93 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 100 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

