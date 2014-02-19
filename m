Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44477 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbaBSSUk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 13:20:40 -0500
Received: by mail-ie0-f179.google.com with SMTP id to1so513453ieb.10
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2014 10:20:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2200534.anptP81x7X@wuerfel>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <2312919.pM61KLBcYY@wuerfel> <20140219002814.GD8786@google.com> <2200534.anptP81x7X@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Feb 2014 11:20:19 -0700
Message-ID: <CAErSpo7JNyqK3NZgP++OWkQYQzZ1_BdR3GrK3vOd8c=_YAX7nA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	Liviu Dudau <liviu@dudau.co.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 19, 2014 at 2:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 18 February 2014 17:28:14 Bjorn Helgaas wrote:
>> On Sat, Feb 15, 2014 at 02:03:26PM +0100, Arnd Bergmann wrote:
>> > On Friday 14 February 2014 22:00:47 Liviu Dudau wrote:
>> >
>> > Can anyone with more experience on the subject than me (Bjorn,
>> > Russell, Jason, ...) think of a reason why we would not want to
>> > just use a new domain for every host bridge we find?
>>
>> With ACPI on x86 and ia64, we currently use _SEG directly as the Linux
>> PCI domain.  Are you proposing that we make the Linux PCI domain
>> independent of _SEG?
>
> I don't think we should change anything for ACPI.
> The point is that we don't currently have the equivalent of _SEG
> for DT probing. The best two options we have are:
>
> a) introduce a 'pci-segment' property with the same meaning as _SEG
> on ACPI, and use that as the domain number
>
> b) don't introduce the segment concept on DT but just give each
> host bridge its own domain.
>
> The second one seems a little easier to implement, and I don't
> see what _SEG is used for other than to avoid having domains
> when you don't need them. Is there more to it that I'm missing?

Not really, but I do have a question related to OS management of host
bridge bus number apertures.  Currently, Linux never changes a host
bridge's bus number range, but it's conceivable that we could in some
hotplug scenario.  ACPI does provide a mechanism to do so (_PRS,
_SRS), and other host bridge drivers could also do this by programming
CSRs to change the bus number range.  The PCI domain is the logical
place to manage allocation of the 00-ff range of bus numbers.

1) x86 platforms may have constraints because PCIBIOS and the 0xcf8
config access mechanism are unaware of segments.  If a platform has to
support legacy OSes that use those, it can't reuse bus numbers even in
different segment groups.  The platform might have to use multiple
segments to allow multiple ECAM regions, but use _PRS/_SRS to prevent
bus number overlaps to keep legacy config access working.  Obviously
this is only an issue if there are non-segment aware config access
methods.

2) If two host bridges share an ECAM region, I think we're forced to
put them in the same domain: if we put them in different domains,
Linux might assign [bus 00-ff] to both bridges, and ECAM config
accesses would only work for one of the bridges.  This is quite common
on x86 and is a potential issue for any architecture.

Bjorn
