Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6AB3033F8;
	Fri, 12 Jun 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274737; cv=none; b=nm9iwNdZciT7IV9zeYN57omD/52Uxn8jLV4Bt8xHmA5h1ahsZ4Ypgf27cpULfxSQXXoZr8kwST8R57bYC2rVyKx9ejuZ/F+OCeCKfhel05JkFxoxjbSquHqMeS3L7Dhw10mD5sXTw5hcKBxU+i1JNWpwTcriZkgN0RV427kzlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274737; c=relaxed/simple;
	bh=tthL31lTK/Jt35GCWLRyLJ3gRCW6hyZ/B/sIeYrQLuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvLgV+BVssl4wQiyfSVERhS5N5qW91A2luung1upMKo1SGWK8dOZd23jS0JD+yoP56wJBhZnj0Xxm+HR8dsFKVDpPlys5Z6ZoX0XCOj9Z92bp6pZtfMCmoKL96ppBnsS3GOi7NeyaY6yLROC6JQgvqHYsFobi/jbL031d0N8Dn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1ZdFsrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1ZdFsrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AED51F000E9;
	Fri, 12 Jun 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781274736;
	bh=XaU+1rvSR/F7XjgGlqq7A+8Ufs+EKuf/XXOYBHAMljo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i1ZdFsrmgYwZOab0f2Gh48s1gQfEsI4qP59TxS8eY5OYXT05tC3YH2MahwLJErBYJ
	 019KX3MiiokOAHxoNFCd+xgrShlxZ5knZD1Vkca2q4Zc0CJ0svo9kSd3pTTpEM0k/w
	 mzyWNul0TUMMXRhvwuN1dAOtTbC9PDKxVXl8fsZM862vsvt9GioiH3cz7q86oj0TpT
	 V9MopHdEujJ2kcBnEdh9aoxFYYll1PhENJuqQysSvJHU1WnPZiqcVtGApbm19sckwX
	 qgz6Obs3rnAEMin43ark8FL3KrQEBou85wytKJ52Y29lN0+hxovxseG4S6lkZZqQZb
	 iP/sV0DoKmt0Q==
Date: Fri, 12 Jun 2026 09:32:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
Message-ID: <178127473464.974137.12177454800671069501.robh@kernel.org>
References: <20260508063633.3894348-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508063633.3894348-1-wenst@chromium.org>


On Fri, 08 May 2026 14:36:32 +0800, Chen-Yu Tsai wrote:
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

Acked-by: Rob Herring (Arm) <robh@kernel.org>

