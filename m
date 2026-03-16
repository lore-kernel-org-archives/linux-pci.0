Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397A28C869;
	Mon, 16 Mar 2026 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660632; cv=none; b=FEYNYHkzrCl8tnez/iNsxA7YuLSmlgFJhTahxLdNGKhSbCV9/ChvuUcusxdUn+H8kybzVyIq6LPX97iV2WW04vrGQhi7bMGXYQMF1QSa5nZm0hk02o9N+mY9cXG3PfcP/k3GTQsY30EpmZPFKHMcN0h/q/TKonu4bjqAR4GY4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660632; c=relaxed/simple;
	bh=VD2SZ4zPl2QiNjFQy49xFNiTsCCQnU4PUIcpFpP9Eus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMBFBaetr6julVszJR7hwXDquYFbxeveKerN2C4w+xGwUc/et79yc9yrEwJPo0Z1qJxe8UwHeuz9BBF6V7bY2WO7JXHpchX5VgEMwGtNH/CowdkzbMxMgBVG22xfGu0HjcVfcJ2Ro7k7fb/NupIEbfOYtTw9W7gI7G7687wnmXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=cXfVaKhl; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="cXfVaKhl"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fZCZ637Sgz89BG;
	Mon, 16 Mar 2026 12:30:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1773660622;
	bh=VD2SZ4zPl2QiNjFQy49xFNiTsCCQnU4PUIcpFpP9Eus=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cXfVaKhlC07VgloevZ/T0lyP4EuX4pTFcfxAIEgc/AdISGU1QIFyIa6oasOkgTVKu
	 OgfHqbsg8ogfpzKUxvzAtYfrVKbk6ukECQfHt09ZRPD68YneMHUWGItbeghxSROiHz
	 eXMcwALJta+B20b+TJzzEsZ0ymBhMmDd1PZeMRcvB+haN/1O6ooUYCniYRHg7eYowS
	 6KBH4C75+qBH4DocFwOtBMC3YCECkl/E+S//gOdqrMecl4pnoebBpPQTLBSgbUo/96
	 v+pp9UOJ46kap/iussgoBPLDIq66VzZAoOBJPgca7i/x6i+1AtHsswuJ2r8MZZzOG+
	 uMq05Vds8+Wuw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fZCZ62RNbz89B9;
	Mon, 16 Mar 2026 12:30:22 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fZCZ566d6z8svh;
	Mon, 16 Mar 2026 12:30:21 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 43263617A5;
	Mon, 16 Mar 2026 12:30:21 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <fbe7b0ad-28c8-4fa6-adbb-860691657eb2@leemhuis.info>
Date: Mon, 16 Mar 2026 12:30:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window
 / BAR allocation failure prevents NVIDIA and AMD GPUs from initializing
To: =?UTF-8?Q?Michal_Babi=C4=8Dka?= <michal.babka@gmail.com>,
 linux-pci@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
References: <FCEB17D3-3DC5-49C8-8C56-8051C875E2F9@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <FCEB17D3-3DC5-49C8-8C56-8051C875E2F9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177366062153.1410887.11442397827644764000@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 43263617A5
X-NC-CID: KMW1k5vmoE6SyIQHu31VK5FSCSLrfyytH8CRfIlGnJ9kPBgqsxY=

On 3/15/26 12:54, Michal Babička wrote:
> Subject: Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window / BAR allocation failure prevents NVIDIA and AMD GPUs from initializing

Lo! You CCed the regression list, which implies that this is a
regression. But you did not specify when the problem started. And if it
really is one: have you considered a git bisection? Then we'd know what
causes this. This in case of a regression most likely will be needed,
unless some developer has an idea what might be at fault here.

Ciao, Thorsten

