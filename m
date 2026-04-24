Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7135E956;
	Fri, 24 Apr 2026 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027881; cv=none; b=ffHH1reqslASg+7JaN/FAJh0gJur9YShm63M2JXyS923OpusYKnTjQ90HA5gcmuwq0xgqOw09bI6svaEWrfaheo9NXVNNhMedxXWm9IpK+rSKnA4DQ04NGloM1ycHJZNYk0Mhz9drKP/u2fZAX8cWhs06O5CDpRuMSfpdUqyFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027881; c=relaxed/simple;
	bh=BGZnG/Ud/w08GvG1VxUb2fJR/gKuVNnL3eMhEkLbThI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tF2H1prhQrz0BzbZLXmALfOKglF4yB2ZCbk377p9hv27yzq7EgL4tUVRLgSF8D23iXe4+/eursGi78rvkyGVCeLXqixyEf4c8z1A87jFg05/bQpmb+tmC6WSYYXVvJ3rtLV+n0DqxyxJfKWcXPM3FbdVbagUAek7RJON6a/94o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JrIgHuLc; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JrIgHuLc"
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4g28s10TVjz95ss;
	Fri, 24 Apr 2026 12:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1777027877;
	bh=BGZnG/Ud/w08GvG1VxUb2fJR/gKuVNnL3eMhEkLbThI=;
	h=Date:From:Subject:To:Cc:From;
	b=JrIgHuLcPzgFwwycppK2lcIwmyw4uJcuNUl3zzLxcw1DToLpJjIivq8IB40k/XpA9
	 haXq95I/QUwqdJTGCAPw2qRlF21OLfTjalnkaBegtRQciCi6LUaLlPVJGAHZ8UsGQy
	 fke5P8Hb/EQdHJC7DfD4MhE0Hemtocmj93udbG+AkOUECrwR3v7DIyifuvtzeqAKrQ
	 1aum85uSFCLMiciBjwzqj6Z9HTVmxXn56POHfl9yaIgzPkLUQCTbyl4GqCtkPvJm9F
	 5AH/TsHZq1mXsdxMAbqfI8SPfYx0a7jc7z7XZkQYLiXnkRSraXGNQJ+5uPos5LNzJx
	 vyyA2A6lyDBNQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4g28s06tKNz7wDk;
	Fri, 24 Apr 2026 12:51:16 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4g28s02rWWz8svh;
	Fri, 24 Apr 2026 12:51:16 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id DE76261746;
	Fri, 24 Apr 2026 12:51:03 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <87df54eb-c527-4f1a-a3a7-67afbd73cb47@leemhuis.info>
Date: Fri, 24 Apr 2026 12:51:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Regression fyi: pci usb3 card in 32bit P4 s478 stopped working
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, roxmail@list.ru,
 Linux kernel regressions list <regressions@lists.linux.dev>
Content-Language: de-DE, en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177702786421.840387.8371487853739029717@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: DE76261746
X-NC-CID: OC467STxFgyuA0gvydJRHLUOGBrNpKgBSIfAs/+RakSE+de1KSg=

Hi Stefan! It seems the change 83dbf898a2d452 ("PCI/MSI: Mask MSI-X
vectors only on success") [v5.16-rc6, v5.15.11, v5.10.88] you submitted
years ago (committed and mainlined by Thomas) causes a regression:

https://bugzilla.kernel.org/show_bug.cgi?id=221028

To quote:

"""
I have a system (32bit P4 s478) with pci usb3 controller card, it is
based on uPD720200 with (PI7C9X111SL PCIe-to-PCI Reversible Bridge).

since commit 83dbf898a2d45289be875deb580e93050ba67529 PCI/MSI: Mask
MSI-X vectors only on success

card stops to work (this commit was backported to lts kernels since
5.10.88).

manual reverting from master (test patch attached) makes a card working.
"""

Might be a very special case, nevertheless wanted to let you know about it.

Ciao, Thorsten

#regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=221028
