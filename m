Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 21 Mar 2017 12:45:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
Message-ID: <20170321174520.GC13150@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131203109.GA14127@bhelgaas-glaptop.roam.corp.google.com>
 <20170201125325.GA15805@localhost.localdomain>
 <20170201151807.GA15793@bhelgaas-glaptop.roam.corp.google.com>
 <376ae1df-da85-e576-75d6-3ae2ab0f1b41@jonmasters.org>
 <20170315113323.GA28027@localhost.localdomain>
 <251db823-591b-483b-9c55-13c911020fd1@jonmasters.org>
 <48b93116-cc0f-e59d-8aa3-704052ad6759@gmail.com>
 <c3392131-9243-24d3-30b4-4d7e84019d6f@jonmasters.org>
 <20170321134744.GA13150@bhelgaas-glaptop.roam.corp.google.com>
 <b50b6a7f-30be-4206-4f38-2539ea936228@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <b50b6a7f-30be-4206-4f38-2539ea936228@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jon Masters <jcm@jonmasters.org>, David.Daney@cavium.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stemerkhanov@CAVIUMNETWORKS.onmicrosoft.com,
 David Daney <ddaney.cavm@gmail.com>,
 Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 21, 2017 at 03:17:17PM +0100, Tomasz Nowicki wrote:
> Hi Bjorn,
> 
> On 21.03.2017 14:47, Bjorn Helgaas wrote:
> >On Tue, Mar 21, 2017 at 07:38:07AM -0400, Jon Masters wrote:
> >>On 03/16/2017 12:25 PM, David Daney wrote:
> >>>On 03/16/2017 07:32 AM, Jon Masters wrote:
> >>
> >>>>>Yes, it is now contains "CAVxxx" as _HID for device config object.
> >>>>
> >>>>Which is different from the version that was merged into upstream. That
> >>>>should never have happened. It will never happen again. I have spent some
> >>>>time over the past few days ensuring folks understand that I will not
> >>>>allow a repeat of this to occur the next time around. We will have
> >>>>platforms that are bulletproof and supported by upstream with any
> >>>>errata fixes in a very carefully controlled manner. There will
> >>>>under no circumstances ever be a situation like this again.
> >>>
> >>>We are still evaluating the merits of registering the values that appeared
> >>>in v4.10, and not changing them.  We should know more in a couple of days.
> >>
> >>Thanks David. What was the verdict? (for the public record). If we need to
> >>get a change into upstream, let's get that teed up before 4.12 merge.
> >>
> >>And for other folks following along with this thread: I'm not just picking
> >>on Cavium here. I'll be doing the same with *every* ARM server SoC company
> >>as necessary over the coming months. We are going to have militantly
> >>compliant standards adherence in this industry and every ARM server SoC is
> >>going to "just work" with an upstream Linux kernel with an ACPI enabled
> >>platform. This will be so utterly clean and boring it'll be amazing.
> >
> >Thanks for keeping on top of this, Jon.  I agree, we should not be
> >using unregistered vendor prefixes, e.g., the "THRX" added by
> >44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host
> >controller").  I'm sorry I merged that without doing the due
> >diligence.
> 
> Honestly, it is me who is responsible for this since I submitted the patch.
> 
> >
> >I suspect the resolution will be to register "THRX".  If that doesn't
> >happen, I'll propose reverting 44f22bd91e88, not because I want to
> >break things, but only because I'm not personally in a position to do
> >anything smarter.  So please propose a better solution that fits
> >within the ACPI _HID/_CID model :)
> 
> I already submitted the patch to fix this. Please see:
> https://patchwork.ozlabs.org/patch/739042/

Applied, thanks!  Glad to have this cleared up!

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
