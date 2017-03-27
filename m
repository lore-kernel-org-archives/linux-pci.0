Return-Path: <SRS0=NLiR=3E=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=NLiR=3E=linutronix.de=tglx@kernel.org>
Date: Mon, 27 Mar 2017 16:46:06 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mason <slash.tmp@free.fr>
cc: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
    Robin Murphy <robin.murphy@arm.com>,
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
    Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
    linux-pci <linux-pci@vger.kernel.org>,
    Linux ARM <linux-arm-kernel@lists.infradead.org>,
    Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
    Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0.2] PCI: Add support for tango PCIe host bridge
In-Reply-To: <9c65e647-8395-4467-53ca-c20ed374131b@free.fr>
Message-ID: <alpine.DEB.2.20.1703271644210.3616@nanos>
References: <91db1f47-3024-9712-309a-fb4b21e42028@free.fr> <e5c0bace-fcbe-de3f-b76f-0fb672562e84@arm.com> <310db9dd-7db6-2106-2e53-f0083b2d3758@free.fr> <9fffedd4-6292-b662-a588-a68fe7380af6@free.fr> <6e847686-43c6-11e9-6782-dec0fe81a58e@arm.com>
 <9c65e647-8395-4467-53ca-c20ed374131b@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 27 Mar 2017, Mason wrote:
> On 24/03/2017 19:22, Marc Zyngier wrote:
> 
> > You cannot directly use a pointer to a u32 in any of the bitmap
> > operations. You need to copy the value to an unsigned long, and
> > apply the bitmap op on that.
> 
> On my platform, find_first_zero_bit() resolves to
> 
>   int _find_first_zero_bit_le(const void * p, unsigned size);
> 
> If the underlying implementation actually expects an unsigned long
> pointer, should the function prototype be changed?

Errm? Why are you worrying about the underlying implementations?

find_first_zero_bit() is what you are supposed to use in your code. And
that explicitely takes a unsigned long pointer.

Thanks,

	tglx
