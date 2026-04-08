Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E643BC66C;
	Wed,  8 Apr 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653152; cv=none; b=GxB+NNRJdcUzDJpfbVm4DlnKQBRbJ6x2iGF+QSh97Q2tMH0CXlp28+H2tY3ZzXJ2/RmlsuDEdnulnA1wZoaeMaw0HlQGcmAM/PmkxMxXf+YiJuVB5Nw7aduohuSb/4BkKW2sVm8WgsI83QksJVxz1dEOeRn39qXvGvRbaVGiDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653152; c=relaxed/simple;
	bh=OlbGJrGFwrI24/GJug24fjlXDRLvgepuqrfrL5/BaOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcS8h34vQiyyUg+7/GgszuATKbnh9J0vH2bA6mIg8oCdKE8sCz3UpiQLkZMnP1KlBZWL3XddK4mj8+R72lq184w4J9k1+ApJBLczzumeJytI7ZepRQhcl91SQ2qczl5AUxcxLS9cZHRp1G7KRqiwOQjhD/J98Vkq+kn+h5cRM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=o0tmtt43; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="o0tmtt43"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E27B91ED994;
	Wed,  8 Apr 2026 14:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1775653141; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eh2Ut171wqmOONOps9l0PZ9TIR9l30BuTl8yI4h9mus=;
	b=o0tmtt43vL9xqdVsg1urR/4VzYAuHc1fUgU/VJm410m6/gCRT/WDV44NhtCuZKyFmgj7LM
	r137un5/F3ZTCsLF0JjLzau92j7RqN+4Zvmf1arTW4jTnSteX2YwSigaITaV6pboxUE7Uk
	9JKxWVIzdkb34nD0lkWZyTCyswJbqrUQJr25VfGvwdexO58xUyTwtpLW5g8IkZfd/8NhvU
	QZ+Pl+d+z7OrV2Rtdb3G6BHBVZ1uT06dkGImxiE13U9Q+dJVUmP5DmaEvoK6iF2zLDhbND
	ZigUHx7vKo9ZbcYMKmjhAfMBzu/cnOAZkRjHV93vVOYF2RtdUkD1IcpDTZOP0w==
Message-ID: <468d439b-9a83-484b-8ada-fabef2d6c8da@cjdns.fr>
Date: Wed, 8 Apr 2026 14:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 8/8] mips: dts: Add PCIe to EcoNet EN751221
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, naseefkm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
 vkoul@kernel.org, neil.armstrong@linaro.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 nbd@nbd.name, ansuelsmth@gmail.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260309131818.74467-1-cjd@cjdns.fr>
 <20260309131818.74467-9-cjd@cjdns.fr> <adOo9xZxXT3FkufM@alpha.franken.de>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <adOo9xZxXT3FkufM@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 06/04/2026 14:37, Thomas Bogendoerfer wrote:
> On Mon, Mar 09, 2026 at 01:18:18PM +0000, Caleb James DeLisle wrote:
>> Add PCIe based on EN7528 PCIe driver, also add two MT76 wifi devices
>> to SmartFiber XP8421-B.
>>
>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>> ---
>>   arch/mips/boot/dts/econet/en751221.dtsi       | 114 ++++++++++++++++++
>>   .../econet/en751221_smartfiber_xp8421-b.dts   |  21 ++++
>>   arch/mips/econet/Kconfig                      |   2 +
>>   3 files changed, 137 insertions(+)
>>
> applied to mips-next

Thank you very much.

Caleb

>
> Thomas.
>
