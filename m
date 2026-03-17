Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7B2989B5
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764046; cv=none; b=YTAJa2hWomHG0bVqarY9E6y8FZwTDxMSAayc2z1Tfo3WTNZMSu3mewJNA3PJLFIEBodF9KyNTOx0WOE+QClk9PjvJeMLHOhFs9tCw/G2M3LdabzCVK4uatt4ZDbVEhbxizAU1CZddX1Unh22RRvG7ZE0FQk1148w9as2AM4d74A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764046; c=relaxed/simple;
	bh=Saybq7IT43xesFYiRZHUv8SNjgjpla7S0shetRSiaQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QNBYQt+JJ2yaoplGvmxczodD17D0sJc5Kb0hddaVkT5ha63hY6RLxTu4fv34CUBbBqsTKcd9POGxOpPWpXtMLRtHcS5rbis/WN21vIfhW3le+wPJj6ROi//XPZw7iyucn4vZLWelcSRJ6iei7g4o9kufpoy6BR1NuL+vmeKa+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh/GKgpD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh/GKgpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DF3C4CEF7;
	Tue, 17 Mar 2026 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764046;
	bh=Saybq7IT43xesFYiRZHUv8SNjgjpla7S0shetRSiaQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bh/GKgpD73qu7uxwgyRY0VBUr1Y7Mrm9x0UmAgpqBrSaKbg1EfNa44cHgOuO34aTI
	 FtVwXMlO6aEXDpe/kIn3N6EeJwaLtD25nOCxt3ZXSwarNJP0Ccx3A5RKwXTeNud1YN
	 nbxVVJAVEhr4O6Uo+Ww6SXnqMGQvTi3Oq4xT6ZeORyUpBPxWohK8d4+s8py+NecoTk
	 uhfUceGTHeqL9q2evt+7tZMk3mmSQOL9ggDtxqIif+fUFGvGn5Mg4FCnFR/8g5hrjZ
	 8KsigV7BHjXiHhTLtXBfhuKUE5+VJvv1BQmhg7rP60oB9Q8IpFvYCe86Ci/XWMlIRU
	 5A03yO0a01RIA==
Date: Tue, 17 Mar 2026 11:14:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michal =?utf-8?Q?Babi=C4=8Dka?= <babicka.michal@icloud.com>
Cc: linux-pci@vger.kernel.org, linux-thunderbolt@lists.01.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [BUG] Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge
 window / BAR allocation failure prevents NVIDIA and AMD GPUs from
 initializing
Message-ID: <20260317161404.GA89998@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8653B042-F73C-46F4-8D3E-79D9F0CC1250@icloud.com>

[+cc Ilpo]

On Sun, Mar 15, 2026 at 12:35:53PM +0100, Michal Babička wrote:
> Subject: Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window / BAR allocation failure prevents NVIDIA and AMD GPUs from initializing
> 
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

Thanks, I think this is a known issue.  The most useful information
for fixing this would be a dmesg log and output of "sudo lspci -vv"
from the newest available kernel, ideally v6.19 or v7.0-rc.  Please
don't select what appears to be useful, just collect the complete
logs.

I'm pretty sure this isn't a regression, but if it is, please mention
the newest working version and the oldest broken one.

> Problem summary:
> On Apple Mac mini 2018, an external GPU connected through
> Thunderbolt 3 in a Razer Core X Chroma enclosure is detected and
> enumerates on the PCI bus, but GPU initialization fails because PCI
> bridge windows / BAR resources are not assigned correctly.
> 
> This is reproducible across different Linux installations and with
> GPUs from different vendors, which strongly suggests a
> platform/topology-level PCIe resource allocation problem rather than
> a bug in one specific GPU driver.
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
> - and the logs again point to invalid / missing BAR assignments and
>   resource allocation problems behind the Thunderbolt PCIe bridge
>   hierarchy.
> 
> For nouveau, the failure is visible as BAR/resource allocation
> failure as well, for example:
> - "bar: one-time init failed, -12"
> - "init failed with -12"
> - "Device allocation failed: -12"
> 
> With AMD Radeon Vega 64 installed in the same enclosure on the same
> host, the same fundamental problem occurs:
> - the enclosure is detected,
> - the GPU enumerates,
> - initialization fails,
> - and the overall behavior indicates the same lower-level PCI
> resource / bridge window allocation issue.
> 
> This strongly suggests the issue is not NVIDIA-specific.
> 
> Thunderbolt state:
> boltctl reports the Razer Core X Chroma enclosure as
> connected/authorized correctly, for example:
> - type: peripheral
> - generation: Thunderbolt 3
> - status: authorized
> - rx speed: 40 Gb/s
> - tx speed: 40 Gb/s
> 
> Important conclusion:
> Thunderbolt authorization itself appears to work.
> PCI enumeration also works.
> The failure happens later, at PCI resource assignment / bridge
> window sizing / BAR allocation time.
> 
> Key dmesg patterns observed:
> - multiple "can't assign; no space" messages for PCI bridges and BARs
> - BAR1 / BAR3 of the GPU not assigned
> - bridge windows under the Thunderbolt hierarchy not large enough
> - reassignment attempts that still leave required windows unassigned
>   or invalid
> - vendor driver subsequently failing device initialization
> 
> Examples of affected topology in logs:
> - 0000:00:01.1
> - 0000:05:00.0
> - 0000:06:01.0
> - 0000:0b:00.0
> - in other boots, the same problem may appear under a different BDF
>   address after Thunderbolt re-enumeration
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
> - The same failure pattern appears with NVIDIA Quadro P400, NVIDIA
>   Quadro P4000, and AMD Radeon Vega 64.
> - The common denominator is Apple Mac mini 2018 + Thunderbolt PCIe
>   topology under Linux.
> - The failure mode is centered around PCI bridge window sizing / BAR
>   placement, not around one vendor-specific driver alone.
> 
> Expected behavior:
> The Thunderbolt eGPU should receive valid PCI bridge windows and
> valid BAR assignments so that the GPU driver can initialize the
> device successfully.
> 
> Actual behavior:
> The GPU is visible on the bus, but bridge windows and BAR resources
> are not fully assigned, which leaves the device unusable and
> prevents the driver from completing initialization.
> 
> Request:
> Please investigate PCI resource allocation / bridge window sizing
> for Thunderbolt eGPU topologies on Apple Mac mini 2018 under Linux,
> especially where large GPU BARs must be assigned behind multiple
> Thunderbolt / PCIe bridges.
> 
> Cross-vendor reproducibility on the same enclosure and same host
> strongly suggests that the root cause is in PCIe/Thunderbolt
> resource allocation on this platform rather than in a specific
> NVIDIA or AMD driver.
