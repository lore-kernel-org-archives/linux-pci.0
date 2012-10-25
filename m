Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47678 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759429Ab2JYSTx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2012 14:19:53 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1939001wib.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Oct 2012 11:19:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1349742167.6336.3.camel@deadeye.wl.decadent.org.uk>
References: <1349643467.16173.148.camel@deadeye.wl.decadent.org.uk>
 <20121008162830.GA1307@kroah.com> <CAErSpo5WymA1qf_mL4F_VYeNt0Ed5EY0RHW4ts76DLbipLp8pQ@mail.gmail.com>
 <1349742167.6336.3.camel@deadeye.wl.decadent.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Oct 2012 12:19:21 -0600
Message-ID: <CAErSpo5Xs8pW6eQjjoDD289e_EiFMxdQyBJ4cVFdn5mfOU=Vnw@mail.gmail.com>
Subject: Re: [stable] PCI: acpiphp: check whether _ADR evaluation succeeded
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg KH <greg@kroah.com>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, jeroen@nijhof.uklinux.net,
	public@stefan-nagy.at
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 8, 2012 at 6:22 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Mon, 2012-10-08 at 10:37 -0600, Bjorn Helgaas wrote:
>> On Mon, Oct 8, 2012 at 10:28 AM, Greg KH <greg@kroah.com> wrote:
>> > On Sun, Oct 07, 2012 at 09:57:47PM +0100, Ben Hutchings wrote:
>> >> Based on <https://bugzilla.kernel.org/show_bug.cgi?id=46481>, the
>> >> following commit should be cherry-picked for stable series < 3.6:
>> >>
>> >> commit dfb117b3e50c52c7b3416db4a4569224b8db80bb
>> >> Author: Bjorn Helgaas <bhelgaas@google.com>
>> >> Date:   Wed Jun 20 16:18:29 2012 -0600
>> >>
>> >>     PCI: acpiphp: check whether _ADR evaluation succeeded
>> >>
>> >> It applies cleanly to 3.2.y and presumably also to later stable
>> >> branches.  I've attached a version that applies to 2.6.32.y and 3.0.y,
>> >> and presumably also to the intermediate stable branches.  Only 3.2.y has
>> >> actually been tested with this, though.
>> >
>> > Thanks, now applied.
>>
>> Has anybody looked deeper to see exactly *how* this patch fixes the
>> problem?  The original reports were oopses caused by dereferencing bad
>> pointers in DRM, and it's not obvious to me how this patch is
>> connected to those.
>
> Oh, I completely missed the oops log.  Yes, it does look like there's
> another more serious bug still to be fixed in 3.2.y (maybe in DRM, maybe
> not).

With a lot of help from Jeroen Nijhof <jeroen@nijhof.uklinux.net> and
Stefan Nagy <public@stefan-nagy.at>, I analyzed this and convinced
myself that the DRM oopses were in fact caused by the bogus slot we
registered when we ignored the _ADR evaluation failures.

More details in https://bugzilla.kernel.org/show_bug.cgi?id=46481

So I believe this _ADR problem was the root cause and we don't need to
look for more DRM issues.

Bjorn
