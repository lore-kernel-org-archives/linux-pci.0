Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.120]:36695 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756610Ab3IDIKH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2013 04:10:07 -0400
Date: Wed, 4 Sep 2013 10:10:23 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Yinghai Lu <yinghai@kernel.org>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI reset problem
Message-ID: <20130904081023.GA25982@jtlinux>
References: <20130829082941.GA11203@jtlinux>
 <CAErSpo56RszdMQDOY8xCmz=1QP-osUGA71V56t9X9zY4rNAYew@mail.gmail.com>
 <20130829150723.GA32730@jtlinux>
 <CAErSpo5nTy7bkU2_ZMR_sROz-FJF28a==eUdE3e-wZoZfzQZBw@mail.gmail.com>
 <20130830080138.GA24908@jtlinux>
 <CAE9FiQWsyY2xnbOcd9L9=G0z50fZo-7OfaZovKVO3XzVuZODjA@mail.gmail.com>
 <20130902080057.GA14515@jtlinux>
 <CAE9FiQVb4GHFS6jwLbGKcPjF0HJ_mkACsj_kPrXvOKsjNDHd8g@mail.gmail.com>
 <20130903095500.GA15782@jtlinux>
 <CAE9FiQXfJmdNzW3j25qkL4mHWxJQCrp4A+sFOuR63p-OJ72gcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAE9FiQXfJmdNzW3j25qkL4mHWxJQCrp4A+sFOuR63p-OJ72gcQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 03, 2013 at 12:38:06PM -0700, Yinghai Lu wrote:
> On Tue, Sep 3, 2013 at 2:55 AM, Johannes Thumshirn
> <johannes.thumshirn@men.de> wrote:
> >
> > As far as I can see with my layman's eyes is, it finds the subordinate busses
> > 1-5 behind the bridge but then somehow looses them again in the enumeration
> > phase.
>
> fsl-pci fe200000.pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
> pci_bus 0000:00: scanning bus
> pci 0000:00:00.0: [1957:0401] type 01 class 0x0b2000
> pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
> pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x6c
> calling  fixup_hide_host_resource_fsl+
> 0x0/0x6c @ 1 for 0000:00:00.0
> pci fixup fixup_hide_host_resource_fsl+0x0/0x6c returned after 0 usecs
> for 0000:00:00.0
> pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x128
> calling  pcibios_fixup_resources+0x0/0x128 @ 1 for 0000:00:00.0
> pci fixup pcibios_fixup_resources+0x0/0x128 returned after 0 usecs for
> 0000:00:00.0
> pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x84
> calling  quirk_fsl_pcie_header+0x0/0x84 @ 1 for 0000:00:00.0
> pci fixup quirk_fsl_pcie_header+0x0/0x84 returned after 0 usecs for 0000:00:00.0
>
> ===> it overrides the class from 0b2000 to 060400
>
> pci 0000:00:00.0: supports D1 D2
> pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:00.0: PME# disabled
> pci 0000:00:00.0: scanning [bus 01-05] behind bridge, pass 0
> pci 0000:00:00.0: check if busn 01-05 is in busn_res: [bus 00-ff]
>
>
> pci_bus 0000:00: fixups for bus
> pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
>
> ====>
>
> so you have PCI_REASSIGN_ALL_BUS set ...
>
> pci_bus 0000:01: busn_res: [bus 01-08] is updated under [bus 00-ff]
> pci_bus 0000:01: scanning bus
>
> ====> should have child devices probed here... but not happen...
>
> so your pcie switch will need more time to settle down?
>
> pci_bus 0000:01: fixups for bus
> pci 0000:00:00.0: PCI bridge to [bus 01-08]
> pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> pci 0000:00:00.0:   bridge window [mem 0x80000000-0x801fffff]
> pci_bus 0000:01: bus scan returning with max=01
> pci_bus 0000:01: busn_res: [bus 01-08] end is updated to 01
> pci_bus 0000:00: bus scan returning with max=01
> pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01

This is what I've thought as well, so I've put an msleep(5000) into
pci_scan_child_bus' loop. But this didn't improve the situation either. As I've
already said, I ran out of ideas with this problem.
