Return-Path: <SRS0=qqUe=EH=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=qqUe=EH=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Fri, 12 Jan 2018 16:46:44 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Jason
 Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>,
 Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>,
 linux-arm-kernel@lists.infradead.org, Antoine Tenart
 <antoine.tenart@free-electrons.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@free-electrons.com>, Victor Gu <xigu@marvell.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 3/7] PCI: aardvark: set host and device to the same
 MAX payload size
Message-ID: <20180112164644.5611fe3b@windsurf.lan>
In-Reply-To: <20180112144024.GB113206@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
	<20170928125838.11887-4-thomas.petazzoni@free-electrons.com>
	<20171005173102.GR25517@bhelgaas-glaptop.roam.corp.google.com>
	<20180109163918.5e46c1a1@windsurf.lan>
	<20180109221436.GE31640@bhelgaas-glaptop.roam.corp.google.com>
	<20180112111448.00feb9f8@windsurf.lan>
	<20180112144024.GB113206@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

Thanks again for this discussion!

On Fri, 12 Jan 2018 08:40:24 -0600, Bjorn Helgaas wrote:

> Sorry, I didn't mean that commit would fix your problem.  It's just an
> example of another case where generic code incorrectly assumed a Root
> Port would always be present.

OK, understood.

> > I.e, there is no Root Port. Therefore, I don't see how the kernel
> > can know what is the maximum allowed payload size of the PCIe
> > controller, nor how to adjust the payload size to use. Same for the L0s
> > configuration.  
> 
> The Device Control MPS field defaults to 128 bytes.  Generic software
> can only change that default if it knows that every element that might
> receive a packet from the device can handle it.  In this case, we have
> no information about what the invisible Root Port can handle, so I
> would argue that we cannot change MPS.
> 
> In the lspci above, MPS is set to 256 bytes.  If that was done by
> firmware, it might be safe because it knows things about the Root Port
> that Linux doesn't.  But I don't think the Linux PCI core could set it
> to 256.

So you're suspecting that the firmware/bootloader has configured the
MPS on the E1000E device to 256 bytes ?

Isn't it dangerous for the kernel to rely on the firmware/bootloader
configuration ? Indeed, the firmware/bootloader might have configured
MPS to X bytes on the endpoint, but when the kernel boots and
initializes the PCIe controller, its sets the PCIe controller MPS to Y
bytes, with Y > X.

> ASPM L0s is similar.  We should only enable L0s if we can tell that
> both ends of the link support it.  If there's no Root Port, we don't
> have any ASPM capability information for the upstream end of the link,
> so we shouldn't enable ASPM at all.

Well, even without the Root Port, we are able to use the endpoint
configuration space to figure out whether it supports L0s, and adjust
the root complex configuration accordingly. This is what our patch is
doing for MPS, and which could be done similarly for L0s, no?

> 
> > This is why we need those changes, one to update the PCIe controller
> > MPS according to the Maximum Payload Size acceptable by the endpoint,
> > and one to disable L0s entirely to avoid issues with non-L0s compliant
> > devices.  
> 
> The generic core code should perform minimal, guaranteed-to-work
> configuration using the least information and fewest assumptions
> possible.  That may not lead to optimal performance, but it should at
> least be functional.  This should work even if there is no Root Port.
> 
> Once we have that figured out, then we can worry about whether we can
> or should do platform-specific tweaks to improve performance, e.g.,
> increase MPS if we know Root Port capabilities implicitly.
> 
> I had the impression that these patches were required for correct
> functionality, not just to improve performance.  But maybe I
> misunderstood?

I don't myself have the device that wasn't working, and that this patch
got to work, so I can't double check myself. However, indeed, I was
told that without this fix, some devices would not work.

One question: is it valid/working to have the root complex configured
with MPS = 128 bytes but the endpoint configured with MPS = 256 or 512
bytes ? Or should the MPS value be strictly equal on both sides ?

Depending on your answer, there are two options:

 - It is a valid situation to have a root complex MPS lower than the
   endpoint MPS. In this case, we could for now simply unconditionally
   set the MPS to 128 bytes in the root complex, as a fix to get all
   devices working. And then separately, work on improving performance
   by increasing the MPS according to the endpoint capabilities.

 - It is not valid for the root complex MPS to be different than the
   endpoint MPS. In this case, then I don't see how we can do things
   differently than the proposed patch: we have to see what the
   endpoint MPS is, and adjust the root complex MPS accordingly.
   Indeed, the bootloader/firmware might have changed the endpoint MPS
   so that it is no longer the default of 128 bytes.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
