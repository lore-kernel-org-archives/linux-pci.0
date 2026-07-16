Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802D432BE9;
	Thu, 16 Jul 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222206; cv=none; b=XkBy/BeGiyJqYSkjW+poqpRV7dNWQ+BIaPS3sT8f4rTrJa19JcUqmbr5bQxKbfuDw7cWG0QXhEVisdywa73SExvQDVdmo0+jD7DgvcNSgbsMK4pNi6fkCxHsIJiMaBWlt8psoC926lGhcw18KoSxGBSErXcj6HCy+eF+BrpA9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222206; c=relaxed/simple;
	bh=SfxmVh82JeVUiMIg5Ix7ybdUy/Tn1k/6+Lx1CoaHy70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwrGKCdS7d8oH19/5ElOKCwp3STZ+3a8E1G1twbvoR4QJjnpMhhpCiIooqaO2nTw2Gasddr6Cg73dzdQjTSXS9CdHUDEk22qdKCxBIggZJiILmJWiNjAvu3vlLXHV906KqEB62iqvNnVD8geUgSYVT9GChcxwulkr56dRRidoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=G132+HNd; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="G132+HNd"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4h1KTH4HhZz6GgT;
	Thu, 16 Jul 2026 19:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1784222195;
	bh=SfxmVh82JeVUiMIg5Ix7ybdUy/Tn1k/6+Lx1CoaHy70=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G132+HNdtECgWKcjhHjwuaGtsqmseHspOikRY9VyE1aiQCfmTJa0willMAgVXrxIV
	 itS7y32weNk5fdNWrqgcit3cmeWjZv4bj7PSy4hk2i8T9+gI1ke+JyNduEkB4QkjeQ
	 jGN6ip2rDgTvtBDCTB0Q1MB2hrWrUo3sEGsYfpta2zSoHO5SORIFMY7YAc8TxeRLZ7
	 CYt7JllK6Nr18WviThNdBXpK3cZsyy6qj7CsFsjt41P6eCdh6kO12J/iDQmPDBUjtP
	 38FTtXgx7ygXh7yjic/2zm84qXODtJZZfTdnbt735Sz79iLGW/9pdrnlv3ME4cbpXw
	 XztOELzlZ1xvQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4h1KTH3YCLz4xrb;
	Thu, 16 Jul 2026 19:16:35 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4h1KTG3VXfz8sZw;
	Thu, 16 Jul 2026 19:16:34 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 481645FA12;
	Thu, 16 Jul 2026 19:16:33 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <eb92c269-efa2-4f39-bd47-4d1ee36169ee@leemhuis.info>
Date: Thu, 16 Jul 2026 19:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
To: Bjorn Helgaas <helgaas@kernel.org>,
 "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
Cc: Leonardo Costa <leoreis.costa@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "leonardo.costa@toradex.com" <leonardo.costa@toradex.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Sherry Sun <sherry.sun@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Hongxing Zhu <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260716164058.GA16414@bhelgaas>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260716164058.GA16414@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178422219399.2284195.6020549002013928240@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 481645FA12
X-NC-CID: Vs77JiHUJeQSI/GM5fLBjJeVYsLXfvjY38tVOy8NioWSC4JmvkE=



On 7/16/26 18:40, Bjorn Helgaas wrote:
> On Thu, Jul 16, 2026 at 02:15:42AM +0000, Hongxing Zhu (OSS) wrote:
>>> On Mon, Jun 29, 2026 at 11:34:32AM -0300, Leonardo Costa wrote:
>>>> We are seeing a regression on Apalis iMX6 where the kernel
>>>> doesn't boot in the newest v7.2-rc1 (it was working before, in
>>>> v7.1). The device tree being used is the imx6q-apalis-eval.dtb.
>>>> The kernel configuration
>>>> used is the one shown below:
>> ...
> 
>>> Can somebody confirm that reverting 610fa91d9863 fixes this
>>> regression, or at least that 610fa91d9863^ works and 610fa91d9863
>>> fails?
>>
>> Sorry for this severe regression. I have posted a fix that has been
>> tested on my i.MX6Q SabreSD board:
>>
>> https://lore.kernel.org/imx/20260708035928.580236-2-hongxing.zhu@oss.nxp.com/
> 
> My question was whether somebody had actually bisected to 610fa91d9863
> ("PCI: imx6: Assert PERST# before enabling regulators").  I don't see
> anything specific on the mailing list, so I don't know how
> 610fa91d9863 got blamed for the regression.

That was me and might have been a stupid idea. I normally wouldn't have
added this, but a earlier message from Hongxing Zhu sounded a pretty
convincingly like something along the lines of  "this is the problem I
already have a fix for there" -- and then I took the commit-id from there.

Sorry.

Ciao, Thorsten
