Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 31 May 2017 15:04:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v4 1/2] PCI: Add tango MSI controller support
Message-ID: <20170531200424.GA23171@bhelgaas-glaptop.roam.corp.google.com>
References: <ef36137c-f0d1-23b9-8b91-a6ed87239578@arm.com>
 <aec89b9a-8377-ff39-547c-9e6eaf254fab@free.fr>
 <f1a57255-be75-e8c4-6b8d-0254f4365d61@arm.com>
 <c78b1e79-59e5-0097-989e-1f1e8cd93fc4@arm.com>
 <b10a211d-1f4a-1cc1-7139-9b48a90dd1c6@free.fr>
 <20170531173414.GB4496@bhelgaas-glaptop.roam.corp.google.com>
 <4885137f-7c1c-5742-4f66-f48c32ce7abb@free.fr>
 <20170531190037.GA18084@bhelgaas-glaptop.roam.corp.google.com>
 <20170531191258.GA18454@bhelgaas-glaptop.roam.corp.google.com>
 <74d6d867-313a-2304-9753-9739ad4703a8@free.fr>
MIME-Version: 1.0
In-Reply-To: <74d6d867-313a-2304-9753-9739ad4703a8@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 David Laight <david.laight@aculab.com>, Thomas Gleixner <tglx@linutronix.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 31, 2017 at 09:27:50PM +0200, Mason wrote:
> On 31/05/2017 21:12, Bjorn Helgaas wrote:
> > On Wed, May 31, 2017 at 02:00:37PM -0500, Bjorn Helgaas wrote:
> >> On Wed, May 31, 2017 at 08:49:04PM +0200, Mason wrote:
> >>> On 31/05/2017 19:34, Bjorn Helgaas wrote:
> >>> ...
> >>
> >>>> This would be more an IRQ patch than a PCI patch, but if I were
> >>>> reviewing it, I would look for assurance that *all* the no-op
> >>>> .irq_set_affinity callbacks were cleaned up, not just those in
> >>>> drivers/pci/host.
> >>>
> >>> Are you saying the patch is *wrong* if not all "do-nothing"
> >>> callbacks are cleaned up?
> >>
> >> I'm saying that (1) this probably wouldn't be applied via the PCI
> >> tree, and (2) if it *were* applied via PCI, I would ask that all the
> >> no-op callbacks were cleaned up at the same time.
> >>
> >> Huh, that sounds a lot like what I wrote above.  Was I unclear?
> > 
> > I'm afraid this sounded snarky, which isn't my intention.  It seems
> > like there's a useful patch here, and I didn't want to see it get
> > ignored for lack of following the usual process.  If this is all
> > obvious to you, my apologies and please ignore my suggestion.
> 
> Thanks for clearing things up. I had indeed assumed from
> your first reply that the patch was pointless.
> 
> Writing a script locating all candidates will be an
> interesting exercise.

Cscope only sees 94 definitions of irq_set_affinity.  I know *I* could
never write a script faster than looking at them manually.  While
doing that, I noticed irq_chip_set_affinity_parent(), which is used in
14 cases and appears similar to your patch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
