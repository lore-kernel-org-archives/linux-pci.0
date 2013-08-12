Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:56600 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab3HLVoF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 17:44:05 -0400
Received: by mail-ie0-f177.google.com with SMTP id a11so8686319iee.8
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2013 14:44:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <520954EA.2060308@message-id.googlemail.com>
References: <520747B6.8010309@message-id.googlemail.com> <1880950.SYaKzZm9j7@vostro.rjw.lan>
 <5207FFB8.3080202@message-id.googlemail.com> <11028683.ZZQRkho7yW@vostro.rjw.lan>
 <CAErSpo6HThAr7MXX1-qpzryy7=F7+eMfNK_zWuP9j5arLb1RXA@mail.gmail.com> <520954EA.2060308@message-id.googlemail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 12 Aug 2013 15:43:44 -0600
Message-ID: <CAErSpo5bxUw8uW0UR3uUNzrOO_QV_3WMuWsx9o7M+HmJzzT9jA@mail.gmail.com>
Subject: Re: acpiphp and pciehp not working together on Thinkpad X200s
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg KH <gregkh@linux.com>, Oliver Neukum <oneukum@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 12, 2013 at 3:34 PM, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
> Hi Bjorn,
>
> Am 12.08.2013 19:21, schrieb Bjorn Helgaas:
>
>> Thanks for the report, Stefan.  I opened
>> https://bugzilla.kernel.org/show_bug.cgi?id=60736 so we don't forget
>> about this.  If you could attach complete dmesg logs for both cases
>> (working and failing) to that bugzilla, that would be great.  An
>> acpidump might also be interesting, since the ACPI namespace
>> determines what acpiphp does.
>
> Ok, I added all that information to the bug.

Thanks!

>> I suspect that we're being too aggressive about determining when we
>> should use one or the other of acpiphp and pciehp.  We basically
>> decide up front which one we expect the platform to use, and we only
>> listen to signals from that one.  But I wonder if we should just
>> prepare for signals from both.
>
> Actually I booted an older Kernel (3.7.10, openSUSE 12.3 kernel) which
> has both drivers configured as modules.
> The interesting thing is: I was not able to load acpiphp there, it
> errored out with ENODEV.
> So maybe something changed, making acpiphp more (too?) relaxed.
>
> Should I try building the latest kernel with both drivers as modules to
> see if this makes a difference?

No, don't bother.  Neither one can be built as a module any more
anyway (6037a803b removed it for acpiphp, and c10cc483b did the same
for pciehp).  There was never a good way to auto-load the modules, so
it really didn't make much sense to have them be modules.

Just bug us periodically if nothing seems to be happening on the bug report :)

Bjorn
