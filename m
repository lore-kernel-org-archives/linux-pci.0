Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571398;
	b=uAkE1mH8dEC9rA9N1RmuIe2FzxJozA2DpTSBBzgqfNe+icbVINnq8Fe+dTjv4Nxsky/W
	 lAi4f/9BjbNPjor2IH43gtA9LOZ+qhz8WQl36xBC6NGhAmYJtZkMHfrLBZ0Z96ws5PeXD
	 hitaT9Macvic/jXiDTyxNwkJAfw/16FliP7hPeedUwrRqIy6pPHdRlPn+czypyFWxAsAw
	 zdpekaW/8IhlcifUQCprgoBEe7fUvfgML05okQmIhwRzGZGtyuIOZwYMaYMVAtwrjV3/u
	 XbUvBPimX2GTS8p5d2hKz3tVulppjDdfc4uduivGmVyRfgVCaX9PN47wbDCWuC6Wm3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571398;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=jgMNL39llvWo9fpC9p/QMlWjuszkHAxcrG1aLPRLi8g=;
	b=wfIPuix1zr65J1mj/2W+lfiKY+YLAXSDmHPTXcL/ICAaoP3bLmv3BdXOMbFpyWuGu/Xb
	 iYsHR0riojgZ+T6wqf3sHj180dGS7npbhR2b4pC8qClwAkpSwjSeYcOHmd7DxE1ef3/tm
	 J2yuLqEBqq93xsGyt3WjwlHYu0woHe4fkhnW0o8lhZzRgNOYQld3SY36pQkkOhkazLG/i
	 6mMv4I7lOqfRL8Z9um4TM6XjzKnuPA+SjLH66H+Vb03wsBWkzck4p5KIwvFB60UzHh99Q
	 HlwvHRBzl3ahL0H73LaCg7CjTUTayLukrpkbkKq20TigNIhgIBacdJtbC53Tdlii+2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYeaF+lL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2584606ECF1;
	Sun,  1 Nov 2026 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYeaF+lL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495611F00919;
	Sun,  1 Nov 2026 22:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571398;
	bh=jgMNL39llvWo9fpC9p/QMlWjuszkHAxcrG1aLPRLi8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XYeaF+lLG+zcg+MoYoZlG0y/uk5q8MRTTDbq8BkdvkzUFl9Vun1ihD1SxAc2ECy16
	 z4DWocwx1WWi47Oj9QiNtJ6jmhL7zmf5bxeoWHoY4yzM2kZQfolcuIAWxK+jS7cm07
	 fmwAg/Ivw2hGS6A7TJkYkC3exTpBiM5aaokwLR9TjbsfP3pWR5EZZp804p7drBfMd8
	 frNkLhYzNMl5ef+Cj82eXGRsRKL/A4gC1aPR37M48qabULeNXZFgqSenEBQ9QKLwWw
	 Vzz4O5/hem3VSNyc/YuAn2p3V4AP0T1bhoNHZjIEalvXnARs3fwKPBkflkTi+V8isn
	 Z38bORaSKlOQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4020238003B8;
	Sun,  1 Nov 2026 22:16:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/3] PCI prerequisites for PHY consumer/provider split
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357139679.2624073.13873851750746305916.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:36 +0000
References: <20260810124315.433448-1-vladimir.oltean@nxp.com>
In-Reply-To: <20260810124315.433448-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, spacemit@lists.linux.dev,
 linux-tegra@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Bjorn Helgaas <bhelgaas@google.com>:

On Mon, 10 Aug 2026 15:43:12 +0300 you wrote:
> "[PATCH v8 phy-next 00/31] Split Generic PHY consumer and provider API"
> https://lore.kernel.org/linux-phy/20260505100523.1922388-1-vladimir.oltean@nxp.com/
> became unmanageably large for a single patch series and needs to be
> split per subsystem.
> 
> Here are the patches pertaining to PCI extracted out of the larger
> series.
> 
> [...]

Here is the summary with links:
  - [v9,1/3] PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()
    https://git.kernel.org/riscv/c/fe108800a865
  - [v9,2/3] PCI: Add missing headers transitively included by <linux/phy/phy.h>
    https://git.kernel.org/riscv/c/a685daa02d97
  - [v9,3/3] PCI: Remove device links to PHY
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


