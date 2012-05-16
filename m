Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34929 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759223Ab2EPHUs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 May 2012 03:20:48 -0400
Received: by dady13 with SMTP id y13so598984dad.19
        for <linux-pci@vger.kernel.org>; Wed, 16 May 2012 00:20:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1337136686.80168.YahooMailNeo@web160302.mail.bf1.yahoo.com>
References: <1337136686.80168.YahooMailNeo@web160302.mail.bf1.yahoo.com>
Date: Wed, 16 May 2012 00:20:47 -0700
Message-ID: <CAE9FiQWK0Ur+dnQmJ4D_Zve+Bcqxt2u+R=Qp6s39vJCZJfhRqg@mail.gmail.com>
Subject: Re: Hotplug Debugging
From: Yinghai Lu <yinghai@kernel.org>
To: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 15, 2012 at 7:51 PM, LinuxDrvDev
<ushmasonal-linuxmail@yahoo.com> wrote:
> Hi,
> 2. The lspci -vv output of the root port and the device shows that "ASPM  disabled". Is this the indication that it doesn't support hotplug?

should have slot cap in lspci reporting like

00:1c.3 PCI bridge: Intel Corporation 6 Series Chipset Family PCI
Express Root Port 4 (rev b4) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=0c, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f1c00000-f23fffff
	Prefetchable memory behind bridge: 00000000f0400000-00000000f0bfffff
...
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
...
