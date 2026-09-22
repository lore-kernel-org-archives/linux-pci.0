Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D04E2F0B;
	Tue, 22 Sep 2026 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110953; cv=none; b=BDfM4S2X13W7MqF9X4gujmWI45vA5oe62ksBJtCiavc+PkGBtQdJv6B21cmj/GVr/Rly0VCqCHbS9RWzIiG3RkaNNvSH0SQFEv7qO6ztQjokNHcyNKk8iafjr9/cxUCTiy+wftDSA6ovH1OIRaOtANj8xBlSugA7X2evkGc79z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110953; c=relaxed/simple;
	bh=lUcfPQUhQAADyE/pubdnyJBHgkaPKoCT2ofrFRHGe3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3t2CQTVkRT2hpxH3mqs+ha2Z6mcox3T0ObW5XodQVtYLVBmF6DboPlY9RjPIGk5520dOfokTvvLMN6t2kIdEG5YCyL5JdqSOSmfJ3qFVmWGpsNGaTLua0c2Sv9VZXE41aBwhahEKL83C6cSAfIgbVOKNjGfuUZ7dewzroPFtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=H/+BVk+C; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tD6Ts3ny; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H/+BVk+C";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tD6Ts3ny"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hqCGM3Ntbz8trG;
	Tue, 22 Sep 2026 23:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790110939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKd/+BlMfOhA3I2FoBD2/HerZf5gpDrEnJWOAQjzo3o=;
	b=H/+BVk+ChKXNvljfjL5j8UHm9YIpTB0ZRZD/flrTnw4DQ0Np6v2Zli/LNdUGOrtuOlhCAx
	Pp2Gr4LxmX4Kc89JkwjfdK7h+MzoYs7b1k4SjTfTvMAl1+F6YdWUe/ZA61YVtmCbe/BuBS
	6UnogDyx5Ljp020+Lf0cWgSQ2rivOUsWHlT7vQ+4Gl0Eda+EkJB7QsqafrkzQvWM9W5GgJ
	R7f6LJPV6zhOHAz7AR89IkyQIJtonUGG34oKoHW6vE7RWLNlIRRp699wqbkzJ4MZmoVzVP
	93YiEeNxh03/U0C/ozF9vwMbkjxLqW6ObIHJ/XgDvPTzve30kEHGACn1IDE3Sw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=tD6Ts3ny;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <e96cf34b-86c9-42be-986d-ee3769467146@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790110938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKd/+BlMfOhA3I2FoBD2/HerZf5gpDrEnJWOAQjzo3o=;
	b=tD6Ts3ny1JkNlH2S6QAHEkR1fGVOu92gl8DgtzZO8FvxluDKHyKVv97nF0/dTZ2dTG8DrN
	C+FH/fhDLDeusPtP5pJhhoDgA/gF6o/Z8SoowHqhdvzqnTv2uRStyCuFZk+BhhN35dWo1k
	6FmpGo09IVZGMUMfA2ot3XPkv+M+UVHbQU94MrFb5bQ0zBIMuK33liiqPPOr48J8Abi1JF
	H+m0arqh6mHcbK1Jq+AUbsew71Tb75U+YTLnK7T2XItn7uNwdDG9qEOE80lWbZp1Ja5lNr
	kLl9u4i+a3DVwi4H9x1cP+lhtrugthbszLwhDyjS9HmtE2rBzEGlEGok+YFDww==
Date: Tue, 22 Sep 2026 21:40:55 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 01/11] PCI: dwc: Add Renesas to the RAS DES VSEC list
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-2-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260918032038.2216471-2-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 181b6597c9e6b3ec0e5
X-MBO-RS-META: h3uxtr9t4bjmpw1sx46fmfq8tw9fwsn7
X-Rspamd-Queue-Id: 4hqCGM3Ntbz8trG

On 9/18/26 5:20 AM, Koichiro Den wrote:
> The Root Port on R-Car Gen4 (DWC 5.20a) carries the RAS DES capability
> with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
> not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
