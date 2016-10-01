Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CALAE=UDjBSMJJZMiJsadfd242jHSfqt7UXYFbsXGC_bHsZ5tOg@mail.gmail.com>
References: <CALAE=UDqxjh1qt5OJexyonynj+uEyhiwdAtUF0_dD5ffRkUo=Q@mail.gmail.com>
 <20160919194122.GA21763@localhost> <CALAE=UDjBSMJJZMiJsadfd242jHSfqt7UXYFbsXGC_bHsZ5tOg@mail.gmail.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 30 Sep 2016 20:20:47 -0700
Message-ID: <CAE9FiQV-vxubz-jfgSFF3jm63-uVFjJtKXWo2Mz6d_zMMmezDA@mail.gmail.com>
Subject: Re: PCI Resource Allocation
To: Robert Jones <rjones@gateworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>, Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 19, 2016 at 1:59 PM, Robert Jones <rjones@gateworks.com> wrote:
> [    0.312076] PCI host bridge /soc/pcie@0x01000000 ranges:
> [    0.312098]   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
> [    0.312147]   err 0x01f00000..0x01f7ffff -> 0x01f00000
> [    0.312186]    IO 0x01f80000..0x01f8ffff -> 0x00000000
> [    0.312275]   MEM 0x01000000..0x01efffff -> 0x01000000
> [    0.521249] imx6q-pcie 1ffc000.pcie: link up
> [    0.521268] imx6q-pcie 1ffc000.pcie: Link: Gen2 disabled
> [    0.521283] imx6q-pcie 1ffc000.pcie: link up
> [    0.521296] imx6q-pcie 1ffc000.pcie: Link up, Gen1
> [    0.521901] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> [    0.521927] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.521946] pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff flags 0x0]
> [    0.521962] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.521978] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
...
> [    0.682168] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> [    0.682199] pci 0000:00:00.0: BAR 8: no space for [mem size 0x01400000]
> [    0.682217] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x01400000]
> [    0.682237] pci 0000:00:00.0: BAR 6: assigned [mem > 0x01100000-0x0110ffff pref]
> [    0.682257] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]

so one of resource resource flags is not right.
> [    0.521946] pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff flags 0x0]

also need a big range, but root bus does not have enough space.

please check if you can increase resource size for hostbridge.

Thanks

Yinghai
