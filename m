Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64D3BED1D
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232982; cv=none; b=O7JRXoCxJGBpHe5Wkv1vkk15ibA0PAN3GL3WB/IFdyVmvh5FMJP782Rqg08TUlMLKONqpwF57tnHq8NihIq9diUSvf6ZF90QD1PPpQciobrMercl08zssoYpkDLH/SZh8zm6pTcjvSXveKKw4/6rr+7K51wqt2plGr6ec3n6WqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232982; c=relaxed/simple;
	bh=JXggeYALTTm5M0m1GtSM1W7T9HmxqrPau5EiOOTN6dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiaSE54JKTwrEtmPdjrsXAkCzRhTDHCSjYtwEKzaLvLuJHJzATSnxNoNC2xUiJfVB0cuiY7336xy1cxALzrBkw28amirR2ELhwZFvjNsVasyWUqn//h/0id43aUG8KxmrSvJOHpNA/LTfALL+8otc6uA5GxEjBNkhAq+RJN06zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=EMvjIwAd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="EMvjIwAd"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852ff06541so43602345e9.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773232980; x=1773837780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6uTPu6jx/7Zp79/JjhqiXhSWgQs0Zw/703LQEYWFA6Q=;
        b=EMvjIwAdA8EovVvdldIRxTxmae62MrxD9rZZ0oWaR/agV5aIQ/Dj7rUanl6cAQkQ9x
         wHMC/SbGZxuKQwhVahNbBjzSQwx16cxwybxlZofHdRn8xeGHq/rlyZbmi+WxoNwdVgkN
         u3OaSh1rlCoFLjKijvKGTdvLt10ei9HAbxxjUjx5VOBtfEgixKh3/f6dsq7c5I8I9o89
         qiFTbf0F6tt9df4yw+QX8g+6Xqg8RkcHfBQ1Xp8G44ztUKLfuC8mxmk5syvPVEU5DOaa
         0o3ecABm2OHtBT/DLvL7AxsUeqVtQqwDIjlS83aNL02+NtDMFYxVTByolrLcGqN82c5X
         ZOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232980; x=1773837780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uTPu6jx/7Zp79/JjhqiXhSWgQs0Zw/703LQEYWFA6Q=;
        b=htp/48JISRcvjN1SQzNfUmRpwHuls/h1T7w25flMZSqv+exlel81Z0ehEZqrSJubfB
         yxaNPf7tAG9rXolY4HfJ7iK19gbOgBjr/KUuaNFaUg/iMtPEo0No2Qchl/xiszRLq0ad
         Qj9s+fpkgsWJyLR7w0pQUUJONRhek+WTL8VAV/vp9b9Hwx6ueTOF43PA3+l5CEHLuOYS
         o29KuZnwVgeejCvw5JDjgUKXtXS2cCf7/HG0yld5OXHEu9yzygHLRM6fl/8WwSlzUxdY
         g+seqKzwf8SCqdPHQKM4hLOSGaJQ+P+9KeoQhhrH0EyxLRmKtAgmAxR0x95Ar+y5fvjI
         XjYA==
X-Forwarded-Encrypted: i=1; AJvYcCXHYM+VuvloQOLrikuUB9gN5sBvRJV/foZg2uabihnFQ9vn2KIsH0xg6HhTf08uwmdxg6HrRqghviA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlbHuyDSK3Vra78tIFxmQouLp+iSBIx+ZzenjSwiCNtAIC8aA
	CjAQ5L3pIwz8jTGZhAvVXBTjSLa8bLiZyKn0xPJXLBay7dGMs1MTcN2fQuxpRLhRYrM=
