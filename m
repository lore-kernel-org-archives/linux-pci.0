Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:61391 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab3KTMnu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2013 07:43:50 -0500
Received: by mail-qe0-f44.google.com with SMTP id b10so169311qen.31
        for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2013 04:43:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131120112303.GA5123@amd.pavel.ucw.cz>
References: <CAPDyKFpypLVKiOZEweWMig9LrNHcOpNQnm+J3KJ3KzCDBgkv9A@mail.gmail.com>
	<Pine.LNX.4.44L0.1311191011470.1145-100000@iolanthe.rowland.org>
	<CAPDyKFopHvAvpb1O__3HoMv2YuhYnVLg5sk+NeRs9tsg8OLSig@mail.gmail.com>
	<20131120112303.GA5123@amd.pavel.ucw.cz>
Date: Wed, 20 Nov 2013 13:43:48 +0100
Message-ID: <CAPDyKFocLDLLp0mJghP-+nwacxM58T3EengqW0vLka=WeRQxvw@mail.gmail.com>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20 November 2013 12:23, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2013-11-20 11:52:05, Ulf Hansson wrote:
>> On 19 November 2013 16:35, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Tue, 19 Nov 2013, Ulf Hansson wrote:
>> >
>> >> At the moment, system PM is already affecting behaviour of runtime PM
>> >> since it is preventing runtime suspend during system suspend.
>> >
>> > Sure.  And that behavior is documented.  In any case, it's a bug for
>> > drivers to depend on runtime suspend for carrying out a system suspend.
>>
>> Why do you say that?
>
> Because that's the way it is?
>
>> A significant amount of drivers should be able to cope with only the
>> runtime PM callbacks, if only the PM core have respected the drivers
>> in the way my RFC proposes.
>
> So what? It is not as additional callback is huge burden -- code is
> the same -- and we do want option of disabling runtime PM.
>
> Don't make system suspend dependend on runtime PM.

I get your point and for sure I respect it, even if don't agree. :-)

Do note that, the intent with my RFC is also to simplify for drivers
in general using runtime PM. No matter how you put it, the
consequences of preventing runtime suspend during system suspend are
causing confusions.

Kind regards
Ulf Hansson

>
>                                                                 Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
