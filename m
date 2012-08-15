Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:51285 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab2HOTnB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 15:43:01 -0400
Received: by ggdk6 with SMTP id k6so2198196ggd.19
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 12:43:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120815192814.GA12870@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7v+i8i=mXCs7ZW8DtGTDN_4AEntwYLqGG8FcCzweySFg@mail.gmail.com> <20120815192814.GA12870@avionic-0098.mockup.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Aug 2012 13:42:39 -0600
Message-ID: <CAErSpo6cjOzJegJqXzmk59DChExcbLK1sOhwyAyQL4FZkTN21A@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] PCI: Keep pci_fixup_irqs() around after init
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2012 at 1:28 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Wed, Aug 15, 2012 at 10:06:27AM -0700, Bjorn Helgaas wrote:
>> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>> > When using deferred driver probing, PCI host controller drivers may
>> > actually require this function after the init stage.
>> >
>> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>> > ---
>> > Changes in v3:
>> > - none
>> >
>> > Changes in v2:
>> > - use __devinit annotations
>>
>> Your original patch removed __init completely.  Here you change it to
>> __devinit.  That means we decide whether to discard the function based
>> on whether CONFIG_HOTPLUG is supported.  But I think your point is not
>> about hotplug; it's merely that we should be able to scan a PCI bus
>> after init-time.  We ought to be able to do a late PCI scan even if
>> hotplug is not supported.
>>
>> Therefore, I'd be inclined to remove __init completely unless you have
>> another reason for preferring __devinit.
>
> I thought __devinit would resolve to nothing if HOTPLUG is defined and
> __init otherwise. That seemed more appropriate. However you are right
> that it is useful to always have it available, so I'm fine with removing
> the annotations altogether. Do you want me to follow up with a patch? Or
> can you just take the first version? I'm not sure if it still applies.

You're right about how __devinit works.  It's just that I don't think
hotplug is actually relevant here.  We're trying to make
pci_fixup_irqs() work after init, whether it's because of hotplug or
simply because the arch scans host bridges after init.

I applied this to my "next" branch.  Thanks!

Bjorn