> Hardware / platform:
> - Host: Apple Mac mini 2018
> - Connection: Thunderbolt 3
> - eGPU enclosure: Razer Core X Chroma
> - Tested GPUs:
>   - NVIDIA Quadro P400
>   - NVIDIA Quadro P4000
>   - AMD Radeon Vega 64
> 
> Linux distributions / kernels tested:
> - Ubuntu-based systems
> - Zorin OS 18 Pro
> - Multiple kernels tested, including 6.12.x and 6.17.x
> 
> Problem summary:
> On Apple Mac mini 2018, an external GPU connected through Thunderbolt 3 in a Razer Core X Chroma enclosure is detected and enumerates on the PCI bus, but GPU initialization fails because PCI bridge windows / BAR resources are not assigned correctly.
> 
> This is reproducible across different Linux installations and with GPUs from different vendors, which strongly suggests a platform/topology-level PCIe resource allocation problem rather than a bug in one specific GPU driver.
> 
> Observed behavior:
> - The Thunderbolt enclosure is detected correctly.
> - boltctl shows the enclosure as connected / authorized.
> - The GPU appears in lspci.
> - The kernel loads the vendor driver module.
> - GPU initialization then fails.
> 
> For NVIDIA, nvidia-smi reports:
>   "NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA driver."
> 
> Relevant NVIDIA kernel messages include:
> - "BAR 1 [mem size 0x10000000 64bit pref]: can't assign; no space"
> - "BAR 3 [mem size 0x02000000 64bit pref]: can't assign; no space"
> - "This PCI I/O region assigned to your NVIDIA device is invalid"
> - "BAR1 is 0M @ 0x0"
> - "RmInitAdapter failed"
> - in some attempts also:
>   "fallen off the bus and is not responding to commands"
> 
> With NVIDIA Quadro P4000, the same general failure pattern was observed:
> - the GPU is detected on the PCI bus,
> - the NVIDIA kernel module loads,
> - initialization fails,
> - and the logs again point to invalid / missing BAR assignments and resource allocation problems behind the Thunderbolt PCIe bridge hierarchy.
> 
> For nouveau, the failure is visible as BAR/resource allocation failure as well, for example:
> - "bar: one-time init failed, -12"
> - "init failed with -12"
> - "Device allocation failed: -12"
> 
> With AMD Radeon Vega 64 installed in the same enclosure on the same host, the same fundamental problem occurs:
> - the enclosure is detected,
> - the GPU enumerates,
> - initialization fails,
> - and the overall behavior indicates the same lower-level PCI resource / bridge window allocation issue.
> 
> This strongly suggests the issue is not NVIDIA-specific.
> 
> Thunderbolt state:
> boltctl reports the Razer Core X Chroma enclosure as connected/authorized correctly, for example:
> - type: peripheral
> - generation: Thunderbolt 3
> - status: authorized
> - rx speed: 40 Gb/s
> - tx speed: 40 Gb/s
> 
> Important conclusion:
> Thunderbolt authorization itself appears to work.
> PCI enumeration also works.
> The failure happens later, at PCI resource assignment / bridge window sizing / BAR allocation time.
> 
> Key dmesg patterns observed:
> - multiple "can't assign; no space" messages for PCI bridges and BARs
> - BAR1 / BAR3 of the GPU not assigned
> - bridge windows under the Thunderbolt hierarchy not large enough
> - reassignment attempts that still leave required windows unassigned or invalid
> - vendor driver subsequently failing device initialization
> 
> Examples of affected topology in logs:
> - 0000:00:01.1
> - 0000:05:00.0
> - 0000:06:01.0
> - 0000:0b:00.0
> - in other boots, the same problem may appear under a different BDF address after Thunderbolt re-enumeration
> 
> Representative log excerpts:
> - pci 0000:0b:00.0: BAR 1 [mem size 0x10000000 64bit pref]: can't assign; no space
> - pci 0000:0b:00.0: BAR 3 [mem size 0x02000000 64bit pref]: can't assign; no space
> - pci 0000:06:01.0: bridge window [mem size 0x10000000]: can't assign; no space
> - pci 0000:05:00.0: bridge window [mem size 0x20200000]: can't assign; no space
> - NVRM: BAR1 is 0M @ 0x0
> - NVRM: RmInitAdapter failed
> - NVRM: The NVIDIA GPU ... has fallen off the bus and is not responding to commands
> - nouveau ... Device allocation failed: -12
> 
> Kernel command line options already tested:
> The following boot parameters were tested in various combinations:
> - pci=realloc=on
> - pci=hpbussize=0x33,hpmemsize=256M,hpiosize=2M
> - pcie_aspm=off
> - pci=nommconf
> - pci=noaer
> 
> These mitigations did not resolve the issue.
> 
> Why this looks platform/topology specific:
> - The same Thunderbolt eGPU enclosure is recognized correctly.
> - The same failure pattern appears with NVIDIA Quadro P400, NVIDIA Quadro P4000, and AMD Radeon Vega 64.
> - The common denominator is Apple Mac mini 2018 + Thunderbolt PCIe topology under Linux.
> - The failure mode is centered around PCI bridge window sizing / BAR placement, not around one vendor-specific driver alone.
> 
> Expected behavior:
> The Thunderbolt eGPU should receive valid PCI bridge windows and valid BAR assignments so that the GPU driver can initialize the device successfully.
> 
> Actual behavior:
> The GPU is visible on the bus, but bridge windows and BAR resources are not fully assigned, which leaves the device unusable and prevents the driver from completing initialization.
> 
> Request:
> Please investigate PCI resource allocation / bridge window sizing for Thunderbolt eGPU topologies on Apple Mac mini 2018 under Linux, especially where large GPU BARs must be assigned behind multiple Thunderbolt / PCIe bridges.
> 
> Cross-vendor reproducibility on the same enclosure and same host strongly suggests that the root cause is in PCIe/Thunderbolt resource allocation on this platform rather than in a specific NVIDIA or AMD driver.

