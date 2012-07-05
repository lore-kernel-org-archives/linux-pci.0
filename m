Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56072 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349Ab2GEWjk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jul 2012 18:39:40 -0400
Received: by lbbgm6 with SMTP id gm6so13668054lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 05 Jul 2012 15:39:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201207060000.51762.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1207051727430.13212-100000@netrider.rowland.org> <201207060000.51762.rjw@sisk.pl>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 5 Jul 2012 16:39:18 -0600
Message-ID: <CAErSpo6AJEdCem2oAv6z0wGiGTZSLQAs5sJN+_rN1d9uqyT7BQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	AceLan Kao <acelan.kao@canonical.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?B?5rSqKEFsZXgp6IyC6ICV?= <alex.hung@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 5, 2012 at 4:00 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, July 05, 2012, Alan Stern wrote:
>> On Thu, 5 Jul 2012, Bjorn Helgaas wrote:
>>
>> > I wish we knew more about what's really going on here.  I looked
>> > through the bug reports AceLan dug up, and I don't get the feeling
>> > that anybody really has a grand unified theory about why Windows works
>> > but Linux doesn't.  But I'm willing to apply one of these patches if
>> > you and/or Alan sign off on it.
>>
>> His description seems to make sense, even if it may not be complete.
>>
>> Windows sets the COMMAND register to 0 before suspending, so it doesn't
>> trigger the BIOS bus.  Linux doesn't, so the BIOS tries to quiesce the
>> EHCI controller.  This involves doing various MMIO accesses, which of
>> course don't work if the controller is already in D3.

Should we clear the COMMAND register for more than just EHCI devices?
It seems like known differences from Windows are just waiting to bite
us.

I like your patch and explanation for how this can cause a hang...
that helps make sense of things.

>> For obvious reasons, I'm in favor of my two-line change over AceLan's
>> new PCI quirk.  So far there have been positive responses from a few
>> volunteers testing the patch.
>
> The two-liner is good enough, I think, and tested.  We can always add a quirk
> based on it in the future.

Cool, do you want to send me a patch with Signed-off-by, etc?
