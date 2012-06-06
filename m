Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 Jun 2012 21:50:34 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg@redhat.com>
Cc: Khalid Aziz <khalid.aziz@hp.com>, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Disable Bus Master on PCI device shutdown
Message-ID: <20120606215034.257d7549@pyramind.ukuu.org.uk>
In-Reply-To: <20120606135009.GB1517@srcf.ucam.org>
References: <20120427190033.GA17588@ldl.usa.hp.com>
	<20120606135009.GB1517@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> This protects against the case where a piece of hardware is continuing 
> to DMA even after the driver shutdown method has been called? I'm not 

It doesn't. We also have hardware which craps itself if you clear the bus
mastering bit and we have platforms where the BIOS gets most upset if you
do that on suspend paths. There are also lots of devices that simply
ignore the bus mastering bit !

> convinced this is safe. Some Broadcom parts will crash if busmastering 
> is disabled while they're still performing DMA, and they'll then hang 
> the bus if reenabled.

This is very common, disabling the bus master bit isn't exactly a
tested or well defined pathway. A lot of device FIFOs will also happily
belch out their queue when you flip the bit. So it might look like
progress but it probably isn't.

Unfortunately if you've got a device peeing into memory you need to fix
the driver, or sometimes the firmware. You can probably use the IOMMU for
some protection on newer systems.

And then you get things like the CS5520 where disabling bus mastering on
the IDE controller crashes the machine, and some UMA video devices that
honour the bit for video fetch.

>From the IDE experience you really need to be careful here. Changing the
default is asking for nasty and weird regressions.

This isn't a fix, its a band aid to cover over broken driver shutdown
methods. Those driver shutdown methods need fixing.

Alan
