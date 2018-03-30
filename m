Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:51163 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeC3VoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Mar 2018 17:44:19 -0400
Received: by mail-wm0-f51.google.com with SMTP id l201so17206584wmg.0
        for <linux-pci@vger.kernel.org>; Fri, 30 Mar 2018 14:44:18 -0700 (PDT)
Subject: Re: imx6 : Problem with PCIe switch and intel i110 ethernet cards
To: Fabio Estevam <festevam@gmail.com>,
        "quentin.aebischer@bodet-timesport.com"
        <quentin.aebischer@bodet-timesport.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dbf9ae2a715f4e83b632774546029b24@bodet-timesport.com>
 <CAOMZO5BfUEkZ+SUPrVLG0ismAVt_ft5G_r3Ja-dGjmVKvBekLA@mail.gmail.com>
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <6b2e2eb8-f359-9e96-d433-f1f8d93f7f3c@ncentric.com>
Date: Fri, 30 Mar 2018 23:44:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BfUEkZ+SUPrVLG0ismAVt_ft5G_r3Ja-dGjmVKvBekLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 30-03-18 23:12, Fabio Estevam wrote:
> Hi Quentin,
>
> [Adding more folks to this thread in case they have some suggestions]
>
> On Thu, Mar 29, 2018 at 9:56 AM, quentin.aebischer@bodet-timesport.com
> <quentin.aebischer@bodet-timesport.com> wrote:
>> Hi everyone,
>>
>> This problem might be linked to the following discussion (same switch ?) : https://patchwork.kernel.org/patch/10163363/
> This commit has already reached Linus' tree as commit
> fc110ebdd014dd1368c98e7685b47789c31fab42.
>
>> I'm currently facing a problem with an ASmedia PCIe switch (ASM1184e - 1 to 4 ports) connected to an imx6 based board.
>> Endpoints devices are intel igb 110 ethernet cards.
>> What I see is that a random number of ethernet cards are recognized at boot (from 0 to n connected cards).
>> In the kernel logs, we see that the BAR assignments for the PCIe switch are changing randomly too.
>> I used latest kernel from linus's git repo for testing.
> Is this a regression? Does this problem happen with 4.15.14 or 4.14.31?
>
>> Kernel logs - not working (only 1 ethernet card behind switch detected) :
>>
>> [    0.471337] PCI: OF: host bridge /soc/pcie@1ffc000 ranges:
>> [    0.471462] PCI: OF:    IO 0x01f80000..0x01f8ffff -> 0x00000000
>> [    0.471673] PCI: OF:   MEM 0x01000000..0x01efffff -> 0x01000000
>> [    0.696418] imx6q-pcie 1ffc000.pcie: link up
>> [    0.696470] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
>> [    0.696512] imx6q-pcie 1ffc000.pcie: Link up, Gen1
>> [    0.697402] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
>> [    0.697466] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    0.697514] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> [    0.697558] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
>> [    0.699708] PCI: bus0: Fast back to back transfers disabled
>> [    0.700782] pci 0000:01:00.0: enabling Extended Tags
>> [    0.702818] PCI: bus1: Fast back to back transfers disabled
>> [    0.702888] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.704224] pci 0000:02:01.0: enabling Extended Tags
>> [    0.706516] pci 0000:02:03.0: enabling Extended Tags
>> [    0.708702] pci 0000:02:05.0: enabling Extended Tags
>> [    0.710969] pci 0000:02:07.0: enabling Extended Tags
>> [    0.713151] PCI: bus2: Fast back to back transfers disabled
>> [    0.713216] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.713317] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.713414] pci 0000:02:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.713510] pci 0000:02:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.714213] PCI: bus3: Fast back to back transfers enabled
>> [    0.717967] PCI: bus4: Fast back to back transfers disabled
>> [    0.718704] PCI: bus5: Fast back to back transfers enabled
>> [    0.719446] PCI: bus6: Fast back to back transfers enabled
>> [    0.720060] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
>> [    0.720125] pci 0000:00:00.0: BAR 14: assigned [mem 0x01100000-0x013fffff]
>> [    0.720176] pci 0000:00:00.0: BAR 6: assigned [mem 0x01400000-0x0140ffff pref]
>> [    0.720235] pci 0000:01:00.0: BAR 14: assigned [mem 0x01100000-0x013fffff]
>> [    0.720289] pci 0000:02:03.0: BAR 14: assigned [mem 0x01100000-0x013fffff]
>> [    0.720334] pci 0000:02:01.0: PCI bridge to [bus 03]
>> [    0.720491] pci 0000:04:00.0: BAR 0: assigned [mem 0x01100000-0x011fffff]
>> [    0.720567] pci 0000:04:00.0: BAR 6: assigned [mem 0x01200000-0x012fffff pref]
>> [    0.720614] pci 0000:04:00.0: BAR 3: assigned [mem 0x01300000-0x01303fff]
>> [    0.720684] pci 0000:02:03.0: PCI bridge to [bus 04]
>> [    0.720759] pci 0000:02:03.0:   bridge window [mem 0x01100000-0x013fffff]
>> [    0.720864] pci 0000:02:05.0: PCI bridge to [bus 05]
>> [    0.721000] pci 0000:02:07.0: PCI bridge to [bus 06]
>> [    0.721135] pci 0000:01:00.0: PCI bridge to [bus 02-06]
>> [    0.721207] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x013fffff]
>> [    0.721310] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> [    0.721357] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x013fffff]
>> [    0.723153] pcieport 0000:00:00.0: Signaling PME with IRQ 301
>> [    0.724167] pcieport 0000:00:00.0: AER enabled with IRQ 301
>> [    0.725332] pcieport 0000:01:00.0: enabling device (0140 -> 0142)
>> [    0.729659] pcieport 0000:02:03.0: enabling device (0140 -> 0142)
>>
>> Kernel logs - working (2 ethernet cards behind switch detected) :
>>
>> [    0.471535] PCI: OF: host bridge /soc/pcie@1ffc000 ranges:
>> [    0.471661] PCI: OF:    IO 0x01f80000..0x01f8ffff -> 0x00000000
>> [    0.471873] PCI: OF:   MEM 0x01000000..0x01efffff -> 0x01000000
>> [    0.696635] imx6q-pcie 1ffc000.pcie: link up
>> [    0.696687] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
>> [    0.696728] imx6q-pcie 1ffc000.pcie: Link up, Gen1
>> [    0.697615] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
>> [    0.697677] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    0.697726] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> [    0.697770] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
>> [    0.699909] PCI: bus0: Fast back to back transfers disabled
>> [    0.700990] pci 0000:01:00.0: enabling Extended Tags
>> [    0.703031] PCI: bus1: Fast back to back transfers disabled
>> [    0.703103] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.704443] pci 0000:02:01.0: enabling Extended Tags
>> [    0.706741] pci 0000:02:03.0: enabling Extended Tags
>> [    0.708923] pci 0000:02:05.0: enabling Extended Tags
>> [    0.711197] pci 0000:02:07.0: enabling Extended Tags
>> [    0.713383] PCI: bus2: Fast back to back transfers disabled
>> [    0.713447] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.713549] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.713646] pci 0000:02:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.713741] pci 0000:02:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> [    0.714443] PCI: bus3: Fast back to back transfers enabled
>> [    0.718190] PCI: bus4: Fast back to back transfers disabled
>> [    0.718928] PCI: bus5: Fast back to back transfers enabled
>> [    0.722577] PCI: bus6: Fast back to back transfers disabled
>> [    0.723199] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
>> [    0.723263] pci 0000:00:00.0: BAR 14: assigned [mem 0x01100000-0x016fffff]
>> [    0.723314] pci 0000:00:00.0: BAR 6: assigned [mem 0x01700000-0x0170ffff pref]
>> [    0.723362] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
>> [    0.723424] pci 0000:01:00.0: BAR 14: assigned [mem 0x01100000-0x016fffff]
>> [    0.723468] pci 0000:01:00.0: BAR 13: assigned [io  0x1000-0x1fff]
>> [    0.723529] pci 0000:02:03.0: BAR 14: assigned [mem 0x01100000-0x013fffff]
>> [    0.723573] pci 0000:02:07.0: BAR 14: assigned [mem 0x01400000-0x016fffff]
>> [    0.723617] pci 0000:02:07.0: BAR 13: assigned [io  0x1000-0x1fff]
>> [    0.723662] pci 0000:02:01.0: PCI bridge to [bus 03]
>> [    0.723821] pci 0000:04:00.0: BAR 0: assigned [mem 0x01100000-0x011fffff]
>> [    0.723897] pci 0000:04:00.0: BAR 6: assigned [mem 0x01200000-0x012fffff pref]
>> [    0.723944] pci 0000:04:00.0: BAR 3: assigned [mem 0x01300000-0x01303fff]
>> [    0.724016] pci 0000:02:03.0: PCI bridge to [bus 04]
>> [    0.724090] pci 0000:02:03.0:   bridge window [mem 0x01100000-0x013fffff]
>> [    0.724197] pci 0000:02:05.0: PCI bridge to [bus 05]
>> [    0.724352] pci 0000:06:00.0: BAR 0: assigned [mem 0x01400000-0x014fffff]
>> [    0.724426] pci 0000:06:00.0: BAR 6: assigned [mem 0x01500000-0x015fffff pref]
>> [    0.724472] pci 0000:06:00.0: BAR 3: assigned [mem 0x01600000-0x01603fff]
>> [    0.724544] pci 0000:06:00.0: BAR 2: assigned [io  0x1000-0x101f]
>> [    0.724615] pci 0000:02:07.0: PCI bridge to [bus 06]
>> [    0.724666] pci 0000:02:07.0:   bridge window [io  0x1000-0x1fff]
>> [    0.724738] pci 0000:02:07.0:   bridge window [mem 0x01400000-0x016fffff]
>> [    0.724840] pci 0000:01:00.0: PCI bridge to [bus 02-06]
>> [    0.724889] pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
>> [    0.724961] pci 0000:01:00.0:   bridge window [mem 0x01100000-0x016fffff]
>> [    0.725063] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> [    0.725104] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
>> [    0.725149] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x016fffff]
>> [    0.727070] pcieport 0000:00:00.0: Signaling PME with IRQ 301
>> [    0.728084] pcieport 0000:00:00.0: AER enabled with IRQ 301
>> [    0.729244] pcieport 0000:01:00.0: enabling device (0140 -> 0143)
>> [    0.733422] pcieport 0000:02:03.0: enabling device (0140 -> 0142)
>> [    0.737584] pcieport 0000:02:07.0: enabling device (0140 -> 0143)
>>
>>
>> I must admit I have little to no experience dealing with PCIe driver issues, or even reporting problems on mailing lists for that matter.
>> Hope I didn't make any big mistake reporting this issue !
>>
>>
>> Best regards,
>>
>> Quentin Aebischer

Hi Quentin,

Next to Fabio's questions, in order to get a better overview, could you 
please:

- Provide more details about the used imx6 board and ethernet cards? 
(Vendor, model, ..)


Provide the following info 2 times using this strategy:
- collect it once
- Repower the board (don't use reboot cmd)
- Collect it again.
- Make sure the issue actually happened between the 2 boots.
- Please clearly mark for each log below if they belong to the first or 
second boot.

Logs required:

- Full output of cmd "dmesg"
- output of lspci -tv
- output of lspci -vv


This should provide a nice delta and hopefully some indication.


Thank you,

Koen
