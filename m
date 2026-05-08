Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BF78F29;
	Fri,  8 May 2026 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262860; cv=none; b=AO4XVoARHwPdKhJvwWQJ5yBWe4XA9DCaka6DZ+V/61xaGq54AxTfKtu8aDGWmQt6b448P3kzJsgO2/RHa47tZxfEaMeX3gt+MNtpfQRFhxXt7YnAvSQF2LxyleFtWvDnD28CylWXVuL+kH8oIytrevuBVqJfjshB7TZZM4EOxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262860; c=relaxed/simple;
	bh=kixTyVjo/edOBEApZc+Tf9KkN7fI8m9XCJYuC6DL0gY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dekTEA8MygAHHzltYLttGsMqSkRk4ACIq9G0XED6Lmdx2PDfTnwXB8a/79LBhOIy9t5K06lroMRuzk0qoGy754gjLNuxigRP1coTHj6xFWXwhyE/kiHzPOheRkKC+W2JtH0k9QuHbvllJjO7jnh8C328T7TwCaaIzOWxoDW5TgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKmrLQ16; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKmrLQ16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9552C2BCB0;
	Fri,  8 May 2026 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262860;
	bh=kixTyVjo/edOBEApZc+Tf9KkN7fI8m9XCJYuC6DL0gY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fKmrLQ16eK05i/QO1VXuWsPYdtSj6bzom61rpm59pP+9WOgE7TX9jD9bCjBLqjpsW
	 m1ud7CTnsuFwjZNdTwj+AOEzwngPrhIui1Sj5Gq6odROxCDgmPiiDfHf2IG6EYN6dU
	 kS4N6Vn8A0wkPJeWPpJU6TLz5ztJpx1vb9azRtJ3nPBuioJmQc1pNiaDfkqKIPmy8r
	 I+A+Y6Q/hPIXZYxe6RqWnJGnWGVyz1ay5XzMYixL/fQEdOIdnS3YegpX1aSa01jOQU
	 gyXOM3rPVrAhjbGVaonlUeQu5VNAcyFxtR3f7bUC0tuoEwF7zlOhBjeGF6UYUm5S8A
	 SP3gmi5aHiC7A==
Date: Fri, 8 May 2026 12:54:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
Message-ID: <20260508175418.GA97653@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508063633.3894348-1-wenst@chromium.org>

On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> controller memory access could be limited to a small region by the
> firmware configuring a memory protection unit. This memory region
> must be assigned to the PCIe controller so that the OS knows to
> use that region. Otherwise PCIe devices would not work properly.
> 
> Allow the memory-region property with one item pointing to a
> restricted DMA buffer.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This patch compliments another patch that moved the memory-region from
> the PCIe device to the PCIe controller [1].
> 
> [1] https://lore.kernel.org/all/20260430120725.241779-1-wenst@chromium.org/
> 
>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 4db700fc36ba..4a9e41d01628 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -115,6 +115,10 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  memory-region:
> +    maxItems: 1
> +    description: phandle to restricted DMA buffer

I guess this is similar to
https://lore.kernel.org/linux-pci/20250716053950.199079-1-huaqian.li@siemens.com/
and uses
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/shared-dma-pool.yaml?

Looks like those keystone changes were never merged; I don't know what
happened to them.  But it will be good if everybody does it the same
way.

I wish there were a simple way to grep for this restricted DMA
concept.  Maybe there is and I just haven't found it :)

>    mediatek,pbus-csr:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
