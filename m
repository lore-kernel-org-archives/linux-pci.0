Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4A547047;
	Mon,  5 Oct 2026 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180000; cv=none; b=GqGP0CIIpWvSk4TTBtvaHrsC2SMYdFZm3upAXWyzm221HwBCmXLmYNZymbuTc2wyUTo952opdmpj9V7QaM6NDVpPZveIhfgIF9xsKN0akClFODKhZMyUvB61nJGGRBkDnuFd7JEFmyQxFTnzhJ+pGznPYk00TSw6k79C5hep88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180000; c=relaxed/simple;
	bh=aLItZcP/H5RkTQJ8n3LRci/NNeMojm8BixxlFLZtxLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPHHYygkbFwYUzayO4LF5J97p8Ib+uL5ktHeCroRQhoMf9qO+E9mnLEgVCBUfAgpT/YGjPqY4Lf2p4KKiiMgF4EKXxUjPSOHHkOLtUsEQRIHi1eRmFQuRb3Mv03ZGhpK6oDhsKSmGrz0USXVxHq3BOkJxpw2zyrtTDrtT5fghC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bDP4oqrO; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=igkD8Dwq; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bDP4oqrO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="igkD8Dwq"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hypd16D3FzMlFx;
	Mon, 05 Oct 2026 07:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791179989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYn/txQTt5JlfdIUpIoIQbi2SYnYhnBxGZBwbOOJ3A8=;
	b=bDP4oqrO+qbc5dxsqxH43WHVmHBn5kTmFU5BtZgI5mabTpJEmNzw2KjEXJ3tMFGG5a1HYh
	Mjxd8yRJoqNZ2SECG3Mkn39p7RMHG0jmNRrZact9h8iRG6+mG6IAUv1Lmwg5TBqQAOdIY5
	vN2CSRUqQB7327ZGYHtydN0vUjk7s7d+EKzNcRl70AYW4M/SNQEsp18+5PQAb+tUTEXKIj
	VdgSbJelvrJ1Rh6K9P+PFt+v/xH6SmsxWH/Xgr40vJR5NwFDlJ5FsvzCQ2wYPYS3kIaTun
	/ZswjFxOQdcbH9UQCF+VnQNjk0Vy96UXORq4utEPeZmrXVokUYeqIhtVe0EkMQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=igkD8Dwq;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <5ad29672-c9c6-4bc8-ba41-cf96528cd9c1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791179988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYn/txQTt5JlfdIUpIoIQbi2SYnYhnBxGZBwbOOJ3A8=;
	b=igkD8DwqoPp8x18Hsevt6m6YlQi9Jj501tcuU86iKghx8mpZfU4WcDZYy6nj0swCm0VoG8
	4ztuikVL5lGGISWfMACANNlIjPxT5ThX+k6Lr1145WJ/0TGe1ulem9Z/vd7GfXlluXIvh/
	Vy5cCascM29appNFrudY6TQp219bbGDA1n5MXzg1Oki8eZSdJtmjKYRFQ/a04htH4ZQwV0
	9DMdwYIS/DsLDPxlo3wwxXYMdI/pIPpDC65K8psTVpKBkdL2R5DtiuPG+7Ks83evTjj5NC
	cmSirz+mBXcC21pLG4K0d0lJelbzK9MizXcs7uiFl6U8ANV3iae0PdMsXEIPiw==
Date: Mon, 5 Oct 2026 07:59:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] PCI: rcar-gen4: Check live link status in
 link_up()
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-3-den@valinux.co.jp>
 <d675e0ba-10f3-4503-bc2e-61977f4a5875@mailbox.org>
 <c038dbd9-7675-43a9-834c-915b6795dd50@mailbox.org>
 <abcodlpsh2k2cood5czno5fqb32uxdrrzy7lwougxhil7zlqbj@b7a7v3kouwxn>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <abcodlpsh2k2cood5czno5fqb32uxdrrzy7lwougxhil7zlqbj@b7a7v3kouwxn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 05438c2c60fc43063f0
X-MBO-RS-META: oz56gi4f1mnfg6g33unuyomhtsd3oxhi
X-Rspamd-Queue-Id: 4hypd16D3FzMlFx

On 10/5/26 6:22 AM, Koichiro Den wrote:

Hello Den-san,

>>> I apologize for the late reply.
>>>
>>> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H
> 
> Thanks for the review and for testing on V4H.
> 
>>>
>>> Since next 20261002 now contains commit
>>>
>>> f29719b5064c ("PCI: dwc: Align register macros with Synopsys
>>> documentation")
>>>
>>> This will need the following slight adjustment:
>>>
>>> "s@PCIE_PORT_DEBUG@PORT_LINK_DEBUG@g"
>>>
>>> "
>>> -       val = dw_pcie_readl_dbi(dw, PCIE_PORT_DEBUG1);
>>> -       return (val & PCIE_PORT_DEBUG1_LINK_UP) &&
>>> -              !(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING);
>>> +       val = dw_pcie_readl_dbi(dw, PORT_LINK_DEBUG1);
>>> +       return (val & PORT_LINK_DEBUG1_LINK_UP) &&
>>> +              !(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING);
>>> "
> 
> Thanks for the heads-up. v3 will be rebased onto the latest -next and use the
> new names.
> 
>>
>> A small nitpick, would the following change make sense to reduce duplication
>> a bit ?
> 
> Yes. In v3 I'm planning to add it as a separate patch right before this one,
> with your Suggested-by.
Thank you !
