Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm9.bullet.mail.bf1.yahoo.com ([98.139.212.168]:44880 "HELO
	nm9.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760559Ab2EPTjd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 May 2012 15:39:33 -0400
References: <1337136686.80168.YahooMailNeo@web160302.mail.bf1.yahoo.com> <CAE9FiQWK0Ur+dnQmJ4D_Zve+Bcqxt2u+R=Qp6s39vJCZJfhRqg@mail.gmail.com> 
Message-ID: <1337197170.68237.YahooMailNeo@web160304.mail.bf1.yahoo.com>
Date: Wed, 16 May 2012 12:39:30 -0700 (PDT)
From: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Reply-To: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Subject: Re: Hotplug Debugging
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Thanks Yinghai. It looks like the slot I was using  didn't supported the Hotplug. However, then I moved to another slot which did supported Hotplug+ but didn't supported surprise- removal.  Here is the tree of my devices. 

-[0000:00]-+-00.0
           +-02.0-[01]--+-00.0
           |            \-00.1
           +-04.0-[02]----00.0
           +-09.0-[03]----00.0
           +-11.0
           +-12.0
           +-12.2
           +-13.0
           +-13.2
           +-14.0
           +-14.1
           +-14.2
           +-14.3
           +-14.4-[04]--
           +-14.5
           +-15.0-[05]--+-00.0
           |            \-00.1
           +-16.0
           +-16.2
           +-18.0
           +-18.1
           +-18.2
           +-18.3
           \-18.4

Here is the info on the slot  - 

00:15.0 PCI bridge: ATI Technologies Inc SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
---
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
----
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise-
            Slot #  0, PowerLimit 0.000000; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet+ LinkState+

Now if I first remove the device from the kernel by issuing 


"echo 1 > /sys/devices/pci0000:\00/0000\:00\:15.0" 

I see the device being removed from the kernel. lspci output shows that device no longer existed.  Then I physically pull out the device from the slot, and then reinsert the device to the same slot and I issue 

"echo 1 > /sys/bus/pci/rescan" 

I only see the bridge device being rescanned but don't see my SATA controller being recognized. ie. devices on secondary side of bus 15 does not appear in lspci output.

I also tried "resetting secondary bus" using the bridge control register but of no avail. 


Any ideas?

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
