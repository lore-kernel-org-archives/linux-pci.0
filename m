Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40A26B764;
	Wed, 25 Feb 2026 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025180; cv=none; b=n6C5x0JWdnmwTQplpW8Tg8NXh7tLGf3sUYFf/hYp6rz7wIHFmKFTQEQSn9/WKJiJ4hZjWaKfjTFTpIQNZ+UU7StVYS3pAr9x4fD8CydZlc3nZyGbIrHnU8VpfP7ApXYKQnM5Vskv9HSxhYhIDIW9PmoD5fUJGxDN8YCzTDXYImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025180; c=relaxed/simple;
	bh=FURIk3aseyFyJaGwGgDxMAOqs3YY9zpxQ3vrYQIHYfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbziHjuNNbCNBIyLwiraRyoWhcG0ldHJS0aeWn3uUoZgA0Ts3bix+pd/lnd/IqbaIjrcOId0+xf3w/Zh8W3HnrrbRWb3J1KIgE0A3GEpUOXx/pkqTj65Ve1u5ayOd1WKS83Uh25F9ntTofk/F9XgV3cfofQNWOldSAkeOrwB1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q+5NqmAz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q+5NqmAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772025177;
	bh=FURIk3aseyFyJaGwGgDxMAOqs3YY9zpxQ3vrYQIHYfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q+5NqmAzQvHozXqGBeH2ASIE1F3xAaw3gdqCz1RJhbupNkkwp40gvupKietBnfXRU
	 w48T3D4ONbdLJgYi/A3IK/7pDAuOGM4Yug8bNLXvKGs5g4nvakB8DbtIwdRZ1t16hS
	 +k2eROhY+liO7mEIpqorYnGnsXTaTz/6mQ6GH/HxJrfgxXZZVvuPm+JNcsJh3YoFqC
	 I/MRz8ZXRzd66Q+sMfNgGbNqiVWg8XANSZJV7cSSYOY5fQt0+GwH2ZDe2xyyEBtpng
	 O+h9by7O2nOUAlC42TCHaGBLCLNZ+B3N3Oztg7burf9GRfBKpl/zHEzIX45N35XfHI
	 6wlLx5tg8feDQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC61817E0959;
	Wed, 25 Feb 2026 14:12:56 +0100 (CET)
Message-ID: <353afba5-9ee1-4359-b91c-115f51bcf675@collabora.com>
Date: Wed, 25 Feb 2026 14:12:56 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: mediatek: mt8195-cherry-dojo: Describe
 M.2 M-key NVMe slot
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
 <20260225072225.3345307-8-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260225072225.3345307-8-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/26 08:22, Chen-Yu Tsai ha scritto:
> The Dojo device has a M.2 M-key slot for an included NVMe on some
> models.
> 
> Add a proper device tree description based on the new M.2 M-key binding.
> Power for the slot is controlled by the embedded controller. As far as
> the main SoC is concerned, it is always on.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

The M.2 connector description that you're adding here is pure awesomeness.
Sunglasses on.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


