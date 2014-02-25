Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62688 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbaBYDCD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2014 22:02:03 -0500
Received: by mail-pa0-f46.google.com with SMTP id rd3so7396703pab.5
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2014 19:02:02 -0800 (PST)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <CAA93t1pApi2zDk81JKiW8WK+foOdKL=tDiCJSpc9WCwSO64NdA@mail.gmail.com>
References: <20140203160724.949a0ee5.izumi.taku@jp.fujitsu.com>
	<20140212004927.GH21057@google.com>
	<E86EADE93E2D054CBCD4E708C38D364A53C32F56@G01JPEXMBYT01>
	<CAErSpo5ycKF4Xm26z80wNrms7G5onn1ASzcU2AHy7XN1YNAYuA@mail.gmail.com>
	<CAA93t1psHnnVSbaaaJ1LsqeNzRYmNiiO9RiTggVovDVJpk4cqw@mail.gmail.com>
	<E86EADE93E2D054CBCD4E708C38D364A53C37ABC@G01JPEXMBYT01>
	<11994c276661475080d900fa8b5942a5@DM2PR05MB671.namprd05.prod.outlook.com>
	<E86EADE93E2D054CBCD4E708C38D364A53C3D4C5@G01JPEXMBYT01>
	<CAErSpo6ku31cXTPNw-Ri6=DBSpCOk25yYs4peqkKA08eWxm5dQ@mail.gmail.com>
	<CAA93t1pApi2zDk81JKiW8WK+foOdKL=tDiCJSpc9WCwSO64NdA@mail.gmail.com>
Date: Mon, 24 Feb 2014 19:02:01 -0800
Message-ID: <CAA93t1ozi=r7zKmnB0apRwnmXQg+6HkN1SFw6aYO=w2e2b+Weg@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Fix the problem that the present bit is not
 cleared though slot is empty
From: Rajat Jain <rajatxjain@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>,
	Rajat Jain <rajatjain@juniper.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	Guenter Roeck <groeck@juniper.net>,
	Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

>>
>> I think our handling of slot capabilities and control is a bit
>> haphazard.  It seems like we're mostly responding to things that
>> break, and we don't really have a coherent explanation of how things
>> *should* work in different configurations.  I think it would be good
>> if somebody wrote up something for Documentation/PCI, with references
>> to the relevant specifications, that describes how we think things
>> should work.
>
> Sure, I think I'll take a stab.
>
> Thanks,
>
> Rajat
>
>>  For example, I think we have at least four models:
>>
>>   1) ExpressCard
>>   2) Slots with attention button
>>   3) Slots with no button where we expect a software UI, e.g., Taku's box
>>   4) Devices with no actual slot, no button, etc., e.g., Rajat's system
>>

I'm trying to come up with a write up for this. And am trying to
understand what differentiates (1) from others - from the view of use
case model of course. I briefly looked at the ExpressCard specs at

http://www.usb.org/developers/expresscard/EC_specifications/ExpressCard_2_0_FINAL.pdf

I understand that ExpressCard shall be an actual slot and of course
has a defined form factor etc, but, when I think of the _use case_
that the user is expected to follow, it shall be pretty much dependent
on the HP elements. For e.g, if there is attention button, it would
follow (2), but if link comes up automatically (no power controller
etc), then it would follow (4) etc.

Thus I think that the use cases (sequence to be followed for hotplug)
shall be more appropriately categorized based on what hot-plug
elements (button etc) are present in a system. Of course, we can give
examples ("ExpressCards are one example in this category and is
typically characterized by .. ") within those categories, while also
making references to the appropriate standards.

 What do you think?

Thanks,

Rajat
