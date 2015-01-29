Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44388 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756845AbbA2Stt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jan 2015 13:49:49 -0500
Date: Thu, 29 Jan 2015 18:49:43 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Rob Herring <robherring2@gmail.com>
cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 02/24] Documentation: DT bindings: add more chip compatible
 strings for Tegra PCIe
In-Reply-To: <CAL_JsqKaDi1cZN8Ndb0FPhvgRVFyxc1NRhV2cx-XJ323wTKiEQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1501291846340.16475@utopia.booyaka.com>
References: <20150128234935.20644.89300.stgit@dusk.lan> <20150128234937.20644.9400.stgit@dusk.lan> <CAL_JsqKMm=r+57ShskgbtNqnCGF1yKYDSJJFQ7o05keNzh5z+g@mail.gmail.com> <alpine.DEB.2.02.1501291543030.16475@utopia.booyaka.com>
 <CAL_JsqLE+W+T5YqzdB+DkdBE+HsgySX0yJHzn1y43QDfw4GA9A@mail.gmail.com> <alpine.DEB.2.02.1501291707350.16475@utopia.booyaka.com> <CAL_JsqKaDi1cZN8Ndb0FPhvgRVFyxc1NRhV2cx-XJ323wTKiEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 29 Jan 2015, Rob Herring wrote:

> On Thu, Jan 29, 2015 at 11:08 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Thu, 29 Jan 2015, Rob Herring wrote:
> >
> >> On Thu, Jan 29, 2015 at 9:45 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >> > On Thu, 29 Jan 2015, Rob Herring wrote:
> >> >
> >> >> On Wed, Jan 28, 2015 at 5:49 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >> >> >
> >> >> > Add compatible strings for the PCIe IP blocks present on several Tegra
> >> >> > chips.  The primary objective here is to avoid checkpatch warnings,
> >> >> > per:
> >> >> >
> >>
> >> [...]
> >>
> >> >> > +  - "nvidia,tegra132-pcie" (not yet matched in the driver)
> >> >> > +  - "nvidia,tegra210-pcie" (not yet matched in the driver)
> >> >>
> >> >> Whether the driver matches or not is irrelevant to the binding and may
> >> >> change over time. Does this mean the driver matches on something else
> >> >> or Tegra132 is not yet supported in the driver?
> >> >
> >> > It means that the driver currently matches on one of the first three
> >> > strings that don't carry that annotation.
> >> >
> >> >> If the former, what is important is what are the valid combinations of
> >> >> compatible properties and that is not captured here. In other words,
> >> >> what is the fallback compatible string for each chip?
> >> >
> >> > The intention was to try to be helpful: to document that anyone adding a
> >> > "nvidia,tegra132-pcie" compatible string would also need to add one of the
> >> > other strings as a fallback.  Would you like that to be documented in a
> >> > different way, or removed?
> >>
> >> Then you should say something like 'must contain "nvidia,tegra20-pcie"
> >> and one of: ...'
> >>
> >> You can also use nvidia,<chip>-pcie if you want. checkpatch will check
> >> for that pattern too. Then your documentation can be something like:
> >>
> >> Must contain '"nvidia,<chip>-pcie", "nvidia,tegra20-pcie"' where
> >> <chip> is tegra30, tegra132, ...
> >>
> >> We don't enforce that the <chip> part is documented ATM and not likely
> >> until we have a schema if ever.
> >
> > OK, thanks for the explanation.
> >
> > So would it be acceptable to you to skip the attempt to document which
> > strings are actually supported by the current driver, and to simply use
> > the <chip> wildcard?
> 
> I don't think the binding document should say anything about what the
> driver uses or not. 

OK, will remove those.

> It should describe what combinations of compatible strings in a dts are 
> valid. I didn't look at every patch, but the ones like this one are.

OK, will switch to the format you described earlier:

"Must contain '"nvidia,<chip>-pcie", "nvidia,tegra20-pcie"' where
 <chip> is tegra30, tegra132, ..."

> I'd be fine with most of this all in one patch BTW.

OK, will squash.

> You should attempt to document known values of <chip> if you use it
> (you could refer to another doc for the list).

Is there an example of this in the tree that you have in mind, where 
another document is used for the list?  Would it just contain a list of 
the Tegra chips, e.g., tegra30, tegra114, tegra124, etc?

> I was only highlighting what you can get away with if no one is paying 
> attention, not that you don't need to add tegra132, etc. :)

OK.


- Paul
