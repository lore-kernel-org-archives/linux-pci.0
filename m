Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B8F1EFFB7;
	Sat, 28 Mar 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774709280; cv=none; b=PInS3MjCYrPcbj74PAKlzH6ke3Wc8kUpdO3RD61gb9Q5gYjPu8C1ksEJfmo0beGBvoYQCG+WLqMOa1fU06pdIw39XdzN973mYSb1rKNeWu7TCS2HABlhlu63x4irs2kyptq3a0ErLOhkG6VEBf4O+n4NLiEZdPdlbyQllKx5DHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774709280; c=relaxed/simple;
	bh=L6AnvYaq6IRX4pGBZET87zaeXQ1fZmHF3MshlEELVWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdC/iyaUrqsg3FdujXMRxG035SMC9QSPRFXCSJP4WlMiQ2YgNZGnz36e5funbDtDogo1gFeBwr24xeGIqeW0mkTLXSKYLFeVv3X80zYZ1NH8pntCLe2x4UeH4W3E+Sm8PHf3B1kl4YgHjAZLB3PwK2BsT25IdulbmUCx5pGcfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=af1eRYb7; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="af1eRYb7"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fjgDG6YlWz4GLH;
	Sat, 28 Mar 2026 15:40:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774708846;
	bh=L6AnvYaq6IRX4pGBZET87zaeXQ1fZmHF3MshlEELVWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=af1eRYb7pAHQSoWWi/iMZo/zh6hp4X4kyMRHwI/KOQZbYHIU8t7jmbt4rasq6gc6F
	 FtBFNx2+03HqThKxb7cqIV9TCRQ8kqHxcgYicYTYoiCF268M20LanU9himx9ksMgeo
	 DBf39dx5gcY9QWg4kLGVQH+JliS7p3xUlS3CZBYha2+J1DYI8EyvCkG1Cx3szfmClD
	 JbCnOQMYMhI2MfP2eTwp8cJu+o4rkXdOXk8HLYm4KebYc6vsM1GCz1CSwD6t57O21n
	 Fz2XFpYlbo7IFNWMpsuUv589fnCPHPIZu+oJDwPoCr/+QMD+9VtBtsBXvoWmLyLDWB
	 q6Ur2lfrdTRpg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4fjgDG5rpXz7x3N;
	Sat, 28 Mar 2026 15:40:46 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fjgDG0KVpz8svJ;
	Sat, 28 Mar 2026 15:40:46 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id DBF8B63590;
	Sat, 28 Mar 2026 15:40:44 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f0054ecb-2524-42e5-ac1d-ed8ab114bcef@leemhuis.info>
Date: Sat, 28 Mar 2026 15:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
To: Salvatore Bonaccorso <carnil@debian.org>, bernd@bschu.de,
 Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: 1131025@bugs.debian.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: 
 <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <acfZrlP0Ua_5D3U4@eldamar.lan>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <acfZrlP0Ua_5D3U4@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177470884541.625005.2082032994498119931@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: DBF8B63590
X-NC-CID: 94YIEh3uvikIOkmOtIhHAKGJqkVKjA5g+6ifOf/pcUTXYXPxGxE=

On 3/28/26 14:37, Salvatore Bonaccorso wrote:
> 
> Bernd Schumacher reported in Debian (report and report from bisection
> in https://bugs.debian.org/1131025) a 6.12.y specific regression of
> 58130e7ce6cb ("PCI/ERR: Ensure error recoverability at all times"):

TWIMC, "6.12.y specific" seems to be really the case here, to quote from
https://bugs.debian.org/1131025: ""Installing
linux-{image,modules,base,binary}-6.19.8+deb14-amd64_6.19.8-1_amd64.deb
and booting 6.19.8+deb14-amd64 (6.19.8-1) works without the described
issues.""

> Anything else we can provide to identify the issue present in 6.12.y
> kernels?

First: many thx for forwarding this regression and a lot of others
similarly in the past; it's great. There is one thing that could make
them a lot better: if you always make it unmistakably obvious (ideally
at the top of the mail) if mainline is affected or not (here it was
close, yes, but sadly some people write "specific" without ever testing
mainline, so it was not unmistakably :-/ ).

Overall, it IMHO is best to keep this mental model: mainline and
stable/longterm series are maintained by different people -- and those
from one group do not care about the regressions the other party has to
handle.

In practice it's of course way more nuanced: for example, many (but not
all!) mainline developers help the stable team out somewhat, and some of
them might even handle regression reports with longterm kernels; and the
members of the stable team are mainline developers as well, so when a
bug falls into their domain, it might not be important.

But to avoid delays or things falling through the cracks, it's really
best to always check if mainline is affected – and report regressions
like a mainline problem using a mainline version if they are and leave
the stable team out of it, as they most likely will leave things to the
mainline developers. And if it's stable-specific regression, state early
that mainline is not affected.

Ciao, Thorsten
