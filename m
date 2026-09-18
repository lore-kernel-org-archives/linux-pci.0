Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27E39795E;
	Fri, 18 Sep 2026 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712458; cv=none; b=B7QIFAuok0r4DffvEVJblcBJe45nRpDD6+ulyUk9HgsmhaEYvBqkaRPQ8EOBf63De0R60QGdNqNrSveBKaDaywNdWktykV/QGmV311XaRWaDzk53Ply/WofeF+16OlayRRlKQuBiZZHy0XhC8/WOXAmpXX9bjESE285M/BAd0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712458; c=relaxed/simple;
	bh=lD7NqqKM7Dgj4jRMfiv+WMvMH2wkE10YCf13FtRvoFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6ynKhH99pv31dMPPUOAMj9J0aVz7R6oKT/QXopdIqfpDmYGkbRFschB9KqCmP4t4seH1DxOCMwHDExdPPvE+02HPvv4X5Uk0UTymNSERpcw65uBVElxNJTUB4imCIJlOZT/1IXr4KyfR7PgezugwszHWubcPymsHMczpX+EOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DivEk2k/; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DivEk2k/"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hmMv41BMxz43LL;
	Fri, 18 Sep 2026 08:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789712448;
	bh=lD7NqqKM7Dgj4jRMfiv+WMvMH2wkE10YCf13FtRvoFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DivEk2k/bI3KdBETZhD7Dzh60wMJSNm6vZ9aH6iXyFP/zJhQd5FD0XfBbUGAwksM1
	 wtRWM75feWifIb+JyYg65PsUu7mZjAyr9nisTJZ7M63mhMtFZduwOsmb6gjZ970BFS
	 7mO/Dbe9gAo7fpb+IvVp3G1lF+oiHykixUClGkeId3hAMRLmMbcZRQfHsNUhj7RwYc
	 jxUPlOQOeRn+mTcLANpbq7jxDqUDLglHTDBARAeD4nLMeiowwc0WrD3IG1mY085vjT
	 /h83FXmq1YZ8iNsTGGB9IPmQZwG+aNEmElh345OCB2Jl/mQ0Yv3klhh5P3hPZlr3+I
	 04y4I00YJ0fOA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hmMv40TLMz43BZ;
	Fri, 18 Sep 2026 08:20:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hmMv31cb9z8tbR;
	Fri, 18 Sep 2026 08:20:47 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 644165F995;
	Fri, 18 Sep 2026 08:20:46 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <42ec4a58-2cc6-4c6c-9d00-705bbe77f400@leemhuis.info>
Date: Fri, 18 Sep 2026 08:20:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] NVIDIA dGPU never enters D3cold since Linux 7.3
 merge window
To: jackpilot <jackpilot27@protonmail.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: 
 <uz7NywYQwAzrOgqWjIeyjuTn3PalBrqAsBKcD81tQNJCCFw2j5yG6zQ9cH_PiHiUBOxOoms_MPh6g9FmBmsD80RVXLf8zSQZ4QXP24Z9dv4=@protonmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <uz7NywYQwAzrOgqWjIeyjuTn3PalBrqAsBKcD81tQNJCCFw2j5yG6zQ9cH_PiHiUBOxOoms_MPh6g9FmBmsD80RVXLf8zSQZ4QXP24Z9dv4=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178971244669.243502.16932713889909070992@mxe9fb.netcup.net>
X-NC-CID: UYec9lk8x3O7c3nC0qK2yGSTDqHpVLGqXH3X0YyfM7VJkpeV9e8=

On 9/14/26 05:06, jackpilot wrote:
> 
> 
> Since upgrading past 7.2.4, my NVIDIA dGPU no longer entersD3cold/runtime suspend and stays permanently active. Confirmed
> regression, not present on 7.2.4, present on both 7.3-rc1 and
> 7.3-rc2.
> 
> Hardware: ASUS ROG Zephyrus G16 (GU605MI), Intel Core Ultra 9
> 185H (Meteor Lake), NVIDIA RTX 4070 Max-Q / AD106M, nvidia-open
> 615.71.09 driver (unchanged across all tested kernels).

Thx for the report. Please reproduce without out-of-tree drivers. If the
kernel then shows the problem as well, you likely need to do a git
bisection with a vanilla setup to identify which change caused this:
https://docs.kernel.org/admin-guide/bug-bisect.html
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

Ciao, Thorsten

> Last known good: 7.2.4
> First known bad:  7.3-rc1
> 
> Evidence (/proc/driver/nvidia/gpus/0000:01:00.0/power):
>   7.2.4:    Runtime D3 status: Enabled (fine-grained)
>   7.3-rc1:  Runtime D3 status: Not supported
>   7.3-rc2:  Runtime D3 status: Not supported
> 
> Same output from /sys/bus/pci/devices/0000:01:00.0/power/
> runtime_status, power/control, power_state confirms the device
> sits at active/auto/D0 permanently on the broken kernels, and
> suspended/auto/D3cold on the working one. No processes hold
> /dev/nvidia* open in the broken state, ruling out a userspace
> handle as the cause.
> 
> I haven't been able to bisect further since the regression is
> already present at rc1, meaning the change is somewhere in the
> 7.3 merge window. While investigating I came across an in-progress
> ACPI series that touches related territory (PCI devices getting
> stuck referencing power resources during early enumeration):
> https://lore.kernel.org/linux-acpi/2295263.irdbgypaU6@rafael.j.wysocki/
> but I want to be clear I haven't confirmed this is the same
> mechanism, I checked dmesg for the specific _DEP/INT3472
> trigger it describes and found no matches, so it may well be
> unrelated. Mentioning it only in case it's a useful lead.
> 
> Note: tested on CachyOS's cachyos-rc kernel build (patches:
> https://github.com/CachyOS/linux-cachyos), not vanilla. Happy
> to test a vanilla build or apply patches if that would help
> narrow this down.
> 
> 

