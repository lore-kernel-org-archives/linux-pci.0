Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB983D47D9
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691611; cv=none; b=B8Y3C2HMThRRDysGUS7UpflnTJswbzrY35HCHiU6cTgmTs3l0WViBR9L5+b3qKQPDy6scag20nR0+X9Gx1qalyAdsaniDKRpo2tLrOd3Lea/lxxW/3q/0IQOplB679eXg4BRuOnglC2Z/2fQviIszPdZCUEfO1SNOo6KXhE0ZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691611; c=relaxed/simple;
	bh=y2/o0znR1/by4PO9hbg78+C7tj2CAfM9d7CyLcRPqTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YMTSkWVv5K3tL15JmDYC/KW7K1aCb3lNJzZzcdI4JIh56NnCyjdONs6NAChEXgSJ6n9NPtDKlPVxF0ynaaiifsrVz2ALD9Felx5yaYbGhGgWxbk4uA0SmI+QdNNofXp1mSjNb3Z9fgujlRnmxuiqtrAOK/ZBCNqjUd1U5hYAJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESX55/Sw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESX55/Sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA10C19421;
	Mon, 16 Mar 2026 20:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773691610;
	bh=y2/o0znR1/by4PO9hbg78+C7tj2CAfM9d7CyLcRPqTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ESX55/SwtZVPIsI32GLMc2pdW6cvBpAwjMS88ApifBKTGE85OVNF3Zxw0OtgCCJ6o
	 PiuMw6y6BlP4yhqESIiRjb+Qlwo1xUh/qACSKk8bfOQAC6dUPemkY/ts3FVxgf/RBx
	 ipOo4iV3fRE5QQJGeWGgsMXLkXazN9JgwgY7KRAWno3egg0L7y/uhahOQMk6mTqsC5
	 IujWAdvKCSR0ITVzKfOJQKh1eoQLBvu4+5dgsTPTbR7g7g2HqmC+Vt5+8rG9S4mHYm
	 BlVePPADfO8FK91SGRDh3Jb57vrA5mE0sMEyfkPEi1G45iXuDntTEltgXPSOWxvVtR
	 uvRp/luTxCupQ==
Date: Mon, 16 Mar 2026 15:06:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB controller broken by zero cacheline size in PCIe to PCI
 bridge
Message-ID: <20260316200649.GA14565@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315015406.533684d1.michal.pecio@gmail.com>

On Sun, Mar 15, 2026 at 01:54:06AM +0100, Michal Pecio wrote:
> Hi,
> 
> I have here a PCIe card with PEX8112 PCIe to PCI bridge and uPD720101
> PCI USB controller (OHCI+EHCI) behind the bridge.
> 
> The card works in one machine and gets sluggish and barely functional
> in another one. Hoping for some PCI misconfiguration, I ran lspci -vv
> on both machines for comparison (diff pasted below).

Is there an actual functional problem like data corruption, or is it
purely a performance issue?

> There are surprisingly many differences, so I started to tweak with
> setpci on live system until I got it to work after setting
> CACHE_LINE_SIZE=10 on the bridge. The original value was zero.
> 
> I rebooted and confirmed that this alone is sufficient, and changing
> back to zero immediately breaks the controller again.
> 
> I know nothing about PCI, so I wonder if this result makes sense and
> what may be causing the "bad" system to end up in such sorry state?

The Cache Line Size depends on the CPU, so maybe the good and bad
machines have different CPUs?  Can you collect /proc/cpuinfo for each?

I don't think the Cache Line Size depends on the actual PCI devices,
so the PCI core really should configure it for every bridge and device
during enumeration, but I don't think it does.

In your case, ehci_pci_reinit() might set it for the uPD72010x EHCI
controller, and it looks like Cache Line Size is set to 64 bytes in
both the good and bad systems.

But I don't see any path at all that would configure Cache Line Size
for bridges, so I suspect BIOS configures the PCIe-to-PCI bridge
differently between the machines.

The Cache Line Size configuration (or lack of it) is kind of a
historical mess, and it only applies to conventional PCI, not PCIe, so
I don't really know how to untangle it.

