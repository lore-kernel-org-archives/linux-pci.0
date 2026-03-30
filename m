Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D6394478
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855331; cv=none; b=FS4+ifVN/yKb/JXOE0HhVHvGyY0dR7Nts8Pcuq6C/N8JCr3SnzMXXNFmv8vEUiYaAU+cIUiLF0+TtibdWlUiwJYRS1HVqV58GrCPiD6QSaPPa79/XTlEOlBnCwWgmpkaXrb08Q8KtX89kMXaQW94IDdGrf8g+J+wvRp4fR8CO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855331; c=relaxed/simple;
	bh=yxG7QF5zwlY0J8+nC7mwj4kOKUph1csKPoskBDMcy+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsYOwEOWU2MePopoAKaBl/snLqgoYOb/14cUCrpUYekZJtlFFDrW0fEN96TudcokouX8YmJaddu5Ea5gF3oRxlr2B8xxtYRwun3+qhVTM0FTfcEvCy+GaOaTuqQvghDSn0YJcI3AyMwDb4gDQ7uxbKuII+n+lMZ1A5nvzJxsRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DehjLqFE; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DehjLqFE"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4fkjP50KPrz6DXZ;
	Mon, 30 Mar 2026 09:22:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774855321;
	bh=yxG7QF5zwlY0J8+nC7mwj4kOKUph1csKPoskBDMcy+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DehjLqFEH0oqs1FB7K4tfhStLUpDz3Ihjkjd736vLBbJTQv77UOiBmK1RWBQbG0pL
	 VQXp02ICX/VzI8TRajKhEE/dz0iYRU2VoTSJHB2w53G/uBj/aQSkKilW6xpSWytWyi
	 GA4ODk2Cz3AEDyUkyhRYZ1GYLZn5/o4CDgg7qJt8Y4MC7teT4QGtlhmXCTp/KC87iq
	 8ovsA8soT1czNIRqfOL2/3NqSFjioHY8IZqid7FyJBFSVIPiJB1B3N7QABLMhwGk02
	 5cHJt6BIedP3l/aHYSM7fkjWUWbGNzlTA33GCdpU6jYZdC10yDB9qJ4EhqIbLQWY7w
	 xJ2L874RaXf3A==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4fkjP46jTSz4xZX;
	Mon, 30 Mar 2026 09:22:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fkjP33Wb2z8tcZ;
	Mon, 30 Mar 2026 09:21:59 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 73647635F5;
	Mon, 30 Mar 2026 09:21:58 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info>
Date: Mon, 30 Mar 2026 09:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since new
 bridge window alignment calculation code
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, regressions@lists.linux.dev,
 =?UTF-8?Q?Jonas_H=C3=B6glund?= <firefly@firefly.nu>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177485531876.201785.11672753983964350513@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 73647635F5
X-NC-CID: uTqEVDorUtlfFxFD/O6VNzMg+0/A1t60E4OF9CJ8quxmm3d4OKE=

[adding author and committer to list of recipients while dropping stable
from CC, as the problem seems to happen in mainline, too]

On 3/28/26 00:02, Jonas Höglund wrote:
> 
> I have an AMD GPU in an external Thunderbolt enclosure that recently
> stopped working with the latest longterm kernel release.  The GPU in
> question is an AMD RX 6750 XT.
> 
>     [...]
>     amdgpu 0000:3e:00.0: amdgpu: vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
>     amdgpu 0000:3e:00.0: BAR 2 [mem 0x74200000-0x743fffff 64bit pref]: releasing
>     amdgpu 0000:3e:00.0: amdgpu: Problem resizing BAR0 (-16).
>     amdgpu 0000:3e:00.0: BAR 2 [mem 0x74200000-0x743fffff 64bit pref]: assigned
>     amdgpu 0000:3e:00.0: amdgpu: VRAM: 12272M 0x0000008000000000 - 0x00000082FEFFFFFF (12272M used)
>     amdgpu 0000:3e:00.0: amdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
>     resource: resource sanity check: requesting [mem 0x0000000000000000-0xffffffffffffffff], which spans more than PCI Bus 0000:00 [mem 0x000a0000-0x000bffff window]
>     ------------[ cut here ]------------
>     WARNING: CPU: 7 PID: 2260 at arch/x86/mm/pat/memtype.c:720 memtype_reserve_io+0xfd/0x110
>     [...]
> 
> Searching for the issue I found this very similar report from last year:
> https://lkml.org/lkml/2025/6/9/88
> 
> so I suppose this might be a re-regression of the same issue(?).
> 
> 
> I checked out latest longterm (v6.18.20) and bisected, which took me to
> commit b855d99 (upstream commit 3958bf16), which is
> "PCI: Stop over-estimating bridge window size".

Ilpo, Bjorn: Jonas in a subthread later confirmed that this problem
happens with 7.0-rc5, too, so it's likely something for you.

Side note: I noticed the "PCI: Improve head free space usage" series
referred to the commit in question; wondering if that is related:
https://lore.kernel.org/all/20260324165633.4583-1-ilpo.jarvinen@linux.intel.com/

Ciao, Thorsten

> After the bisect I tried reverting the commit on top of v6.18.20 (going
> back to the old way of calculating alignment), and this is sufficient
> for the eGPU to dock properly again.
> 
> I've attached a longer excerpt of the kernel logs from a failing boot
> (let me know if a full dmesg would be helpful and I can find somewhere
> to upload it).  I've also attached an excerpt when connecting the eGPU
> in a "good" case, since I figured the memory adress ranges could be
> useful.
> 
> 
> Hardware:
>   Machine: Dell XPS 13 9310 (0991)
>   GPU: AMD RX 6750 XT
>   Dock: EXP GDC TH3P4G3
> 
> Distribution: NixOS
> Architecture: x86-64
> 
> #regzbot introduced: b855d99
> 
> Let me know if any additional information would be helpful.
> 
> Thanks,
> Jonas

