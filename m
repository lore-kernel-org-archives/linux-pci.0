Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44958 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751327Ab2IGRWu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 13:22:50 -0400
Received: by lagy9 with SMTP id y9so1993541lag.19
        for <linux-pci@vger.kernel.org>; Fri, 07 Sep 2012 10:22:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120907170024.GA16114@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7v+i8i=mXCs7ZW8DtGTDN_4AEntwYLqGG8FcCzweySFg@mail.gmail.com>
 <20120815192814.GA12870@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6cjOzJegJqXzmk59DChExcbLK1sOhwyAyQL4FZkTN21A@mail.gmail.com>
 <504A1EA2.9030008@wwwdotorg.org> <20120907170024.GA16114@avionic-0098.mockup.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 7 Sep 2012 10:22:28 -0700
Message-ID: <CAErSpo4Y4QXfahRkBoJ_jmKy6VAYqOzixTmCPkwSATfO+rzVxg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] PCI: Keep pci_fixup_irqs() around after init
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 7, 2012 at 10:00 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Fri, Sep 07, 2012 at 10:19:46AM -0600, Stephen Warren wrote:
>> On 08/15/2012 01:42 PM, Bjorn Helgaas wrote:
>> > On Wed, Aug 15, 2012 at 1:28 PM, Thierry Reding
>> > <thierry.reding@avionic-design.de> wrote:
>> >> On Wed, Aug 15, 2012 at 10:06:27AM -0700, Bjorn Helgaas wrote:
>> >>> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
>> >>> <thierry.reding@avionic-design.de> wrote:
>> >>>> When using deferred driver probing, PCI host controller drivers may
>> >>>> actually require this function after the init stage.
>> >>>>
>> >>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>> >>>> ---
>> >>>> Changes in v3:
>> >>>> - none
>> >>>>
>> >>>> Changes in v2:
>> >>>> - use __devinit annotations
>> >>>
>> >>> Your original patch removed __init completely.  Here you change it to
>> >>> __devinit.  That means we decide whether to discard the function based
>> >>> on whether CONFIG_HOTPLUG is supported.  But I think your point is not
>> >>> about hotplug; it's merely that we should be able to scan a PCI bus
>> >>> after init-time.  We ought to be able to do a late PCI scan even if
>> >>> hotplug is not supported.
>> >>>
>> >>> Therefore, I'd be inclined to remove __init completely unless you have
>> >>> another reason for preferring __devinit.
>> >>
>> >> I thought __devinit would resolve to nothing if HOTPLUG is defined and
>> >> __init otherwise. That seemed more appropriate. However you are right
>> >> that it is useful to always have it available, so I'm fine with removing
>> >> the annotations altogether. Do you want me to follow up with a patch? Or
>> >> can you just take the first version? I'm not sure if it still applies.
>> >
>> > You're right about how __devinit works.  It's just that I don't think
>> > hotplug is actually relevant here.  We're trying to make
>> > pci_fixup_irqs() work after init, whether it's because of hotplug or
>> > simply because the arch scans host bridges after init.
>> >
>> > I applied this to my "next" branch.  Thanks!
>>
>> Bjorn, I don't see this patch in next-20120907. Did it get dropped for
>> some reason?
>
> Yes, it turns out that dropping the annotations causes lots of section
> mismatches on other architectures. See here[0] for the details. I think
> the solution to the issue would be to either remove HOTPLUG altogether
> and drop __devinit and __devexit annotations or update all architectures
> to fix these warnings. I think Bjorn and I settled on the latter because
> it's obviously less intrusive. I've been busy building toolchains for
> all the PCI architectures and I think I have all of them. I'll just need
> some more time to build, find and fix any remaining section mismatches.

Greg KH is actively removing CONFIG_HOTPLUG altogether -- see
https://lkml.org/lkml/2012/9/4/489

That will make __devinit resolve to nothing in all cases, and we'll
eventually remove __devinit completely.  So we don't want to convert
__init to __devinit; we have to remove the __init altogether.  I think
that means we have to update all arches first to avoid the section
mismatches.

So I think Thierry is on the right track:
  1) Change all arch pcibios_update_irq() implementations (and
probably a few other things) to be non-__init
  2) Change pci_fixup_irqs() to be non-__init

Bjorn
