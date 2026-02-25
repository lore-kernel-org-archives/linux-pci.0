Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444A3B8D51;
	Wed, 25 Feb 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025184; cv=none; b=emiYW85MquFqnE1xLATnhpmW/qzMMNSc2BKanDiIaRN/MJYJ31NQH0G3rl/FuByUlXUUmp3ligahzzF7fTaEkXQm6lmJKEY5eWkg/ZX18jEDycFTiLu1SxqlKU30QMyVKfmXFQqj8IUCsqvQBPlDGpcVFIw4r7PD8hSjgxyVegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025184; c=relaxed/simple;
	bh=/0xaQZyWpI4s5bVwNLU2o3Pf+ovfZdLHiQEKO2fUD+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ly5ndaN7fzy7cyrY6rGEOjQtqH3vF3EssywS4aGOvkXeEwG2gF+fVETUhO9tGsWGx6VYJkTfyPzvI/SxbAPQiQkINRJdubpl+w1dYMVtUn2LFUUIJJTTZyf+J5+IOTxgn/oBUDRTCm4sU/f5EKAk7afQUobVZv3Rhx6R6eb2Qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CtB7luOe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CtB7luOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772025181;
	bh=/0xaQZyWpI4s5bVwNLU2o3Pf+ovfZdLHiQEKO2fUD+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CtB7luOegegOwzmuv0XXOtfg3KHaGanVCDQLIiXCW7k+avQn1VNLPIpWtKhcKEU6k
	 oru3I/07fm0bwX4VZ4lxrrkcliCrClJN8iJV0h70fBKdPjpHVdXX2EdiveE4NRiISi
	 jpCvpjyKdyy8/7822HEBA/mcAPJo2lMvSEvSTu0U5oVdWE0jrVYfExOvYnAY/2YnuE
	 iedKeHoBhldBBGcQQGOk9zjgbWEu1UkfE2YyE1NLYZWOq0EX31+8aTulmDRabekCmN
	 s/1BjzwJ7ahEKpujGXJVvxsx+XLV1SC4COv34t91z8i94FxUHrXcoUZqUIbGzrtRrL
	 f0XGPaVGa0yPw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E6AAD17E0D70;
	Wed, 25 Feb 2026 14:13:00 +0100 (CET)
Message-ID: <c79f2d6e-42ac-4df6-a3bf-3a596d43fd19@collabora.com>
Date: Wed, 25 Feb 2026 14:13:00 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260225072225.3345307-1-wenst@chromium.org>
 <20260225072225.3345307-6-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260225072225.3345307-6-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/26 08:22, Chen-Yu Tsai ha scritto:
> With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> now have a way to describe and power up WiFi/BT adapters connected
> through a PCIe or M.2 slot, or exploded onto the mainboard itself.
> 
> Integrate the PCI pwrctrl API into the PCIe driver, so that power is
> properly enabled before PCIe link training is done, allowing the
> card to successfully be detected.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


