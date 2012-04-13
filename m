Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63020 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757064Ab2DMNsH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Apr 2012 09:48:07 -0400
Message-ID: <4F882E94.1070504@redhat.com>
Date: Fri, 13 Apr 2012 09:48:04 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Matthew Wilcox <matthew@wil.cx>,
	"Hao, Xudong" <xudong.hao@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V4] Quirk for IVB graphics FLR errata
References: <403610A45A2B5242BD291EDAE8B37D300FD0DA33@SHSMSX102.ccr.corp.intel.com> <4F8594FD.8020109@redhat.com> <20120412040630.GC6557@parisc-linux.org> <4F86F28E.8020807@redhat.com> <CAErSpo4pAGnQm=5=1kEeLmUBZi2wLWXCpw7s-+JFJbz4LVp3fQ@mail.gmail.com>
In-Reply-To: <CAErSpo4pAGnQm=5=1kEeLmUBZi2wLWXCpw7s-+JFJbz4LVp3fQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/12/2012 09:48 PM, Bjorn Helgaas wrote:
> On Thu, Apr 12, 2012 at 9:19 AM, Don Dutile<ddutile@redhat.com>  wrote:
>> On 04/12/2012 12:06 AM, Matthew Wilcox wrote:
>
>>>> -->    other arch compile problem source???
>>>
>>>
>>> Well, this device is part of the x86 CPU.  It's never going to be found
>>> as part of any other architecture.  Why force other architectures to
>>> carry this quirk around?
>>
>> Well, the trend to include more IO into chipsets tied to an arch
>> will probably increase over time, so such conditional quirks will
>> increase as well.
>> Sounds like the quirk tables need an arch-hook (linked list) to check
>> &  traverse.  Then such code can go into arch/<arch>/pci/quirks.c .
>
> We do have arch/x86/pci/fixup.c already.  I agree it'd be nice if it
> had the same name as the generic quirks.c.  Other than that, do you
> think there's an advantage to adding some sort of explicit arch hook,
> or is it sufficient that DECLARE_PCI_FIXUP...() uses the linker to
> collect all the quirks (both generic and arch-specific)?
>
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I didn't understand that DECLARE_PCI_FIXUP...() uses the linker to
collect all the quirks.  if so, that WFM.
I do think the arch/<>/pci/fixup.c module should be renamed to quirks.c
so it's association with drivers/pci/quirks.c is (more) obvious.
fixup.c gives the impression it may be more like bios-related fixup,
and not quirk-related fixups.

