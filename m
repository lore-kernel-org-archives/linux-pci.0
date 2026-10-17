Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB03C8C68;
	Sat, 17 Oct 2026 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258419; cv=none; b=kApj3tGYL7Kyh9qyrF6G0jHS/BDKAIX13/JoqI8YEkjj0kbHFdGEPLQIUxErheRuRr3BuFLHwoG7H0H4LOfWfO5t8rqryANMNSFQZlGGLrWtMXKzgtIO6g4LeU9MgBVAkX040IVb8DNUY/SyZqau2DWkd/NcHXn/d4uUAT1TtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258419; c=relaxed/simple;
	bh=T/h6CY1fUsJnpk75d7YEDaeATteZ18FX499uU03II1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W//TPHKkgooECeU7+PA99zm/lF8VV7VKHD8qkkFwNlJWCp3tQ2QFvcrzNIqNFzdSZs8cBl0rVe6S3yvlxvgYrn0kF2rrc2swDKoFwC68xew/m6J7Tu7Ds9ym/TNxxbL9TlmCrya9daiVjpMktGY6RCS29iBe/kdFyDBNfslfdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZT5sFYcU; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZT5sFYcU"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6TRx5GN8zKnjj;
	Sat, 17 Oct 2026 19:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wN7yaUxayKg6i+92YqS4bvwXXLse4slYUwkICAgqFyM=;
	b=ZT5sFYcUofFI1ZiF+zdI0tqExtOVQ2iEL9SAVcHX1px2t+gA4S+eCCIdOB9WJ3bm5AEKl9
	Q/2SHk98uA7z8W3mG2oZL+H62y9vOsDrzYa5U8OyqsqhcwJIGOeEAjHEy2tJTFEQCFW2dK
	+lH7Q3v0m+P+uwD9ofXPS6AGUeWo9zPEOLVoHGn8XT/nBCMPm1LIO5P+JcAVTgb+iTUeON
	myREBAbgr1dQXVF216eFB0dXjZN6WOT7LW4csZSqIXSTaAKZ0YhVa4EnBJRvJpBADJ3JdO
	lBNkDU9PGtB7Vsx8uId7drbyr3K7CVFCzAYrnqS2SbDMnz2YPdivc/IFBRa/Dg==
Message-ID: <001f4975-46db-4a2e-a187-bde76bb4a0aa@mailbox.org>
Date: Sat, 17 Oct 2026 15:24:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] arm64: dts: renesas: r8a779g0: Describe the PCIe
 AER interrupts
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-18-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261015033103.3076869-18-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 579987f2eb200ed68e0
X-MBO-RS-META: 4hh5r611bg8ope6xryyqbduy31ido5zf

On 10/15/26 5:31 AM, Koichiro Den wrote:
> The PCIe controllers report Root Port AER notifications through SPI 454
> and SPI 461, respectively, separately from the integrated MSI receiver
> interrupts. Describe these interrupts with the "aer" name so the
> controller driver can use them for Root Port error reporting.
> 
> Append the new interrupts to preserve the existing interrupt indices.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
