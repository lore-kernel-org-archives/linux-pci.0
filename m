Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 25 Aug 2016 12:20:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Duc Dang <dhdang@apm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rafael Wysocki <rafael@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, patches <patches@apm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
Message-ID: <20160825172029.GC11257@localhost>
References: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
 <20160824142723.GA25843@red-moon>
 <20160824193000.GE23914@localhost>
 <20160824213005.1a9300ef@arm.com>
 <87pooxqi5p.fsf@e105922-lin.cambridge.arm.com>
 <20160825111424.GA9244@red-moon>
 <CADaLNDkJ5wQC-59oD26J0F8T+pP5BEJcSTN16j_EYm-pmfPi=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADaLNDkJ5wQC-59oD26J0F8T+pP5BEJcSTN16j_EYm-pmfPi=A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 09:46:25AM -0700, Duc Dang wrote:
> On Thu, Aug 25, 2016 at 4:14 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > On Thu, Aug 25, 2016 at 11:04:02AM +0100, Punit Agrawal wrote:
> >> If there are no good reason to restrict using link devices to
> >> configurable interrupts, perhaps the spec needs an update.
> >
> > Yes and that's what I am going to ask if nobody complains.
> 
> In my opinion, if the interrupt is not configurable, I should be able
> to choose not to use interrupt link, which requires a spec. update as
> well to specify the polarity of the fixed interrupts?

This is a little out of my area, but I really don't see the point of
an ACPI spec update.  PCI has specified level/low and ACPI systems
have worked that way for decades.

Can't you just make your GIC driver aware of the fact that some of
its inputs have inverters on them and are effectively active low?
Then all the generic code should work just like it does on other
systems.
