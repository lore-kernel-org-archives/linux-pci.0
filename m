Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:54217 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab2HQVZo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 17:25:44 -0400
Received: by ghrr11 with SMTP id r11so4406202ghr.19
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 14:25:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com> <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de> <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 Aug 2012 15:25:22 -0600
Message-ID: <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2012 at 3:07 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
>> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
> [...]
>> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
>> > affect you?  I think we would still have to change some __inits to
>> > __devinit, including pcibios_update_irq(), but it might be more
>> > manageable.
>>
>> You said that depending on HOTPLUG wouldn't be enough because it would
>> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
>> theoretically possible to build a kernel without HOTPLUG but have the
>> enumeration start after init because of deferred probing. Those cases
>> won't work if we keep __init or __devinit respectively, right?
>
> Another possibility would be to make PCI select HOTPLUG or depend on it.
> That way it would be made sure that __devinit wouldn't cause all the
> functions to be discarded after init.

There's been some discussion recently about whether CONFIG_HOTPLUG is
worth keeping any more, but nothing's been resolved yet.  If we did
decide to remove CONFIG_HOTPLUG, or require it for PCI, I would rather
just remove all the __devinit annotations because they'd be
superfluous.

> Also, using PCI without HOTPLUG is sort of contradictory.

I'm not sure I follow this one.  I can easily imagine embedded systems
that use PCI internally but have no slots or connectors, so there's no
possibility of anything changing.
