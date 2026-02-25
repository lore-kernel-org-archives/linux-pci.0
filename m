Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838403B8BDC;
	Wed, 25 Feb 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025192; cv=none; b=iF3ZSCKlNUW6jMQfUykrs3fOc8jvgtI4i09rNEJ0ks3TruJZHhJMjNv5zho8V62UlSRn3B/efO0Uyxl7drmO5lP1xsjs+VAUZS5PleUSEkAxmZAd+/++4k0CP9ZC9w36aAxUVB5mj8zIvHa4RrQK4AFQLuDOwEzdip+5zFapjns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025192; c=relaxed/simple;
	bh=9nwd6J7vPnLix9sIrT5JA6n5SKgLQzROMtQ/2zyqkUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQ7SpNmiDNoloterv8oh+ouXRu3B3EZoQuK06cGPENDFZR5DEazXx6+qP/4vQJ4ua7QSM9NQ5m1VSZZ4DYg5joeVAD0FT2Z3i6NOnW9yCmk8urKfUfkJofN1pG0Xx1dJVd95dIa2jqqnKIFc0jQWHqUaa7nevfy4QTacKLH33zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=im/XYZ3U; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="im/XYZ3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772025184;
	bh=9nwd6J7vPnLix9sIrT5JA6n5SKgLQzROMtQ/2zyqkUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=im/XYZ3U7IBhKG3hMNpSZWXbSP/UCDRog0YG9LEu7mEp1bG+o+4sWRgyAuLVyCqcI
	 CT+ZeiXosUlmLTmSYDOF8SgWapuK75nNR30kxOX5vO12K7jwqKhguRAY43oV7rcGeK
	 cq7mc4QU50wRSpWWx49+OeavS5BvZnpT2C67V48sD1ngD6dUdEJteEpdx35KNxhx7V
	 vOweyG4ifkrlwyCGW57RvyZ0RP4O5C7wJ34ShQ5Ff4O69TZMczxVZEFy5lyLjkj967
	 +okSWbtLufruEAsiytKqUcsK61lQv51b918iVvytlxippO+oNLxc+ys3/UbDx7L1+u
	 7XLGx1wl0eWAQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6A3E117E0D91;
	Wed, 25 Feb 2026 14:13:03 +0100 (CET)
Message-ID: <d028150f-0202-4816-a8d1-dfd35eb75fa2@collabora.com>
Date: Wed, 25 Feb 2026 14:13:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] PCI: mediatek-gen3: Split out device power helpers
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
 <20260225072225.3345307-4-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260225072225.3345307-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/02/26 08:22, Chen-Yu Tsai ha scritto:
> Split out existing code that deals with device power sequencing into
> into helpers to allow cleaning up the error paths and integrating the
> new PCI pwrctrl API,
> 
> This change is purely code movement.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

I was really about to (and really wrote 80% of it) write a comment saying
that this is not really doing power up, but then I looked at the other
patches before continuing.

Eh, I agree about doing what you're doing in this number of steps, but please
write that spoiler in the commit description here :-)

Something along the lines of...

In preparation for adding full power on/off control with the pwrctrl API, split
out the existing code that only partially deals with device power sequencing into
separate helper functions.

This is purely moving code around, and brings no functional changes.

After which:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


