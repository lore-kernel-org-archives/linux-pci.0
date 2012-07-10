Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44505 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab2GJQlI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 12:41:08 -0400
Received: by bkwj10 with SMTP id j10so223925bkw.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 09:41:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120710161727.GA18361@kroah.com>
References: <20120710160042.GA17949@kroah.com> <Pine.LNX.4.44L0.1207101209150.1308-100000@iolanthe.rowland.org>
 <20120710161727.GA18361@kroah.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Jul 2012 10:40:46 -0600
Message-ID: <CAErSpo63O_d1j5aMPJyEQNcx5y_U-CZfAHgr=SbypBPfh9sCfA@mail.gmail.com>
Subject: Re: [PATCH] PCI: EHCI: fix crash during suspend on ASUS computers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
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

On Tue, Jul 10, 2012 at 10:17 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Jul 10, 2012 at 12:11:41PM -0400, Alan Stern wrote:
>> On Tue, 10 Jul 2012, Greg KH wrote:
>>
>> > > I'm fine with this patch.  I was going to add these:
>> > >
>> > >     Based-on-patch-by: AceLan Kao <acelan.kao@canonical.com>
>> > >     Reference: https://bugzilla.kernel.org/show_bug.cgi?id=37632
>> > >     Reference: https://bugzilla.kernel.org/show_bug.cgi?id=42728
>> > >
>> > > I don't have the previous iteration (c2fb8a3fa25513d) in my "next"
>>
>> The commit is already in 3.5-rc6.  And I intended this fix to get into
>> 3.5-final, not into Linux-next (I should have said so explicitly in the
>> patch).
>
> Ah, ok, if so, and Bjorn doesn't mind, I can add it to the other USB
> patches that I have queued up to go in before 3.5-final is released.
>
> Bjorn, want me to take it?  If so, can I get your ack?

Yes, please.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
