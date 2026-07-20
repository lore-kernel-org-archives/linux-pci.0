Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6B41B34F;
	Mon, 20 Jul 2026 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552013; cv=none; b=qBlSe/4shjw7H0NnI9rEQj5rWspBKnlz1NDv+2OkCLkDYrvULsoCHXbw2ezfl4I7nyCev4+qNmSQcfBWjkitov0wwYaDrBzztUTT2Nnwm/TOXTvinhf6PN9HQVYKOlaXiRrs5gCnSq3CsrfWAZvG6myf991O/cph/8gzIO4yMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552013; c=relaxed/simple;
	bh=VYQi8z9ZEwz8QiRMf/wZKTdL6xqD9nnLKw9TlnU9Fgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hok/Fe9QBfm0E2/jC7uas9CsOXScC7ZtVMrYG9gZcuhOUwGFaBgmxo63VOK73xdR46TUWyEEL5FlW0qkPJgx7RQbLcd3yUxjO/GWXPSSk00hu9k+IuV0QsC7FIM+LRtZ0SIxkPtY/OO0ra6dbXGg/ltxaRBC+hAfLSNue1f/tSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt3DI0FP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt3DI0FP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085B91F000E9;
	Mon, 20 Jul 2026 12:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784552012;
	bh=UHakvw+cq0FvSh0mcTv/5djlh0p78EMHWetYuji+QdU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Rt3DI0FPJzv9T7eyZMiTb199zFGMKp82CFz/QaWeeA/eUQzd+HrvS6R8qdPnDjLj2
	 9GbsxwPvf1MZ4B/Atcpbja823x+dCwbAMe+25SI849UCnYeIiUdRnFNUgb2f+UNep/
	 kDSJFzXO9xH0Zj7ULfL6VGTUxX373GFrRM8JV11V8udzOr3A4GRdghyvOa45jFL7WR
	 TUVUBz0gt3hyIhE1oiai0SBUpqId9x3Dqjhy6IB6A86TN8cXeMIFvVBU8k3FX/F5bK
	 Rjp3qYNaWcAoNX8HdqiSVDdDJ3LxDFWEpbolaXBE3lrvWEhHo+ts3BwO3VFz6Iupx7
	 PoBdBxeL3YzQA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20260720092116.1823562-1-wenst@chromium.org>
References: <20260720092116.1823562-1-wenst@chromium.org>
Subject: Re: [PATCH RESEND] dt-bindings: PCI: mediatek-gen3: Allow
 memory-region for restricted DMA buffer
Message-Id: <178455200859.22551.15072267007886622364.b4-ty@b4>
Date: Mon, 20 Jul 2026 14:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 20 Jul 2026 17:21:15 +0800, Chen-Yu Tsai wrote:
> On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> controller memory access could be limited to a small region by the
> firmware configuring a memory protection unit. This memory region
> must be assigned to the PCIe controller so that the OS knows to
> use that region. Otherwise PCIe devices would not work properly.
> 
> Allow the memory-region property with one item pointing to a
> restricted DMA buffer.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: PCI: mediatek-gen3: Allow memory-region for restricted DMA buffer
      commit: 7e38b7b0e0e582024e97289a3b63c201f226124d

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


