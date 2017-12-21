Return-Path: <SRS0=XQ2r=DR=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=XQ2r=DR=intel.com=keith.busch@kernel.org>
Date: Thu, 21 Dec 2017 07:59:43 -0700
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maik Broemme <mbroemme@libmpq.org>
Subject: Re: [PATCH 1/4] PCI/AER: Return approrpiate value when AER is not
 supported
Message-ID: <20171221145942.GC15276@localhost.localdomain>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171221010452.GD30595@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221010452.GD30595@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 20, 2017 at 05:04:52PM -0800, Bjorn Helgaas wrote:
> On Tue, Dec 19, 2017 at 02:06:40PM -0700, Keith Busch wrote:
> > Getting the AER information is documented to return 0 when it failed to
> > get the information.
> 
> I think this case is either impossible (if we only call this function
> for devices known to support AER), or it fixes an actual bug (the
> caller would call aer_print_error() when it shouldn't, and potentially
> print garbage).  Right?
> 
> If the former, I vote for removing the test.  If the latter, the
> changelog should mention that it fixes a bug.

I just spotted this mistake when I was changing the function to
non-static. I've never observed bogus data printed in real life.

In the current AER handling, the only way we could incorrectly get there
is if the root port's Error Source ID Register somehow contains the ID
of a device that doesn't have AER capabilities, which would of course
be broken.

So if we trust hardware, we should are safe to remove the check.
