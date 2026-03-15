Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E7286A9
	for <linux-pci@vger.kernel.org>; Sun, 15 Mar 2026 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773536054; cv=none; b=g5DeAIBWQPekMhESSfLL2x5FFan/LLIirBrdYStuRT0r3Yzl6RyngmVRhbRID3cwUUwkx4qaPxRN82XkToVuFargZqrilh8w28eOBpWnA6FvM4CVx37nEZPX1KR+Scf5PFBuPlyk/25AHDWWOrltRG02KkYXeIDwrzZI9KGITaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773536054; c=relaxed/simple;
	bh=EbJfoGizSDqnToWG5pqJ4vK5GpJKC7funQjd8qKdPsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=M3fU+q/4ob2OJ9y2PH8fqnFGSQZy550ssX7bfvwtDijbkPGH/q+nZz5wX8y2b3BulKOiQS6x22G6GBAFnUef2bHeO3chorl4D9bIDjSFHB6t/Fd6DFWex+tlxHr3r0Tp+WqGlB5f7YdhifprvqzyBK/7H4G3mrXxiKhsZqBVWtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhJKHx5c; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhJKHx5c"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b941762394aso419211066b.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773536051; x=1774140851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8IPBmLzpHl1fBgoj067M6aZlp8V7A3p5efisTtSM1g=;
        b=LhJKHx5c2AzjVwvP1FXMLoDuJ0a4CdKZdY+pptf9+5dR0QcjwP2v6glMdO3Ti05ni2
         qtjAFXLLk/Htx6Nxa3+iya76h012+Z98G9t1SJslK4BbNQAuRkinee1WSqZ9XJd7OfyV
         swfB2VTghyetNd6J7N8q5h0p6F3KLXr64zrDudcVvZMNPqH6vJqgTeHY/YquUWlT+bev
         tg5fT+XpQPC75OAEic0M/q1yuMSC6H1heZCXO4z4sSUCrbY1cdXvMTGNiBfM0TjRi9O1
         YA/LXlwUexAtKPURe37TYFKdJSMERgATHzY+b4J7dCu40XEB0U7xti3wBLVTYsiDs1vq
         bkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773536051; x=1774140851;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8IPBmLzpHl1fBgoj067M6aZlp8V7A3p5efisTtSM1g=;
        b=fHnGXYB/t2dKRQ30cYkXv/txmrcC+H3RcEHMZ34MTHV0Ap7yLpHI7ham/4o9WddJwX
         qYcrNbtcbB9C1ooxkuJdvttETaNB6y94Dw8QUj5o3fP4tyrlcnl9c962DeIJSeK2HNC/
         PUGnJeRgbF5ag9swYYCdzYOc2nRoAJFPHQQ7cLBkc5/UnDRzeQE5x4yGRFF111ZjBa50
         7V6c6peg/ZGFwid4idr1wbJjRDUKQcFXzEdGAknocnhsvZqnwuMP8t+ZhCIyZzM38xui
         Ll+VHQcfWAKyy1/wTRZsLLwxWhfAq8bmPLMUuHdpJUK8Rl7d2qkgjwdjy6jeZQRfAtJA
         QPVg==
X-Gm-Message-State: AOJu0YwLqKy4QBrP9zWcXLHMb31hUjMjQFKSNBRrTe0zab9HZe99aWfu
	NCxzNELAMyKq21Nrj3+ozaG+V/9VPzkNHuUKqiZ4cX0nZW1ApQ+fj1i+t3MOhw==
X-Gm-Gg: ATEYQzx061HPQINVqxvf7n7XYalnePVRPzd8s6qH8GpZxpDwwdm0phdE9EttE8GToEP
	HWTFqwKk1opwe0C877dlQBdHu8bPYTIGbWil1RkBWSnw9xXFndmAaoxW69pZ2AJ+HKdhTFDcDYO
	T1Q23+D4VmyEf4jH0mxjkMnLn93eumak3buvxdu4y2K3z1Fo2K6eRuJY4YSaIpmlRVkT+/Wkm7B
	t2y6Me7GAwMjj4/9ACWSHKmFVI22BLM80+zYK2qMBvOkym8PY/YXtQ2LCdbNORNGzJRT3iaTj1i
	zRB04wkzsU+4Ow+VwUQZNzkkRGqFU587dlU7yIv5SgrYJ9K1ie3/rBUALsC4j4VlfP53NdNR3It
	X1xNU4WkHn32XPVcSaunBK7/CUzWXU52NxsvdmX2mJxMstlsQhdpq4c1iMbjFDBzKyPSN23OqPf
	M2V4pVZcfUWjJAd/dgGZ1rLBJEtDT6HFkvkrI=
