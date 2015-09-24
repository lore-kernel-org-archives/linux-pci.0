Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
References: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
Date: Wed, 23 Sep 2015 20:21:59 -0700
Message-ID: <CAE9FiQWY1gdpzdqToBM0sNgfCRnRfEEgJfn-J9igorLH1K80JA@mail.gmail.com>
Subject: Re: [RFC] PCI: Unassigned Expansion ROM BARs
From: Yinghai Lu <yinghai@kernel.org>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 23, 2015 at 7:47 PM, Myron Stowe <myron.stowe@gmail.com> wrote:
>
> The kernel expects device Expansion ROM BARs to be programmed with valid
> values - even if the respective Expansion ROM's Enable bit is 0 (i.e. the
> device’s expansion ROM address space is disabled).  This seems to be the
> main contention point with said BIOS engineers.  If an Expansion ROM BAR is
> not programmed, the kernel will attempt to find available resources and, if
> successful, program it.  As this occurs various 'dmesg' entries
> related to kernel's actions are output.
...
> There is a kernel boot parameter, pci=norom, that is intended to disable the
> kernel's resource assignment actions for Expansion ROMs that do not already
> have BIOS assigned address ranges.  Note however, if I remember correctly,
> that this only works if the Expansion ROM BAR is set to "0" by the BIOS
> before hand-off.

option rom is used by legacy bios to enable booting from external device.
usually BIOS call the option rom, so the firmware will be loaded to
add on cards.
and firmware get started.
Also option rom would include tools that is used to configure behavior of cards
like add/remove raid.

Also there is some use case that kernel driver try to get some parameters from
BIOS. like intel soft raid ? --- bad practice !

I would like to treat option rom BAR as optional resources during
resource allocation.

https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=7f689da33302e4871fd18aee2c19abb5e3ea5261

Subject: PCI: Treat ROM resource as optional during realloc

Current on realloc path, we just ignore ROM resource if we can not assign
them in first try.

Treat ROM resources as optional resources,so try to allocate them together
with required ones, if can not assign them, could go with other required
resources only, and try to allocate them second time in expand path.

Thanks

Yinghai
