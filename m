Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33118 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755239AbbJHJSQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Oct 2015 05:18:16 -0400
Date: Thu, 8 Oct 2015 10:18:43 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Matthew Minter <matt@masarand.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	David Daney <ddaney.cavm@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/5] PCI: Add pci_bus_fixup_irqs().
Message-ID: <20151008091843.GA31644@red-moon>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
 <56157BC8.3070406@caviumnetworks.com>
 <20151007230847.GG27633@localhost>
 <1906663.FAJXtJhtPt@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1906663.FAJXtJhtPt@shredder>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Matthew,

On Thu, Oct 08, 2015 at 03:07:34AM +0100, Matthew Minter wrote:
> On Wednesday 07 October 2015 18:08:47 Bjorn Helgaas wrote:

[...]

> Yes, I had been working on this last year, and got a patchset that was tested 
> on arm, x86 (and amd64), and slightly tested on powerpc. However I was not 
> able to test other architectures as they were not available in the software 
> lab I work in but should in theory work on all arches the kernel runs on.
> 
> I can say that that patchset is being used by several projects out of tree 
> currently but unfortunately due to a shift in priorities in the lab I was 
> working for I lost access to the resources to develop and test the patch 
> easily.
> 
> I have done some additional work personally on it but so far have not got 
> anything that I am happy to submit for inclusion in tree. (due to a number of 
> issues in structure and  a complication relating to weak functions where 
> multiple variations of the same arch exist.
> 
> You can see in thread that is linked above 
> (http://lkml.kernel.org/r/1412222866-21068-1-git-send-email-matt@masarand.com)
> some feedback on the issues that need to be solved.
> 
> I also expect that the patchset needs to be pulled forward to a newer kernel 
> as I have been working in a frozen tree without rebasing to reduce test 
> complexity.
> 
> I would be happy to put some time this weekend if possible into reviewing the 
> state of this and seeing if I can at least put together a version running on a 
> recent kernel. I can also go over the issues again which were proving 
> problematic and see if any of them are easy to fix.
> 
> However I can only work on this in my own time for now and on my own boxes 
> (which are all x86 and amd64) so the amount I can do will be limited. 

I was not aware of your patchset but I am happy to see that code since it
is definitely the right approach and I am willing to help you test it on
arm with the HW I have (probably it will also help remove some code
from arm64 too), let me know when you have a branch ready to test and
if you need any help in rebasing the set.

Thanks,
Lorenzo