X-Received: by 2002:a17:907:3d87:b0:b73:4d06:bc8 with SMTP id a640c23a62f3a-b97651e70ebmr452909766b.53.1773536051022;
        Sat, 14 Mar 2026 17:54:11 -0700 (PDT)
Received: from foxbook (bfk214.neoplus.adsl.tpnet.pl. [83.28.48.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97846174cfsm236954366b.22.2026.03.14.17.54.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 14 Mar 2026 17:54:10 -0700 (PDT)
Date: Sun, 15 Mar 2026 01:54:06 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Subject: USB controller broken by zero cacheline size in PCIe to PCI bridge
Message-ID: <20260315015406.533684d1.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I have here a PCIe card with PEX8112 PCIe to PCI bridge and uPD720101
PCI USB controller (OHCI+EHCI) behind the bridge.

The card works in one machine and gets sluggish and barely functional
in another one. Hoping for some PCI misconfiguration, I ran lspci -vv
on both machines for comparison (diff pasted below).

There are surprisingly many differences, so I started to tweak with
setpci on live system until I got it to work after setting
CACHE_LINE_SIZE=10 on the bridge. The original value was zero.

I rebooted and confirmed that this alone is sufficient, and changing
back to zero immediately breaks the controller again.

I know nothing about PCI, so I wonder if this result makes sense and
what may be causing the "bad" system to end up in such sorry state?

Thanks,
Michal


--- bad
+++ good

-07:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa) (prog-if 00 [Normal decode])
-	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
+02:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa) (prog-if 00 [Normal decode])
+	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 0
-	Interrupt: pin A routed to IRQ 28
-	IOMMU group: 2
-	Bus: primary=07, secondary=08, subordinate=08, sec-latency=0
+	Latency: 0, Cache Line Size: 64 bytes
+	Interrupt: pin A routed to IRQ 18
+	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
 	I/O behind bridge: [disabled] [16-bit]
-	Memory behind bridge: d0b00000-d0bfffff [size=1M] [32-bit]
+	Memory behind bridge: fe900000-fe9fffff [size=1M] [32-bit]
 	Prefetchable memory behind bridge: [disabled] [32-bit]
 	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
-	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
+	BridgeCtl: Parity+ SERR+ NoISA+ VGA- VGA16- MAbort- >Reset- FastB2B-
 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 	Capabilities: [40] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [60] Express (v1) PCI-Express to PCI/PCI-X Bridge, IntMsgNum 0
 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
-			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- SlotPowerLimit 0W TEE-IO-
+			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- SlotPowerLimit 25W TEE-IO-
 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
 			MaxPayload 128 bytes, MaxReadReq 512 bytes
 		DevSta:	CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr- TransPend-
 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <16us
 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
-		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
+		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 		LnkSta:	Speed 2.5GT/s, Width x1
 			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
 	Capabilities: [100 v1] Power Budgeting <?>
 
-08:00.0 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
+03:00.0 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
 	Subsystem: NEC Corporation USB Controller
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 64 (250ns min, 10500ns max)
-	Interrupt: pin A routed to IRQ 28
-	IOMMU group: 2
-	Region 0: Memory at d0b02000 (32-bit, non-prefetchable) [size=4K]
+	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 64 bytes
+	Interrupt: pin A routed to IRQ 18
+	Region 0: Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: [40] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Kernel driver in use: ohci-pci
 	Kernel modules: ohci_pci
 
-08:00.1 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
+03:00.1 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
 	Subsystem: NEC Corporation USB Controller
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 64 (250ns min, 10500ns max)
-	Interrupt: pin B routed to IRQ 55
-	IOMMU group: 2
-	Region 0: Memory at d0b01000 (32-bit, non-prefetchable) [size=4K]
+	Latency: 64 (250ns min, 10500ns max), Cache Line Size: 64 bytes
+	Interrupt: pin B routed to IRQ 19
+	Region 0: Memory at fe9fe000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: [40] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
 	Kernel driver in use: ohci-pci
 	Kernel modules: ohci_pci
 
-08:00.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04) (prog-if 20 [EHCI])
+03:00.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04) (prog-if 20 [EHCI])
 	Subsystem: NEC Corporation uPD72010x USB 2.0 Controller
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-	Latency: 68 (4000ns min, 8500ns max), Cache Line Size: 64 bytes
-	Interrupt: pin C routed to IRQ 44
-	IOMMU group: 2
-	Region 0: Memory at d0b00000 (32-bit, non-prefetchable) [size=256]
+	Latency: 64 (4000ns min, 8500ns max), Cache Line Size: 64 bytes
+	Interrupt: pin C routed to IRQ 16
+	Region 0: Memory at fe9fdc00 (32-bit, non-prefetchable) [size=256]
 	Capabilities: [40] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
 	Kernel driver in use: ehci-pci
 	Kernel modules: ehci_pci
