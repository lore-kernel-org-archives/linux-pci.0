Return-Path: <SRS0=eJnL=FX=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=eJnL=FX=davemloft.net=davem@kernel.org>
Date: Wed, 28 Feb 2018 22:28:53 -0500 (EST)
Message-Id: <20180228.222853.1570972177848923005.davem@davemloft.net>
To: helgaas@kernel.org
Cc: dwmw2@infradead.org, sparclinux@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] sparc: Use generic pci_mmap_resource_range()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180228230828.GR127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1519053858.7876.84.camel@infradead.org>
	<20180219.103025.1676484157305869188.davem@davemloft.net>
	<20180228230828.GR127842@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 28 Feb 2018 17:08:29 -0600

> On Mon, Feb 19, 2018 at 10:30:25AM -0500, David Miller wrote:
>> From: David Woodhouse <dwmw2@infradead.org>
>> Date: Mon, 19 Feb 2018 15:24:18 +0000
>> =

>> >> For one, the sparc specific code allows mmap'ing any address rang=
e
>> >> within a PCI bus device.=A0=A0The generic code does not allow tha=
t.
>> > =

>> > =

>> > You mean any address range in a given PCI bus even if there is no
>> > actual device with a BAR at the corresponding address?
>> > =

>> > Would I be right to assume this was only available through the leg=
acy
>> > procfs API? I think it should be possible to accommodate it, and i=
t
>> > does look like I'd missed this requirement the first time round; t=
hanks
>> > for pointing it out.
>> =

>> It was probably the case that only procfs could do it.
>> =

>> It is the mechanism by which we were able to let the X server poke
>> around in VGA ISA space.  It does a bus I/O space map for the bus
>> device above the VGA card.
> =

> What's the bottom line?  Do we want this for sparc?  If so, do you
> want to take it, Dave M, or would you like me to?

The bottom line is that David W.'s patch would break sparc so
we don't want this.
