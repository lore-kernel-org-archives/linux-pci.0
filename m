Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:46798 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab3JRH1x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2013 03:27:53 -0400
Received: by mail-we0-f181.google.com with SMTP id t60so3317700wes.12
        for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2013 00:27:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
	<1379319655-20210-4-git-send-email-xobs@kosagi.com>
	<CAJ+vNU36neHP77dVnqSP=+oMxaU=-6PxWQ8Afni-tTRjNTkM_A@mail.gmail.com>
	<0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net>
Date: Fri, 18 Oct 2013 00:27:51 -0700
Message-ID: <CAJ+vNU13FA5s7tt-yEnBYNSBV+FHmHqZNoykFq8aF=O=TvqTnA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
From: Tim Harvey <tharvey@gateworks.com>
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Sean Cross <xobs@kosagi.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 17, 2013 at 11:34 PM, Zhu Richard-R65037
<r65037@freescale.com> wrote:

[...]

> Hi Tim:
> Regarding to my experience, the difference shouldn't be related with the bus hang.
> Here are my DT region setup when I trying to bring up imx6 pcie on 3.1x kernel by my own driver.
>                         clock-names = "pcie_axi", "pcie_ref", "pcie_bus_in", "pcie_bus_out";
>                         #address-cells = <3>;
>                         #size-cells = <2>;
>                         ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000   /* configuration space */
>                                   0x81000000 0 0          0x01f80000 0 0x00010000   /* downstream I/O */
>                                   0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
>                         num-lanes = <1>;
>
> It works sometimes, although that there is random kernel panic and system hang(log is pasted below):(
> LOGS, when pericom's PI7C9X2G303EL and Intel e1000e network card is used.
> ...
> imx-pcie 1ffc000.pcie: legacy_irq 155
> imx-pcie 1ffc000.pcie: map [mem 0x01ffc000-0x01ffffff]
> IMX PCIe port: link up.
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
> pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> PCI: bus0: Fast back to back transfers disabled
> PCI: bus1: Fast back to back transfers disabled
> pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> PCI: bus2: Fast back to back transfers disabled
> pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> PCI: bus3: Fast back to back transfers disabled
> PCI: bus4: Fast back to back transfers enabled
> pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff 64bit]
> pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
> pci 0000:00:00.0: BAR 6: assigned [mem 0x01300000-0x0130ffff pref]
> pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> pci 0000:01:00.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
> pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> pci 0000:02:01.0: BAR 8: assigned [mem 0x01100000-0x012fffff]
> pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
> pci 0000:03:00.0: BAR 1: assigned [mem 0x01100000-0x011fffff]
> pci 0000:03:00.0: BAR 0: assigned [mem 0x01200000-0x0121ffff]
> pci 0000:03:00.0: BAR 3: assigned [mem 0x01220000-0x01223fff]
> pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f]
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
> pci 0000:02:01.0:   bridge window [mem 0x01100000-0x012fffff]
> pci 0000:02:02.0: PCI bridge to [bus 04]
> pci 0000:01:00.0: PCI bridge to [bus 02-04]
> pci 0000:01:00.0:   bridge window [io  0x1000-0x1fff]
> pci 0000:01:00.0:   bridge window [mem 0x01100000-0x012fffff]
> pci 0000:00:00.0: PCI bridge to [bus 01-04]
> pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> pci 0000:00:00.0:   bridge window [mem 0x01100000-0x012fffff]
> PCI: enabling device 0000:01:00.0 (0140 -> 0143)
> PCI: enabling device 0000:02:01.0 (0140 -> 0143)
> PCI: enabling device 0000:02:02.0 (0140 -> 0143)
> ...
> e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
> e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
> e1000e 0000:03:00.0: Disabling ASPM L0s L1
> PCI: enabling device 0000:03:00.0 (0140 -> 0142)
> e1000e 0000:03:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> e1000e 0000:03:00.0 eth1: registered PHC clock
> e1000e 0000:03:00.0 eth1: (PCI Express:2.5GT/s:Width x1) 00:1b:21:3a:18:8b
> e1000e 0000:03:00.0 eth1: Intel(R) PRO/1000 Network Connection
> e1000e 0000:03:00.0 eth1: MAC: 3, PHY: 8, PBA No: E42641-005
> igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.3-k
> igb: Copyright (c) 2007-2013 Intel Corporation.
> ...
>
> ALSA device list:
>   #0: wm8962-audio
> VFS: Mounted root (nfs filesystem) on device 0:11.
> devtmpfs: mounted
> Freeing unused kernel memory: 324K (8082d000 - 8087e000)
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b  <-- Kernel panic here randomly. Same phenomena when the root-fs is located in SD.

Richard,

I would suspect this is the imprecise abort issue.  Please see my
patch (http://thread.gmane.org/gmane.linux.kernel.pci/26159) resolves
that for you and reply to that thread if so.

I believe that the imprecise abort's only occurs if you have a PCIe
switch on the bus - is this your topology and if so are you
experiencing any issues with devices behind the bus that use io
regions?  If you do have a switch, perhaps you can provide me with an
'lspci -v' for comparison.

Tim
