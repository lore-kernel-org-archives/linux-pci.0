Return-Path: <marc.zyngier@arm.com>
Return-Path: <marc.zyngier@arm.com>
Date: Fri, 26 Aug 2016 13:08:32 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <helgaas@kernel.org>, "Rafael
 Wysocki" <rafael@kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, patches <patches@apm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Punit Agrawal <punit.agrawal@arm.com>,
 <okaya@codeaurora.org>
Subject: Re: Defining polarity and trigger mode for static interrupts in
 _PRT
Message-ID: <20160826130832.2fde2327@arm.com>
In-Reply-To: <20160826090813.GA1038@red-moon>
References: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
	<20160824142723.GA25843@red-moon>
	<20160824193000.GE23914@localhost>
	<20160824213005.1a9300ef@arm.com>
	<CADaLNDm+edKaveG76h_fbMjM_b==PdranXLoATL8+JrsWRC6BQ@mail.gmail.com>
	<20160825121825.322d8450@arm.com>
	<CADaLND=MkDmYNESmL9zLEQQ5NaZp4_aGv4SnQ4=VS4LmFkFG6g@mail.gmail.com>
	<20160825195917.0e75a8db@arm.com>
	<20160826090813.GA1038@red-moon>
Sender: marc.zyngier@foss.arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Fri, 26 Aug 2016 10:08:13 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> [ +Sinan ]
> 
> On Thu, Aug 25, 2016 at 07:59:17PM +0100, Marc Zyngier wrote:
> 
> [...]
> 
> > > Thanks, Marc! It works, I tested on current X-Gene platforms that uses
> > > GICv2 and GICv2m.
> > > 
> > > Will you commit this change? It will be a huge help as going with
> > > interrupt link will require firmware change.  
> > 
> > Not for the time being. We now have an understanding of *why* things do
> > not work, but Lorenzo seems to have a good grasp on what we can do to
> > address it correctly, and we should explore this first. If (and only if)
> > there is a consensus that firmware already does all it should, then
> > I'll turn this hack into a proper series.  
> 
> For the records, it is a discussion that already took place:
> 
> https://lkml.org/lkml/2016/3/14/923
> 
> As I have said there are already ARM64 systems with ACPI tables
> out there using PCI interrupt links; I doubt that Qualcomm systems
> allow to reconfigure the GIC interrupt pin allocated to legacy PCI
> IRQs through interrupt links _SRS (hey it is *empty* :)),
> therefore:
> 
> a) Some (the above is just an example from the mailing lists I am not
>    picking on anyone it is just for the sake of this discussion, I have
>    not dumped all ARM partners _PRT from their ACPI tables to check)
>    ACPI tables must be rewritten because they are not FW compliant
> 
> OR
> 
> b) We allow PCI interrupt links to be used for static interrupt
>    configurations
> 
> OR
> 
> c) We ignore the polarity flag (only for PCI legacy IRQs ? I wonder
>    how GIC code can detect from which part of the kernel the interrupt
>    request is coming, unless we implement an ACPI-PCI-legacy-IRQ-special
>    gem)
> 
> Comments ?

I'm not overly keen on (c), as it is pretty hard to find out where the
request is coming from (and the hack I previously posted opens the door
to all kind of undetected misconfiguration). We *could* use a stacked
irqchip to represent the inverter, but it feels like using a car sized
hammer to squash a tiny fly.

(b) seems like the right thing to do, but I cannot comment on whether
or not this is compliant with the specification.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
