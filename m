Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40218442391;
	Wed, 26 Aug 2026 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753532; cv=none; b=OVVGgTYCU4Zs/xZyGh7zbOlJndb0hHC5A+kzkuPEfsEPnYTEqcvGxupJEsgb2jbtcUAStNwzm5LqUvNy0dftSSXBC4oCylTjAoCJIMCEPf6pQKDNSmFYQeNeTl4QxTfk+OPseoij3aezTTnZiePrKeWthJSlrYJytOkHZBzoUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753532; c=relaxed/simple;
	bh=LR3sXZyv9BZpKnMkFqGg2COPCZoeIEfg8/rVtySW0wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnPWbF0/B9wtzfbcNY2d0MPNOHeF8lfvHeaJK3+wFc8bYDblcQsnGJYs3nzbP74b2kSH1V3mOJT7g1lhY1YIKiaHi2rkgMANn8j/VD56CzdyZPh3TXh/hM7MHSEQYqroWdx0qz0payrk/97vWpyjDHb8IavhXmvhOpsu0sFjGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=lUN82dPn; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="lUN82dPn"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hVRRG4WWdz6Crs;
	Wed, 26 Aug 2026 16:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1787753514;
	bh=LR3sXZyv9BZpKnMkFqGg2COPCZoeIEfg8/rVtySW0wE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lUN82dPnB7XbbKExuk2IfwWOlfjroBdGo5tWmDybP9VKEpFd3dTDU+4qtsnyQR9V1
	 YRnKi0DZqM4KHr3BoFYpUnZNpECmbzEKg4Z7l6Fg/wEF4TFPSi+izmzbb3LYkS0Kvn
	 M+yjLrEshbs9oaD3qb7xxpOSBUTM00nYqnJOgjTyoHSGpRK91xLLBOaru9bIJyljPP
	 /muBx+gvJRUkk7sH6b7XD2T3gmQkZi5AQXLuRsQJ0wX6ajn034AnrC2r3w5bAB5YI9
	 fopo1FDc0WTrPoFKKl1eIbh9JGVz562H8C3LP+iq27X0i3bYn/At9SqjEldPPDf2cv
	 iRXoGX17wFVhg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hVRRG3mq0z4yTM;
	Wed, 26 Aug 2026 16:11:54 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hVRRD6yhQz8sch;
	Wed, 26 Aug 2026 16:11:52 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id B2ADA5F992;
	Wed, 26 Aug 2026 16:11:47 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <04454db7-0779-4a7f-bab2-72fea3480dcf@leemhuis.info>
Date: Wed, 26 Aug 2026 16:11:46 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mainline/master: PCI link creation fails on Apalis
 iMX6
To: Francesco Dolcini <francesco@dolcini.it>,
 Leonardo Costa <leoreis.costa@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, Frank.Li@nxp.com, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, regressions@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, leonardo.costa@toradex.com
References: <bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgneropf3hpgwve6@n2m5uhlduw57>
 <20260810211209.GB4821@francesco-nb>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260810211209.GB4821@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178775350852.4133069.1765088279857940281@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: B2ADA5F992
X-NC-CID: G3r5K1/Ois168fF789GTTufWvzg9G612mk5/qbx22u4FQm275A0=

On 8/10/26 23:12, Francesco Dolcini wrote:
> On Mon, Aug 10, 2026 at 02:54:45PM -0300, Leonardo Costa wrote:
>> We are seeing a regression on Apalis iMX6 where connected PCI device
>> links fail to come up at initialization, as shown below. The issue is
>> not on the devices' physical connection, as they worked properly on v7.1
>> and are working on other stable kernel versions.
> 
> just to make this more clear.
> 
> 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> introduced a regression that prevented the boot. because of that we were
> not able to run any of our test in our CI/CD
> 
> commit 7678e81498e2 ("PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing")
> fixes the boot issue, but now PCIe is not longer working
Just wondering: what the status of this regression? I feel a bit lost here.

It looks like people were really keen on getting this resolved for 7.2
-- even multiple revert were considered, but not performed in the end
(not judging here, just mentioning it). Three days after the quoted mail
(and thus even before 7.2 was out) Richard Zhu posted a fix afaics:

https://lore.kernel.org/all/20260813095003.356062-1-hongxing.zhu@oss.nxp.com/

But that still sits on the list and did not even receive a tested-by. Is
it not that urgent anymore for some reason I cannot see? Are developers
waiting for test-results from affected people? Or did this fall through
the cracks?

Ciao, Thorsten
