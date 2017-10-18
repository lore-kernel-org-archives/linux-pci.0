Return-Path: <robh+dt@kernel.org>
Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171018161752.GQ5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20171012205220.130048-1-briannorris@chromium.org>
 <20171012205220.130048-2-briannorris@chromium.org> <20171013165152.GE25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171017233904.GA65743@google.com> <20171018161752.GQ5641@bhelgaas-glaptop.roam.corp.google.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 18 Oct 2017 15:38:48 -0500
Message-ID: <CAL_JsqLYAOGHNRomE2a4Z+MLp807exqsYf7hPJhTd0cAbE85uA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/devicetree: Add pcie-reset-suspend property
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 18, 2017 at 11:17 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Oct 17, 2017 at 04:39:05PM -0700, Brian Norris wrote:
>> On Fri, Oct 13, 2017 at 11:51:52AM -0500, Bjorn Helgaas wrote:
>> > On Thu, Oct 12, 2017 at 01:52:18PM -0700, Brian Norris wrote:
>> > > The patch is self-descriptive. I've found that we may need
>> > > platform-specific behavior for the PERST# signal in system suspend,
>> > > depending on the type of PCIe endpoints are attached.
>> > >
>> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
>> > > ---
>> > >  Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
>> > >  1 file changed, 11 insertions(+)
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
>> > > index c77981c5dd18..91339b6d0652 100644
>> > > --- a/Documentation/devicetree/bindings/pci/pci.txt
>> > > +++ b/Documentation/devicetree/bindings/pci/pci.txt
>> > > @@ -24,3 +24,14 @@ driver implementation may support the following properties:
>> > >     unsupported link speed, for instance, trying to do training for
>> > >     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>> > >     for gen2, and '1' for gen1. Any other values are invalid.
>> > > +- pcie-reset-suspend:
>> > > +   If present this property defines whether the PCIe Reset signal (referred to
>> > > +   as PERST#) should be asserted when the system enters low-power suspend modes
>> > > +   (e.g., S3). Depending on the form factor, the associated PCIe
>> > > +   electromechanical specification may specify a particular behavior (e.g.,
>> > > +   "PERST# is asserted in advance of the power being switched off in a
>> > > +   power-managed state like S3") or it may be less clear. The net result is
>> > > +   that some endpoints perform better (e.g., lower power consumption) with
>> > > +   PERST# asserted, and others prefer PERST# deasserted. The value must be '0'
>> > > +   or '1', where '0' means do not assert PERST# and '1' means assert PERST#.
>> > > +   When absent, behavior may be platform-specific.
>> >
>> > I don't understand this at all.  Are you suggesting that we need
>> > different "pcie-reset-suspend" values based on what sort of endpoint
>> > the user plugs in?
>>
>> Partly. I guess I also failed to mention in this particular text (but I
>> did, in patch 3) that it can be a board-specific problem, related to the
>> fact that the only endpoint used on said board--soldered on, not
>> replaceable--never seemed to require PERST# to be asserted in suspend.
>> On such boards, I believe [1] it is physically impossible to drive this
>> pin low in S3 suspend. So even if we tried to assert PERST#, it would
>> pull back up when we suspend the system. I'm not sure if that's better
>> or worse than not asserting it at all.
>>
>> So, that's why I settled on a device tree property. It describes the
>> physical ability of the board too, in some cases. (I could document this
>> better, I see.)
>
> It would make sense to me to have a DT property in the PCIe host
> controller object that describes how that controller works, including
> its capabilities with respect to PERST#, assuming there's a reasonable
> way to use that information.
>
> If there's a DT way to describe a hard-wired PCIe endpoint, it might
> make sense to have a second property in the endpoint object that
> describes its preferences.  Obviously this couldn't apply to slots
> where we don't know what might be plugged in.

That's implicit with having an endpoint described in DT though true OF
would have every device present.

Rob
