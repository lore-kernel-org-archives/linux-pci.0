Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F533CA491;
	Tue, 10 Mar 2026 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773131146; cv=none; b=UCZ//9bX8m6jyWpLXLVte4bDWaCmUErx6XgBnfzipwqNJ3t+EMYDgeI7h+IKX1MZXg7KgnoAgw9sZNvmGsJY4IozF+SR3hhDnzAQqOlPaF3QYchT1l6K01bu5vt8SJV7MzK/35+NFFGW9sPZxNXhGsOmz3uEW2vVyB2wazWvOfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773131146; c=relaxed/simple;
	bh=cuyXodzCUJDUciuTuMLZ7yq7kwx0PZeH+CANPawJXyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBiynEwmaCn75awQr10HOVGk9Hktk+ik4QJuxC98z87NKDAdTYXZyu6bMXeugT0Z29pHsyJFAy7PYuuqHwR+FS2okumdDYffrfqAmDo/QudYikcG+kI9lpzqgbhQRYCjiyk/mxCpOkj8/3OW3JVKx41lzLx07BKlznrKYss/3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JieQepDV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JieQepDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E43C19423;
	Tue, 10 Mar 2026 08:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773131146;
	bh=cuyXodzCUJDUciuTuMLZ7yq7kwx0PZeH+CANPawJXyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JieQepDVERwVWnitXD9N0MA2AcgB0PzHHytY/SxYWvP2Xligm3ViBnsiU8IYik0dR
	 +GgsBzXMC+1Sb674F/+Vrzicw7e4nnJCBVRozia6Zw2unGpEwFwYkdSKoHMJQs0Rnl
	 1WnAIDL8Y0AMpElTrVqOgd4qcLzL4Iryfv8XC2vObnJLBhLpPYFvOzMyG3Mb0+kI9E
	 ZVi7cuwk/TJp5wf9lfyGHBWhPFvmGQpVWSg48WyYdJMC8xgBxEUhCMBnJAeWLSpAvu
	 TMlz+ZnNkCKWW4b3G0MEbyElarMvt/40ChM9TztCXTpysEDuaBfNFGdV+Q12NVj7Sz
	 Aza/AOg1DwWmg==
Date: Tue, 10 Mar 2026 09:25:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: linux-mips@vger.kernel.org, naseefkm@gmail.com, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tsbogend@alpha.franken.de, ryder.lee@mediatek.com, 
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	bhelgaas@google.com, vkoul@kernel.org, neil.armstrong@linaro.org, 
	p.zabel@pengutronix.de, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	nbd@nbd.name, ansuelsmth@gmail.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/8] dt-bindings: PCI: mediatek: Add support for
 EcoNet EN7528
Message-ID: <20260310-onyx-ibex-of-progress-fdf1bf@quoll>
References: <20260309131818.74467-1-cjd@cjdns.fr>
 <20260309131818.74467-6-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309131818.74467-6-cjd@cjdns.fr>

On Mon, Mar 09, 2026 at 01:18:15PM +0000, Caleb James DeLisle wrote:
> Introduce EcoNet EN7528 SoC compatible in MediaTek PCIe controller
> binding.
> 
> EcoNet PCIe controller has the same configuration model as
> Mediatek v2 but is initiallized more similarly to an MT7621
> PCIe.
> 
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie.yaml | 1 +
> 	 1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> index 0b8c78ec4f91..57cbfbff7a31 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> @@ -14,6 +14,7 @@ properties:
>      oneOf:
>        - enum:
>            - airoha,an7583-pcie
> +          - econet,en7528-pcie

Patch is heavily incomplete - why do you have variable number of clocks?
1, 2, 3 ... or 6 at the same time?

Look at the rest of this file to understand what you need to write.

Best regards,
Krzysztof

