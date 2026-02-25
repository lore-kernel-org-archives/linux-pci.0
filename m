Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E293B8BDA;
	Wed, 25 Feb 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025193; cv=none; b=QgVXdD14cVCheWCnocn9GfcQTDzm/EfygoF1Dqu5Pymq1MM4IRbDw0Yflu6EgxS+Y97guEFVXXqudtXKRd4KiOIpOVWenWjKnSLJZC3MZWtqU7D2MljJUDhQlV+9mHAXrc1ntvBVEt+f0za7d3WuG4gj5jeFW3WyD8Vp9lOKBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025193; c=relaxed/simple;
	bh=n4DHsYxUKbgES8MiHsACk0FhFdNJP+CaJdwmJWhWYi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qc9svy31l/yn1UkbTNtN7LWXdDdLjZipqK3EYz75i0D2jpEvKaKmvXJ03Te8Pu8aCqzUAu0ZfNpQadO6x4Y2dytK6k6N7mPQwRYVCMzTWBNucD1Tt7OS9vGkfvJeASDmIvJelURWpM19Un7xgeQCI+22CKDRPuDLfbo1SowQ7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Onu5z4Wq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Onu5z4Wq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772025186;
	bh=n4DHsYxUKbgES8MiHsACk0FhFdNJP+CaJdwmJWhWYi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Onu5z4WqnR/45diDIi/k8XZqdvJ6b9N6+Qvzu6F5eIir/6l0ngkpAjraPNJMwpR4x
	 yQgO0HEtqvSJ3tP0m04aw1j8GeIHl+4GYESGhyxQjNHVK95gK+QQdF1CJKyX+e5buw
	 xHblyUWmbpzwk5w2lNKkcCQJdQG+RxWQjNE/chLCUzCFUvsdm9/qe8YeKbxjUgNz3t
	 CYu3bwCG6VtIvQpq/t1QxE1H1ubJkLRm4GXKlWncpUFjq/V5RqHzVHO++Jti5YRHwG
	 kWoDlvpHU/JBeDX3/W+Kd7f1EvdWR4kJNTRe1BUdX8LGTUi3GDHpnU5Yw/4DO3xOwB
	 XquDH7uzzIbHQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A59C17E012E;
	Wed, 25 Feb 2026 14:13:06 +0100 (CET)
Message-ID: <ff0fd6d6-c7b7-420e-96bd-75f844188cf5@collabora.com>
Date: Wed, 25 Feb 2026 14:13:06 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] PCI: mediatek-gen3: Clean up mtk_pcie_parse_port()
 with dev_err_probe()
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
 <20260225072225.3345307-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260225072225.3345307-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/26 08:22, Chen-Yu Tsai ha scritto:
> mtk_pcie_parse_port() in the pcie-mediatek-gen driver has a bunch of
> 
>      if (err) {
>      	dev_err(dev, "error message\n");
> 	return err; # or goto
>      }
> 
> patterns.
> 
> Simplify these with dev_err_probe(). The system also gains proper
> deferred probe messages that can be seen in
> 
>      /sys/kernel/debug/devices_deferred
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Ah, finally - thanks for this cleanup, love it.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


