Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3336A030
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808431; cv=none; b=pe87rfI87r3luRKOWbAjjYDtmBgTH8JUkVfnN9dkyPqOX+23UAR+OgpdNogjVUWCZCAoIDjr/wmMT2z+T/NHtu4Ax01uEs5wf1uo7OZLHxNHn/JoTw6HzDKENijroiknHrOPkTucsV5pAiaqdS9r9+mWDRYPjbbJihpI48KpEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808431; c=relaxed/simple;
	bh=jds/KUEnMypQxF/dsmHVwU7tav2q16u3klT9lSJO4Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Okmoi3DovR9CItHwpwOCWu3YvTDJtzoPd4LmU8PZbMGBJ+tmJIwUPeFMay4Mc1H+grVgAA07NSORKWdeykm/lk3YMDys7NLiHfbinLW42VNvr4dZ1NClvkAHq1EIql4GgaessR4SqyS8K3rl/Aw49xnAv9K4IGSQMJJcrXe9bkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKn5CzOw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKn5CzOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9D4C2BCB3;
	Fri, 15 May 2026 01:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808431;
	bh=jds/KUEnMypQxF/dsmHVwU7tav2q16u3klT9lSJO4Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKn5CzOw33zLhbULxmodZj4uSBxZUoymOm3B0RWi06fo/Tj2RARVGhm2M6dBAApiH
	 hZdpobN+XsohyfcO+zcpdWbhWFuz+9THuBp/UQBrRu5mAHgEFO/nDgHtth+FviXQem
	 /K4dEkKuze88YD2gaGUbeg7IO9LX6wXwlPwCBdpv1unf/Vvd3zNC9AwuirSn1ocquu
	 LPtaOWT8gpJtSbqvCL/0WpfaECf1gYilANfyrwqjI1psxqkVZxVBgU0Xr/WW5ke+JY
	 OFrjwxtt27geZM/MJWdFqpITcKcRyFl7HDV6OxZY+YyfPMsF26p1GhijOUUowI4pYB
	 AURsy24vtCkRw==
Date: Fri, 15 May 2026 10:27:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek: Fix operator precedence in
 PCIE_FTS_NUM_L0 macro
Message-ID: <20260515012505.GA3166828@rocinante>
References: <20260515005552.2343-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515005552.2343-1-lirongqing@baidu.com>

Hello,

> The original PCIE_FTS_NUM_L0(x) macro was buggy due to improper operator
> precedence, where ((x) & 0xff << 8) was evaluated as ((x) & 0xff00).
> 
> Instead of just fixing the parentheses, use the standard FIELD_PREP()
> macro. This makes the code more robust by automatically handling masks
> and shifts, while also adding compile-time type and range checking to
> ensure the value fits within PCIE_FTS_NUM_MASK.
> 
> Fixes: 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 7572252..00f0e29 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -61,7 +61,7 @@
>  /* MediaTek specific configuration registers */
>  #define PCIE_FTS_NUM		0x70c
>  #define PCIE_FTS_NUM_MASK	GENMASK(15, 8)
> -#define PCIE_FTS_NUM_L0(x)	((x) & 0xff << 8)
> +#define PCIE_FTS_NUM_L0(x)	FIELD_PREP(PCIE_FTS_NUM_MASK, x)

Aww.  Nice catch!  Thank you for fixing this!

Happy to offer:

  Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

All the best,

	Krzysztof
