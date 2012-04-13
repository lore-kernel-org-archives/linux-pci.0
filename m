Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57039 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756982Ab2DMBtA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2012 21:49:00 -0400
Received: by lbbgm6 with SMTP id gm6so2099024lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 12 Apr 2012 18:48:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F86F28E.8020807@redhat.com>
References: <403610A45A2B5242BD291EDAE8B37D300FD0DA33@SHSMSX102.ccr.corp.intel.com>
 <4F8594FD.8020109@redhat.com> <20120412040630.GC6557@parisc-linux.org> <4F86F28E.8020807@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 12 Apr 2012 19:48:38 -0600
Message-ID: <CAErSpo4pAGnQm=5=1kEeLmUBZi2wLWXCpw7s-+JFJbz4LVp3fQ@mail.gmail.com>
Subject: Re: [PATCH V4] Quirk for IVB graphics FLR errata
To: Don Dutile <ddutile@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
	"Hao, Xudong" <xudong.hao@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2012 at 9:19 AM, Don Dutile <ddutile@redhat.com> wrote:
> On 04/12/2012 12:06 AM, Matthew Wilcox wrote:

>>> -->  other arch compile problem source???
>>
>>
>> Well, this device is part of the x86 CPU.  It's never going to be found
>> as part of any other architecture.  Why force other architectures to
>> carry this quirk around?
>
> Well, the trend to include more IO into chipsets tied to an arch
> will probably increase over time, so such conditional quirks will
> increase as well.
> Sounds like the quirk tables need an arch-hook (linked list) to check
> & traverse.  Then such code can go into arch/<arch>/pci/quirks.c .

We do have arch/x86/pci/fixup.c already.  I agree it'd be nice if it
had the same name as the generic quirks.c.  Other than that, do you
think there's an advantage to adding some sort of explicit arch hook,
or is it sufficient that DECLARE_PCI_FIXUP...() uses the linker to
collect all the quirks (both generic and arch-specific)?

Bjorn
