Return-Path: <SRS0=IXpx=2Y=firstfloor.org=andi@kernel.org>
Return-Path: <SRS0=IXpx=2Y=firstfloor.org=andi@kernel.org>
Date: Tue, 14 Mar 2017 19:24:14 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
	Andi Kleen <andi@firstfloor.org>, bhelgaas@google.com,
	x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
Message-ID: <20170315022414.GC14380@two.firstfloor.org>
References: <20170302232104.10136-1-andi@firstfloor.org>
 <20170302232104.10136-3-andi@firstfloor.org>
 <alpine.DEB.2.20.1703141407090.3619@nanos>
 <20170314154155.GG32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703141713010.3619@nanos>
 <20170314170255.GH32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703141849170.3619@nanos>
 <20170314194720.GD26264@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314194720.GD26264@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

> I agree that it should be fairly safe to do ECAM/MMCONFIG without
> locking.  Can we handle the decision part by adding a "lockless" bit
> to struct pci_ops?  Old ops don't mention that bit, so it will be
> initialized to zero and we'll do locking as today.  ECAM/MMCONFIG ops
> can set it and we can skip the locking.

That's what my other patch already did. 

-Andi
