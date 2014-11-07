Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62284 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbaKGPh5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Nov 2014 10:37:57 -0500
MIME-Version: 1.0
In-Reply-To: <20141107152311.GJ8916@e106497-lin.cambridge.arm.com>
References: <1415101660-26450-1-git-send-email-l.stach@pengutronix.de>
 <20141105231743.GI6168@google.com> <20141106100518.GI8916@e106497-lin.cambridge.arm.com>
 <CAL_JsqK-g2qW12jatyZBLeBEtpr80o=WWZVet5+OgMtzAAXHJQ@mail.gmail.com>
 <20141106153051.GU8916@e106497-lin.cambridge.arm.com> <CAL_Jsq+WHyRN+hAaEwH1ZHabEYgTDnpPinoL8pagHYzP4Zfe=g@mail.gmail.com>
 <20141107101728.GZ8916@e106497-lin.cambridge.arm.com> <CAL_JsqKdwLkybzLHdYcg81vEYfZvLu3_Cg1vZyoAyuobi6Vc4Q@mail.gmail.com>
 <20141107152311.GJ8916@e106497-lin.cambridge.arm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Fri, 7 Nov 2014 09:37:34 -0600
Message-ID: <CAL_JsqLGav-_g1eq9Q_YsUrNao4KpHqYPHsm6qKxR1VkcicZ=Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: add missing DT binding for linux,pci-domain property
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 7, 2014 at 9:23 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Fri, Nov 07, 2014 at 02:00:56PM +0000, Rob Herring wrote:
>> On Fri, Nov 7, 2014 at 4:17 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> > On Thu, Nov 06, 2014 at 07:46:33PM +0000, Rob Herring wrote:
>> >> On Thu, Nov 6, 2014 at 9:30 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> >> > On Thu, Nov 06, 2014 at 02:57:35PM +0000, Rob Herring wrote:
>> >> >> On Thu, Nov 6, 2014 at 4:05 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> >> >> > On Wed, Nov 05, 2014 at 11:17:43PM +0000, Bjorn Helgaas wrote:
>> >> >> >> On Tue, Nov 04, 2014 at 12:47:40PM +0100, Lucas Stach wrote:
>> >> >> >> > This property was added by 41e5c0f81d3e
>> >> >> >> > (of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr())
>> >> >> >> > without the required binding documentation. As this property
>> >> >> >> > will be supported by a number of host bridge drivers going forward,
>> >> >> >> > add it to the common PCI binding doc.
>> >> >> >> >
>> >> >> >> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> >> >> >>
>> >> >> >> I merged 41e5c0f81d3e through my tree, and I could merge something like
>> >> >> >> this if a consensus develops with some acks.  But I'll just let you guys
>> >> >> >> handle it unless you poke me again.
>> >> >> >
>> >> >> > While I think the "linux,pci-domain" property *must* be documented, I
>> >> >> > would like to get a consensus first on the usage. If we agree that
>> >> >> > the property is mandatory to all host bridge drivers that use OF then
>> >> >> > we need to patch existing drivers (partially done through Lorenzo's
>> >> >> > patches, but other arches are ignoring it). If we say all *new* drivers
>> >> >> > need to use it then we also need to come up with a strategy on how to
>> >> >> > deal with old vs new school drivers.
>> >> >> >
>> >> >> > My preferred approach is the 3rd way: "linux,pci-domain" becomes part of
>> >> >> > the core PCI infrastructure (and we find the common ground with ACPI).
>> >> >> > That way the host bridge drivers don't have to do anything, but the DT
>> >> >> > creators have to specify a value.
>> >> >>
>> >> >> I'm okay with it being in the core. It was the mixture of using the
>> >> >> property and automatic numbering that I had issues with. Any mixture
>> >> >> whether in DT or in drivers should be an error. Also, I think having a
>> >> >> mixture of root bus host drivers would be rare, so I'm not too
>> >> >> concerned about some drivers supporting the property and others not.
>> >> >> In any case, these issues are all with the kernel and not really the
>> >> >> concern for the binding. For the binding, simply all hosts set the
>> >> >> domain or none of them do.
>> >> >
>> >> > Repeating what you've said to verify my understanding: you are OK with
>> >> > the "linux,pci-domain" being handled in the PCI framework and mandatory
>> >> > to all OF-based host bridges and architectures. Failure to include
>> >> > the property should be an error and no host bridge driver should default
>> >> > to the auto-generation of domain numbers.
>> >> >
>> >> > Is that correct?
>> >>
>> >> Not exactly. It is only mandatory when you have multiple root buses.
>> >> But we can't say an existing dtb is in error, so it has to remain
>> >> optional for compatibility. Also, given it is a Linux property, you
>> >> can't really say it is mandatory for all PCI bindings from a DT
>> >> perspective.
>> >>
>> >> While we could have issues in theory if this is handled in the
>> >> drivers, I don't think we will in practice as having root buses with
>> >> different drivers is unlikely.
>> >
>> > That's correct. However, I would like to bring to you attention that as
>> > long as the property is treated as optional in certain cases we will need,
>> > in the framework code, to mix the assignment of a domain number coming from
>> > parsing of the property with the auto-numbering scheme in order to support
>> > old DT files. And that was one of your major concerns when reviewing the
>> > series. Any suggestions or clarifications?
>>
>> We have to support both allocation schemes, but not on the same
>> system. A mixture on a given system is an error. So the cases to
>> handle are like this:
>>
>> 1 root bus w/ domain -> use domain prop
>> 1 root bus w/o domain -> auto numbering
>> N root buses w/ domains -> use domain prop
>> N root buses w/o domains -> auto numbering
>> N root buses w/ and w/o domains -> error
>
> Agree.
>
>>
>> I also had issues just around the implementation details, but we can
>> discuss those when there is another version.
>
> Well, there is a version already in arch/arm64/kernel/pci.c:
> pci_bus_assign_domain_nr() and I believe it works on all the cases
> listed above. Question is if you agree on making this the default
> implementation for OF-based architectures. Lorenzo has already
> copied it into arch/arm.

I agree it is correct implementation for correct DTs, but it doesn't
handle some error cases. I'll comment on Lorenzo's ARM version about
specifics.

Rob
