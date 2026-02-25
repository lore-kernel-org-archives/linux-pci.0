Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F103B8D69;
	Wed, 25 Feb 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025192; cv=none; b=CynsSqLjEieBEW9MYLH0bRZpO0MFvD/6G7Cjm6bJ/G0M2TgeahuWXnT9wQEcLgJmvMPoITEKLrSKHAbagSd8EVZqK5RQJELZZ4C2O6e3QPqPxcTyz+SLA26h/3gLzJSllVMxvKVTfAcPQlPGL4vD395q9zwlvNCDWJ+uGO2wL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025192; c=relaxed/simple;
	bh=FgRCrpuX9seBlaU1PRhdPC/qxo2FBhcMug3D6AadulA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHSV7bCAjsKA4FESiz8KvV2fQPoIqoAt9kv8gKiqnVb2xDfa7IWVYpcv6RnAbkxGNHw43KkY0kMsEdLQvW26uhB5vyvDx4f8qblT7kDLIyDxZztxWJoL9Gal2uMuudCG4HhnQxwRs2ectAq8l49gc4ctnbPDkyt4DL3/C5bHIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JRn23u/l; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JRn23u/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772025185;
	bh=FgRCrpuX9seBlaU1PRhdPC/qxo2FBhcMug3D6AadulA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JRn23u/l2T3tKj9C2Fr4FErYoYMWhOpx5JPV7WuEopb1h+sB5pJCemXN3/XD5cmfF
	 e6I+g1IVb+ZoVrdMp2HcquuFcrsWeIhMC+tBUhoMhc0xBL43lXnXPSQJ8OHl3KF0Oy
	 pk5va31bzFHI8tmNpVFz7Cu5CPBIEtWIiOFoSgZefBFXMVXJu5uLXlkeSFibc1tYtf
	 h/0GsCR+KWQu9MJrP1okzqyRAq7iPJlJyiz09yjC2FoACoDyFzAFe4VjZBLtl2PG7m
	 fDzhWzlo4MvCGedcrzWJGitzVMkLwypJhl4yLEuzcIYtV10/dtcekwPIPoDfRgfOhX
	 esfbnvhHQH9mA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E327C17E0D98;
	Wed, 25 Feb 2026 14:13:04 +0100 (CET)
Message-ID: <e0204fbb-4d82-44ec-a381-c030098ef86a@collabora.com>
Date: Wed, 25 Feb 2026 14:13:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] PCI: mediatek-gen3: Add error path for probe and
 resume driver callbacks
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
 <20260225072225.3345307-3-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260225072225.3345307-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/26 08:22, Chen-Yu Tsai ha scritto:
> The probe and resume callbacks currently do teardown in the conditional
> block directly. This is going to get ugly when the pwrctrl calls are
> added.
> 
> Move the teardown to proper error cleanup paths.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Though I don't exactly like it that much, you have a "more than just good" reason,
and that's enough for me to say

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

