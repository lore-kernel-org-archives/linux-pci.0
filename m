Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35981 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbaF0A3I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jun 2014 20:29:08 -0400
Received: by mail-ob0-f171.google.com with SMTP id nu7so4820272obb.30
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2014 17:29:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140626054937.GB7859@dragon>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
	<20140626031247.GN2224@dragon>
	<CAOMZO5A0pQfJRwb41046UpkbG6xH7c+EVu+YuY71Zuyq5gHaDA@mail.gmail.com>
	<20140626054937.GB7859@dragon>
Date: Thu, 26 Jun 2014 17:29:07 -0700
Message-ID: <CAJ+vNU0DNCT5pcvnptNBo-tPTVOH1HnrCwy7uCZt33dfyq8U-g@mail.gmail.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
From: Tim Harvey <tharvey@gateworks.com>
To: Shawn Guo <shawn.guo@freescale.com>,
	Richard Zhu <r65037@freescale.com>
Cc: Fabio Estevam <festevam@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	=?UTF-8?Q?David_M=C3=BCller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 25, 2014 at 10:49 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, Jun 26, 2014 at 12:43:19AM -0300, Fabio Estevam wrote:
>> On Thu, Jun 26, 2014 at 12:12 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
>> > On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
>> >> From: Fabio Estevam <fabio.estevam@freescale.com>
>> >>
>> >> When the mx6 PCI conctroller is initialized in the bootloader we see a kernel
>> >> hang inside imx6_add_pcie_port().
>> >>
>> >> Adding a 30ms delay allows the kernel to boot.
>> >
>> > We may not want to add a random delay into the driver before we
>> > understand the root cause of the issue.
>>
>> Yes, that's why I sent this as RFC and also explained it below the ---
>> line that I am actually trying to get some help with this issue.
>>
>> >
>> > Do you see this issue with FSL kernel?
>>
>> Yes, it also hangs.
>>
>> It is reproducible in 100% of the boots. Just need to use mainline
>> U-boot (which has PCI driver enabled by default).
>> I am using an Intel Wifi 7260 PCI card. This was also reported by
>> other folks in the U-boot list.
>
> Richard,
>
> Can you schedule some time to look at this issue?  I think it will come
> to us sooner or later if any our customer enables PCIe before launching
> kernel?
>
> Shawn
>

Shawn / Richard,

I am also affected by this issue on IMX6 boards that I support. If I
enable PCI in the bootloader I see similar hangs.

I have the following hardware configurations on my bench:
  1. IMX6DL + i210 (same PCI setup as Fabio's above, but DL instead of Q)
  2. IMX6Q + ath9k device
  3. IMX6DL + PLX PEX860x PCIe-to-PCIe bridge with various devices
behind the bridge, using a clock buffer from IMX6 PCIe clock
  4. IMX6Q + PLX PEX860x PCIe-to-PCIe bridge with various devices
behind the bridge, using a clock buffer from IMX6 PCIe clock
  5. IMX6Q + PLX PEX860x PCIe-to-PCIe bridge with various devices
behind the bridge using a clock generator (always on, ignoring the
PCIe clock)

For all of the above I have no PCI issues using
3.14/3.15/3.16-rc2/vendor 3.10.17_1.0.0_ga unless I enable PCI in the
bootloader. When I do so, all of the above configurations hang
somewhere around PCI init/enumeration. The same occurs with the most
recent vendor kernel 3.10.17_1.0.0_ga kernel (works when PCI is
disabled in the bootloader, hangs otherwise).

When I apply Fabio's patch above to the 3.16-rc2 kernel I find that
scenarios #4 and #5 above then work, #3 boots but the PLX bridge fails
all config cycles (0xff's), #2 boots but with no PCIe link, and #1
above still hangs. Previously, when I have dug into this particular
'hang' issue on 3.15 I found that the delay needed to be between
imx6_pcie_probe() requesting and asserting reset_gpio low, and before
setting IOMUX_GPR1:18 to power down the PCIe PHY (note here, that the
PHY is currently enabled in the bootloader when PCI is enabled there).

When I apply Fabio's patch above to the most recent vendor kernel
3.10.17_1.0.0_ga I still hang in all cases.

So while I agree there is something horribly wrong with IMX6 PCI
still, I don't think Fabio's patch is the right solution and I don't
have anything better at this point in time. I'm happy to share any
hardware with anyone that can work through this issue.

Thanks,

Tim
