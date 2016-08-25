Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Thu, 25 Aug 2016 09:44:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vikram Sethi <vikrams@codeaurora.org>, alex.williamson@redhat.com
Subject: Re: PCI CRS Support
Message-ID: <20160825084441.GA9025@red-moon>
References: <f114c582-8e55-ee1a-a72d-864483077fd0@codeaurora.org>
 <20160824191007.GD23914@localhost>
 <046ebcb0-cb0d-65a5-d7f4-2805fe99199e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <046ebcb0-cb0d-65a5-d7f4-2805fe99199e@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

[+Alex]

On Wed, Aug 24, 2016 at 03:28:51PM -0400, Sinan Kaya wrote:
> On 8/24/2016 3:10 PM, Bjorn Helgaas wrote:
> >> Where do we go from here? I was thinking of putting something deep down into the reset secondary
> >> > bus function but I'm afraid it will break things especially when we wait up to 60 seconds.
> > I agree CRS handling after reset is probably all broken.
> > 
> > I hate the fact that we reset devices without re-enumerating them.  We
> > have no assurance that the device is the same after reset (it could
> > have loaded new firmware and been completely reconfigured).
> > 
> > I don't have any good suggestions for you, so if you have some ideas
> > and want to fix it, please go ahead.
> 
> I think I'll make a list of paths that reach to secondary bus reset
> function and try to keep CRS loop as close as possible to the caller. 
> 
> I'll focus on FLR later. I won't be heart-broken if somebody took a
> stab at the FLR.

Side note, taking advantage of this query: I hope this is a problem
solved by end of October, if it is not I would suggest adding a track to
tackle it at LPC16 PCI uconf, I added Alex since I know he is interested
in the topic too, it makes sense to debate a solution with all
interested people in one room.

Thanks,
Lorenzo
