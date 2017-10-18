Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 18 Oct 2017 11:17:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/3] Documentation/devicetree: Add pcie-reset-suspend
 property
Message-ID: <20171018161752.GQ5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20171012205220.130048-1-briannorris@chromium.org>
 <20171012205220.130048-2-briannorris@chromium.org>
 <20171013165152.GE25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171017233904.GA65743@google.com>
MIME-Version: 1.0
In-Reply-To: <20171017233904.GA65743@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Rajat Jain <rajatja@google.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 04:39:05PM -0700, Brian Norris wrote:
> On Fri, Oct 13, 2017 at 11:51:52AM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 12, 2017 at 01:52:18PM -0700, Brian Norris wrote:
> > > The patch is self-descriptive. I've found that we may need
> > > platform-specific behavior for the PERST# signal in system suspend,
> > > depending on the type of PCIe endpoints are attached.
> > > 
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > >  Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> > > index c77981c5dd18..91339b6d0652 100644
> > > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > > @@ -24,3 +24,14 @@ driver implementation may support the following properties:
> > >     unsupported link speed, for instance, trying to do training for
> > >     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> > >     for gen2, and '1' for gen1. Any other values are invalid.
> > > +- pcie-reset-suspend:
> > > +   If present this property defines whether the PCIe Reset signal (referred to
> > > +   as PERST#) should be asserted when the system enters low-power suspend modes
> > > +   (e.g., S3). Depending on the form factor, the associated PCIe
> > > +   electromechanical specification may specify a particular behavior (e.g.,
> > > +   "PERST# is asserted in advance of the power being switched off in a
> > > +   power-managed state like S3") or it may be less clear. The net result is
> > > +   that some endpoints perform better (e.g., lower power consumption) with
> > > +   PERST# asserted, and others prefer PERST# deasserted. The value must be '0'
> > > +   or '1', where '0' means do not assert PERST# and '1' means assert PERST#.
> > > +   When absent, behavior may be platform-specific.
> > 
> > I don't understand this at all.  Are you suggesting that we need
> > different "pcie-reset-suspend" values based on what sort of endpoint
> > the user plugs in?
> 
> Partly. I guess I also failed to mention in this particular text (but I
> did, in patch 3) that it can be a board-specific problem, related to the
> fact that the only endpoint used on said board--soldered on, not
> replaceable--never seemed to require PERST# to be asserted in suspend.
> On such boards, I believe [1] it is physically impossible to drive this
> pin low in S3 suspend. So even if we tried to assert PERST#, it would
> pull back up when we suspend the system. I'm not sure if that's better
> or worse than not asserting it at all.
> 
> So, that's why I settled on a device tree property. It describes the
> physical ability of the board too, in some cases. (I could document this
> better, I see.)

It would make sense to me to have a DT property in the PCIe host
controller object that describes how that controller works, including
its capabilities with respect to PERST#, assuming there's a reasonable
way to use that information.

If there's a DT way to describe a hard-wired PCIe endpoint, it might
make sense to have a second property in the endpoint object that
describes its preferences.  Obviously this couldn't apply to slots
where we don't know what might be plugged in.

> > If you want a quirk to tune this based on specific devices, that might
> > make sense.  It would still sound like an interoperability issue and
> > an ongoing maintenance problem, but at least we would have specific
> > details about which devices are involved, and we'd have a chance to
> > make them work on more controllers than just Rockchip.
> 
> (continued) ...I suppose we could do this too. Like, a new entry in enum
> pci_dev_flags, and code in drivers/pci/quirks.c? And then some helper so
> that a PCIe root port driver like Rockchip's can walk its children and
> check for the existence of this quirk? I'll see if I can write that up
> reasonably.

I'm not sure how this would work out.  I can see the quirk side (e.g.,
the quirk could set a bit in the root port), but who would consume it?
Would every host bridge driver have to look at the bit?  This doesn't
feel like a generic model that works well across vendors.

If devices rely on things not specified by the spec, they will work
better on some systems than on others.  That feels like an issue for
the vendors, not for us.

Obviously you want to tweak something for your particular
configuration, and you can do that either via out-of-tree code or via
some more generic way that I haven't seen yet.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
