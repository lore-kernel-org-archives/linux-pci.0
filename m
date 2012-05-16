Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:32795 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965833Ab2EPU2C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 May 2012 16:28:02 -0400
Received: by dady13 with SMTP id y13so1462636dad.19
        for <linux-pci@vger.kernel.org>; Wed, 16 May 2012 13:28:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1337197170.68237.YahooMailNeo@web160304.mail.bf1.yahoo.com>
References: <1337136686.80168.YahooMailNeo@web160302.mail.bf1.yahoo.com>
	<CAE9FiQWK0Ur+dnQmJ4D_Zve+Bcqxt2u+R=Qp6s39vJCZJfhRqg@mail.gmail.com>
	<1337197170.68237.YahooMailNeo@web160304.mail.bf1.yahoo.com>
Date: Wed, 16 May 2012 13:28:02 -0700
Message-ID: <CAE9FiQU-aCZokS7V_77cpNMN-jK=WEekSJX3F4vnv8ZSEuv4Ow@mail.gmail.com>
Subject: Re: Hotplug Debugging
From: Yinghai Lu <yinghai@kernel.org>
To: LinuxDrvDev <ushmasonal-linuxmail@yahoo.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 16, 2012 at 12:39 PM, LinuxDrvDev
<ushmasonal-linuxmail@yahoo.com> wrote:
>
>
> Thanks Yinghai. It looks like the slot I was using  didn't supported the Hotplug. However, then I moved to another slot which did supported Hotplug+ but didn't supported surprise- removal.  Here is the tree of my devices.
>
> -[0000:00]-+-00.0
>            +-02.0-[01]--+-00.0
>            |            \-00.1
>            +-04.0-[02]----00.0
>            +-09.0-[03]----00.0
>            +-11.0
>            +-12.0
>            +-12.2
>            +-13.0
>            +-13.2
>            +-14.0
>            +-14.1
>            +-14.2
>            +-14.3
>            +-14.4-[04]--
>            +-14.5
>            +-15.0-[05]--+-00.0
>            |            \-00.1
>            +-16.0
>            +-16.2
>            +-18.0
>            +-18.1
>            +-18.2
>            +-18.3
>            \-18.4
>
> Here is the info on the slot  -
>
> 00:15.0 PCI bridge: ATI Technologies Inc SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0) (prog-if 00 [Normal decode])
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> ---
>     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> ----
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise-
>             Slot #  0, PowerLimit 0.000000; Interlock- NoCompl+

interesting. No attention button and not support surprise removal.


>         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>             Changed: MRL- PresDet+ LinkState+
>
> Now if I first remove the device from the kernel by issuing
>
>
> "echo 1 > /sys/devices/pci0000:\00/0000\:00\:15.0"
>
> I see the device being removed from the kernel. lspci output shows that device no longer existed.  Then I physically pull out the device from the slot, and then reinsert the device to the same slot and I issue
>
> "echo 1 > /sys/bus/pci/rescan"
>
> I only see the bridge device being rescanned but don't see my SATA controller being recognized. ie. devices on secondary side of bus 15 does not appear in lspci output.

can you post whole log with "debug ignore_loglevel pciehp.pciehp_debug=1" ?

>
> I also tried "resetting secondary bus" using the bridge control register but of no avail.

may need to reset the pcie-link?

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=afa42ff2f3987f57ee2523f07af5ec9a7c9132be


Yinghai
