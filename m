Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28B381C4;
	Thu, 14 May 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736212; cv=none; b=XRNr7efmx6CsHJGyBLCS79vOsnu4/GIbrPRc9VPFe5uX7N3aai2UnCM77+8FiHbxstKGQ5kp8nj839vkelbdJy/jO/TVy/yRrzP+CIxV7UpnCVsaKlNkvYlAyj5pY/eMrRP12AEyHwi4uWMj+8E6qa9f4hP/2V5CnjGOJGW32eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736212; c=relaxed/simple;
	bh=xLYXugCJEOfKmxl4cJu885NVF0HVggIfq0+loLNHOCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY6Oo6iSzhEY3R5Db70LVkvQplamtACSxvTMGSil6flFDVuloue0BLrsJIUcaDu1gont4wEIw1pRYaE5eC3wENLt2YdFK7O9S1Hk2ahXZnTKgi//t3AbfwKQhEXaI4YnXrf/FW9uayF0wF7hNVpiygGvD/K6fTFT5W2mW0sZ738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixL0scZd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixL0scZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229D3C2BCB7;
	Thu, 14 May 2026 05:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778736212;
	bh=xLYXugCJEOfKmxl4cJu885NVF0HVggIfq0+loLNHOCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixL0scZde5Jrz04rNuIMCd9Zq4ai5a1PnIEkiy+eyoq5WheG+C40QoP4UZ5DJ1Bfs
	 1se/oUbJTgDpKfIrQ+5sPqNk8EWfoUsLzXL6JMw/UdWSuobcRjWcjLjdpzTc+MBf+0
	 1gyqvEJdKjHzULPY9aPJRw9mToDriVMuBTgR58dQpBSIMrQlDQQN7c5Hfhe4z1i6Oq
	 Oinzg0QtS8T+i3GGywtHegNisgGT0sHqfOu2phoEp+9h3rdCiy8sq+Nib9Tc+4DydL
	 0zICvJ5b2hMjAIu28g5rxvw/uUbNKdXs4z700elDg3zAz5XTg38nXpYg2JvaH9dDUU
	 pS0HYg2H7p8Lg==
Date: Thu, 14 May 2026 10:53:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
Message-ID: <locoul5wdzuvvmm7mqpuntjqu4o75gmyd5npgfqrw3zuwsrse6@dhrjggs4cihh>
References: <20260508063633.3894348-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508063633.3894348-1-wenst@chromium.org>

On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> controller memory access could be limited to a small region by the
> firmware configuring a memory protection unit. This memory region
> must be assigned to the PCIe controller so that the OS knows to
> use that region. Otherwise PCIe devices would not work properly.
> 

So this means, the PCIe devices can only access a specific carveout memory
configured by MPU for DMA? If so, you should use 'dma-ranges' as suggested by
Rob.

'memory-region' also serves the purpose, but for PCI, we have the dedicated
'dma-ranges' property.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
