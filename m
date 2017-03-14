Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Mar 2017 18:56:26 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andi Kleen <ak@linux.intel.com>
cc: Andi Kleen <andi@firstfloor.org>, bhelgaas@google.com,
        x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
In-Reply-To: <20170314170255.GH32070@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.20.1703141849170.3619@nanos>
References: <20170302232104.10136-1-andi@firstfloor.org> <20170302232104.10136-3-andi@firstfloor.org> <alpine.DEB.2.20.1703141407090.3619@nanos> <20170314154155.GG32070@tassilo.jf.intel.com> <alpine.DEB.2.20.1703141713010.3619@nanos>
 <20170314170255.GH32070@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 14 Mar 2017, Andi Kleen wrote:
> The other option is to simply make it unconditional. That would
> be even simpler, but it is a bit more risky. Hmm, I suppose may
> be worth trying to find out what Windows uses. If they get away
> with MMCONFIG everywhere we should be too.

>From the PCIe spec:

 The PCI 3.0 compatible Configuration Space can be accessed using either
 the mechanism defined in the PCI Local Bus Specification or the PCI
 Express Enhanced Configuration Access Mechanism (ECAM) described later in
 this section. Accesses made using either access mechanism are
 equivalent. The PCI Express Extended Configuration Space can only be
 accessed by using the ECAM.

The 1.0 spec has a similar wording (s/3.0/2.3).

Definitely the best way to go.

Thanks,

	tglx
