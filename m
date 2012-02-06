Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo4HJH+3EQAWowyVxZFa5jVy1EOo=SoybJqqcjhVdo0nzw@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
	<1328425088-6562-2-git-send-email-yinghai@kernel.org>
	<CAErSpo4HJH+3EQAWowyVxZFa5jVy1EOo=SoybJqqcjhVdo0nzw@mail.gmail.com>
Date: Mon, 6 Feb 2012 10:55:14 -0800
Message-ID: <CAE9FiQXeRGXE2RCe5S1iOE=QY37wauM=WUevjXWkMqMOjV3t7A@mail.gmail.com>
Subject: Re: [PATCH 01/24] PCI: Add iobusn_resource
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 6, 2012 at 10:48 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> +struct resource iobusn_resource = {
>> +       .name   = "PCI busn",
>> +       .start  = 0,
>> +       .end    = 0xffffff,
>> +       .flags  = IORESOURCE_BUS,
>> +};
>
> I'm not sure this should be global.  iomem_resource and
> ioport_resource *are* really global, because they refer to processor
> address space that is the same for everybody.  But PCI bus numbers are
> specific to PCI.  Some machines don't have PCI at all, and there are
> different bus architectures to which this doesn't apply.

that does not hurt them.

>
> The 0-0xffffff range is misleading because it includes both the domain
> and the bus number, and it's meaningless to allocate ranges that cross
> domain boundaries.  For example, [bus 0x0000f0-0x000120] includes bus
> numbers from domain 0000 and domain 0001, which doesn't make any sense
> because a bus can only be in one domain.

allocation code will make sure it will be cross the boundary for domain.

>
> I think it would make more sense to keep this bus number resource in a
> per-host bridge structure.  Then we wouldn't need to include the
> domain number at all because the host bridge determines the domain.

not sure. insert the all busn_res of all peer root buses into one
global iobusn_resource
looks more simple.

Yinghai
