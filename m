Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4593B8BDA;
	Wed, 25 Feb 2026 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025185; cv=none; b=qdGNorimABGvtYHbclCltPPC29YlwY0PiAeBYj/NpPn3hyTw4uHUlG2SCMd+pPCGBPA/FARyDIqHD1c7kGp/x1Vnez7xfxRjr8ucayZAWhQdcyCq2yNnwrjapJVM7Dqi1rfqGCJQi1wYJyH6rEej5p4kcYypWxQ5Oxkf+lpIJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025185; c=relaxed/simple;
	bh=0OYJVrGzHeHo71a4qjaYHaB5i/Wxv/lLqWp9M+WtRQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNInYBX6NRim3zlr23fcuvRtH38SGn9nA7U6S3bnY8c+OFpfT/6PHHdwihqXOzB+JJD2lKqj+nvCzEgB1J6tUHCMO7vkZOwja4YDqoJTkBJiaGgnoMZw0dLGWT1m6kSONgqsu8Ja2JlOAVXYsNluCOpCA1gPrupLMtFSoiwYmkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R0B2OzV4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R0B2OzV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772025182;
	bh=0OYJVrGzHeHo71a4qjaYHaB5i/Wxv/lLqWp9M+WtRQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R0B2OzV4iRgrFJQjaLeW5PqN6rUJwdVlMdClTqJAsv6M/rxxo0azL9WyzH93S9Is0
	 NKvkhvKlnRsItAQUfsir2NCy2hpOApMWL4oUT8aGxq0OQATkusUUYKgale9jafnHJM
	 4JqRr/FWoyL9D01gR9nNiU5zPvav/HrCEZVfsUQie4AdWNDW90Yz7N4sIJnf+mw1ta
	 OCnas86JWDlIv4+oVv5nVfXn7BFjPuKVELcFEFZQqxtDwjl3qFp525lutQ7Kz9ndpx
	 EPIA0Eaolzl3f6bge3euMAuayNJTE76tpK6Fhqwo8XDTa5LWNsl1ncwFylC6qT+BUv
	 QhGEw1ii3tSbw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D136917E0D8E;
	Wed, 25 Feb 2026 14:13:01 +0100 (CET)
Message-ID: <ce5899b6-1b88-4212-9e61-edd80c5b8c3a@collabora.com>
Date: Wed, 25 Feb 2026 14:13:01 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] PCI: mediatek-gen3: Disable device if further setup
 fails
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
 <20260225072225.3345307-5-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260225072225.3345307-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/26 08:22, Chen-Yu Tsai ha scritto:
> If further setup fails after the device is powered on and link training
> succeeds, we want to place the device back in a quiescence state to
> avoid unintended activity and save power. This also helps with power
> state tracking and balancing once pwrctrl API is integrated.
> 
> Power down the device in the error paths of mtk_pcie_startup_port() and
> mtk_pcie_setup().
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

