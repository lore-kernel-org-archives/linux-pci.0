Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514A39B4A9;
	Thu,  5 Mar 2026 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714593; cv=none; b=USdKbTHp99T2Ou7SgRHlnwnE72ZQ/Sg1ml1Vv2GfcMbUFdga/uBX5g8igRr9bWwj29LZuEGuOq3R3wQWL4n56rRkG0CXvlIKTae5SYKuHysPc/k5JfQFkEHsPcH0AI+ruEC6ybl963lsf0wlbjRGw+dtxVW9x6OdOGBFQTyoPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714593; c=relaxed/simple;
	bh=j2nmEUsed1xGW7mYNjCxskTFeMzmDSGgZTXSXzW87/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pVs9bzwiACewIBkFR5XMW46rO53zJxRYgaQ2CcHV4VNuzl1QsagkHCAL7orw1uh622iwDWcoc57p4OvXtizTfJp7WxL5tP+R2f1id9EZEtHFubYu0nFsC72dS9HotTpFWtwhtedheHNynoCJ943Ho/kwlzMeC8O/ty1XlIUIK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cMlCYiIm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cMlCYiIm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772714589;
	bh=j2nmEUsed1xGW7mYNjCxskTFeMzmDSGgZTXSXzW87/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cMlCYiIm9nkWc0v85Ktic0IMmXr0Pjl6WyCyR2/YcPw1cnMxSUAqpvCGUbLOAmIxL
	 wbPMgYmSSsoCbrsomViW6h7d2210+ZMnKQqiQMqvGenv4EkATTrMsfUcjdhIFu2U4D
	 IYR9wIp2lcRsNWDDuwYO13P3SWk1idXsK+6AILiP3O5yTWFJFsB3/LH45bZ17NZ43V
	 WEfN+5NWAFL44RpoNs+IdjTpGVMBLg+EiEnRw6J6UlxE/VnXqB76Rm0z2m3m7DRtwT
	 m6+uFYxOzykD1JwWAEyTAEP/zwEI/F4bj4rcHG0e2pluHcVLLq3Xss0zBmG2DjXYsL
	 eCRxH8kiH6jXg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB2C917E0071;
	Thu,  5 Mar 2026 13:43:08 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260302053109.1117091-1-wenst@chromium.org>
References: <20260302053109.1117091-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH v3 0/7] PCI: mediatek-gen3: add power control
 support
Message-Id: <177271458883.33613.9898365722639233697.b4-ty@collabora.com>
Date: Thu, 05 Mar 2026 13:43:08 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 02 Mar 2026 13:31:00 +0800, Chen-Yu Tsai wrote:
> This is v3 of my MediaTek PCIe gen3 controller driver power control
> support series.
> 
> Changes since v2:
> - Link to v2: https://lore.kernel.org/all/20260226092234.3859740-1-wenst@chromium.org/
> - Made PCIE_MEDIATEK_GEN3 select PCI_PWRCTRL_SLOT, following existing
>   examples
> 
> [...]

Applied to v7.0-next/dts64, thanks!

[6/7] arm64: dts: mediatek: mt8195-cherry: add WiFi PCIe and BT USB power supplies
      commit: 0c5d91b3d0eeed3925dd43f834afcc19a11aa9fd
[7/7] arm64: dts: mediatek: mt8195-cherry-dojo: Describe M.2 M-key NVMe slot
      commit: 4c434585ce6d485ee12ed6becb1524f933454aba

Cheers,
Angelo