> --- bad
> +++ good
> 
> -07:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa) (prog-if 00 [Normal decode])
> -	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> +02:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa) (prog-if 00 [Normal decode])
> +	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>  	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -	Latency: 0
> -	Interrupt: pin A routed to IRQ 28
> -	IOMMU group: 2
> -	Bus: primary=07, secondary=08, subordinate=08, sec-latency=0
> +	Latency: 0, Cache Line Size: 64 bytes
> +	Interrupt: pin A routed to IRQ 18
> +	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
>  	I/O behind bridge: [disabled] [16-bit]
> -	Memory behind bridge: d0b00000-d0bfffff [size=1M] [32-bit]
> +	Memory behind bridge: fe900000-fe9fffff [size=1M] [32-bit]
>  	Prefetchable memory behind bridge: [disabled] [32-bit]
>  	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> -	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
> +	BridgeCtl: Parity+ SERR+ NoISA+ VGA- VGA16- MAbort- >Reset- FastB2B-
>  		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>  	Capabilities: [40] Power Management version 2
>  		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
>  		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>  	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>  		Address: 0000000000000000  Data: 0000
>  	Capabilities: [60] Express (v1) PCI-Express to PCI/PCI-X Bridge, IntMsgNum 0
>  		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> -			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- SlotPowerLimit 0W TEE-IO-
> +			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- SlotPowerLimit 25W TEE-IO-
>  		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
>  			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
>  			MaxPayload 128 bytes, MaxReadReq 512 bytes
>  		DevSta:	CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr- TransPend-
>  		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
>  			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> -		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
> +		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
>  			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>  		LnkSta:	Speed 2.5GT/s, Width x1
>  			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
>  	Capabilities: [100 v1] Power Budgeting <?>
>  
> -08:00.0 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
> +03:00.0 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
>  	Subsystem: NEC Corporation USB Controller
>  	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>  	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -	Latency: 64 (250ns min, 10500ns max)
> -	Interrupt: pin A routed to IRQ 28
> -	IOMMU group: 2
> -	Region 0: Memory at d0b02000 (32-bit, non-prefetchable) [size=4K]
> +	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 64 bytes
> +	Interrupt: pin A routed to IRQ 18
> +	Region 0: Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
>  	Capabilities: [40] Power Management version 2
>  		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
>  		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>  	Kernel driver in use: ohci-pci
>  	Kernel modules: ohci_pci
>  
> -08:00.1 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
> +03:00.1 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
>  	Subsystem: NEC Corporation USB Controller
>  	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>  	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -	Latency: 64 (250ns min, 10500ns max)
> -	Interrupt: pin B routed to IRQ 55
> -	IOMMU group: 2
> -	Region 0: Memory at d0b01000 (32-bit, non-prefetchable) [size=4K]
> +	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 64 bytes
> +	Interrupt: pin B routed to IRQ 19
> +	Region 0: Memory at fe9fe000 (32-bit, non-prefetchable) [size=4K]
>  	Capabilities: [40] Power Management version 2
>  		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
>  		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>  	Kernel driver in use: ohci-pci
>  	Kernel modules: ohci_pci
>  
> -08:00.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04) (prog-if 20 [EHCI])
> +03:00.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04) (prog-if 20 [EHCI])
>  	Subsystem: NEC Corporation uPD72010x USB 2.0 Controller
>  	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>  	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -	Latency: 68 (4000ns min, 8500ns max), Cache Line Size: 64 bytes
> -	Interrupt: pin C routed to IRQ 44
> -	IOMMU group: 2
> -	Region 0: Memory at d0b00000 (32-bit, non-prefetchable) [size=256]
> +	Latency: 64 (4000ns min, 8500ns max), Cache Line Size: 64 bytes
> +	Interrupt: pin C routed to IRQ 16
> +	Region 0: Memory at fe9fdc00 (32-bit, non-prefetchable) [size=256]
>  	Capabilities: [40] Power Management version 2
>  		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
>  		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
>  	Kernel driver in use: ehci-pci
>  	Kernel modules: ehci_pci
