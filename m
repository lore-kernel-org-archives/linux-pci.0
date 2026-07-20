Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4941A79A;
	Mon, 20 Jul 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551921; cv=none; b=OOdtWZF+9mZaH4chPHTMmWDyqhhN2mBFl4LDDINqJi8y1cDBBdhmIJ/PDAUJ1JEw92jQfgTjda9mV5mGNZOwAl1pXvLjR8pNIQFL+P3NuwswitBT1QyJSggPiKklUrf6+ikRBFfIRRGGrgZqbGrH2KPx/kPEhWftkSmxck8saDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551921; c=relaxed/simple;
	bh=Bgzh53U3Rt5UCb4ptqiO1YYJQPUQliBmMCElL0H/Yis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNiTkzRSZvlL+TjNoWDNWpfMDsPBZqWX89HxWEXVtlDCx7OKG94i0cOfVPcZvQwK+QNuPHgQewmlMbetwvAio+QGadbHtMrMu0sh26BAecGpcxH/XQYP3SwEiN7tmtAM40rgKEFuMiVJZo/Dvl9ty5DhPXG/pYvCO96eQHknadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTX3EbeH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTX3EbeH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8381F00A3A;
	Mon, 20 Jul 2026 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784551919;
	bh=7NbFmGRL+DFWpJhLrxNldLv/oXQ0zjLejhLY/pDKR2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTX3EbeHXY2kGexsywwF78WG7NqBTfzKJqMqDKHVVjZnH1EexAo7I4eDQG86iOrAX
	 mz5KzDBOBHms3gwIwzER4Z5y2Mi6h/65ywmrL55Ue6nZbxixoK8HSQE6dSbRyQfhA5
	 U8kV+t1MtkTjWiMC512cc4AeaBPaFOtfJKNEOxAIDQi6/8jAR1EIpmBAVFYKOGrF96
	 HSrTp3mrd+krZlCoIue4CKbKJDKyBSlh9GcbGNHDr0anjjKV8Z4q1O1p+ce8/MYxuk
	 faLdaSxd54O+cvOvc34RNu0jAdnF6sVmGA79YtkGC2izi9fVWtlou6YowFRUofOQkc
	 gEvSrnY1VbaXQ==
Date: Mon, 20 Jul 2026 14:51:52 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH RESEND] dt-bindings: PCI: mediatek-gen3: Allow
 memory-region for restricted DMA buffer
Message-ID: <fgnu3itbp5wpnh23i3qafvku64ny33rwrncpjwd3cuwh6ipvt6@vujjmoikotht>
References: <20260720092116.1823562-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720092116.1823562-1-wenst@chromium.org>

On Mon, Jul 20, 2026 at 05:21:15PM +0800, Chen-Yu Tsai wrote:
> On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> controller memory access could be limited to a small region by the
> firmware configuring a memory protection unit. This memory region
> must be assigned to the PCIe controller so that the OS knows to
> use that region. Otherwise PCIe devices would not work properly.
> 
> Allow the memory-region property with one item pointing to a
> restricted DMA buffer.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Can we get this merged for v7.2? A matching device tree change was
> already merged in v7.2-rc1.
> 

This is not a bug fix, so not sure if this patch can be applied for 7.2. But DTS
change getting applied before the binding change was a mistake first of all.

- Mani

> 
>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index fbc0378392d4..b88717dec1fa 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -116,6 +116,10 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  memory-region:
> +    maxItems: 1
> +    description: phandle to restricted DMA buffer
> +
>    mediatek,pbus-csr:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> -- 
> 2.55.0.229.g6434b31f56-goog
> 

-- 
மணிவண்ணன் சதாசிவம்
