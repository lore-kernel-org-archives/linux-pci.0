Return-Path: <matt@console-pimps.org>
Return-Path: <matt@console-pimps.org>
Date: Sat, 30 Apr 2016 22:17:38 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Graf <agraf@suse.de>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Peter Jones <pjones@redhat.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] arm64: Relocate screen_info.lfb_base on PCI BAR
 allocation
Message-ID: <20160430211738.GN2839@codeblueprint.co.uk>
References: <20160428180641.GA25125@localhost>
 <57228317.1030808@suse.de>
 <20160429134126.GA949@localhost>
 <CAKv+Gu-4vqT-tQXdwJbLV0r3FhtrYk=TOWxDYS6LjG_BNf=b_A@mail.gmail.com>
 <20160429200609.GA28261@localhost>
 <35998183-0322-49D4-91CD-4D441577C44F@linaro.org>
 <5723C956.4040907@suse.de>
 <20160429213751.GB5359@localhost>
 <5723D7AF.3080108@suse.de>
 <20160429233119.GA10197@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160429233119.GA10197@localhost>
List-ID: <linux-pci.vger.kernel.org>

(Pulling in efifb maintainer, Peter)

On Fri, 29 Apr, at 06:31:19PM, Bjorn Helgaas wrote:
> 
> The efifb.c driver doesn't do anything at all with PCI (it includes
> linux/pci.h, but probably doesn't need it).  That's part of what I'm
> suggesting -- if it *did* register as a PCI device driver, then it
> would look at pci_dev->resource[n], which is populated by the PCI
> core based on the BAR values.
 
This discussion came up recently here,

  https://lkml.kernel.org/r/20160216151859.GB11373@redhat.com

There's nothing PCI-specific about the EFI framebuffer per se, but in
practice it's always a PCI device.

> Is ConOut what you're after?  I.e., is the whole point of this
> exercise to get a framebuffer driver attached to the device that was
> the firmware console?  I would think the ConOut path should be
> decodable -- it has to tell you how to navigate the interconnect from
> the CPU to the device.  But I don't know how to do it.
> 
> It looks like on x86, at least, setup_gop32()/setup_gop64() might be
> extracting the framebuffer address from the ConOut device and stuffing
> it into screen_info, which is what efifb.c later looks at (maybe this
> is what Ard was referring to).
 
Matthew Garrett wrote the x86 code for guessing where the console is.
We look for the ConOut protocol with a fallback to first GOP device if
we can't find it. I think the heuristic was based on reading the
implementation in EDK2. See commit 38cb5ef4473c ("X86: Improve GOP
detection in the EFI boot stub").
