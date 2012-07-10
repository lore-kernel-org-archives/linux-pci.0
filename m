Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53973 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab2GJQrA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 12:47:00 -0400
Received: by lbbgm6 with SMTP id gm6so637675lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 09:46:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1207101209150.1308-100000@iolanthe.rowland.org>
References: <20120710160042.GA17949@kroah.com> <Pine.LNX.4.44L0.1207101209150.1308-100000@iolanthe.rowland.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Jul 2012 10:46:39 -0600
Message-ID: <CAErSpo6qfMft+32HcRSYhaKjNDBzGu=rUDb+a=wM7+=Fr-Fe+Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: EHCI: fix crash during suspend on ASUS computers
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	AceLan Kao <acelan.kao@canonical.com>,
	=?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>,
	Javier Marcet <jmarcet@gmail.com>,
	Andrey Rahmatullin <wrar@wrar.name>,
	Oleksij Rempel <bug-track@fisher-privat.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 10:11 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 10 Jul 2012, Greg KH wrote:
>
>> > I'm fine with this patch.  I was going to add these:
>> >
>> >     Based-on-patch-by: AceLan Kao <acelan.kao@canonical.com>
>> >     Reference: https://bugzilla.kernel.org/show_bug.cgi?id=37632
>> >     Reference: https://bugzilla.kernel.org/show_bug.cgi?id=42728
>> >
>> > I don't have the previous iteration (c2fb8a3fa25513d) in my "next"
>
> The commit is already in 3.5-rc6.  And I intended this fix to get into
> 3.5-final, not into Linux-next (I should have said so explicitly in the
> patch).
>
>> > branch.  I think it went through you, Greg.  Do you want to handle
>> > this one as well?
>>
>> I can easily take it if you don't want to.
>>
>> > I *could* do it, but it looks like a messy merge -- I think I'd have
>> > to rebase almost everything in my "next" branch -- so I'd rather not.
>> > Of course, I do have some D3-related updates in pci_prepare_to_sleep()
>> > which will conflict with this, too, so I guess it will be a bit of
>> > work for somebody either way.
>>
>> Ick, no, don't rebase anything.
>>
>> If I take this then we will have merge issues in linux-next, which we
>> can work out, and then we will have the same issues for 3.6-rc1 as well.
>>
>> Or, Alan can redo the patch based on your next branch, which might make
>> it easier for everyone involved?
>
> If Bjorn's "next" branch diverged from Linus's tree before c2fb8a3 was
> added, that would make things more difficult.

It did.  My "next" branch is based on v3.5-rc2, and I think c2fb8a3
first appeared in -rc3.
