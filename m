Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F993CA4B9;
	Sat, 17 Oct 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239157; cv=none; b=pR1aIEE3T7TuS5kj6sJym4PEXZTAbhAiasNDuTzAEM6gJh2BJiNZer2NiAv576q0AIEJ1m4yFS+a1TBr7GA/7+AySRbLdWBqwyPC7t38XkYysYTKlT7ivGBaKe2KzkNolGlbqZGwWWYeIj2KjXl+ByJKW1kHQN6CDgMlfDYryOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239157; c=relaxed/simple;
	bh=zRJU0WG9Zkq4jTEKkU7FtXZ89Y0anq2YQF6kYDCEUQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbOKgVt7w6eR7Rp7DNPSyX6eF5IIsJr2pBVte2JSF8beQD8QTKVCudyQW7TRRXSgrjT+hJxWPsAkzjTdhtEC6G6S043tpkXTXS1gFRAGdSLlT+K4LqBmlt2Q8Q93tPpSzOrzvBOYaZOvGSY3P/9ABJmqsAh/yi8OJIcouXO3NUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nJTa69zh; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nJTa69zh"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6LKW5RdLzKnWS;
	Sat, 17 Oct 2026 14:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792239151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9g0XoimYUH25XFfAs9i86QtQLWCG1fLb3h7h5amVKY=;
	b=nJTa69zhafpqPIC99eUCQJCTOnGadeSds1bw/JEoIFc/X01XfpdRaiftaRnAyDwwTBb74r
	26hUSQKi4LJpL8tZnnZuwBTkz37Jp3FVnPyTdRSohOs3blwv7U+idjk/tBAb5yAq6FzoFF
	z7WrvtwPJUVn5Pcjln1v4wa86rI/AGjU3pd1yqJMX7LJxAZqEPvANL9/jA7GSiJ2pGcG1S
	eXG4xmbFwr2YFHtsqtnvNlzQ7cHck2Kopw2dMw0rl8ufFkrmkBGhe6+MR73DjAW1IASkdu
	bbtXrDvNt9brzgTCwRdLLUQepwxynlc6h1jlNCwxGvS33mDaOoQCdVkFSZz6cA==
Message-ID: <650ed710-c11a-4d7b-9e0e-f83a8b52b078@mailbox.org>
Date: Sat, 17 Oct 2026 14:12:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/18] PCI: dwc: Factor out the PORT_LINK_DEBUG1
 link-up check
To: Koichiro Den <den@valinux.co.jp>,
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
 <20261015033103.3076869-3-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261015033103.3076869-3-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b7ad063e07287705aaa
X-MBO-RS-META: fmxu4zyybco91pata315jrztghxmmofa

On 10/15/26 5:30 AM, Koichiro Den wrote:
> dw_pcie_link_up() reads PORT_LINK_DEBUG1 when the glue driver provides
> no .link_up() callback. A callback that needs a platform-specific check
> on top of that register would have to duplicate the register read.
> 
> Factor the check out into dw_pcie_link_up_debug_check() and export it
> for modular glue drivers. pcie-rcar-gen4 will be the first user: its APP
> link-up events remain latched after the link goes down, so it has to
> combine them with the live PORT_LINK_DEBUG1 state.
> 
> No functional change.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
