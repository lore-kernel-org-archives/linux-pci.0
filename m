Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 12 Jan 2018 13:39:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 3/7] PCI: aardvark: set host and device to the same
 MAX payload size
Message-ID: <20180112193959.GA205469@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-4-thomas.petazzoni@free-electrons.com>
 <20171005173102.GR25517@bhelgaas-glaptop.roam.corp.google.com>
 <20180109163918.5e46c1a1@windsurf.lan>
 <20180109221436.GE31640@bhelgaas-glaptop.roam.corp.google.com>
 <20180112111448.00feb9f8@windsurf.lan>
 <20180112144024.GB113206@bhelgaas-glaptop.roam.corp.google.com>
 <20180112164644.5611fe3b@windsurf.lan>
MIME-Version: 1.0
In-Reply-To: <20180112164644.5611fe3b@windsurf.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Hanna Hawa <hannah@marvell.com>, Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Victor Gu <xigu@marvell.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 12, 2018 at 04:46:44PM +0100, Thomas Petazzoni wrote:
> On Fri, 12 Jan 2018 08:40:24 -0600, Bjorn Helgaas wrote:

> > The Device Control MPS field defaults to 128 bytes.  Generic software
> > can only change that default if it knows that every element that might
> > receive a packet from the device can handle it.  In this case, we have
> > no information about what the invisible Root Port can handle, so I
> > would argue that we cannot change MPS.
> > 
> > In the lspci above, MPS is set to 256 bytes.  If that was done by
> > firmware, it might be safe because it knows things about the Root Port
> > that Linux doesn't.  But I don't think the Linux PCI core could set it
> > to 256.
> 
> So you're suspecting that the firmware/bootloader has configured the
> MPS on the E1000E device to 256 bytes ?

I didn't word that very well.  It looks like *something* set it to
256, but I don't know what.  It's possible Linux did, but I think that
would be a bug and should be fixed.  We'd have to instrument the code
or analyze it more closely than I have.

> Isn't it dangerous for the kernel to rely on the firmware/bootloader
> configuration ? Indeed, the firmware/bootloader might have configured
> MPS to X bytes on the endpoint, but when the kernel boots and
> initializes the PCIe controller, its sets the PCIe controller MPS to Y
> bytes, with Y > X.
> 
> > ASPM L0s is similar.  We should only enable L0s if we can tell that
> > both ends of the link support it.  If there's no Root Port, we don't
> > have any ASPM capability information for the upstream end of the link,
> > so we shouldn't enable ASPM at all.
> 
> Well, even without the Root Port, we are able to use the endpoint
> configuration space to figure out whether it supports L0s, and adjust
> the root complex configuration accordingly. This is what our patch is
> doing for MPS, and which could be done similarly for L0s, no?

Yes, this is where it would get machine-specific.  I don't know how
that should be structured, or even whether it's really worthwhile.  I
think the core should make it *work* with the least-common-denominator
approach, but I'm not convinced that a lot of effort should be put
into optimizing a topology that doesn't follow the spec.  A driver
could do this outside the core, but I think it would be better to put
the effort into making the topology more standard.

Why exactly *doesn't* Aardvark expose the Root Port?  I assume it does
actually exist, since there is actually a link leading to the slot,
and there has to be *something* at the upstream end of that link.

> > I had the impression that these patches were required for correct
> > functionality, not just to improve performance.  But maybe I
> > misunderstood?
> 
> I don't myself have the device that wasn't working, and that this patch
> got to work, so I can't double check myself. However, indeed, I was
> told that without this fix, some devices would not work.
> 
> One question: is it valid/working to have the root complex configured
> with MPS = 128 bytes but the endpoint configured with MPS = 256 or 512
> bytes ? Or should the MPS value be strictly equal on both sides ?

Per PCIe r4.0, sec 2.2.2, a device cannot transmit a TLP with a
payload larger than its MPS.  A device receiving a TLP with a payload
larger than its MPS must treat the TLP as malformed.

I think that means MPS really should be set the same on both sides so
the device can do both DMA reads and writes safely.

> Depending on your answer, there are two options:
> 
>  - It is a valid situation to have a root complex MPS lower than the
>    endpoint MPS. In this case, we could for now simply unconditionally
>    set the MPS to 128 bytes in the root complex, as a fix to get all
>    devices working. And then separately, work on improving performance
>    by increasing the MPS according to the endpoint capabilities.
> 
>  - It is not valid for the root complex MPS to be different than the
>    endpoint MPS. In this case, then I don't see how we can do things
>    differently than the proposed patch: we have to see what the
>    endpoint MPS is, and adjust the root complex MPS accordingly.
>    Indeed, the bootloader/firmware might have changed the endpoint MPS
>    so that it is no longer the default of 128 bytes.

All devices are guaranteed to support MPS = 128 bytes, so if you set
the Root Port to that in the driver, we should be able to make the PCI
core leave (or set, if necessary) all devices with MPS = 128.

I think we should start with that first, then worry about performance
optimizations separately.  I guess I'm still just shaking my head over
the invisible Root Port mystery.  I think the other cases I know about
are related to virtualization, where I can sort of understand why the
Root Port is missing, but I don't think that's the situation here.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
