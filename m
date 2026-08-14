Received: from smtp-outbound9.duck.com (smtp-outbound9.duck.com [20.67.221.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A324343D72
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.67.221.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786680636; cv=none; b=Tqp+B+4t0a5276Uw0WnJBO+7elGz6JEcxNVTLOT2g4FbYKxijR0w0xTbxsF+OveeN+f4t1IGWui2c3B92P0yfSsmfo5hn5sVUjGZDfoYBLdnpphba83xoYNXhjg6TwdlsnHv5tlxt0cT/mmvgLFr7jGbwhvvOTatNLCjADKx1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786680636; c=relaxed/simple;
	bh=1gzmiElDAqk1OTq0jV+LM8rF9/igys3uXNKhgxDHKe4=;
	h=MIME-Version:Subject:Content-Type:To:Message-ID:Date:From; b=iZvramWg5dfoq2+1/0sHvV9UjHmEVThvInC5eHxakpPJsfAyekTb0CG6UGQSZplFQYugQ++yPL49pmj6pks740CGntLuZ4EFz39mGOsIfhTtbWHjiFJak3ZxWBvjNoPTsiQwYGzmURDhJRmR0tyVeYxRAjfwbGIa9dQhtSVC6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com; spf=pass smtp.mailfrom=duck.com; dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b=F1v/UP4m; arc=none smtp.client-ip=20.67.221.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duck.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b="F1v/UP4m"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: vmd: BUS_RESTRICT_CFG encoding 3 rejected, no NVMe on MSI Raider 16
 Max HX B2WJ (8086:ad0b)
Content-Type: text/plain;
	charset="UTF-8"
X-Rspamd-Bar: --
X-Rspamd-Report: DMARC_POLICY_ALLOW(-0.5) R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2) ARC_ALLOW(-1)
X-Rspamd-Score: -2
X-Rspamd-Action: no action
To: linux-pci@vger.kernel.org
Received: by smtp-inbound1.duck.com; Fri, 14 Aug 2026 00:10:33 -0400
Message-ID: <8C83D634-B55C-466C-86C1-EADA91FF008E.1@smtp-inbound1.duck.com>
Date: Fri, 14 Aug 2026 00:10:33 -0400
From: kohmenghui@duck.com
Feedback-ID: :isSendReply:isDirect:duckcom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com;
 h=Feedback-ID: From: Date: Message-ID: To: Content-Type: Subject:
 MIME-Version; q=dns/txt; s=postal-KpyQVw; t=1786680633;
 bh=dR9QQpd8hciS9IgSou5tRv44aWz2Rv+uG+uDF0su+Ss=;
 b=F1v/UP4mc2PzU6Wi41eVLGGF5YuqsSAvCvlmHjWQeXkCur2eRXIEQuZHHoE4bQcUnJC3pbgAu
 EKqxwN3y15h61pm7VFcWbqY0gF8pEylwbIirO97DJE8vSt6ir0nmxxevtX2ZLTG2TskrVuKIxO5
 zp9yI0NhmgTr/+jpBLFzKLM=

Hi,

AI assisted report below. I could not install ubuntu 22.04.5 because
there were no detected NVMe drives and I couldn't disable VMD / Intel
RST in the bios.

On this laptop the VMD driver refuses to probe because the controller
reports a BUS_RESTRICT_CFG encoding of 3, which vmd.c does not handle:

    vmd 0000:00:0e.0: Unknown Bus Offset Setting (3)

The result is that no NVMe device is visible at all, including the boot
drive, so the machine cannot install or boot any Linux distribution as
shipped. The firmware has no option to disable VMD / Intel RST.

Hardware
--------
System vendor : Micro-Star International Co., Ltd.
Product name  : Raider 16 Max HX B2WJ
Board         : MS-2651
BIOS          : American Megatrends International, LLC. E2651IMS.110
(05/21/2026)
CPU           : Intel(R) Core(TM) Ultra 9 275HX
Kernel        : 6.8.0-136-generic #136~22.04.1-Ubuntu SMP
PREEMPT_DYNAMIC Fri Jul  3 16:29:11 UTC
Distribution  : Ubuntu 22.04.5 LTS

VMD controller
--------------
0000:00:0e.0 RAID bus controller [0104]: Intel Corporation Device [8086:ad0b]

PCI_REG_VMCAP    (0x40) : 00000001
PCI_REG_VMCONFIG (0x44) : 02b42f01
PCI_REG_VMLOCK   (0x70) : 00000000

Workaround and what it produces
-------------------------------
Adding a case 3 to the switch in vmd_get_bus_number_start() that sets
busn_start = 224 makes the controller probe and both NVMe devices appear.
The system has been running normally on this since, including as the root
filesystem, across kernel updates via DKMS.

With that change applied:

    vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
    vmd 0000:00:0e.0: Bound to PCI domain 10000

    10000:e2:00.0 Non-Volatile memory controller [0108]: Samsung
Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO [144d:a80a]
    10000:e3:00.0 Non-Volatile memory controller [0108]: Samsung
Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO [144d:a80a]

The child devices enumerate at bus 0xe2 and 0xe3, i.e. immediately above
the 0xe0 (224) base, which suggests 224 is the correct base rather than a
value that merely happens to work.

Questions
---------
1. I do not know what encoding 3 is actually defined to mean. Encoding 2
   already maps to 224, so mapping 3 to the same value is an empirical
   result, not something I can justify from the spec. Could someone from
   Intel confirm the correct busn_start for encoding 3?

2. Is this related to the second root bus work in the current series
   "PCI: vmd: Add support for second rootbus under VMD" (v6, 2026-08-06)?
   If encoding 3 signals a second root bus rather than a different single
   base, the correct handling is presumably different from what I did.

Full lspci -nnvv for the VMD controller
---------------------------------------
0000:00:0e.0 RAID bus controller [0104]: Intel Corporation Device [8086:ad0b]
DeviceName: Onboard - Other
Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:14fb]
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
IOMMU group: 10
Region 0: Memory at b830000000 (64-bit, non-prefetchable) [size=32M]
Region 2: Memory at 92000000 (32-bit, non-prefetchable) [size=16M]
Region 4: Memory at b832000000 (64-bit, non-prefetchable) [size=16M]
Capabilities: [80] MSI-X: Enable+ Count=32 Masked-
Vector table: BAR=4 offset=00000000
PBA: BAR=4 offset=00001000
Capabilities: [90] Express (v2) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE- FLReset-
DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
FRS-
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
AtomicOpsCtl: ReqEn-
Capabilities: [e0] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: vmd
Kernel modules: vmd
