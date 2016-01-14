Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta23.ai270.net ([94.126.44.34]:39918 "EHLO
	out-mta22.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161000AbcANXOI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2016 18:14:08 -0500
Received: from [94.126.40.188] (helo=outscan2.ai270.net)
	by out-mta22.ai270.net with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <lists@keynet-technology.com>)
	id 1aJpqo-0007SN-6b
	for linux-pci@vger.kernel.org; Thu, 14 Jan 2016 21:54:38 +0000
Received: from mail.lcn.com (mail.lcn.com [94.126.40.131])
	by outscan2.ai270.net (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id u0ELsb3O016976
	for <linux-pci@vger.kernel.org>; Thu, 14 Jan 2016 21:54:37 GMT
Received: from 175.141.112.87.dyn.plus.net ([87.112.141.175] helo=ha-server.lan)
	by mail.lcn.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <lists@keynet-technology.com>)
	id 1aJpqn-0001UH-0f
	for linux-pci@vger.kernel.org; Thu, 14 Jan 2016 21:54:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by ha-server.lan (Postfix) with ESMTP id A2CB480DEA5B
	for <linux-pci@vger.kernel.org>; Thu, 14 Jan 2016 21:54:36 +0000 (GMT)
Received: from ha-server.lan ([127.0.0.1])
	by localhost (ha-server.lan [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zPsOFkK6rW5e for <linux-pci@vger.kernel.org>;
	Thu, 14 Jan 2016 21:54:35 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by ha-server.lan (Postfix) with ESMTP id 65D1F80DEA76
	for <linux-pci@vger.kernel.org>; Thu, 14 Jan 2016 21:54:35 +0000 (GMT)
Received: from ha-server.lan ([127.0.0.1])
	by localhost (ha-server.lan [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lsWcfTFp7knC for <linux-pci@vger.kernel.org>;
	Thu, 14 Jan 2016 21:54:35 +0000 (GMT)
Received: from [10.0.0.1] (CORE-I5.lan [10.0.0.1])
	by ha-server.lan (Postfix) with ESMTP id 4ADB580DEA5B
	for <linux-pci@vger.kernel.org>; Thu, 14 Jan 2016 21:54:35 +0000 (GMT)
From: Richard F <lists@keynet-technology.com>
Subject: Hint HB6 - kernel doesn't see chips behind it.
To: linux-pci@vger.kernel.org
Message-ID: <5698191B.1070904@keynet-technology.com>
Date: Thu, 14 Jan 2016 21:54:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello

I moved a Kodicom card (http://linuxtv.org/wiki/index.php/Kodicom_4400R)
from an older machine to a new with a PCIe bridge.  Bttv modprobe can no
longer find the BT878 chips behind the PCI bridge, though the bridge is
found.

The bridge is a PCI6140 AKA "Hint HB6".
I noticed a PCI quirk for it, tried manually adding the IO/memory spaces
that were originally logged, but doesn't help.

This machine runs kernel 3.12.52 (x64), but it also fails on 3.0.76.
The BT878 chips were recognised on the older machine also running 3.0.76
but with a vanilla PCI bus.

Relevant dmesg lines when not working (can post entire logs if helpful)

[    0.089046] pci 0000:00:1c.2: scanning [bus 03-05] behind bridge, pass 0
[    0.089105] pci_bus 0000:03: scanning bus
[    0.089136] pci 0000:03:00.0: [1283:8893] type 01 class 0x060401
[    0.089335] pci 0000:03:00.0: supports D1 D2
[    0.089336] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.089343] pci 0000:03:00.0: PME# disabled
[    0.089382] pci_bus 0000:03: fixups for bus
[    0.089383] pci 0000:00:1c.2: PCI bridge to [bus 03-05]
[    0.089397] pci 0000:03:00.0: scanning [bus 04-05] behind bridge, pass 0
[    0.089487] pci_bus 0000:04: scanning bus
[    0.089523] pci 0000:04:01.0: [3388:0021] type 01 class 0x060400
[    0.089729] pci 0000:04:01.0: supports D1 D2
[    0.089730] pci 0000:04:01.0: PME# supported from D1 D2 D3hot D3cold
[    0.089738] pci 0000:04:01.0: PME# disabled
[    0.089871] pci_bus 0000:04: fixups for bus
[    0.089872] pci 0000:03:00.0: PCI bridge to [bus 04-05] (subtractive decode)
[    0.089906] pci 0000:03:00.0:   bridge window [??? 0x00000000 flags 0x0] (subtractive decode)
[    0.089907] pci 0000:03:00.0:   bridge window [??? 0x00000000 flags 0x0] (subtractive decode)
[    0.089908] pci 0000:03:00.0:   bridge window [??? 0x00000000 flags 0x0] (subtractive decode)
[    0.089910] pci 0000:03:00.0:   bridge window [??? 0x00000000 flags 0x0] (subtractive decode)
[    0.089914] pci 0000:04:01.0: scanning [bus 05-05] behind bridge, pass 0
[    0.090011] pci_bus 0000:05: scanning bus
[    0.090116] pci_bus 0000:05: fixups for bus
[    0.090117] pci 0000:04:01.0: PCI bridge to [bus 05]
[    0.090139] pci_bus 0000:05: bus scan returning with max=05
[    0.090148] pci 0000:04:01.0: scanning [bus 05-05] behind bridge, pass 1
[    0.090159] pci_bus 0000:04: bus scan returning with max=05
[    0.090167] pci 0000:03:00.0: scanning [bus 04-05] behind bridge, pass 1
[    0.090177] pci_bus 0000:03: bus scan returning with max=05
[    0.090181] pci 0000:00:1c.0: scanning [bus 01-01] behind bridge, pass 1
[    0.090187] pci 0000:00:1c.1: scanning [bus 02-02] behind bridge, pass 1
[    0.090193] pci 0000:00:1c.2: scanning [bus 03-05] behind bridge, pass 1
[    0.090197] pci_bus 0000:00: bus scan returning with max=05

Working - in older machine

[    0.203039] pci 0000:04:00.0: [1409:7268] type 0 class 0x000701
[    0.203055] pci 0000:04:00.0: reg 10: [io  0xef00-0xef07]
[    0.203066] pci 0000:04:00.0: reg 14: [io  0xee00-0xee07]
[    0.203139] pci 0000:04:01.0: [3388:0021] type 1 class 0x000604
[    0.203219] pci 0000:04:01.0: supports D1 D2
[    0.203222] pci 0000:04:01.0: PME# supported from D1 D2 D3hot D3cold
[    0.203227] pci 0000:04:01.0: PME# disabled
[    0.203257] pci 0000:04:04.0: [1106:3044] type 0 class 0x000c00
[    0.203277] pci 0000:04:04.0: reg 10: [mem 0xfd8ff000-0xfd8ff7ff]
[    0.203289] pci 0000:04:04.0: reg 14: [io  0xed00-0xed7f]
[    0.203365] pci 0000:04:04.0: supports D2
[    0.203367] pci 0000:04:04.0: PME# supported from D2 D3hot D3cold
[    0.203372] pci 0000:04:04.0: PME# disabled
[    0.203416] pci 0000:00:1e.0: PCI bridge to [bus 04-05] (subtractive decode)
[    0.203423] pci 0000:00:1e.0:   bridge window [io  0xd000-0xefff]
[    0.203428] pci 0000:00:1e.0:   bridge window [mem 0xfd700000-0xfd8fffff]
[    0.203435] pci 0000:00:1e.0:   bridge window [mem 0xfd600000-0xfd6fffff 64bit pref]
[    0.203438] pci 0000:00:1e.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.203441] pci 0000:00:1e.0:   bridge window [mem 0x00000000-0xfffffffff] (subtractive decode)
[    0.203520] pci 0000:05:0c.0: [109e:036e] type 0 class 0x000400
[    0.203546] pci 0000:05:0c.0: reg 10: [mem 0xfd6ff000-0xfd6fffff pref]
[    0.203690] pci 0000:05:0c.1: [109e:0878] type 0 class 0x000480
[    0.203717] pci 0000:05:0c.1: reg 10: [mem 0xfd6fe000-0xfd6fefff pref]
[    0.203871] pci 0000:05:0d.0: [109e:036e] type 0 class 0x000400
[    0.203898] pci 0000:05:0d.0: reg 10: [mem 0xfd6fd000-0xfd6fdfff pref]
[    0.204041] pci 0000:05:0d.1: [109e:0878] type 0 class 0x000480
[    0.204067] pci 0000:05:0d.1: reg 10: [mem 0xfd6fc000-0xfd6fcfff pref]
[    0.204222] pci 0000:05:0e.0: [109e:036e] type 0 class 0x000400
[    0.204249] pci 0000:05:0e.0: reg 10: [mem 0xfd6fb000-0xfd6fbfff pref]
[    0.204392] pci 0000:05:0e.1: [109e:0878] type 0 class 0x000480
[    0.204419] pci 0000:05:0e.1: reg 10: [mem 0xfd6fa000-0xfd6fafff pref]
[    0.204572] pci 0000:05:0f.0: [109e:036e] type 0 class 0x000400
[    0.204599] pci 0000:05:0f.0: reg 10: [mem 0xfd6f9000-0xfd6f9fff pref]
[    0.204741] pci 0000:05:0f.1: [109e:0878] type 0 class 0x000480
[    0.204768] pci 0000:05:0f.1: reg 10: [mem 0xfd6f8000-0xfd6f8fff pref]
[    0.204933] pci 0000:04:01.0: PCI bridge to [bus 05-05]
[    0.204939] pci 0000:04:01.0:   bridge window [io  0xd000-0xdfff]
[    0.204945] pci 0000:04:01.0:   bridge window [mem 0xfd700000-0xfd7fffff]
[    0.204950] pci 0000:04:01.0:   bridge window [mem 0xfd600000-0xfd6fffff pref]


lspci -vvv (NOT working)

04:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 11) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Bus: primary=04, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
        Capabilities: [90] CompactPCI hot-swap <?>

lspci -vvv (working)

04:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fd700000-fd7fffff
	Prefetchable memory behind bridge: fd600000-fd6fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [90] CompactPCI hot-swap <?>
	Kernel modules: shpchp
 

Thanks for any help / guidance on debugging


