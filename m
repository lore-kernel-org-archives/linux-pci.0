Return-Path: <SRS0=/q0J=BQ=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=/q0J=BQ=chromium.org=briannorris@kernel.org>
Date: Tue, 17 Oct 2017 16:39:05 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] Documentation/devicetree: Add pcie-reset-suspend
 property
Message-ID: <20171017233904.GA65743@google.com>
References: <20171012205220.130048-1-briannorris@chromium.org>
 <20171012205220.130048-2-briannorris@chromium.org>
 <20171013165152.GE25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013165152.GE25517@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Sorry for a little delay. I haven't been able to get much better answers
out of the problematic vendor here (they insist they are within the
spec), so I guess I'll have to go ahead based on current knowledge.

On Fri, Oct 13, 2017 at 11:51:52AM -0500, Bjorn Helgaas wrote:
> [+cc Doug]
> 
> On Thu, Oct 12, 2017 at 01:52:18PM -0700, Brian Norris wrote:
> > The patch is self-descriptive. I've found that we may need
> > platform-specific behavior for the PERST# signal in system suspend,
> > depending on the type of PCIe endpoints are attached.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> > index c77981c5dd18..91339b6d0652 100644
> > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > @@ -24,3 +24,14 @@ driver implementation may support the following properties:
> >     unsupported link speed, for instance, trying to do training for
> >     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> >     for gen2, and '1' for gen1. Any other values are invalid.
> > +- pcie-reset-suspend:
> > +   If present this property defines whether the PCIe Reset signal (referred to
> > +   as PERST#) should be asserted when the system enters low-power suspend modes
> > +   (e.g., S3). Depending on the form factor, the associated PCIe
> > +   electromechanical specification may specify a particular behavior (e.g.,
> > +   "PERST# is asserted in advance of the power being switched off in a
> > +   power-managed state like S3") or it may be less clear. The net result is
> > +   that some endpoints perform better (e.g., lower power consumption) with
> > +   PERST# asserted, and others prefer PERST# deasserted. The value must be '0'
> > +   or '1', where '0' means do not assert PERST# and '1' means assert PERST#.
> > +   When absent, behavior may be platform-specific.
> 
> I don't understand this at all.  Are you suggesting that we need
> different "pcie-reset-suspend" values based on what sort of endpoint
> the user plugs in?

Partly. I guess I also failed to mention in this particular text (but I
did, in patch 3) that it can be a board-specific problem, related to the
fact that the only endpoint used on said board--soldered on, not
replaceable--never seemed to require PERST# to be asserted in suspend.
On such boards, I believe [1] it is physically impossible to drive this
pin low in S3 suspend. So even if we tried to assert PERST#, it would
pull back up when we suspend the system. I'm not sure if that's better
or worse than not asserting it at all.

So, that's why I settled on a device tree property. It describes the
physical ability of the board too, in some cases. (I could document this
better, I see.)

However, in other cases, we might have boards that are physically
capable, but where the use of this endpoint might still cause
interoperability problems, per your next comment. So... (continued
below)

> If so, I really don't want to get involved in that, because that's an
> issue that needs to be resolved by the vendors and the PCI-SIG.  If we

Judging by conversations with these vendors, I can't really imagine them
proactively dealing with the PCI-SIG on this. Is that really what you
think will work best?

I personally believe deferring (i.e., ignoring) the problem will not
cause any change; badly behaved vendors will just do whatever suits
them, and system designers will have to figure it out somehow -- ACPI
systems will have platform-specific behavior hidden in firmware; device
tree systems will do whatever they want out of tree; and the rare device
tree system that gets upstream support will either have suboptimal power
management, or have to have these sorts of conversations again. None of
that puts pressure on an endpoint vendor to talk to the PCI-SIG.

(I can try to put that pressure on them, but I only have so much power.)

> put in a tweak like this, I think it would be a band-aid that only
> delays getting a real solution figured out.
> 
> If you want a quirk to tune this based on specific devices, that might
> make sense.  It would still sound like an interoperability issue and
> an ongoing maintenance problem, but at least we would have specific
> details about which devices are involved, and we'd have a chance to
> make them work on more controllers than just Rockchip.

(continued) ...I suppose we could do this too. Like, a new entry in enum
pci_dev_flags, and code in drivers/pci/quirks.c? And then some helper so
that a PCIe root port driver like Rockchip's can walk its children and
check for the existence of this quirk? I'll see if I can write that up
reasonably.

Then I guess technically we could get away with not supporting the
aforementioned device tree property, since any board where the HW won't
support asserting PERST# in S3 should also have an endpoint with this
quirk.

Brian

[1] I say "I believe" because the GPIO power rail is not powered in S3
    (so at best we can possibly give a weak pull) and it is pulled up
    externally. I don't think there's any way around this.