X-Gm-Gg: ATEYQzxG5lV5eBM9HcEQ0ySM1acSsT0jDPIAiWWSCExhrg3OJYDrFaJJmr5r0ef69Lr
	3ysSOfURlRHklTtkxrSDC7HJ//x1Dc6fYYk8RFrhXAN9rqMAusG+EkGenaYPpeh2NmQlYUgSxzA
	nsY8H6zmEldllDgUI/44wqr6Trd+QvqWVH8BHuSeOU+2WaJjfLwi1iKa3N0Qo1KuDkNz90FwG3y
	Xncb0EMP/G9aJY/hNNMORZFioNqtN/ezgDa1fJNM33yyaRyfMG2R38dAoqRHJlOidGbI6PSVbrx
	7KqBNWI9gguUH76yYDqVYt3QhvQTrtrgdgExyaOJSP0seObRX/JcH4gLiN4AoBI/DW4rgtr+Cmw
	xySAoO9W+g+cfsfxQitZBF1oG6hE4cCJlDUzbfo3+68o5AFQoEeeObpmnzIHE2VXTkZCeFlfZtA
	fXaXITcUmkkXKq77LVNV6y0SkZ8LQUF1EQ9nJK2pRrGA==
X-Received: by 2002:a05:600c:46d2:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-4854b10c835mr37437555e9.23.1773232979907;
        Wed, 11 Mar 2026 05:42:59 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm157299345e9.4.2026.03.11.05.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 05:42:59 -0700 (PDT)
Message-ID: <a425e707-a9ff-4a32-bf64-8dc3b5a07fac@tuxon.dev>
Date: Wed, 11 Mar 2026 14:42:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/15] PCI: renesas: Add RZ/G3E PCIe controller support
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260306143423.19562-1-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260306143423.19562-1-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/26 16:34, John Madieu wrote:
> The Renesas RZ/G3E SoC features a PCIe controller that shares similarities with
> the existing RZ/G3S PCIe controller, but with several key differences.
> This series adds support for the RZ/G3E PCIe controller by extending the existing
> RZ/G3S driver and device tree bindings.
> 
> Key differences between RZ/G3E and RZ/G3S PCIe controllers:
> 
> Link Speed Support:
>   - RZ/G3E: Supports PCIe Gen3 (8.0 GT/s) alongside Gen2 (5.0 GT/s)
>   - RZ/G3S: Supports PCIe Gen2 (5.0 GT/s) only
> 
> Reset Control:
>   - RZ/G3E: Uses register-based reset control mechanism
>   - RZ/G3S: Uses exclusively external reset control signals
> 
> Inbound Window Configuration:
>   - RZ/G3E: Requires precise power-of-2 window coverage with strict address
>     alignment constraints. Non-power-of-2 memory regions must be split into
>     multiple windows to avoid over-mapping, ensuring proper hardware address
>     decoding for DMA operations.
>   - RZ/G3S: Uses a simpler approach that rounds up to the next power-of-2,
>     creating single larger windows. The hardware tolerates over-mapped regions.
> 
> Class/Revision IDs:
>   - RZ/G3E: Requires explicit setting of class/revision values
>   - RZ/G3S: Has default values in hardware
> 
> Clock Naming:
>   - RZ/G3E: Uses "clkpmu" clock for power management
>   - RZ/G3S: Uses "clkl1pm" PM control clock while CLKREQ_B is deasserting
> 
> Phy Settings:
>   - RZ/G3E: Does not need PHY settings as it works with default hw values
>   - RZ/G3S: Requires explicit PHY settings
> 
> This series extends the existing driver to detect the SoC type from the device
> tree compatible string and configure the controller appropriately. The updates
> are minimal and focused on the hardware-specific differences while keeping the
> common code paths unified.
> 
> Changes:
> 
> v8:
>   - Collected additional Rb tags on remaining code patches
>   - Fixed typos in patch descriptions
>   - Fixed checkpatch warnings


I've tested this series on Renesas RZ/G3S SMARC Carrier-II board with an NVMe 
device:

root@smarc-rzg3s:/lava-testing# lspci
00:00.0 PCI bridge: Renesas Technology Corp. Device 0033
01:00.0 Non-Volatile memory controller: Transcend Information, Inc. NVMe PCIe 
SSD 110S/112S/120S/MTE300S/MTE400S/MTE652T2 (DRAM-less) (rev 03)
root@smarc-rzg3s:/lava-testing#

All looks good, thus, for all the patches in this series:

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thank you,
Claudiu
