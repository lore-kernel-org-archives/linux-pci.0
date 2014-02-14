Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33238 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaBNRbn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 12:31:43 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so4800939ier.4
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2014 09:31:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <E86EADE93E2D054CBCD4E708C38D364A53C3D4C5@G01JPEXMBYT01>
References: <20140203160724.949a0ee5.izumi.taku@jp.fujitsu.com>
 <20140212004927.GH21057@google.com> <E86EADE93E2D054CBCD4E708C38D364A53C32F56@G01JPEXMBYT01>
 <CAErSpo5ycKF4Xm26z80wNrms7G5onn1ASzcU2AHy7XN1YNAYuA@mail.gmail.com>
 <CAA93t1psHnnVSbaaaJ1LsqeNzRYmNiiO9RiTggVovDVJpk4cqw@mail.gmail.com>
 <E86EADE93E2D054CBCD4E708C38D364A53C37ABC@G01JPEXMBYT01> <11994c276661475080d900fa8b5942a5@DM2PR05MB671.namprd05.prod.outlook.com>
 <E86EADE93E2D054CBCD4E708C38D364A53C3D4C5@G01JPEXMBYT01>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 14 Feb 2014 10:31:22 -0700
Message-ID: <CAErSpo6ku31cXTPNw-Ri6=DBSpCOk25yYs4peqkKA08eWxm5dQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix the problem that the present bit is not
 cleared though slot is empty
To: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>
Cc: Rajat Jain <rajatjain@juniper.net>,
	"rajatxjain@gmail.com" <rajatxjain@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	Guenter Roeck <groeck@juniper.net>,
	Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 14, 2014 at 12:21 AM, Izumi, Taku <izumi.taku@jp.fujitsu.com> wrote:
>> Hmm... I see that the Slot has a power controller. Which means that the power to the slot shall not be turned on automatically
>> (by HW) when the card is plugged in. Also meaning that the link will not come up automatically - so this does not seem
>> like the Link state based hotplug kicking in.
>>
>> What I suspect is this one:
>>
>> f02d1843d83b "PCI: pciehp: Remove surprise bit checks"
>
>   You are right.
>   In case of omitting comit-f02d1843, it worked as expected.
>   Slot power doesn't become ON automatically when PCIe card is inserted.

OK, I dropped f02d1843d83b ("PCI: pciehp: Remove surprise bit
checks").  Thanks for testing, everybody!

I think our handling of slot capabilities and control is a bit
haphazard.  It seems like we're mostly responding to things that
break, and we don't really have a coherent explanation of how things
*should* work in different configurations.  I think it would be good
if somebody wrote up something for Documentation/PCI, with references
to the relevant specifications, that describes how we think things
should work.  For example, I think we have at least four models:

  1) ExpressCard
  2) Slots with attention button
  3) Slots with no button where we expect a software UI, e.g., Taku's box
  4) Devices with no actual slot, no button, etc., e.g., Rajat's system

We handle these slightly differently, implicitly relying on various
capability tests scattered throughout the code.  I think we should be
able to come up with a scheme that would make this more explicit and
make pciehp simpler and more consistent.

Bjorn
